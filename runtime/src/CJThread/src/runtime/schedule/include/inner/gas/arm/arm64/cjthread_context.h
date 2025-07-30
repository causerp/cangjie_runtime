// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef RUNTIME_CJTHREAD_CONTEXT_H
#define RUNTIME_CJTHREAD_CONTEXT_H

struct CJThreadContext {
    unsigned long long GetFrameAddress()
    {
        return x29Fp;
    }
    unsigned long long GetPC()
    {
        return pc;
    }
    unsigned long long x18; /* 0x0 */
    unsigned long long x19; /* 0x8 */
    unsigned long long x20; /* 0x10 */
    unsigned long long x21; /* 0x18 */
    unsigned long long x22; /* 0x20 */
    unsigned long long x23; /* 0x28 */
    unsigned long long x24; /* 0x30 */
    unsigned long long x25; /* 0x38 */
    unsigned long long x26; /* 0x40 */
    unsigned long long x27; /* 0x48 */
    unsigned long long x28; /* 0x50 */
    unsigned long long x29Fp;  /* 0x58 */
    unsigned long long x30Lr;  /* 0x60 */

    /* Note: The pc does not actually save the pc register. PC is set to cjthread_entry and lr
     * is initialized to 0 only during process initialization. In other cases, the values of pc
     * and lr are the same. The cjthread address jumps to the pc, which is to avoid stack push
     * problems. If only lr is used instead of pc, lr is set to cjthread_entry during cjthread
     * initialization. In this case, when the lr register is used for stack push, the upper
     * stack of cjthread_entry points to cjthread_entry itself, and the stack push fails.
     * Similarly, the mcall push stack can be problematic.
     **/
    unsigned long long pc;  /* 0x68 */
    unsigned long long sp;  /* 0x70 */

    /* d8-d15 are the lower 64 bits of the 128-bit floating-point registers v8-v15 */
    unsigned long long d8;  /* 0x78 */
    unsigned long long d9;  /* 0x80 */
    unsigned long long d10; /* 0x88 */
    unsigned long long d11; /* 0x90 */
    unsigned long long d12; /* 0x98 */
    unsigned long long d13; /* 0xa0 */
    unsigned long long d14; /* 0xa8 */
    unsigned long long d15; /* 0xb0 */

    unsigned int fpcr;      /* 0xb8 */
};

extern "C" void CJThreadMcall(void *func, void **gCJThread);

extern "C" void CJThreadMcallNosave(void *func, void **gCJThread);

extern "C" void CJThreadExecute(void *nextCJThread, void **gCJThread);

#ifdef __OHOS__
extern "C" void SingleCJThreadStoreSP();
#endif

extern "C" void CJThreadContextGet(struct CJThreadContext *context);

extern "C" void CJThreadContextSet(struct CJThreadContext *context);

extern "C" void CJThreadContextInit(struct CJThreadContext *context, void *func, char *stackBaseAddr);

#endif // RUNTIME_CJTHREAD_CONTEXT_H
