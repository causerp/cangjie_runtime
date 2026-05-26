// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include <cstdint>
#include "schedule_impl.h"

#ifdef __cplusplus
extern "C" {
#endif

struct CJThreadKeyInternal g_cjthreadKeys;

int CJThreadKeyCreateInner(CJThreadKey *key, DestructorFunc destructor)
{
    unsigned int index;
    if (key == nullptr) {
        return ERRNO_SCHD_CJTHREAD_KEY_INVALID;
    }

    index = atomic_load(&g_cjthreadKeys.count);
    do {
        if (index >= CJTHREAD_KEYS_MAX) {
            return ERRNO_SCHD_CJTHREAD_KEY_FULL;
        }
    } while (!atomic_compare_exchange_weak(&g_cjthreadKeys.count, &index, index + 1u));
    atomic_store(&g_cjthreadKeys.keyDestructor[index], (uintptr_t)destructor);
    *key = index;

    return 0;
}

int CJThreadSetspecificInner(CJThreadKey key, void *value)
{
    struct CJThread *cjthread = CJThreadGet();
    if (cjthread == nullptr) {
        return ERRNO_SCHD_CJTHREAD_NULL;
    }
    if (key >= CJTHREAD_KEYS_MAX) {
        return ERRNO_SCHD_CJTHREAD_KEY_INVALID;
    }
    if (key >= g_cjthreadKeys.count) {
        return ERRNO_SCHD_CJTHREAD_KEY_INVALID;
    }
    cjthread->localData[key] = value;
    return 0;
}

void *CJThreadGetspecificInner(CJThreadKey key)
{
    struct CJThread *cjthread = CJThreadGet();
    if (cjthread == nullptr) {
        return nullptr;
    }
    if (key >= CJTHREAD_KEYS_MAX) {
        return nullptr;
    }
    if (key >= g_cjthreadKeys.count) {
        return nullptr;
    }
    return cjthread->localData[key];
}

void CJThreadKeysClean(struct CJThread *cjthread)
{
    unsigned int i;
    DestructorFunc func;
    unsigned int count = atomic_load(&g_cjthreadKeys.count);
    if (UNLIKELY(count > CJTHREAD_KEYS_MAX)) {
        HILOG_FATAL(ERRNO_SCHD_CJTHREAD_KEY_FULL,
                    "cjthread key count %u exceeds max %u", count, CJTHREAD_KEYS_MAX);
    }
    for (i = 0; i < count; i++) {
        func = reinterpret_cast<DestructorFunc>(atomic_load(&g_cjthreadKeys.keyDestructor[i]));
        if (cjthread->localData[i] != nullptr) {
            if (func != nullptr) {
                func(cjthread->localData[i]);
            }
            cjthread->localData[i] = nullptr;
        }
    }
}

#ifdef __cplusplus
}
#endif