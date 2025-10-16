/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

import std.unittest.mock.internal.*

class Invocation {
    let stubId: StubId

    Invocation(
        let mockObject: Option<MockObject>,
        let call: Call,
        let location: Location
    ) {
        stubId = StubId(call.funcInfo, mockObject?.id ?? 0)
    }
}

class StubId <: Hashable & Equatable<StubId> {
    StubId(
        let funcInfo: FuncInfo,
        let receiverId: UInt64
    ) {}

    @OverflowWrapping
    public func hashCode(): Int64 {
        return Int64(receiverId) + 31 * funcInfo.id.hashCode()
    }

    public operator func ==(that: StubId): Bool {
        return this.receiverId == that.receiverId && this.funcInfo.id == that.funcInfo.id
    }

    public operator func !=(that: StubId): Bool {
        return this.receiverId != that.receiverId || this.funcInfo.id != that.funcInfo.id
    }
}
