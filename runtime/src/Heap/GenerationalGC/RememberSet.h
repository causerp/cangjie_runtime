// Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information

#ifndef MRT_REMEMBER_SET_H
#define MRT_REMEMBER_SET_H

#include <cstddef>
#include <cstdint>
#include <mutex>
#include <unordered_set>
#include <utility>

#include "Allocator/RegionInfo.h"
#include "RSetTypes.h"

namespace MapleRuntime {

// RememberSet stores only old regions. Each old region owns the card table
// that identifies its slots containing old-to-young references.

class RememberSet {
public:
    static RememberSet& Instance() noexcept;

    void Record(RegionInfo* source, uintptr_t slotAddr);
    void RemoveRegion(RegionInfo* source);

    template <typename Func>
    void VisitRememberedSlots(Func&& func)
    {
        RSetRegions regions;
        {
            std::lock_guard<std::mutex> lock(mtx_);
            regions = rememberedRegions;
        }
        for (RegionInfo* source : regions) {
            if (!source->IsOldRegion()) {
                continue;
            }
            VisitRegionSlots(source, func);
        }
    }

    void ClearAll();
    void MergeFrom(RSetRegions&& local);

    RememberSet(const RememberSet&) = delete;
    RememberSet& operator=(const RememberSet&) = delete;

private:
    RememberSet() = default;
    ~RememberSet() = default;

    template <typename Func>
    static void VisitRegionSlots(RegionInfo* source, Func&& func)
    {
        for (size_t slotIdx = 0; slotIdx < source->GetRSetSlotCount(); ++slotIdx) {
            if (source->IsRSetSlotMarked(slotIdx)) {
                func(source->GetRegionStart() + slotIdx * RegionInfo::RSET_SLOT_SIZE);
            }
        }
    }

    RSetRegions rememberedRegions;
    std::mutex mtx_;
};

} // namespace MapleRuntime

#endif // MRT_REMEMBER_SET_H
