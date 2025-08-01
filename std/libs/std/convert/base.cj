/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file
 *
 * This file defines basic help methods.
 *
 */

package std.convert

let DIGITS_UI64: Array<UInt64> = [100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,
    100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,
    100, 100, 100, 100, 100, 100, 100, 100, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 100, 100, 100, 100, 100, 100, 100, 10, 11, 12,
    13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 100, 100, 100, 100, 100,
    100, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 100,
    100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,
    100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,
    100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,
    100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,
    100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,
    100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100]
let DIGITS: Array<String> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h",
    "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
let MOVE_RADIX: Array<Int64> = [0, 0, 1, 0, 2, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 5, 0, 0, 0, 0]
const FOTMAT_BASE_NUM_UI64_2: UInt64 = 2
const FOTMAT_BASE_NUM_UI64_8: UInt64 = 8
const FOTMAT_BASE_NUM_UI64_10: UInt64 = 10
const FOTMAT_BASE_NUM_UI64_16: UInt64 = 16
const MAXVAL_I8: UInt64 = 0x7F
const MAXVAL_UI8: UInt64 = 0xFF
const MAXVAL_I16: UInt64 = 0x7FFF
const MAXVAL_UI16: UInt64 = 0xFFFF
const MAXVAL_I32: UInt64 = 0x7FFF_FFFF
const MAXVAL_UI32: UInt64 = 0xFFFF_FFFF
const MAXVAL_I64: UInt64 = 0x7FFF_FFFF_FFFF_FFFF
const MAXVAL_UI64: UInt64 = 0xFFFF_FFFF_FFFF_FFFF
let MAXVAL_F16: Float16 = Float16((1.0 + Float64((Float64(1 << 10) - 1.0) / Float64(1 << 10))) * Float64(2.0 ** 0xF))
let MINVAL_F16: Float16 = (Float16((1.0 + Float64((Float64(1 << 10) - 1.0) / Float64(1 << 10))) * Float64(2.0 ** 0xF))) *
    Float16(-1.0)
let Float32_INF = Float32(1.0) / Float32(0.0)
let Float16_INF = Float16(1.0) / Float16(0.0)
const DECIMAL_OVERFLOW_LIMIT_I8 = MAXVAL_I8 / 10
const DECIMAL_OVERFLOW_LIMIT_UI8 = MAXVAL_UI8 / 10
const DECIMAL_OVERFLOW_LIMIT_I16 = MAXVAL_I16 / 10
const DECIMAL_OVERFLOW_LIMIT_UI16 = MAXVAL_UI16 / 10
const DECIMAL_OVERFLOW_LIMIT_I32 = MAXVAL_I32 / 10
const DECIMAL_OVERFLOW_LIMIT_UI32 = MAXVAL_UI32 / 10
const DECIMAL_OVERFLOW_LIMIT_I64 = MAXVAL_I64 / 10
const DECIMAL_OVERFLOW_LIMIT_UI64 = MAXVAL_UI64 / 10
const BINARY_OVERFLOW_LIMIT_I8 = MAXVAL_I8 / 2
const BINARY_OVERFLOW_LIMIT_UI8 = MAXVAL_UI8 / 2
const BINARY_OVERFLOW_LIMIT_I16 = MAXVAL_I16 / 2
const BINARY_OVERFLOW_LIMIT_UI16 = MAXVAL_UI16 / 2
const BINARY_OVERFLOW_LIMIT_I32 = MAXVAL_I32 / 2
const BINARY_OVERFLOW_LIMIT_UI32 = MAXVAL_UI32 / 2
const BINARY_OVERFLOW_LIMIT_I64 = MAXVAL_I64 / 2
const BINARY_OVERFLOW_LIMIT_UI64 = MAXVAL_UI64 / 2
const OCTAL_OVERFLOW_LIMIT_I8 = MAXVAL_I8 / 8
const OCTAL_OVERFLOW_LIMIT_UI8 = MAXVAL_UI8 / 8
const OCTAL_OVERFLOW_LIMIT_I16 = MAXVAL_I16 / 8
const OCTAL_OVERFLOW_LIMIT_UI16 = MAXVAL_UI16 / 8
const OCTAL_OVERFLOW_LIMIT_I32 = MAXVAL_I32 / 8
const OCTAL_OVERFLOW_LIMIT_UI32 = MAXVAL_UI32 / 8
const OCTAL_OVERFLOW_LIMIT_I64 = MAXVAL_I64 / 8
const OCTAL_OVERFLOW_LIMIT_UI64 = MAXVAL_UI64 / 8
const HEXADECIMAL_OVERFLOW_LIMIT_I8 = MAXVAL_I8 / 16
const HEXADECIMAL_OVERFLOW_LIMIT_UI8 = MAXVAL_UI8 / 16
const HEXADECIMAL_OVERFLOW_LIMIT_I16 = MAXVAL_I16 / 16
const HEXADECIMAL_OVERFLOW_LIMIT_UI16 = MAXVAL_UI16 / 16
const HEXADECIMAL_OVERFLOW_LIMIT_I32 = MAXVAL_I32 / 16
const HEXADECIMAL_OVERFLOW_LIMIT_UI32 = MAXVAL_UI32 / 16
const HEXADECIMAL_OVERFLOW_LIMIT_I64 = MAXVAL_I64 / 16
const HEXADECIMAL_OVERFLOW_LIMIT_UI64 = MAXVAL_UI64 / 16
const MAXABSVAL_I8: UInt64 = MAXVAL_I8 + 1
const MAXABSVAL_I16: UInt64 = MAXVAL_I16 + 1
const MAXABSVAL_I32: UInt64 = MAXVAL_I32 + 1
const MAXABSVAL_I64: UInt64 = MAXVAL_I64 + 1
const DECIMAL_OVERFLOW_LIMIT_MAXABSVAL_I8 = MAXABSVAL_I8 / 10
const DECIMAL_OVERFLOW_LIMIT_MAXABSVAL_I16 = MAXABSVAL_I16 / 10
const DECIMAL_OVERFLOW_LIMIT_MAXABSVAL_I32 = MAXABSVAL_I32 / 10
const DECIMAL_OVERFLOW_LIMIT_MAXABSVAL_I64 = MAXABSVAL_I64 / 10
const BINARY_OVERFLOW_LIMIT_MAXABSVAL_I8 = MAXABSVAL_I8 / 2
const BINARY_OVERFLOW_LIMIT_MAXABSVAL_I16 = MAXABSVAL_I16 / 2
const BINARY_OVERFLOW_LIMIT_MAXABSVAL_I32 = MAXABSVAL_I32 / 2
const BINARY_OVERFLOW_LIMIT_MAXABSVAL_I64 = MAXABSVAL_I64 / 2
const OCTAL_OVERFLOW_LIMIT_MAXABSVAL_I8 = MAXABSVAL_I8 / 8
const OCTAL_OVERFLOW_LIMIT_MAXABSVAL_I16 = MAXABSVAL_I16 / 8
const OCTAL_OVERFLOW_LIMIT_MAXABSVAL_I32 = MAXABSVAL_I32 / 8
const OCTAL_OVERFLOW_LIMIT_MAXABSVAL_I64 = MAXABSVAL_I64 / 8
const HEXADECIMAL_OVERFLOW_LIMIT_MAXABSVAL_I8 = MAXABSVAL_I8 / 16
const HEXADECIMAL_OVERFLOW_LIMIT_MAXABSVAL_I16 = MAXABSVAL_I16 / 16
const HEXADECIMAL_OVERFLOW_LIMIT_MAXABSVAL_I32 = MAXABSVAL_I32 / 16
const HEXADECIMAL_OVERFLOW_LIMIT_MAXABSVAL_I64 = MAXABSVAL_I64 / 16
let baseInfosInt8: Array<Array<(UInt64, UInt64, UInt64)>> = [
    [(0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_2, BINARY_OVERFLOW_LIMIT_MAXABSVAL_I8, MAXABSVAL_I8), (0, 0, 0),
        (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (FOTMAT_BASE_NUM_UI64_8, OCTAL_OVERFLOW_LIMIT_MAXABSVAL_I8, MAXABSVAL_I8), (0, 0, 0),
        (FOTMAT_BASE_NUM_UI64_10, DECIMAL_OVERFLOW_LIMIT_MAXABSVAL_I8, MAXABSVAL_I8), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_16, HEXADECIMAL_OVERFLOW_LIMIT_MAXABSVAL_I8, MAXABSVAL_I8)],
    [(0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_2, BINARY_OVERFLOW_LIMIT_I8, MAXVAL_I8), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_8, OCTAL_OVERFLOW_LIMIT_I8, MAXVAL_I8), (0, 0, 0),
        (FOTMAT_BASE_NUM_UI64_10, DECIMAL_OVERFLOW_LIMIT_I8, MAXVAL_I8), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (FOTMAT_BASE_NUM_UI64_16, HEXADECIMAL_OVERFLOW_LIMIT_I8, MAXVAL_I8)]
]
let baseInfosInt16: Array<Array<(UInt64, UInt64, UInt64)>> = [
    [(0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_2, BINARY_OVERFLOW_LIMIT_MAXABSVAL_I16, MAXABSVAL_I16), (0, 0, 0),
        (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (FOTMAT_BASE_NUM_UI64_8, OCTAL_OVERFLOW_LIMIT_MAXABSVAL_I16, MAXABSVAL_I16), (0, 0, 0),
        (FOTMAT_BASE_NUM_UI64_10, DECIMAL_OVERFLOW_LIMIT_MAXABSVAL_I16, MAXABSVAL_I16), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_16, HEXADECIMAL_OVERFLOW_LIMIT_MAXABSVAL_I16, MAXABSVAL_I16)],
    [(0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_2, BINARY_OVERFLOW_LIMIT_I16, MAXVAL_I16), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_8, OCTAL_OVERFLOW_LIMIT_I16, MAXVAL_I16), (0, 0, 0),
        (FOTMAT_BASE_NUM_UI64_10, DECIMAL_OVERFLOW_LIMIT_I16, MAXVAL_I16), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (FOTMAT_BASE_NUM_UI64_16, HEXADECIMAL_OVERFLOW_LIMIT_I16, MAXVAL_I16)]
]
let baseInfosInt32: Array<Array<(UInt64, UInt64, UInt64)>> = [
    [(0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_2, BINARY_OVERFLOW_LIMIT_MAXABSVAL_I32, MAXABSVAL_I32), (0, 0, 0),
        (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (FOTMAT_BASE_NUM_UI64_8, OCTAL_OVERFLOW_LIMIT_MAXABSVAL_I32, MAXABSVAL_I32), (0, 0, 0),
        (FOTMAT_BASE_NUM_UI64_10, DECIMAL_OVERFLOW_LIMIT_MAXABSVAL_I32, MAXABSVAL_I32), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_16, HEXADECIMAL_OVERFLOW_LIMIT_MAXABSVAL_I32, MAXABSVAL_I32)],
    [(0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_2, BINARY_OVERFLOW_LIMIT_I32, MAXVAL_I32), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_8, OCTAL_OVERFLOW_LIMIT_I32, MAXVAL_I32), (0, 0, 0),
        (FOTMAT_BASE_NUM_UI64_10, DECIMAL_OVERFLOW_LIMIT_I32, MAXVAL_I32), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (FOTMAT_BASE_NUM_UI64_16, HEXADECIMAL_OVERFLOW_LIMIT_I32, MAXVAL_I32)]
]
let baseInfosInt64: Array<Array<(UInt64, UInt64, UInt64)>> = [
    [(0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_2, BINARY_OVERFLOW_LIMIT_MAXABSVAL_I64, MAXABSVAL_I64), (0, 0, 0),
        (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (FOTMAT_BASE_NUM_UI64_8, OCTAL_OVERFLOW_LIMIT_MAXABSVAL_I64, MAXABSVAL_I64), (0, 0, 0),
        (FOTMAT_BASE_NUM_UI64_10, DECIMAL_OVERFLOW_LIMIT_MAXABSVAL_I64, MAXABSVAL_I64), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_16, HEXADECIMAL_OVERFLOW_LIMIT_MAXABSVAL_I64, MAXABSVAL_I64)],
    [(0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_2, BINARY_OVERFLOW_LIMIT_I64, MAXVAL_I64), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_8, OCTAL_OVERFLOW_LIMIT_I64, MAXVAL_I64), (0, 0, 0),
        (FOTMAT_BASE_NUM_UI64_10, DECIMAL_OVERFLOW_LIMIT_I64, MAXVAL_I64), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (FOTMAT_BASE_NUM_UI64_16, HEXADECIMAL_OVERFLOW_LIMIT_I64, MAXVAL_I64)]
]
let baseInfosUInt8: Array<Array<(UInt64, UInt64, UInt64)>> = [
    [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)],
    [(0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_2, BINARY_OVERFLOW_LIMIT_UI8, MAXVAL_UI8), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_8, OCTAL_OVERFLOW_LIMIT_UI8, MAXVAL_UI8), (0, 0, 0),
        (FOTMAT_BASE_NUM_UI64_10, DECIMAL_OVERFLOW_LIMIT_UI8, MAXVAL_UI8), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (FOTMAT_BASE_NUM_UI64_16, HEXADECIMAL_OVERFLOW_LIMIT_UI8, MAXVAL_UI8)]
]
let baseInfosUInt16: Array<Array<(UInt64, UInt64, UInt64)>> = [
    [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)],
    [(0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_2, BINARY_OVERFLOW_LIMIT_UI16, MAXVAL_UI16), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_8, OCTAL_OVERFLOW_LIMIT_UI16, MAXVAL_UI16), (0, 0, 0),
        (FOTMAT_BASE_NUM_UI64_10, DECIMAL_OVERFLOW_LIMIT_UI16, MAXVAL_UI16), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (FOTMAT_BASE_NUM_UI64_16, HEXADECIMAL_OVERFLOW_LIMIT_UI16, MAXVAL_UI16)]
]
let baseInfosUInt32: Array<Array<(UInt64, UInt64, UInt64)>> = [
    [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)],
    [(0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_2, BINARY_OVERFLOW_LIMIT_UI32, MAXVAL_UI32), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_8, OCTAL_OVERFLOW_LIMIT_UI32, MAXVAL_UI32), (0, 0, 0),
        (FOTMAT_BASE_NUM_UI64_10, DECIMAL_OVERFLOW_LIMIT_UI32, MAXVAL_UI32), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (FOTMAT_BASE_NUM_UI64_16, HEXADECIMAL_OVERFLOW_LIMIT_UI32, MAXVAL_UI32)]
]
let baseInfosUInt64: Array<Array<(UInt64, UInt64, UInt64)>> = [
    [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)],
    [(0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_2, BINARY_OVERFLOW_LIMIT_UI64, MAXVAL_UI64), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (0, 0, 0), (0, 0, 0), (FOTMAT_BASE_NUM_UI64_8, OCTAL_OVERFLOW_LIMIT_UI64, MAXVAL_UI64), (0, 0, 0),
        (FOTMAT_BASE_NUM_UI64_10, DECIMAL_OVERFLOW_LIMIT_UI64, MAXVAL_UI64), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0),
        (0, 0, 0), (FOTMAT_BASE_NUM_UI64_16, HEXADECIMAL_OVERFLOW_LIMIT_UI64, MAXVAL_UI64)]
]

/**
 * Specifies the data type.
 */
enum TypeBase {
    | I8 /* 8-bit  */
    | UI8 /* U-8-bit  */
    | I16 /* 16-bit  */
    | UI16 /* U-16-bit  */
    | I32 /* 32-bit  */
    | UI32 /* U-32-bit  */
    | I64 /* 64-bit  */
    | UI64 /* U-64-bit  */
}

enum ConvertResult<T> {
    Success(T) | Failure(String)
}

func getBaseInfos(typeBase: TypeBase, isNegative: Int64, rawData: Array<Byte>): (UInt64, UInt64, UInt64) {
    var baseInfos = match (typeBase) {
        case I8 => baseInfosInt8
        case I16 => baseInfosInt16
        case I32 => baseInfosInt32
        case I64 => baseInfosInt64
        case UI8 => baseInfosUInt8
        case UI16 => baseInfosUInt16
        case UI32 => baseInfosUInt32
        case _ => baseInfosUInt64
    }
    var (formatBaseNum, multmin, maxAbsVal): (UInt64, UInt64, UInt64) = match (rawData[1]) {
        case 'b' | 'B' => baseInfos[isNegative][2]
        case 'o' | 'O' => baseInfos[isNegative][8]
        case 'x' | 'X' => baseInfos[isNegative][16]
        case '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' => baseInfos[isNegative][10]
        case _ => (0, 0, 0)
    }
    return (formatBaseNum, multmin, maxAbsVal)
}

func getBaseInfosWithRadix(typeBase: TypeBase, isNegative: Int64, radix: Int64): (UInt64, UInt64, UInt64) {
    var maxAbsVa = match ((typeBase, isNegative)) {
        case (I8, 1) => MAXVAL_I8
        case (I8, 0) => MAXABSVAL_I8
        case (I16, 1) => MAXVAL_I16
        case (I16, 0) => MAXABSVAL_I16
        case (I32, 1) => MAXVAL_I32
        case (I32, 0) => MAXABSVAL_I32
        case (I64, 1) => MAXVAL_I64
        case (I64, 0) => MAXABSVAL_I64
        case (UI8, 1) => MAXVAL_UI8
        case (UI16, 1) => MAXVAL_UI16
        case (UI32, 1) => MAXVAL_UI32
        case _ => MAXVAL_UI64
    }
    let radixUint64 = UInt64(radix)
    return (radixUint64, maxAbsVa / radixUint64, maxAbsVa)
}

/*
 * 1. Remove "'" from the character string.
 * 2. The length of the removed character string must be 1. If the length is not 1,
 *    an empty character string is returned.
 *
 * @param data of Array<Rune>.
 * @return Parameters of Option<Rune>
 */
func strToChar(data: Array<Rune>): Option<Rune> {
    if (data.size < 2 || data[0] != r'\'' || data[data.size - 1] != r'\'') {
        return None
    }
    /* Check special characters. */
    if (data.size == 4 && data[1] == r'\\') {
        match (data[2]) {
            case r'n' => return Option<Rune>.Some(r'\n')
            case r'r' => return Option<Rune>.Some(r'\r')
            case r't' => return Option<Rune>.Some(r'\t')
            case r'b' => return Option<Rune>.Some(r'\b')
            case r'f' => return Option<Rune>.Some(r'\f')
            case r'v' => return Option<Rune>.Some(r'\v')
            case r'0' => return Option<Rune>.Some(r'\0')
            case r'$' => return Option<Rune>.Some(r'$')
            case r'\\' => return Option<Rune>.Some(r'\\')
            case r'\'' => return Option<Rune>.Some(r'\'')
            case _ => return Option<Rune>.None
        }
    }
    /* Determine a single character. */
    if (data.size == 3) {
        return Option<Rune>.Some(data[1])
    }
    /* Check whether it is Unicode. */
    if (data[1] == r'\\' && data[2] == r'u') {
        return unicodeToChar(data)
    }
    return None
}

/*
 * Converts chs to the corresponding numeric type.
 *
 * @Param chs of Rune
 * @return Parameters of UInt64
 *
 * @since 0.17.4
 */
func charToNumber(chs: Rune): UInt64 {
    var value: UInt64 = UInt64(UInt32(chs))
    if (chs == r'A' || chs == r'B' || chs == r'C' || chs == r'D' || chs == r'E' || chs == r'F') {
        return value - 65 + 10
    }
    if (chs == r'a' || chs == r'b' || chs == r'c' || chs == r'd' || chs == r'e' || chs == r'f') {
        return value - 97 + 10
    } else {
        return value - 48
    }
}

func checkChar(formatBaseNum: UInt64, ch: Rune): Bool {
    return match (formatBaseNum) {
        /* ASCII: 0 => 48 1 => 49 */
        case 2 where ch == r'0' || ch == r'1' => true
        /* ASCII: 0 => 48 8 => 49 */
        case 8 where ch >= r'0' && ch <= r'7' => true
        /* SCII: 0 => 48 9 => 57 */
        case 10 where ch >= r'0' && ch <= r'9' => true
        /* ASCII: 0 => 48 9 => 57 A => 65 F => 70 a => 97 f => 102 */
        case 16 where (ch >= r'0' && ch <= r'9') || (ch >= r'A' && ch <= r'F') || (ch >= r'a' && ch <= r'f') => true
        case _ => false
    }
}

func charsToInteger(chars: Array<Rune>, formatBaseNum: UInt64, typeBase!: TypeBase = UI64, onlyNegative!: Bool = false): Option<UInt64> {
    /*
     * Calculate the result of each character based on the formula
     * and sum it up to obtain the final result.
     */
    var maxAbsVal: UInt64 = match (typeBase) {
        case I8 => MAXVAL_I8
        case UI8 => MAXVAL_UI8
        case I16 => MAXVAL_I16
        case UI16 => MAXVAL_UI16
        case I32 => MAXVAL_I32
        case UI32 => MAXVAL_UI32
        case I64 => MAXVAL_I64
        case _ => MAXVAL_UI64
    }
    if (onlyNegative && maxAbsVal != MAXVAL_UI64) {
        maxAbsVal += 1
    }
    var num: UInt64 = 0
    for (ch in chars) {
        /* Whether the character complies with the definition of the hexadecimal type */
        if (checkChar(formatBaseNum, ch)) {
            /* Obtains the number corresponding to char. */
            let digit: UInt64 = charToNumber(ch)
            if ((maxAbsVal / UInt64(formatBaseNum)) < num) {
                return Option<UInt64>.None
            } else {
                num = num * UInt64(formatBaseNum)
            }
            if (maxAbsVal - num < digit) {
                return Option<UInt64>.None
            } else {
                num = num + digit
            }
        } else {
            /* If the definition is not correct, the system returns the value. */
            return Option<UInt64>.None
        }
    }
    return Option<UInt64>.Some(num)
}
/*
 * Escape unicode to char.
 *
 * @Param string of String.
 * @return Parameters of Option<Rune>
 *
 * @since 0.17.4
 */
func unicodeToChar(data: Array<Rune>): Option<Rune> {
    if (data.size < 5 || data[3] != r'{' || data[data.size - 2] != r'}') {
        return None
    }
    match (charsToInteger(data[4..(data.size - 2)], 16)) {
        case Some(n) => Some(Rune(UInt32(n)))
        case None => None
    }
}
