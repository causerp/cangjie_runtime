/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.ast

import std.collection.ArrayList

public class TokensIterator <: Iterator<Token> {
    /* Fields */
    private var position: Int64 = -1
    private let data: Tokens

    /* Constructors */

    public init(tokens: Tokens) {
        data = tokens
    }

    /* Methods */

    /** Returns the current Option<Token>. */
    public func peek(): Option<Token> {
        if (position >= data.size || position < 0) {
            return None<Token>
        }
        return Some(data[position])
    }

    /** Returns true if current token is the kind, otherwise false. */
    public func seeing(kind: TokenKind): Bool {
        return match (this.peek()) {
            case Some(obj) => obj.kind == kind
            case None => false
        }
    }

    /** Returns next Option<Token>. */
    public func next(): Option<Token> {
        // This is not quite right. Why do we need to add a Token(END) in the end?
        if (position < data.size) {
            position = position + 1
        }
        return peek()
    }
}

// This function is used in macro desugar and we don't want this function be public,
// the implicit used functions must be toplevel so we encapsulate refreshPosition().
func refreshTokensPosition(tks: Tokens) {
    return tks.refreshPosition()
}

public open class Tokens <: ToString & Iterable<Token> & ToBytes {
    /* Invariant: `tokens` is immutable; after construction, we never alter its elements */

    /* Fields */
    protected var tokens: ArrayList<Token> = ArrayList<Token>(0)

    func refreshPosition() {
        var newTokens: ArrayList<Token> = ArrayList<Token>(0)
        for (tk in tokens) {
            newTokens.add(refreshPos(tk, tk.pos.fileID, tk.pos.line, tk.pos.column))
        }
        tokens = newTokens
        return this
    }

    /* Constructors */

    /** Create an empty tokens. */
    public init() {
    }

    /** Create a new tokens from tokens' bytes. */
    init(buf: Array<UInt8>) {
        if (buf.size == 0) {
            return
        }
        var off: Int64 = 0
        let sizeOfTokens: UInt32 = getUInt32(buf[off..off + 4])
        off = off + 4
        for (_ in 0..Int64(sizeOfTokens)) {
            let tokenId: UInt16 = getUInt16(buf[off..off + 2])
            off = off + 2
            let strLen = getUInt32(buf[off..off + 4])
            off = off + 4
            let value: String = getString(buf, off, strLen)
            off = off + value.size
            let fileID: UInt32 = getUInt32(buf[off..off + 4])
            off = off + 4
            let line: Int32 = getInt32(buf[off..off + 4])
            off = off + 4
            let column: Int32 = getInt32(buf[off..off + 4])
            off = off + 4
            var tokenKind = getTokenKind(tokenId)
            let isSingle: UInt16 = getUInt16(buf[off..off + 2])
            if (tokenKind == STRING_LITERAL && isSingle == 1) {
                tokenKind = SINGLE_QUOTED_STRING_LITERAL
            }
            off = off + 2
            var token: Token = Token(tokenKind, value, fileID, line, column)
            if (isSingle == 1) {
                token.isSingleQuote = true
            }
            if (tokenKind == TokenKind.MULTILINE_RAW_STRING) {
                token.delimiterNum = getUInt16(buf[off..off + 2])
                off = off + 2
            }
            tokens.add(token)
        }
    }

    /** Create a new tokens from token array. */
    public init(tokArray: Array<Token>) {
        tokens.add(all: tokArray)
    }

    /** Create a new tokens from token array. */
    public init(tokArrayList: ArrayList<Token>) {
        // We need to copy the elements over in order to guarantee the invariant
        // that `tokens` is immutable.
        tokens.add(all: tokArrayList)
    }

    /* Methods */

    /** Returns the size of tokens. */
    public open prop size: Int64 {
        get() {
            return tokens.size
        }
    }

    /** Returns the token from the index, if the index is out of bound or its element is null then throws IndexOutOfBoundsException. */
    public open func get(index: Int64): Token {
        if (index < 0 || index >= tokens.size) {
            throw IndexOutOfBoundsException("index is ${index} but the size of tokens is ${tokens.size}")
        }
        return tokens[index]
    }

    /** Returns an iterator over the tokens. */
    public func iterator(): TokensIterator {
        return TokensIterator(this)
    }

    /** Returns the concatenation of this Tokens and the argument. */
    public func concat(tokens: Tokens): Tokens {
        return ConcatTokens(this, tokens)
    }

    /* Operator functions */

    /** Returns the token at the specified index. */
    public operator func [](index: Int64): Token {
        return this.get(index)
    }

    public open operator func [](range: Range<Int64>): Tokens {
        return Tokens(tokens[range])
    }

    /** Returns a tokens which is the result of concatenating `ts1` and `ts2`. */
    public operator func +(r: Tokens): Tokens {
        return this.concat(r)
    }

    /** Returns a tokens which is the result of concatenating `ts1` and `t2`. */
    public operator func +(r: Token): Tokens {
        var rts: Tokens = Tokens(Array<Token>(1, repeat: r))
        return this.concat(rts)
    }

    /** Returns current tokens which is the result of concatenating this and `tks`. */
    public open func append(tokens: Tokens): Tokens {
        for (tk in tokens) {
            this.tokens.add(tk)
        }
        return this
    }

    /** Returns current tokens which is the result of concatenating this and `tk`. */
    public open func append(token: Token): Tokens {
        tokens.add(token)
        return this
    }

    public func append(node: Node): Tokens {
        this.append(node.toTokens())
        return this
    }

    public func remove(index: Int64): Tokens {
        tokens.remove(at: index)
        return this
    }

    /** Print the information of this tokens. */
    public func dump(): Unit {
        for (tk in this) {
            tk.dump()
        }
    }

    /** Convert Tokens to String. */
    public func toString(): String {
        // This API is just for pretty printing. Do not use this for production code.
        // For example, prviously if we have a MULTILINE_RAW_STRING Token:  #"hello\123"# 
        // When we toSting that Token, we get: "hello\123", which is wrong, and will cause
        // a internal compiler error when lexing. I have fixed that in tokenToString function,
        // but still, be careful when you use this API.
        if (size == 0) {
            return ""
        } else if (size == 1) {
            return tokenToString(this[0])
        }
        var tokBytes: CPointer<UInt8> = unsafePointerCastFromUint8Array((this).toBytes())
        var spaceFlag: CPointer<Bool> = unsafe { LibC.malloc<Bool>(count: size) }
        if (spaceFlag.isNull()) {
            unsafe { LibC.free(tokBytes) }
            throw IllegalMemoryException("malloc failed!")
        }
        unsafe { CJ_CheckAddSpace(tokBytes, spaceFlag) }
        var toStr: String = ""
        var indentStr = "    "
        try {
            var indent = 0;
            for (loop in 0..this.size) {
                if (this[loop].kind == TokenKind.RCURL && indent > 0) {
                    indent = indent - 1
                }
                // add indentation string
                if (loop != 0 && this[loop - 1].kind == TokenKind.NL) {
                    toStr = toStr + indentStr * indent
                }
                if (this[loop].kind == TokenKind.LCURL) {
                    indent = indent + 1
                }
                toStr = toStr + tokenToString(this[loop])
                // add space
                if (unsafe { spaceFlag.read(loop) }) {
                    toStr = toStr + " "
                }
            }
        } finally {
            unsafe { LibC.free(tokBytes) }
            unsafe { LibC.free(spaceFlag) }
        }
        return toStr
    }

    public func toBytes(): Array<UInt8> {
        let numberOfTokens: Int64 = this.size
        if (numberOfTokens == 0) {
            return Array<UInt8>(0, {_ => 0})
        }

        let size = getSize()
        let arr = Array<UInt8>(size, repeat: 0)
        var start = 0

        start = castUInt32ToBytes(arr, start, UInt32(numberOfTokens))

        for (i in 0..numberOfTokens) {
            start = this[i].toBytes(arr, start)
        }

        return arr
    }

    func toBytes(startFrom: Int64): Array<UInt8> {
        let numberOfTokens: Int64 = this.size - startFrom
        if (numberOfTokens <= 0) {
            return Array<UInt8>(0, {_ => 0})
        }

        let size = getSize(startFrom: startFrom)
        let arr = Array<UInt8>(size, repeat: 0)
        var start = 0

        start = castUInt32ToBytes(arr, start, UInt32(numberOfTokens))

        for (i in startFrom..this.size) {
            start = this[i].toBytes(arr, start)
        }

        return arr
    }

    func getSize(startFrom!: Int64 = 0) {
        let numberOfTokens: Int64 = this.size
        var size = 0;
        for (i in startFrom..numberOfTokens) {
            size += this[i].getSize()
        }
        let size_numberOfTokens = 4
        return size + size_numberOfTokens
    }
}

func tokenToString(tk: Token): String {
    var ret: String = " "
    let quoteMark: String = if (tk.isSingleQuote) {
        "\'"
    } else {
        "\""
    }
    if (tk.kind == TokenKind.MULTILINE_RAW_STRING) {
        var delimiter: String = ""
        var cnt = tk.delimiterNum
        while (cnt > 0) {
            delimiter += "#"
            cnt--
        }
        if (tk.value.endsWith("\\")) {
            ret = delimiter + "\\" + quoteMark + tk.value + "\\" + quoteMark + delimiter
        } else {
            ret = delimiter + quoteMark + tk.value + quoteMark + delimiter
        }
    } else if (tk.kind == TokenKind.MULTILINE_STRING) {
        ret = quoteMark + quoteMark + quoteMark + "\n" + tk.value + quoteMark + quoteMark + quoteMark
    } else if (tk.kind == TokenKind.STRING_LITERAL || tk.kind == TokenKind.SINGLE_QUOTED_STRING_LITERAL) {
        ret = quoteMark + tk.value + quoteMark
    } else if (tk.kind == TokenKind.JSTRING_LITERAL) {
        if (tk.value.endsWith("\\")) {
            ret = "J\\" + quoteMark + tk.value + "\\" + quoteMark
        } else {
            ret = "J" + quoteMark + tk.value + quoteMark
        }
    } else if (tk.kind == TokenKind.RUNE_LITERAL) {
        ret = "r" + quoteMark + tk.value + quoteMark
    } else {
        ret = tk.value
    }
    return ret
}

class ConcatTokens <: Tokens {
    /* Invariant: by construction, the `tokens` field inherited from Tokens is always empty. */
    /* Invariant: `cachedSize` is the `leftChild.size + rightChild.size` */

    /* Fields */
    private let leftChild: Tokens
    private var rightChild: Tokens
    private var cachedSize: Int64

    /* Constructors */

    /** Create a concatenation between a left Tokens subtree and a right Tokens subtree. */
    init(lc: Tokens, rc: Tokens) {
        // In the long run, we can do more here to balance the resulting tree. See AVL trees
        // and red-black trees. This makes a difference, because successive concatenation
        // tends to create left-leaning trees: (((ts1 + ts2) + ts3) + ts4) + ...

        leftChild = lc
        rightChild = rc
        cachedSize = leftChild.size + rightChild.size
    }

    /* Methods */

    /** Returns the size of tokens. */
    public override prop size: Int64 {
        get() {
            return cachedSize
        }
    }

    /** Returns the token from the index, if the index is out of bound or its element is null then throws IndexOutOfBoundsException. */
    public override func get(index: Int64): Token {
        if (index < 0 || index >= size) {
            throw IndexOutOfBoundsException("index is ${index} but the size of tokens is ${size}")
        }
        let leftChildSize = leftChild.size
        if (index < leftChildSize) {
            return leftChild[index]
        } else {
            return rightChild[index - leftChildSize]
        }
    }

    public operator func [](range: Range<Int64>): Tokens {
        if (range.step != 1) {
            throw IllegalArgumentException("Illegal step ${range.step}, step should be 1")
        }

        if (range.start < 0 || range.end < range.start || range.end > size) {
            throw IndexOutOfBoundsException("the range is illegal or out of bound of index of the tokens")
        }

        let leftChildSize = leftChild.size
        if (range.end <= leftChildSize) {
            return leftChild[range]
        } else if (range.start >= leftChildSize) {
            return rightChild[(range.start - leftChildSize)..(range.end - leftChildSize)]
        } else {
            return leftChild[range.start..leftChildSize] + rightChild[0..(range.end - leftChildSize)]
        }
    }

    /** Returns current ConcatTokens which is the result of concatenating leftChild + rightChild + tks. */
    public override func append(tks: Tokens): Tokens {
        rightChild = rightChild + tks
        cachedSize += tks.size
        return this
    }

    /** Returns current ConcatTokens which is the result of concatenating leftChild + rightChild + tk. */
    public override func append(tk: Token): Tokens {
        rightChild = rightChild + tk
        cachedSize += 1
        return this
    }
}
