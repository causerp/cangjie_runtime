// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "Base/ImmortalWrapper.h"
#include "Heap/Allocator/RegionInfo.h"
#include "Heap/Allocator/RegionSpace.h"
#include "ForwardDataManager.h"
#include "LiveInfo.h"

namespace MapleRuntime {
uintptr_t RouteInfo::GetRoute(uint64_t preLiveBytes)
{
    if (preLiveBytes < toRegion1UsedBytes) {
        return toRegion1StartAddress + preLiveBytes;
    } else { // object is routed to to-region2
        CHECK(toRegion2Idx != INVALID_VALUE);
        RegionInfo* toRegion2 = reinterpret_cast<RegionInfo*>(RegionInfo::GetRegionInfo(toRegion2Idx));
        return toRegion2->GetRegionStart() + (preLiveBytes - toRegion1UsedBytes);
    }
}
} // namespace MapleRuntime
