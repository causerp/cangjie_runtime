// Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#ifndef MRT_GENERATION_CONSTANTS_H
#define MRT_GENERATION_CONSTANTS_H

#include "Base/Globals.h"

#include <cstddef>
#include <cstdint>

namespace MapleRuntime {
// Tuning constants of the generational GC.

// Young generation capacity: min(max heap / YOUNG_GEN_CAPACITY_DIVISOR, size caps below).
constexpr size_t YOUNG_GEN_CAPACITY_DIVISOR = 3;
constexpr size_t YOUNG_GEN_MAX_SIZE = 512 * MB;
constexpr size_t YOUNG_CAPACITY_FOR_MIXED_MAX = 256 * MB;
constexpr size_t INITIAL_YOUNG_THRESHOLD = 20 * MB;

// Young GC threshold: youngCapacity * MAX_YOUNG_THRESHOLD_NUM / MAX_YOUNG_THRESHOLD_DEN.
constexpr size_t MAX_YOUNG_THRESHOLD_NUM = 2;
constexpr size_t MAX_YOUNG_THRESHOLD_DEN = 3;

// Mixed GC threshold: maxCapacity * MAX_MIXED_THRESHOLD_NUM / MAX_MIXED_THRESHOLD_DEN.
constexpr size_t MAX_MIXED_THRESHOLD_NUM = 2;
constexpr size_t MAX_MIXED_THRESHOLD_DEN = 3;

// Min mixed GC threshold: max(youngCapacity * MIN_MIXED_THRESHOLD_NUM / MIN_MIXED_THRESHOLD_DEN,
// maxCapacity / MIN_MIXED_THRESHOLD_HEAP_DIVISOR).
constexpr size_t MIN_MIXED_THRESHOLD_NUM = 6;
constexpr size_t MIN_MIXED_THRESHOLD_DEN = 5;
constexpr size_t MIN_MIXED_THRESHOLD_HEAP_DIVISOR = 2;

// Allocation increment prediction window when updating GC thresholds.
constexpr uint64_t PREDICT_WINDOW_MS = 20;

// Growth limit of loose region requests: gcStartAllocated * GROWTH_LIMIT_NUM / GROWTH_LIMIT_DEN.
constexpr size_t GROWTH_LIMIT_NUM = 3;
constexpr size_t GROWTH_LIMIT_DEN = 2;

// Mutator assist budget: min(max(gcStartAllocated / ASSIST_BUDGET_ALLOC_DIVISOR, ASSIST_BUDGET_MIN),
// ASSIST_BUDGET_MAX).
constexpr size_t ASSIST_BUDGET_ALLOC_DIVISOR = 2;
constexpr size_t ASSIST_BUDGET_MIN = 100 * MB;
constexpr size_t ASSIST_BUDGET_MAX = 256 * MB;

// Lower bound of the dynamic assist interval: assistBaseInterval / ASSIST_MIN_INTERVAL_DIVISOR.
constexpr size_t ASSIST_MIN_INTERVAL_DIVISOR = 4;
} // namespace MapleRuntime

#endif // MRT_GENERATION_CONSTANTS_H
