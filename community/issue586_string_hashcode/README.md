<!--
  Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
  This source file is part of the Cangjie project, licensed under Apache-2.0
  with Runtime Library Exception.

  See https://cangjie-lang.cn/pages/LICENSE for license information.
-->

# Issue #586 String.hashCode — fair no-cache evidence + algo opt

- Issue: https://atomgit.com/Cangjie/cangjie_runtime/issues/586
- Core changes (no String hash-cache field):
  - `stdlib/libs/std/core/string.cj`: empty-string fast path in `hashCode`
  - `stdlib/libs/std/core/hashable.cj`: long-string `wyhash` via one `acquireRawData` + wide `UInt64` loads (hash-identical to byte-wise `r8`)

## How to run this package

```bash
cd community/issue586_string_hashcode
cjc -O2 -Woff unused --output issue586_bench src/main.cj
./issue586_bench
```

## Fair no-cache comparison (same shape as Issue)

Workload: 262144 strings, length 2–20, XOR all hashes.

| Path | ≈ ms / round |
|------|----------------|
| Cangjie recompute (`String.hashCode`, always cold) | ~1.6 |
| Java hot cached (`String.hashCode` after warmup) | ~0.29 |
| Java uncached algorithm (`31*h+c`, no field) | ~3.25 |
| Issue Java 17 JMH (warmup+measure, cached) | 1.223 |
| Issue Cangjie 1.0.4 | 10.60 |

Under **no-cache** rules from maintainers: current Cangjie is already faster than Java’s uncached polyhash on this mix. The multi-fold Issue gap vs Java JMH is dominated by Java’s hash field + warmup, not by a broken `wyhash`.

We still optimized the algorithm path (empty fast-path + long wide-load) without adding a cache field, which maintainers indicated would break `String`’s structure / review bar.

## Compatibility

Hash results for existing inputs must match pre-change `wyhash` / `String.hashCode` (wide load only reformulates `r8` packing).
