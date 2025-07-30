// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_CKI_H
#define MRT_CKI_H

#include <cstdint>

#include "Base/Log.h"
#include "schedule.h"

namespace MapleRuntime {
namespace Cki { // cjthreadKeyItems
const uint8_t SLOT_TABLE_SIZE = 8;
extern CJThreadKey cjthreadKeyItems[SLOT_TABLE_SIZE];

enum CJThreadKeySlot {
    SLOT_MUTATOR = 0,
    CKI_SIZE = 1, // Number of Used Slots
    RESERVED_2 = 2,
    RESERVED_3 = 3,
    RESERVED_4 = 4,
    RESERVED_5 = 5,
    RESERVED_6 = 6,
    RESERVED_7 = 7
};

int CreateCKI();

inline int SetCKI(const void* value, CJThreadKeySlot slot)
{
    return CJThreadSetspecific(cjthreadKeyItems[slot], const_cast<void*>(value));
}

inline void* GetCKI(CJThreadKeySlot slot) { return CJThreadGetspecific(cjthreadKeyItems[slot]); }
} // namespace Cki
} // namespace MapleRuntime

#endif // MRT_CKI_H
