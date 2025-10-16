/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
macro package std.unittest.testmacro

import std.ast.*
import std.collection.ArrayList

// stack functions for ArrayList
extend<T> ArrayList<T> {
    func push(value: T): Unit {
        add(value)
    }

    func pop(): ?T {
        if (size == 0) {
            None
        } else {
            remove(at: size - 1)
        }
    }

    prop top: ?T {
        get() {
            if (size == 0) { None } else { get(size - 1) }
        }
    }
}


/**
 * A simple stateful parser class. Now use for @Types macro, later will be used for other macros too.
 */
class DSLParser {
    // current index in input
    var inputIndex: Int64 = 0

    DSLParser(let input: Tokens) {
        skipIgnored()
    }

    // current token, or Token(END) if input ended
    prop currentToken: Token {
        get() { if (inputIndex < input.size) { input[inputIndex] } else { Token(END) } }
    }

    // move forward to next token, skip ignored tokens
    func nextToken() {
        if (completed()) {
            return
        }
        inputIndex++
        skipIgnored()
    }

    // skip ignored tokens, such as newlines, comments and END
    func skipIgnored() {
        while (!completed()) {
            match (currentToken.kind) {
                case NL | COMMENT | END => inputIndex++
                case _ => break
            }
        }
    }

    // Expect a specific token as current, if current token is not that,
    // throw exception. Advances input.
    func expectToken(kind: TokenKind): Token {
        if (currentToken.kind != kind) {
            throw MacroException(
                "Expected ${kind} at index ${inputIndex}, got `${currentToken.value}` of kind ${currentToken.kind}"
            )
        } else {
            let result = currentToken
            nextToken()
            return result
        }
    }

    // parse a number of balanced entities (treating round, square and angle brackets as balanced)
    // using delimiter token as separator between entities
    // and terminator as end signifier
    // example: (a + b[2]), 3, <a b>(4)| => [[(a + b[2])], [3], [<a b>(4)]]
    // if r',' is delimiter and r'|' is terminator
    func parseBalancedDelimited(delimiter!: TokenKind, terminator!: TokenKind): Array<Tokens> {
        let result = ArrayList<Tokens>()
        var current = TokensBuilder()
        while (true) {
            let once = parseBalanced(terminator: delimiter)
            current.append(once)
            if (currentToken.kind == delimiter) {
                nextToken()
                result.add(current.toTokens())
                current = TokensBuilder()
                continue
            } else if (currentToken.kind == terminator) {
                result.add(current.toTokens())
                break
            }
        }
        return result.toArray()
    }

    // parse single balanced entity (treating round, square and angle brackets as balanced)
    // until terminator token, end of input or top-level closing bracket is reached
    // throws MacroException is input is unbalanced (such as '<)>')
    func parseBalanced(terminator!: TokenKind = TokenKind.END): Tokens {
        let stack = ArrayList<TokenKind>()
        let tb = TokensBuilder()
        func opposite(tk: TokenKind): ?TokenKind {
            match (tk) {
                case LPAREN => RPAREN
                case LSQUARE => RSQUARE
                case LT => GT
                case RPAREN => LPAREN
                case RSQUARE => LSQUARE
                case GT => LT
                case _ => None
            }
        }

        while (!completed()) {
            // '>>' and '<<' are always treated as two tokens, so we
            // don't need to handle them
            match (currentToken.kind) {
                case LPAREN | LSQUARE | LT =>
                    stack.push(currentToken.kind)
                case RPAREN | RSQUARE | GT =>
                    // in a balanced input, top-level closing brace is
                    // end of "our" scope
                    if (stack.size == 0) {
                        return tb.toTokens()
                    }
                    let top = stack.pop()
                    match ((top, opposite(currentToken.kind))) {
                        case (Some(a), Some(b)) where a == b => ()
                        case _ =>
                            throw MacroException("Incorrect token sequence: ${tb.toTokens()} ${currentToken.value}")
                    }
                    if (stack.size == 0) {
                        tb.append(currentToken)
                        nextToken()
                        return tb.toTokens()
                    }
                case tk where tk == terminator =>
                    if (stack.size == 0) {
                        return tb.toTokens()
                    }
                case _ => ()
            }
            tb.append(currentToken)
            nextToken()
        }
        // if we reached end and stack is not empty, we have unbalanced input
        if (stack.size != 0) {
            throw MacroException("Incorrect token sequence: ${tb.toTokens()}")
        }
        return tb.toTokens()
    }

    // did this parser reach the end of input?
    func completed(): Bool {
        return inputIndex >= input.size
    }
}
