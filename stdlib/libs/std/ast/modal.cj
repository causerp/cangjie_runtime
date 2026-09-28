/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.ast

// Local mode carried by a modal AST node, mirroring the compiler's ASTMode.
// NONE means no modal is set; the other three correspond to the source spellings
// @~local (NOT), @local? (HALF) and @local! (FULL).
public enum ASTMode {
    MODAL_NONE |
    MODAL_NOT |
    MODAL_HALF |
    MODAL_FULL

    public operator func ==(right: ASTMode): Bool {
        match (this) {
            case MODAL_NONE => match (right) {
                case MODAL_NONE => true
                case _ => false
            }
            case MODAL_NOT => match (right) {
                case MODAL_NOT => true
                case _ => false
            }
            case MODAL_HALF => match (right) {
                case MODAL_HALF => true
                case _ => false
            }
            case MODAL_FULL => match (right) {
                case MODAL_FULL => true
                case _ => false
            }
        }
    }

    public operator func !=(right: ASTMode): Bool {
        return !(this == right)
    }
}

// A parsed postfix modal such as `@local!` / `@local?` / `@~local`, attached to a Type, CallExpr,
// PrimitiveTypeExpr, FuncDecl or ThisParam. `Empty()` is true when there is no modal.
public class ModalInfo {
    init() {}
    init(at: Token, local: Token, mode: ASTMode, marker: Token) {
        at_ = at
        local_ = local
        mode_ = mode
        marker_ = marker
    }
    private var at_: Token = Token(TokenKind.AT)
    private var local_: Token = Token(TokenKind.IDENTIFIER, "local")
    private var marker_: Token = Token()
    private var mode_: ASTMode = ASTMode.MODAL_NONE

    public mut prop at: Token {
        get() { at_ }
        set(v) { at_ = v }
    }
    public mut prop local: Token {
        get() { local_ }
        set(v) { local_ = v }
    }
    // For NOT the marker is '~'; for FULL it is '!'; for HALF it is '?'. Empty for NOT-without-tilde
    // (not used: @~local always has the tilde) and for NONE.
    public mut prop marker: Token {
        get() { marker_ }
        set(v) { marker_ = v }
    }
    public mut prop mode: ASTMode {
        get() { mode_ }
        set(v) { mode_ = v }
    }

    // True when no modal is set (NONE).
    public func Empty(): Bool {
        return mode_ == ASTMode.MODAL_NONE
    }

    public func toTokens(): Tokens {
        if (mode_ == ASTMode.MODAL_NONE) {
            return Tokens()
        }
        var ret = Tokens().append(at_)
        if (mode_ == ASTMode.MODAL_NOT) {
            // @~local
            ret.append(marker_)
        }
        ret.append(local_)
        if (mode_ == ASTMode.MODAL_FULL || mode_ == ASTMode.MODAL_HALF) {
            ret.append(marker_)
        }
        return ret
    }

    protected func dump(indent: UInt16): String {
        if (mode_ == ASTMode.MODAL_NONE) {
            return ""
        }
        var ret = getIndent(indent) + "ModalInfo {\n"
        ret += getTokenIndent("-at", at_, indent + 1)
        if (mode_ == ASTMode.MODAL_NOT) {
            ret += getTokenIndent("-marker", marker_, indent + 1)
        }
        ret += getTokenIndent("-local", local_, indent + 1)
        if (mode_ == ASTMode.MODAL_FULL || mode_ == ASTMode.MODAL_HALF) {
            ret += getTokenIndent("-marker", marker_, indent + 1)
        }
        ret += getIndent(indent) + "}\n"
        return ret
    }
}

// Build a ModalInfo from a flatbuffer NodeFormat_ModalInfo. Returns a default (empty) ModalInfo
// when the optional field is absent.
func createModalInfo(modal: Option<NodeFormat_ModalInfo>): ModalInfo {
    var info = match (modal) {
        case Some(v) => v
        case None => return ModalInfo()
    }
    var mode = match (info.GetLocal()) {
        case NodeFormat_ASTMode.ASTMode_AST_MODE_NONE => ASTMode.MODAL_NONE
        case NodeFormat_ASTMode.ASTMode_AST_MODE_NOT => ASTMode.MODAL_NOT
        case NodeFormat_ASTMode.ASTMode_AST_MODE_HALF => ASTMode.MODAL_HALF
        case NodeFormat_ASTMode.ASTMode_AST_MODE_FULL => ASTMode.MODAL_FULL
    }
    if (mode == ASTMode.MODAL_NONE) {
        return ModalInfo()
    }
    let at = Token(TokenKind.AT).addPosition(info.GetAtPos())
    let localPos = info.GetLocalPos()
    // localPos is the start of the modal text: for NOT it is the position of '~', otherwise the
    // position of 'local'. The marker ('~' for NOT) precedes 'local'; '!'/'?' follow it.
    let local = if (mode == ASTMode.MODAL_NOT) {
        Token(TokenKind.IDENTIFIER, "local").addPosition(localPos.fileId, localPos.line, localPos.column + 1)
    } else {
        Token(TokenKind.IDENTIFIER, "local").addPosition(localPos)
    }
    var marker = Token()
    if (mode == ASTMode.MODAL_NOT) {
        marker = Token(TokenKind.BITNOT, "~").addPosition(localPos)
    } else if (mode == ASTMode.MODAL_FULL) {
        marker = Token(TokenKind.NOT, "!").addPosition(localPos.fileId, localPos.line, localPos.column + 5)
    } else if (mode == ASTMode.MODAL_HALF) {
        marker = Token(TokenKind.QUEST, "?").addPosition(localPos.fileId, localPos.line, localPos.column + 5)
    }
    return ModalInfo(at, local, mode, marker)
}
