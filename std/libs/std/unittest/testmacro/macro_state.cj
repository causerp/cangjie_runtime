/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
macro package std.unittest.testmacro

import std.ast.*
import std.collection.*
import std.collection.concurrent.ConcurrentHashMap
import std.sync.AtomicUInt64

type MacroAttrs = HashMap<MacroKey, ArrayList<Tokens>>

//NOTE: this is a temporary implementation, until we have contextual macros
class MacroStorage {
    private static let globalMutableState = ConcurrentHashMap<String, Tokens>()
    private static let globalCounter = AtomicUInt64(0)

    private static let TEST_GENERATED_PREFIX = quote(@Attribute[TEST_GENERATED])
    private static let ATTR_PREFIX = quote(@Attribute[)

    private static func store(key: MacroKey, args: Tokens): String {
        let index = globalCounter.fetchAdd(1)
        let uniqueId = "${key.attrPrefix}${index}"
        globalMutableState[uniqueId] = args
        return uniqueId
    }

    static func saveAsAttribute(key: MacroKey, declTokens: Tokens, args: Tokens): Tokens {
        let uniqueId = Token(IDENTIFIER, store(key, args))
        let tb = TokensBuilder()
        match {
            case declTokens.startsWith(ATTR_PREFIX) =>
                let newCode = Tokens(collectArray(declTokens)[ATTR_PREFIX.size..])
                tb.append(ATTR_PREFIX).append(uniqueId).append(TokenKind.COMMA).append(newCode).toTokens()
            case _ => tb
                .append(ATTR_PREFIX)
                .append(uniqueId)
                .append(quote(]))
                .append(TokenKind.NL)
                .append(declTokens)
                .toTokens()
        }
    }

    static func loadAttrsByKey(key: MacroKey, decl: Decl): ArrayList<Tokens> {
        let result = ArrayList<Tokens>()
        for (anno in decl.annotations) {
            for (attr in anno.attributes) {
                if (attr.value.startsWith(key.attrPrefix)) {
                    let loaded = globalMutableState.get(attr.value) ?? continue
                    result.add(loaded)
                }
            }
        }
        return result
    }

    static func loadAllAttrs(decl: Decl): MacroAttrs {
        let result = MacroAttrs()
        for (key in SUPPORTED_MACROS) {
            let attributesByKey = loadAttrsByKey(key, decl)
            if (!attributesByKey.isEmpty()) {
                result[key] = attributesByKey
            }
        }
        result
    }

    static func markTestGenerated(tb: TokensBuilder) {
        tb.append(TEST_GENERATED_PREFIX)
    }

    static func verifyNotYetGenerated(generating: MacroKey, originalTokens: Tokens): Unit {
        if (let Some(alreadyGenerated) <- findAlreadyGenerated(originalTokens)) {
            if (alreadyGenerated == generating) {
                MacroErrors.doThrow("${generating} macro is not repeatable.")
            } else {
                MacroErrors.doThrow("${generating} cannot be used with ${alreadyGenerated}.")
            }
        }
    }

    static func findAlreadyGenerated(tokens: Tokens): ?MacroKey {
        if (tokens.startsWith(TEST_GENERATED_PREFIX)) {
            return TEST_MACRO
        }
        let isTestBuilderGenerated = tokens.startsWith(ATTR_PREFIX) &&
            tokens.size >= 4 && tokens[3].value.startsWith(TEST_BUILDER_MACRO.attrPrefix)
        if (isTestBuilderGenerated) {
            return TEST_BUILDER_MACRO
        }
        return None
    }
}

extend Decl {
    func loadSingle(key: MacroKey): ?Tokens {
        MacroStorage.loadAttrsByKey(key, this).get(0)
    }

    func loadRepeatable(key: MacroKey): ArrayList<Tokens> {
        MacroStorage.loadAttrsByKey(key, this)
    }

    func has(key: MacroKey): Bool {
        loadSingle(key).isSome()
    }
}
