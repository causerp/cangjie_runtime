/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

import java.lang.reflect.Field;
import java.util.Random;

/**
 * Fair no-cache hash comparison for Issue #586.
 *
 * Workload: 256K strings, length 2..20 (printable ASCII), XOR all hashes.
 *
 * Metrics:
 *   - java_hot_cached: String.hashCode after warmup (Issue JMH-like)
 *   - java_forced_recompute: clear hash field then hashCode (true String path, no cache)
 *   - java_algo_nocache: reimplement Java polyhash on chars (no field/cache, no clear cost)
 *   - java_latin1_algo: byte-polyhash like OpenJDK LATIN1 compact strings
 *
 * Compare Cangjie always-recompute String.hashCode to java_forced_recompute / java_*_algo.
 */
public class JavaUncachedHashBench {
    static final int DATA_SIZE = 256 * 1024;
    static final int STR_MIN = 2;
    static final int STR_MAX = 20;

    static String[] makeRandomStrings(long seed) {
        Random rnd = new Random(seed);
        String[] arr = new String[DATA_SIZE];
        StringBuilder sb = new StringBuilder(STR_MAX);
        for (int i = 0; i < DATA_SIZE; i++) {
            int size = STR_MIN + rnd.nextInt(STR_MAX - STR_MIN);
            sb.setLength(0);
            for (int j = 0; j < size; j++) {
                sb.append((char) (32 + rnd.nextInt(95)));
            }
            arr[i] = sb.toString();
        }
        return arr;
    }

    static long hashAllCached(String[] arr) {
        long result = 0;
        for (String s : arr) {
            result ^= s.hashCode();
        }
        return result;
    }

    /** Java's classic polynomial hash without touching String.hash cache. */
    static int javaAlgo(String s) {
        int h = 0;
        for (int i = 0, n = s.length(); i < n; i++) {
            h = 31 * h + s.charAt(i);
        }
        return h;
    }

    static long hashAllAlgo(String[] arr) {
        long result = 0;
        for (String s : arr) {
            result ^= javaAlgo(s);
        }
        return result;
    }

    /**
     * OpenJDK-style LATIN1 compact hash (ASCII subset of our printable strings).
     * Uses getBytes once outside the timed hash when possible — here we hash chars as bytes.
     */
    static int latin1Algo(String s) {
        int h = 0;
        for (int i = 0, n = s.length(); i < n; i++) {
            h = 31 * h + (s.charAt(i) & 0xff);
        }
        return h;
    }

    static long hashAllLatin1(String[] arr) {
        long result = 0;
        for (String s : arr) {
            result ^= latin1Algo(s);
        }
        return result;
    }

    static void clearHashCache(String[] arr, Field hashField, Field hashIsZeroField)
            throws IllegalAccessException {
        for (String s : arr) {
            hashField.setInt(s, 0);
            if (hashIsZeroField != null) {
                hashIsZeroField.setBoolean(s, false);
            }
        }
    }

    static double timedUs(String label, int rounds, LongSupplierEx body) throws Exception {
        long sink = body.getAsLong();
        long t0 = System.nanoTime();
        for (int i = 0; i < rounds; i++) {
            sink ^= body.getAsLong();
        }
        long elapsedNs = System.nanoTime() - t0;
        double perRoundUs = (elapsedNs / (double) rounds) / 1000.0;
        System.out.printf(
                "%s\trounds=%d\tper_round_us=%.6f\ttotal_ms=%.6f\tsink=%d%n",
                label, rounds, perRoundUs, elapsedNs / 1_000_000.0, sink);
        return perRoundUs;
    }

    @FunctionalInterface
    interface LongSupplierEx {
        long getAsLong() throws Exception;
    }

    public static void main(String[] args) throws Exception {
        System.out.println("=== Java fair no-cache (Issue #586 shape) ===");
        System.out.println("java: " + System.getProperty("java.version"));

        Field hashField = String.class.getDeclaredField("hash");
        hashField.setAccessible(true);
        Field hashIsZeroField = null;
        try {
            hashIsZeroField = String.class.getDeclaredField("hashIsZero");
            hashIsZeroField.setAccessible(true);
        } catch (NoSuchFieldException ignored) {
        }
        final Field hz = hashIsZeroField;

        String[] arr = makeRandomStrings(42);

        // Warm cache
        hashAllCached(arr);
        double hotUs = timedUs("java_hot_cached", 30, () -> hashAllCached(arr));

        // Clear + hash each round (include clear cost — upper bound on uncached path)
        double forcedUs = timedUs("java_forced_recompute", 20, () -> {
            clearHashCache(arr, hashField, hz);
            return hashAllCached(arr);
        });

        double algoUs = timedUs("java_algo_nocache", 30, () -> hashAllAlgo(arr));
        double latin1Us = timedUs("java_latin1_algo", 30, () -> hashAllLatin1(arr));

        System.out.println();
        System.out.println("=== Fair comparison notes ===");
        System.out.printf("java_hot_cached_us=%.6f  (Issue JMH-like; cache hits)%n", hotUs);
        System.out.printf("java_forced_recompute_us=%.6f  (clear field + String.hashCode; includes clear)%n", forcedUs);
        System.out.printf("java_algo_nocache_us=%.6f  (31*h+c on chars; pure algo)%n", algoUs);
        System.out.printf("java_latin1_algo_us=%.6f  (31*h+(c&0xff); OpenJDK LATIN1-like)%n", latin1Us);
        System.out.println("Compare Cangjie always-recompute (~1.5ms on SDK 1.1.3) to java_*_algo / forced_recompute.");
    }
}
