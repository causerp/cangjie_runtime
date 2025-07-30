// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_STACKSIZE_VARINT_H
#define MRT_STACKSIZE_VARINT_H

#include "StackMap/StackMapTable.h"

namespace MapleRuntime {
class StacksizeVarInt {
public:
    StacksizeVarInt(U8* ptr, U32 bitPos) : value(ptr, bitPos) { ResolveVarInt(); }
    explicit StacksizeVarInt(const BitsManager& bitsManager) : value(bitsManager) { ResolveVarInt(); }
    ~StacksizeVarInt() = default;

    BitsManager GetNextTable() const { return nextTable; }

    U32 GetStacksize() const { return stacksize; }

private:
    void ResolveVarInt()
    {
        VarInt sizeBits(value);
        VarPair varPair = sizeBits.GetValue();
        stacksize = varPair.first;
        nextTable = value.GetNext(varPair.second);
    }
    BitsManager value;
    BitsManager nextTable;
    U32 stacksize{ 0 };
};
} // namespace MapleRuntime

#endif // ~MRT_STACKSIZE_VARINT_H