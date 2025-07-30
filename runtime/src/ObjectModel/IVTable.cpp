// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "Base/Log.h"
#include "IVTable.inline.h"

namespace MapleRuntime {
FuncRef ITable::GetFuncSlow(const char* signature, U32 secondHash) const
{
    U32 low = 0;
    U32 high = GetL2Size();
    CHECK_DETAIL(high != 0, "itable size is 0");
    U32 index = 0;
    while (low <= high) {
        index = (low + high) >> 1;
        U32 srchash = l2Table[index].hash;
        if (srchash == secondHash) {
            // found
            break;
        }
        if (srchash < secondHash) {
            low = index + 1;
        } else {
            high = index - 1;
        }
    }
    FuncRef addr = l2Table[index].func;
    if (LIKELY(reinterpret_cast<Uptr>(addr) != FLAG_SECOND_HASH_CONFLICT)) {
        return addr;
    }

    // search in L3 table
    const L3Entry* l3Entry = GetL3Table();
    U32 l3Size = GetL3Size();
    for (U32 i = 0; i < l3Size; ++i) {
        const L3Entry* l3EntryItem = &l3Entry[i];
        if (strcmp(signature, l3EntryItem->signature) == 0) {
            return l3EntryItem->func;
        }
    }
    return nullptr;
}
} // namespace MapleRuntime
