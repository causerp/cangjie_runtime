/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file The file declares the RegexOption class.
 */
package std.regex

import std.collection.*

const REGEX_NORMAL = 0x00000000u32
const REGEX_IGNORECASE = 0x00000008u32
const REGEX_MULTILINE = 0x00000400u32
const REGEX_UNICODE = 0x00020000u32 | 0x00080000u32

public enum RegexFlag {
    | IgnoreCase
    | MultiLine
    | Unicode

    func value(): UInt32 {
        return match (this) {
            case IgnoreCase => REGEX_IGNORECASE
            case MultiLine => REGEX_MULTILINE
            case Unicode => REGEX_UNICODE
        }
    }

    static func getValue(flags: Array<RegexFlag>): UInt32 {
        var value = REGEX_NORMAL
        for (flag in flags) {
            value |= flag.value()
        }
        return value
    }
}

@Deprecated[message: "Use `public enum RegexFlag` instead."]
public class RegexOption <: ToString {
    private var option: UInt32

    public init() {
        option = REGEX_NORMAL
    }

    public func ignoreCase(): RegexOption {
        option |= REGEX_IGNORECASE
        return this
    }

    public func multiLine(): RegexOption {
        option |= REGEX_MULTILINE
        return this
    }

    public func toString(): String {
        if (option == REGEX_NORMAL) {
            return "NORMAL"
        }
        var options = ArrayList<String>()
        if ((option & REGEX_IGNORECASE) == REGEX_IGNORECASE) {
            options.add("IGNORECASE")
        }
        if ((option & REGEX_MULTILINE) == REGEX_MULTILINE) {
            options.add("MULTILINE")
        }
        if ((option & REGEX_UNICODE) == REGEX_UNICODE) {
            options.add("REGEX_UNICODE")
        }
        return String.join(options.toArray(), delimiter: ",")
    }

    func toFlags(): Array<RegexFlag> {
        var flags = ArrayList<RegexFlag>()
        if ((option & REGEX_IGNORECASE) == REGEX_IGNORECASE) {
            flags.add(IgnoreCase)
        }
        if ((option & REGEX_MULTILINE) == REGEX_MULTILINE) {
            flags.add(MultiLine)
        }
        if ((option & REGEX_UNICODE) == REGEX_UNICODE) {
            flags.add(Unicode)
        }
        return flags.toArray()
    }
}
