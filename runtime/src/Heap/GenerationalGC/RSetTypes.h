// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#ifndef MRT_RSET_TYPES_H
#define MRT_RSET_TYPES_H

#include <cstddef>
#include <cstdint>
#include <unordered_set>

namespace MapleRuntime {

class RegionInfo;

using RSetRegions = std::unordered_set<RegionInfo*>;

} // namespace MapleRuntime

#endif // MRT_RSET_TYPES_H
