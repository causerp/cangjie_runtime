/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.common

import std.collection.fold

protected interface TextWidth {
    func width(): Int64
}

private func isFullWidth(r: Rune): Bool {
    // These ranges and specific characters are used in
    // implementations of libc's wcwidth
    let ch = UInt32(r)
    return ch >= 0x1100 &&
        (ch <= 0x115f ||                   // Hangul Jamo init. consonants
         ch == 0x2329 || ch == 0x232a ||
         (ch >= 0x2e80 && ch <= 0xa4cf &&  // CJK ... Yi
          ch != 0x303f) ||
         (ch >= 0xac00 && ch <= 0xd7a3) || // Hangul Syllables
         (ch >= 0xf900 && ch <= 0xfaff) || // CJK Compatibility Ideographs
         (ch >= 0xfe10 && ch <= 0xfe19) || // Vertical forms
         (ch >= 0xfe30 && ch <= 0xfe6f) || // CJK Compatibility Forms
         (ch >= 0xff00 && ch <= 0xff60) || // Fullwidth Forms
         (ch >= 0xffe0 && ch <= 0xffe6) ||
         (ch >= 0x20000 && ch <= 0x2fffd) ||
         (ch >= 0x30000 && ch <= 0x3fffd))
}

extend Rune <: TextWidth {
    public func width(): Int64 {
        if (isFullWidth(this)) { 2 } else { 1 }
    }
}

extend String <: TextWidth {
    public func width(): Int64 {
        this.runes() |> fold(0) { acc: Int64, r: Rune => acc + r.width() }
    }
}
