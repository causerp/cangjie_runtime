// Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#include "RegionFreeSlotList.h"

namespace MapleRuntime {
std::array<uint8_t, FreeSlotNode::SMALL_SIZE_THRESHOLD + 1> FreeSlotNode::smallSizeToSlotIdx {};

namespace {
struct SizeToSlotMapInitializer {
    SizeToSlotMapInitializer()
    {
        FreeSlotNode::InitSizeToSlotMap();
    }
} g_sizeToSlotMapInitializer;
}
}
