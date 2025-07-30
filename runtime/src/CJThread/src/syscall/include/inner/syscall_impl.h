// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#ifndef MRT_CJTHREAD_SYSCALL_IMPL_H
#define MRT_CJTHREAD_SYSCALL_IMPL_H

#include "mid.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif

void SyscallEnter(void);

void SyscallExit(void);

/**
 * @brief Non-blocking system call with 3 arguments
 * @par syscall(int number, arg1, arg2, arg3),
 * This method is basically the same as the Linux system call. The only difference is that
 * before the system call is entered, if the current context is a cjthread, the processor
 * and thread are unbound. After the call is complete, the processor is bound.
 * This method supports only three additional parameters.
 * @attention If the number of parameters is less than 3, fill them with 0.
 * @param  number           [IN]  Sequence number of the system call
 * @retval Return value of the corresponding system call.
 */
extern int Syscall3(int number, ...);

/**
 * @brief Non-blocking system call with 6 arguments
 * @par syscall(int number, arg1, arg2, arg3, arg4, arg5, arg6),
 * This method is basically the same as the Linux system call. The only difference is that
 * before the system call is entered, if the current context is a cjthread, the processor
 * and thread are unbound. After the call is complete, the processor is bound.
 * This method supports only six additional parameters.
 * @attention If the number of parameters is less than 6, fill them with 0.
 * @param  number           [IN]  Sequence number of the system call
 * @retval Return value of the corresponding system call.
 */
extern int Syscall6(int number, ...);

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif
#endif /* MRT_CJTHREAD_SYSCALL_IMPL_H */
