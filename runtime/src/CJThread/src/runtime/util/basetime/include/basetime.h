// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_BASETIME_H
#define MRT_BASETIME_H

#include "mid.h"
#include "macro_def.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif

/**
 * @brief Obtains a nanosecond representation of the current time.
 * @par Description: Number of nanoseconds from 00:00:00 on January 1, 1970 to the present time.
 * @retval Returns the number of nanoseconds of the current time.
 */
unsigned long long CurrentNanotimeGet(void);

/**
 * @brief Obtain the current CPU clock cycle.
 * @par Description: Obtain the current CPU clock cycle.
 * @retval Return the number of current CPU clock cycles.
 */
unsigned long long CurrentCPUTicks(void);

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif
#endif /* MRT_BASETIME_H */
