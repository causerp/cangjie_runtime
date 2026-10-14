// Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information

#include "RememberSet.h"

namespace MapleRuntime {

RememberSet& RememberSet::Instance() noexcept
{
    static RememberSet instance;
    return instance;
}

void RememberSet::Record(RegionInfo* source, uintptr_t slotAddr)
{
    if (source == nullptr || !source->IsOldRegion() || slotAddr < source->GetRegionStart() ||
        slotAddr >= source->GetRegionEnd()) {
        return;
    }
    size_t slotIdx = (slotAddr - source->GetRegionStart()) / RegionInfo::RSET_SLOT_SIZE;
    std::lock_guard<std::mutex> lock(mtx_);
    source->MarkRSetSlot(slotIdx);
    rememberedRegions.insert(source);
}

void RememberSet::RemoveRegion(RegionInfo* source)
{
    if (source == nullptr) {
        return;
    }
    std::lock_guard<std::mutex> lock(mtx_);
    rememberedRegions.erase(source);
}

void RememberSet::ClearAll()
{
    std::lock_guard<std::mutex> lock(mtx_);
    rememberedRegions.clear();
}

void RememberSet::MergeFrom(RSetRegions&& local)
{
    std::lock_guard<std::mutex> lock(mtx_);
    rememberedRegions.insert(local.begin(), local.end());
}

} // namespace MapleRuntime
