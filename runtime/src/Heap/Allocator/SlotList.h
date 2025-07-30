// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_SLOT_LIST_H
#define MRT_SLOT_LIST_H

#include "Common/BaseObject.h"

namespace MapleRuntime {
struct ObjectSlot {
    StateWord stateWord; // same with BaseObject::stateWord
    ObjectSlot* next;
};

class SlotList {
public:
    void PushFront(BaseObject* slot)
    {
        ObjectSlot* headSlot = reinterpret_cast<ObjectSlot*>(slot);
        ClearExtraContent(slot);
        headSlot->next = head;
        head = headSlot;
    }

    uintptr_t PopFront(size_t size)
    {
        if (head == nullptr || size != reinterpret_cast<BaseObject*>(head)->GetSize()) {
            return 0;
        }
        ObjectSlot* allocSlot = head;
        head = head->next;
        allocSlot->next = nullptr;
        return reinterpret_cast<uintptr_t>(allocSlot);
    }

    void Clear() { head = nullptr; }

    // Clear the rest memory of slot object if the slot object size is greater than ObjectSlot(16 Bytes).
    void ClearExtraContent(BaseObject* slot)
    {
        size_t size = slot->GetSize() - sizeof(ObjectSlot);
        if (size > 0) {
            MAddress start = reinterpret_cast<uintptr_t>(slot) + sizeof(ObjectSlot);
            CHECK_E((memset_s(reinterpret_cast<void*>(start), size, 0, size) != EOK), "memset_s fail");
        }
    }

private:
    ObjectSlot* head = nullptr;
};
} // namespace MapleRuntime
#endif // MRT_SLOT_LIST_H