// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_PANIC_H
#define MRT_PANIC_H

#include <cassert>
#include <cstdlib>

#include "CangjieRuntime.h"
#include "StackManager.h"

namespace MapleRuntime {
#if defined(MRT_DEBUG) && (MRT_DEBUG == 1)
#if (defined(__OHOS__) && (__OHOS__ == 1))
#define MRT_ASSERT(p, msg) \
    do { \
        if (!(p)) { \
            if (OH_LOG_IsLoggable(LOG_DOMAIN, LOG_TAG, LOG_INFO)) {       \
                OH_LOG_INFO(LOG_APP, "%{public}s:%{public}d:%{public}s", __FILE__, __LINE__, msg);                    \
            } \
            abort(); \
        } \
    } while (0)
#else
#define MRT_ASSERT(p, msg) \
    do { \
        if (!(p)) { \
            (void)PRINT_INFO("%s:%d:%s", __FILE__, __LINE__, msg); \
            abort(); \
        } \
    } while (0)
#endif
#define ASSERT(f) assert(f)
#else
#define MRT_ASSERT(p, msg)
#define ASSERT(f)
#endif
} // namespace MapleRuntime

#endif // MRT_PANIC_H
