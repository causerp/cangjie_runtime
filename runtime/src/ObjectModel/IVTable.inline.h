// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_ITABLE_VTABLE_INLINE_H
#define MRT_ITABLE_VTABLE_INLINE_H

#include "IVTable.h"

namespace MapleRuntime {
inline FuncRef ITable::GetFunc(const char* signature, U32 hash, U32 secondHash)
{
    auto func = l1Table[hash % ITAB_FIRST_HASH_SIZE];
    if (func != nullptr) {
        return func;
    }
    return GetFuncSlow(signature, secondHash);
}

inline U32 ITable::GetL2Size() const { return l2Size; }

inline U32 ITable::GetL3Size() const { return l3Size; }

inline const ITable::L3Entry* ITable::GetL3Table() const
{
    U32 l2SizeU32 = GetL2Size();
    return reinterpret_cast<const L3Entry*>(&l2Table[l2SizeU32]);
}
} // namespace MapleRuntime

#endif // MRT_ITABLE_VTABLE_INLINE_H
