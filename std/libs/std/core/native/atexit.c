/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

#include <stdatomic.h>

static atomic_flag g_atexitCallbackListLocker = ATOMIC_FLAG_INIT;
extern void CJ_CORE_AtExitCallbackListLock(void)
{
    while (atomic_flag_test_and_set(&g_atexitCallbackListLocker)) {
    }
}
extern void CJ_CORE_AtExitCallbackListUnlook(void)
{
    atomic_flag_clear(&g_atexitCallbackListLocker);
}
