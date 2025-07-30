// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_MARCO_DEF_H
#define MRT_MARCO_DEF_H

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif

/* x86 */
#ifndef MRT_X86
#define MRT_X86 0
#endif

/* arm */
#ifndef MRT_ARM
#define MRT_ARM 1
#endif

/* windows x86 */
#ifndef MRT_WINDOWS_X86
#define MRT_WINDOWS_X86 2
#endif

/* INLINE is used for include file
 * STATIC_INLINE is used for cpp file
 */
#if defined(MRT_DEBUG) && (MRT_DEBUG == 1)
#define MRT_INLINE inline
#define MRT_STATIC_INLINE
#else
#define MRT_INLINE inline __attribute__((always_inline))
#define MRT_STATIC_INLINE static inline  __attribute__((always_inline))
#endif

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif
#endif /* MRT_MARCO_DEF_H */
