/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.math.numeric

import std.convert.*
import std.math.*

extend BigInt <: Parsable<BigInt> {
    /**
     * Translate a value presented by string @p value into a BigInt.
     * The form of @p value string follows the BNF 'IntegerString' shown below.
     *
     * IntegerString
     *     : SignString? BaseString? ValueString
     *
     * SignString
     *     : '+' | '-'
     *
     * BaseString
     *     : '0b' | '0B' | '0o' | '0O' | '0x' | '0X'
     *
     * ValueString
     *     : digit*
     *
     * digit
     *     : '0' ~ '9' | 'A' ~ 'F' | 'a' ~ 'f'
     *
     * where the digit follows the restriction:
     * - if the BaseString is '0b' or '0B', then digit should belong to '0' ~ '1';
     * - if the BaseString is '0o' or '0O', then digit should belong to '0' ~ '7';
     * - if the BaseString is '0x' or '0X', then digit should belong to '0' ~ '9', 'a' ~ 'f' or 'A' ~ 'F' ;
     * - if the BaseString does not exist, then digit should belong to '0' ~ '9';
     *
     * @param value: the string to translate to the BigInt;
     *
     * @throws IllegalArgumentException
     * - if @p value does match the required string format
     */
    public static func parse(value: String): BigInt {
        // parse SignString
        var (isNeg, start) = parseSign(value)
        // parse BaseString
        let (radix, baseLength) = (parseBase(value, start))
        start += baseLength
        // parse ValueString
        let (int, arr) = parseDigits(value, start, radix)
        if (int == 0 && arr.size == 0) {
            isNeg = false // no -0 for bigint
        }
        return BigInt(int, arr, isNeg)
    }

    public static func tryParse(value: String): ?BigInt {
        try {
            return parse(value)
        } catch (e: Exception) {
            return None
        }
    }
}

extend BigInt <: RadixConvertible<BigInt> {
    /**
     * Translate a value presented by string @p value into a BigInt.
     * Here, @p value is a string form of a @p radix number.
     * The form of @p value string follows the BNF 'IntegerString' shown below.
     *
     * IntegerString
     *     : SignString? ValueString
     *
     * SignString
     *     : '+' | '-'
     *
     * ValueString
     *     : digit+
     *
     * digit
     *     : '0' ~ '9' | 'A' ~ 'Z' | 'a' ~ 'z'
     *
     * where the digit follows the restriction:
     * - if digit belongs to 0 ~ 9, then (digit - r'0') < radix;
     * - if digit belongs to r'A' ~ r'Z', then (digit - r'A') + 10 < radix;
     * - if digit belongs to r'a' ~ r'z', then (digit - r'A') + 10 < radix.
     *
     * @param value: the string form of the specific base number to translate to the BigInt;
     * @param radix: the radix of the number in translation.
     *
     * @throws IllegalArgumentException
     * - if @p value does match the required string format
     * - if @p radix does not in the range of [2, 36].
     */
    public static func parse(value: String, radix!: Int64): BigInt {
        if (radix < 2 || radix > 36) {
            throw IllegalArgumentException("The radix should in the range of [2, 36].")
        }
        let (int, intArr, negSign) = parseString(value, UInt64(radix))
        return BigInt(int, intArr, negSign)
    }

    public static func tryParse(value: String, radix!: Int64): ?BigInt {
        try {
            return parse(value, radix: radix)
        } catch (e: Exception) {
            return None
        }
    }

    /**
     * Return the String representation of this BigInteger in the given radix.
     *
     * @param radix: the radix of this BigInt.
     *
     * @return: string representation of this BigInteger in the given radix.
     *
     * @throws IllegalArgumentException if @p radix does not in the range of [2, 36]
     */
    public func toString(radix!: Int64): String {
        return this.convertToString(radix)
    }
}

private let HEX_LOWER_MAP = "0123456789abcdef".toArray()
private let HEX_UPPER_MAP = "0123456789ABCDEF".toArray()
private let DECIMAL_MAP = "0123456789".toArray()

extend BigInt <: Formattable {
    /**
     * The format of @p fmt is as follows:
     *
     * Format
     *  : Flag? Width? Precision? Specifier?
     *
     * Flag
     *  : '-' | '+' | '#' | '0'
     *
     * Width
     *  : Integer
     *
     * Precision
     *  : '.' Integer
     *
     * Specifier
     *  :  'b' | 'B' | 'o' | 'O' | 'x' | 'X'
     *
     * The data layout in BigInt is as follows:
     *
     *  0x 1010 1010 1010 1010 1010 1010 1010 1010
     *    |-- [1] --|-- [0] --|------- int -------|
     */
    public func format(fmt: String): String {
        // no fast path - the int.format have a bug like: 0x10.format("010.5x") is the same as 0x10.format("10.5x"), which flag 0 does not work.

        // verify `fmt`
        if (!(Verify(fmt).verifyIntFormatArg())) {
            throw IllegalArgumentException("Wrong format string '" + fmt + "' for 'UInt' type.")
        }
        // prase `fmt`
        let (flag, width, precision, specifier) = parseFormat(fmt)

        // convert BigInt number
        let numberString = toNumberString(specifier, precision)

        // caculate the prefix
        let prefix = cacultePrefix(flag, specifier)

        // padding ' ' or '0', before or after the number
        return paddingString(flag, width, prefix, numberString)
    }

    private func paddingString(flag: Flags, width: Int64, prefix: String, numberString: String): String {
        let paddingSize = width - (prefix.size + numberString.size)
        if (paddingSize <= 0) { // no padding
            return match (prefix.isEmpty()) { // reduce the use of StringBuilder
                case true => numberString
                case false => prefix + numberString
            }
        }

        let paddingString = match (flag) {
            case Flags.Zero => String(Array<Rune>(paddingSize, repeat: r'0'))
            case _ => String(Array<Rune>(paddingSize, repeat: r' '))
        }

        return match (flag) {
            case Flags.Minus => prefix + numberString + paddingString
            case Flags.Zero => prefix + paddingString + numberString
            case _ => paddingString + prefix + numberString
        }
    }

    private func toNumberString(specifier: Rune, precision: Int64): String {
        func fillZeroByPrecision(numberString: String, precision: Int64): String {
            if (precision <= numberString.size) { // include precision < 0
                return numberString
            }

            // fill '0' before number
            return String(Array<Rune>(precision - numberString.size, repeat: r'0')) + numberString
        }

        // fast path for 0
        if (int == 0 && intArr.size == 0) {
            return fillZeroByPrecision("0", precision)
        }

        let numberString = match (specifier) {
            case r'b' | r'B' => toBinary()
            case r'o' | r'O' => toOctal()
            case r'x' | r'X' => toHex(specifier == r'X')
            case _ => toDecimal()
        }
        return fillZeroByPrecision(numberString, precision)
    }

    private func toBinary(): String {
        return toStringByBits(1, DECIMAL_MAP)
    }

    private func toOctal(): String {
        return toStringByBits(3, DECIMAL_MAP) // 3 bits indicate 1 ocatal
    }

    private func toHex(upper: Bool): String {
        let hexMap = match (upper) {
            case true => HEX_UPPER_MAP
            case false => HEX_LOWER_MAP
        }

        return toStringByBits(4, hexMap) // 4 bits indicate 1 hex
    }

    private func toStringByBits(stepSize: Int64, map: Array<Byte>) {
        let reader = BitsReader(this, stepSize)
        let length = reader.caculateSteps()
        let buffer = Array<Byte>(length, repeat: 0)

        reader.forEach {
            idx, byte => buffer[idx] = map[Int64(byte)]
        }
        return unsafe { String.fromUtf8Unchecked(buffer) }
    }

    private func toDecimal(): String {
        let numberStringWithSign = toString(radix: 10)
        return match (negSign) {
            case true => numberStringWithSign[1..] // ignore the '-' in number String
            case false => numberStringWithSign
        }
    }

    private func cacultePrefix(flag: Flags, specifier: Rune) {
        let sign = match ((this.negSign, flag)) {
            case (true, _) => "-"
            case (_, Flags.Plus) => "+"
            case (_, _) => ""
        }
        let ns = match ((flag, specifier)) {
            case (Flags.Sharp, r'b') => "0b"
            case (Flags.Sharp, r'B') => "0B"
            case (Flags.Sharp, r'o') => "0o"
            case (Flags.Sharp, r'O') => "0O"
            case (Flags.Sharp, r'x') => "0x"
            case (Flags.Sharp, r'X') => "0X"
            case _ => ""
        }
        return match ((sign, ns)) { // reduce the use of StringBuilder
            case ("", "") => ""
            case (_, "") => sign
            case ("", _) => ns
            case _ => sign + ns
        }
    }
}

/**
 * The data layout in BigInt is as follows:
 *
 *  0x 1010 1010 1010 1010 1010 1010 1010 1010
 *    |-- [1] --|-- [0] --|------- int -------|
 *
 * @return the bits length without sign
 */
private func caculateBitsLen(bigInt: BigInt): Int64 {
    if (bigInt.intArr.size == 0) {
        if (bigInt.int == 0) {
            return 1
        }
        return 64 - leadingZeros(bigInt.int)
    }

    return (64 - leadingZeros(bigInt.intArr[bigInt.intArr.size - 1])) + (bigInt.intArr.size - 1) * 32 + 64
}

/**
 * Read the bits by step in BigInt.
 * The value of BigInt must not be 0.
 * The step should be less than 8.
 */
class BitsReader {
    private let int: UInt64
    private let bitsLen: Int64 // bits length except the sign
    private let stepSize: Int64

    private let intArr: Array<UInt32>
    private var intArrReadIdx: Int64

    private var buffer: UInt64 = 0
    private var bufferReadIdx = 0

    private var readBits = 0

    init(bigInt: BigInt, stepSize: Int64) {
        this.int = bigInt.int
        this.intArr = bigInt.intArr
        this.bitsLen = caculateBitsLen(bigInt)
        this.stepSize = stepSize
        this.intArrReadIdx = intArr.size - 1
    }

    func caculateSteps(): Int64 {
        return match (bitsLen % stepSize == 0) { // The value of bitsLen must be greater than 0
            case true => bitsLen / stepSize
            case false => bitsLen / stepSize + 1
        }
    }

    func forEach(action: (Int64, Byte) -> Unit): Unit {
        var step = 0
        action(step, first())
        while (hasNext()) {
            step++
            action(step, next(stepSize))
        }
    }

    private func first(): Byte {
        var firstStepBits = bitsLen % stepSize
        if (firstStepBits == 0) {
            firstStepBits = stepSize
        }

        // init the buffer
        if (intArrReadIdx < 0) { // should read int
            buffer = int
        } else if (intArrReadIdx == 0) {
            buffer = UInt64(intArr[intArrReadIdx])
            intArrReadIdx--
        } else {
            buffer = (UInt64(intArr[intArrReadIdx]) << 32) | UInt64(intArr[intArrReadIdx - 1])
            intArrReadIdx -= 2
        }
        bufferReadIdx = leadingZeros(buffer)

        return next(firstStepBits)
    }

    private func next(n: Int64): Byte {
        let remainLen = 64 - bufferReadIdx
        if (remainLen >= n) {
            return read(n)
        }

        var byte = read(remainLen) << (n - remainLen)
        fill()
        byte |= read(n - remainLen)
        return byte
    }

    private func fill(): Unit {
        if (intArrReadIdx < 0) { // should read int
            buffer = int
            bufferReadIdx = 0
        } else if (intArrReadIdx == 0) {
            buffer = UInt64(intArr[intArrReadIdx])
            intArrReadIdx--
            bufferReadIdx = 32 // ignore the high 32 bits
        } else {
            buffer = (UInt64(intArr[intArrReadIdx]) << 32) | UInt64(intArr[intArrReadIdx - 1])
            intArrReadIdx -= 2
            bufferReadIdx = 0
        }
    }

    @OverflowWrapping
    private func read(n: Int64): Byte { // n shoule be less than 8
        let byte = UInt8((buffer << bufferReadIdx) >> (64 - n)) // read n bits from buffer
        bufferReadIdx += n
        readBits += n
        return byte
    }

    private func hasNext(): Bool {
        return readBits < bitsLen
    }
}
