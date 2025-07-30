// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_ITABLE_VTABLE_H
#define MRT_ITABLE_VTABLE_H

// the interface for itable and vtable
#include "Common/TypeDef.h"

namespace MapleRuntime {
// VTable is currently not used directly in runtime.
// just declare to clarify its content.
struct VTable { // vtable doesn't
    FuncRef vtable[0];
};

// from itab_util.h in MapleRuntime
struct ITable {
    // constants
    static constexpr U32 ITAB_FIRST_HASH_SIZE = 23;
    static constexpr I32 FLAG_SECOND_HASH_CONFLICT = 1;

    // fields
    FuncRef l1Table[ITAB_FIRST_HASH_SIZE];

    U16 l2Size;
    U16 l3Size;
    U32 padding; // align to 64 bits.

    // l2Table is sorted by hash value ascendingly
    struct L2Entry {
        U64 hash;
        FuncRef func;
    };
    L2Entry l2Table[];

    // l3Table has signature and funcref
    // in file they're encoded as relative offset and MUID
    struct L3Entry {
        const char* signature;
        FuncRef func;
    };

    // functions
    inline FuncRef GetFunc(const char* signature, U32 hash, U32 secondHash);
    inline const L3Entry* GetL3Table() const;
    inline U32 GetL2Size() const;
    inline U32 GetL3Size() const;
    FuncRef GetFuncSlow(const char* signature, U32 secondHash) const;
};
} // namespace MapleRuntime
#endif // MRT_ITABLE_VTABLE_H
