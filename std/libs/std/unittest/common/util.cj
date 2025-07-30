/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.common

import std.collection.enumerate
import std.convert.Formattable

private func isNonPrintable(char: Rune): Bool {
    let cp = UInt32(char)
    // characters with codepoints 0x00..0x1F are basic ascii control characters (C0)
    // 0x7F is DEL, also a control character
    // characters with codepoints 0x80..0x9F are extended control characters (C1)
    // NOTE: some of the characters handled separately in shieldEscapeSeq
    // are also in this ranges, which is by design
    if (0x00 <= cp && cp <= 0x1F || 0x7f <= cp && cp <= 0x9f) {
        return true
    }
    return false
}

private func asCodePointEscape(char: Rune): String {
    let resultBuilder = StringBuilder("\\u{")
    let cp = UInt32(char)
    if (cp <= 0xffff) {
        resultBuilder.append(cp.format("04x"))
    } else {
        resultBuilder.append(cp.format("08x"))
    }
    resultBuilder.append(r'}')
    return resultBuilder.toString()
}

/**
 * Escape the given string: print non-printable characters like control characters
 * as their escaped variants. Also escape any utf-8 sequences longer than 1 byte.
 * For example, TAB, CR or LF are printed as r'\t', r'\r' and r'\n' respectively,
 * and will be printed as '\u6211'. All one-byte utf-8 characters are left as-is.
 * Random-generated data may (and probably will) contain characters that may break the terminal,
 * so in order to be safe we try to escape such things when printing this data.
 */
protected func shieldEscapeSeq(
    s: String,
    shieldSingleQuote!: Bool = true,
    shieldDoubleQuote!: Bool = true,
    shieldBackslash!: Bool = true,
    shieldInterpolation!: Bool = true
): String {
    let resultBuilder = StringBuilder()
    let runes = s.toRuneArray()
    for ((i, ch) in runes |> enumerate) {
        match (ch) {
            case r'\0' => resultBuilder.append("\\0")
            case r'\\' where shieldBackslash => resultBuilder.append("\\\\")
            case r'\b' => resultBuilder.append("\\b")
            case r'\f' => resultBuilder.append("\\f")
            case r'\n' => resultBuilder.append("\\n")
            case r'\r' => resultBuilder.append("\\r")
            case r'\t' => resultBuilder.append("\\t")
            case r'\v' => resultBuilder.append("\\v")
            case r'\'' where shieldSingleQuote => resultBuilder.append("\\\'")
            case r'\"' where shieldDoubleQuote => resultBuilder.append("\\\"")
            case r'\$' where shieldInterpolation && i < runes.size - 1 && runes[i + 1] == r'{' => resultBuilder.append(
                "\\\$")
            case _ =>
                if (isNonPrintable(ch)) {
                    resultBuilder.append(asCodePointEscape(ch))
                } else {
                    resultBuilder.append(ch)
                }
        }
    }
    return resultBuilder.toString()
}

extend PrettyPrinter {
    protected func space() {
        append(" ")
    }

    protected func appendLine() {
        appendLine("")
    }
}
