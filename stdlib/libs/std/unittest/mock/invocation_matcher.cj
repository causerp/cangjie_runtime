/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

import std.collection.*
import std.unittest.mock.internal.ParameterInfo

enum MatchStatus {
    Ok
    | FuncMismatch
    | ReceiverMismatch
    | ArgumentMismatch( /*mismatchedPositions: */ Array<Int64>)
    | TypeArgMismatch( /*mismatchedPositions: */ Array<Int64>)
}

struct StubDescription {
    StubDescription(
        let fullCall: String,
        let prefixRefName: Option<String>,
        let location: Location
    ) {}
}

// NOTE: VerifyStatement and StubChain classes are basically wrappers around InvocationMatcher
class InvocationMatcher {
    let positionalMatchers = ArrayList<ArgumentMatcher>()

    InvocationMatcher(
        argumentMatchers: Array<ArgumentMatcher>,
        let typeParameters: Array<String>,
        let stubId: StubId,
        let description: StubDescription
    ) {
        let positionalParams = ArrayList<ParameterInfo>()
        let namedParams = ArrayList<ParameterInfo>()
        for (param in stubId.funcInfo.params) {
            if (!param.isNamed) {
                positionalParams.add(param)
            } else {
                namedParams.add(param)
            }
        }
        for ((index, param) in positionalParams |> enumerate) {
            if (param.position - 1 != index) {
                internalError("Inconsistent information for ${stubId.funcInfo.id.shortName}")
            }
            let matcherByPosition = argumentMatchers.get(index) ?? internalError(
                InconsistentState(
                    "Wrong number of matchers provided: ${argumentMatchers.size}" +
                        ", declaration has ${stubId.funcInfo.params.size} parameters"))
            positionalMatchers.add(matcherByPosition)
        }
        for (param in namedParams) {
            if (param.position - 1 != positionalMatchers.size) {
                internalError("Inconsistent information for ${stubId.funcInfo.id.shortName}")
            }
            let matchersWithThisName = argumentMatchers |>
                filter {
                matcher: ArgumentMatcher => matcher.getParameterName() == Some(param.name)
            } |> collectArray
            match (matchersWithThisName.size) {
                case 1 => positionalMatchers.add(matchersWithThisName[0])
                case 0 => positionalMatchers.add(Matchers.any())
                case _ => illegalInput("Several matchers with the same parameter name: ${param.name}")
            }
        }
    }

    func tryMatch(invocation: Invocation): MatchStatus {
        if (invocation.stubId.funcInfo.id != stubId.funcInfo.id) {
            return MatchStatus.FuncMismatch
        }
        if (invocation.stubId.receiverId != stubId.receiverId) {
            return MatchStatus.ReceiverMismatch
        }

        let typeArgsMismatchedPositions = ArrayList<Int64>()
        for (typeArgPosition in 0..invocation.call.typeArgs.size) {
            if (invocation.call.typeArgs[typeArgPosition] != typeParameters[typeArgPosition]) {
                typeArgsMismatchedPositions.add(typeArgPosition)
            }
        }
        if (!typeArgsMismatchedPositions.isEmpty()) {
            return MatchStatus.TypeArgMismatch(typeArgsMismatchedPositions.toArray())
        }

        let mismatchedPositions = ArrayList<Int64>()
        for (argumentPosition in 0..invocation.call.args.size) {
            if (!positionalMatchers[argumentPosition].matchesAny(invocation.call.args[argumentPosition])) {
                mismatchedPositions.add(argumentPosition)
            }
        }
        if (!mismatchedPositions.isEmpty()) {
            return MatchStatus.ArgumentMismatch(mismatchedPositions.toArray())
        }
        return MatchStatus.Ok
    }

    func matches(invocation: Invocation): Bool {
        match (tryMatch(invocation)) {
            case Ok => true
            case _ => false
        }
    }
}
