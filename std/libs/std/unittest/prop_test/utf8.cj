/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.prop_test

func coerceInRange(value: Byte, min: Byte, max: Byte) {
    if (min <= value && value <= max) { return value }
    return value % (max - min + 1) + min
}

func nextIn<T>(random: RandomSource, arr: Array<T>): T {
    let ix = random.nextInt64(arr.size)
    return arr[ix]
}
/**
 * A new random byte in range [low, high], both inclusive
 */
// @OverflowWrapping is not needed here because it cannot overflow,
// but on CJVM that throws overflow exception
@OverflowWrapping
func nextInRange(random: RandomSource, low: Byte, high: Byte): Byte {
    let tri = random.nextUInt8()
    if (low <= tri && tri <= high) { return tri }
    return tri % (high - low + 1) + low
}
/**
 * Here we encode each state of UTF-8 state machine (see below)
 * as a jump table (data field) that associates each byte with a new state
 * and a set or byte ranges (ranges field) which encodes which ranges of bytes
 * are valid in that state
 */
struct UTFState {
    init() {
        this.data = []
        this.ranges = []
    }
    init(rangeTransfer: Array<(Byte, Byte, UTFState)>) {
        this.data = Array(256) { ix: Int64 =>
            let byte = UInt8(ix)
            for ((low, high, next) in rangeTransfer) {
                if (low <= byte && byte <= high) {
                    return next
                }
            }
            return UTFState()
        }
        this.ranges = Array(rangeTransfer.size) { ix =>
            let (low, high, _) = rangeTransfer[ix]
            (low, high)
        }
    }
    init(low: Byte, high: Byte, next: UTFState) {
        this.data = Array(256) { ix: Int64 =>
            let byte = UInt8(ix)
            if (low <= byte && byte <= high) { next } else { UTFState() }
        }
        this.ranges = [(low, high)]
    }

    let data: Array<UTFState>
    let ranges: Array<(Byte, Byte)>

    func isInvalid() { data.isEmpty() }

    operator func ()(byte: Byte): UTFState {
        data[Int64(byte)]
    }

    func nextByte(random: RandomSource) {
        let (low, high) = nextIn(random, ranges)
        return nextInRange(random, low, high)
    }
    /**
     * The canonical UTF8 state machine
     * [START]+--{00..7F}--------------------------------------------------------+
     *        |--{C2..DF}--------------------------------------+                 |
     *        |--{E0}-----> [C] --{A0..BF}---------------------|                 |
     *        |--{ED}-----> [D] --{A0..9F}---------------------|                 |
     *        |--{E1..EC, EE..EF}-------------+                |                 |
     *        |--{F1..F3}-> [E] --{80..BF}----|                |                 |
     *        |--{F0}-----> [F] --{90..BF}----|                |                 |
     *        |                               v                v                 v
     *        +--{F4}-----> [G] --{80..8F}-> [B] --{80..BF}-> [A] --{80..BF}-> [END]
     * (all other transitions are invalid)
     **/
    static let END_STATE = UTFState()
    static let A_STATE = UTFState(0x80, 0xBF, END_STATE)
    static let B_STATE = UTFState(0x80, 0xBF, A_STATE)
    static let C_STATE = UTFState(0xA0, 0xBF, A_STATE)
    static let D_STATE = UTFState(0x80, 0x9F, A_STATE)
    static let E_STATE = UTFState(0x80, 0xBF, B_STATE)
    static let F_STATE = UTFState(0x90, 0xBF, B_STATE)
    static let G_STATE = UTFState(0x80, 0x8F, B_STATE)
    static let START_STATE = UTFState(
        (0x00, 0x7F, END_STATE),
        (0xC2, 0xDF, A_STATE),
        (0xE1, 0xEC, B_STATE),
        (0xEE, 0xEF, B_STATE),
        (0xE0, 0xE0, C_STATE),
        (0xED, 0xED, D_STATE),
        (0xF1, 0xF3, E_STATE),
        (0xF0, 0xF0, F_STATE),
        (0xF4, 0xF4, G_STATE)
    )
}

let alnumChars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".toArray()

func randomAlnumRune(random: RandomSource): Rune {
    let candidate = random.nextUInt8()
    match {
        case b'0' <= candidate && candidate <= b'9'
            || b'a' <= candidate && candidate <= b'z'
            || b'A' <= candidate && candidate <= b'Z' => Rune(candidate)
        case _ => Rune(alnumChars[Int64(candidate) % alnumChars.size])
    }
}

private const asciiPrintableMin: Byte = 0x20
private const asciiPrintableMax: Byte = 0x7E

func randomAsciiRune(random: RandomSource): Rune {
    Rune(nextInRange(random, asciiPrintableMin, asciiPrintableMax))
}

func randomUtf8Rune(random: RandomSource): Rune {
    var state = UTFState.START_STATE
    let result = Array<Byte>(6, repeat: 0)
    var i = 0
    while (!state.isInvalid()) {
        let byte = state.nextByte(random)
        state = state(byte)
        result[i] = byte
        i++
    }

    return Rune.fromUtf8(result[..i], 0)[0]
}

func randomBiasedRune(random: RandomSource): Rune {
    match (random.nextInt64(3)) {
        case 0 => randomAlnumRune(random)
        case 1 => randomAsciiRune(random)
        case 2 => randomUtf8Rune(random)
        case _ => throw IllegalArgumentException()
    }
}

func randomSuggestedRune(random: RandomSource): Rune {
    let byte = random.suggestUInt8()
    if (asciiPrintableMin <= byte && byte <= asciiPrintableMax) {
        return Rune(byte)
    }
    // utf-8 is too complex to do anything smart
    return randomUtf8Rune(random)
}

func shrinkToAscii(charValue: Rune): Rune {
    if (charValue.isAscii()) {
        return charValue
    }
    let min = UInt32(asciiPrintableMin)
    let max = UInt32(asciiPrintableMax)
    let cp = UInt32(charValue) % (max - min + 1) + min
    Rune(cp)
}

func shrinkToAlnum(charValue: Rune): Rune {
    if (charValue.isAsciiLetter() || charValue.isAsciiNumber()) {
        return charValue
    }
    let alnumByte = alnumChars[charValue.hashCode() % alnumChars.size]
    Rune(alnumByte)
}
