/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.ast

public interface ToTokens {
    func toTokens(): Tokens
}

/**
     Basical ToTokens method. List of supporting type in the following.
         + Token, Tokens
         + Int64, Int32, Int16, Int8
         + UInt64, UInt32, UInt16, UInt8
         + Float64, Float32, Float16
         + Bool, Rune, String
 */
extend Token <: ToTokens {
    public func toTokens(): Tokens {
        return this + Tokens()
    }
}

extend Tokens <: ToTokens {
    public func toTokens(): Tokens {
        return this
    }
}

extend Int64 <: ToTokens {
    public func toTokens(): Tokens {
        if (this < 0) {
            return Tokens().append(Token(TokenKind.SUB)).append(Token(TokenKind.INTEGER_LITERAL, this.toString()[1..]))
        }
        let tok: Token = Token(TokenKind.INTEGER_LITERAL, this.toString())
        return tok.toTokens()
    }
}

extend Int32 <: ToTokens {
    public func toTokens(): Tokens {
        if (this < 0) {
            return Tokens().append(Token(TokenKind.SUB)).append(Token(TokenKind.INTEGER_LITERAL, this.toString()[1..]))
        }
        let tok: Token = Token(TokenKind.INTEGER_LITERAL, this.toString())
        return tok.toTokens()
    }
}

extend Int16 <: ToTokens {
    public func toTokens(): Tokens {
        if (this < 0) {
            return Tokens().append(Token(TokenKind.SUB)).append(Token(TokenKind.INTEGER_LITERAL, this.toString()[1..]))
        }
        let tok: Token = Token(TokenKind.INTEGER_LITERAL, this.toString())
        return tok.toTokens()
    }
}

extend Int8 <: ToTokens {
    public func toTokens(): Tokens {
        if (this < 0) {
            return Tokens().append(Token(TokenKind.SUB)).append(Token(TokenKind.INTEGER_LITERAL, this.toString()[1..]))
        }
        let tok: Token = Token(TokenKind.INTEGER_LITERAL, this.toString())
        return tok.toTokens()
    }
}

extend UInt64 <: ToTokens {
    public func toTokens(): Tokens {
        let tok: Token = Token(TokenKind.INTEGER_LITERAL, this.toString())
        return tok.toTokens()
    }
}

extend UInt32 <: ToTokens {
    public func toTokens(): Tokens {
        let tok: Token = Token(TokenKind.INTEGER_LITERAL, this.toString())
        return tok.toTokens()
    }
}

extend UInt16 <: ToTokens {
    public func toTokens(): Tokens {
        let tok: Token = Token(TokenKind.INTEGER_LITERAL, this.toString())
        return tok.toTokens()
    }
}

extend UInt8 <: ToTokens {
    public func toTokens(): Tokens {
        let tok: Token = Token(TokenKind.INTEGER_LITERAL, this.toString())
        return tok.toTokens()
    }
}

extend Float64 <: ToTokens {
    public func toTokens(): Tokens {
        let strPtr = unsafe { CJ_AST_Float64ToCPointer(this) }
        var floatStr = String()
        if (!strPtr.isNull()) {
            floatStr = strPtr.toString()
            unsafe { LibC.free(strPtr) }
        }
        if (this < 0.0) {
            return Tokens().append(Token(TokenKind.SUB)).append(Token(TokenKind.FLOAT_LITERAL, floatStr[1..]))
        }
        let tok: Token = Token(TokenKind.FLOAT_LITERAL, floatStr)
        return tok.toTokens()
    }
}

extend Float32 <: ToTokens {
    public func toTokens(): Tokens {
        if (this < 0.0) {
            return Tokens().append(Token(TokenKind.SUB)).append(Token(TokenKind.FLOAT_LITERAL, this.toString()[1..]))
        }
        let tok: Token = Token(TokenKind.FLOAT_LITERAL, this.toString())
        return tok.toTokens()
    }
}

extend Float16 <: ToTokens {
    public func toTokens(): Tokens {
        if (this < 0.0) {
            return Tokens().append(Token(TokenKind.SUB)).append(Token(TokenKind.FLOAT_LITERAL, this.toString()[1..]))
        }
        let tok: Token = Token(TokenKind.FLOAT_LITERAL, this.toString())
        return tok.toTokens()
    }
}

extend Bool <: ToTokens {
    public func toTokens(): Tokens {
        let tok: Token = Token(TokenKind.BOOL_LITERAL, this.toString())
        return tok.toTokens()
    }
}

extend Rune <: ToTokens {
    public func toTokens(): Tokens {
        var tok: Token = Token(TokenKind.RUNE_LITERAL, this.toString())
        tok.isSingleQuote = true
        return tok.toTokens()
    }
}

func countDelimiter(charArray: Array<Rune>): (UInt16, String, String) {
    var delimiterNum: UInt16 = 0
    var prefix = "\""
    var suffix = "\""
    for (c in charArray) {
        if (c == r'#') {
            delimiterNum++
            prefix = "#" + prefix
            suffix = suffix + "#"
        } else {
            break
        }
    }
    return (delimiterNum, prefix, suffix)
}

extend String <: ToTokens {
    public func toTokens(): Tokens {
        let charArray = this.toRuneArray()
        // If the multiline string is """\n abc""", the value of token should be " abc", need to remove prefix("""\n) and suffix(""").
        if (charArray.size > 6 && this.startsWith("\"\"\"\n") && this.endsWith("\"\"\"")) {
            return Token(TokenKind.MULTILINE_STRING, String(charArray[4..(this.size - 3)])).toTokens()
        }
        let kind = if (this.contains("\n")) {
            TokenKind.MULTILINE_STRING
        } else {
            TokenKind.STRING_LITERAL
        }
        // If the string is "abc", the value of token should be abc, need to remove prefix(") and suffix(").
        if (charArray.size > 1 && this.startsWith("\"") && this.endsWith("\"")) {
            return Token(kind, String(charArray[1..(charArray.size - 1)])).toTokens()
        } else if (charArray.size > 1 && this.startsWith("\'") && this.endsWith("\'")) {
            return Token(SINGLE_QUOTED_STRING_LITERAL, String(charArray[1..(charArray.size - 1)])).toTokens()
        }
        if (this.startsWith("\"\"")) {
            return Token(TokenKind.STRING_LITERAL, " " + this).toTokens()
        } else if (this.startsWith("\'\'")) {
            return Token(TokenKind.SINGLE_QUOTED_STRING_LITERAL, " " + this).toTokens()
        }
        // If the multi raw string is #"abc"#, the value of token should be "abc", need to remove prefix(#") and suffix("#).
        if (charArray.size > 4 && this.startsWith("#") && this.endsWith("#")) {
            let (delimiterNum, prefix, suffix) = countDelimiter(charArray)
            // if the multi raw string is ##"abc"##, the prefix is "##\"" and the len of the string must be more than 6.
            let fixlen = prefix.size
            if ((charArray.size > fixlen * 2) && this.startsWith(prefix) && this.endsWith(suffix)) {
                var tk = Token(TokenKind.MULTILINE_RAW_STRING, String(charArray[fixlen..(this.size - fixlen)]))
                tk.delimiterNum = delimiterNum
                return tk.toTokens()
            }
        }
        return Token(kind, this).toTokens()
    }
}
