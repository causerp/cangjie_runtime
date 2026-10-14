// Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#include "RSetUpdateBarrier.h"
#include "Allocator/RegionInfo.h"
#include "Mutator/Mutator.h"

namespace MapleRuntime {

void RSetUpdateBarrier::WriteReference(BaseObject* obj, RefField<>* field, BaseObject* target)
{
    if (!Heap::IsHeapAddress(obj) || !Heap::IsHeapAddress(target)) { return; }
    RegionInfo* objRegion = RegionInfo::GetRegionInfoAt(reinterpret_cast<uintptr_t>(obj));
    RegionInfo* refRegion = RegionInfo::GetRegionInfoAt(reinterpret_cast<uintptr_t>(target));
    if (objRegion->IsOldRegion() && !refRegion->IsOldRegion()) {
        Mutator* mutator = Mutator::GetMutator();
        if (mutator != nullptr) {
            mutator->RecordLocalRSetSlot(objRegion, reinterpret_cast<uintptr_t>(field));
        }
    }
}

} // namespace MapleRuntime
