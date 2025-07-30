// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef RUNTIME_CJTHREAD_CONTEXT_H
#define RUNTIME_CJTHREAD_CONTEXT_H

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif

#define XMM_QUADWORD_SIZE 2

struct CJThreadContext {
    constexpr static unsigned long long MCALL_STACK_SIZE = 8;
    unsigned long long GetFrameAddress()
    {
#ifdef MRT_WINDOWS
        return rsp;
#else
        return rbp;
#endif
    }
    unsigned long long GetPC()
    {
        return rip;
    }
    unsigned long long rsp;  /* 0x0 */
    unsigned long long rbp;  /* 0x8 */
    unsigned long long rbx;  /* 0x10 */
    unsigned long long rip;  /* 0x18 */
    unsigned long long r12;  /* 0x20 */
    unsigned long long r13;  /* 0x28 */
    unsigned long long r14;  /* 0x30 */
    unsigned long long r15;  /* 0x38 */
    unsigned int mxcsr;      /* 0x40 */
    unsigned short fpuCw;   /* 0x44 */
#ifdef MRT_WINDOWS
    unsigned long long rdi;                       /* 0x48 */
    unsigned long long rsi;                       /* 0x50 */
    unsigned long long xmm6[XMM_QUADWORD_SIZE];   /* 0x58 */
    unsigned long long xmm7[XMM_QUADWORD_SIZE];   /* 0x68 */
    unsigned long long xmm8[XMM_QUADWORD_SIZE];   /* 0x78 */
    unsigned long long xmm9[XMM_QUADWORD_SIZE];   /* 0x88 */
    unsigned long long xmm10[XMM_QUADWORD_SIZE];  /* 0x98 */
    unsigned long long xmm11[XMM_QUADWORD_SIZE];  /* 0xa8 */
    unsigned long long xmm12[XMM_QUADWORD_SIZE];  /* 0xb8 */
    unsigned long long xmm13[XMM_QUADWORD_SIZE];  /* 0xc8 */
    unsigned long long xmm14[XMM_QUADWORD_SIZE];  /* 0xd8 */
    unsigned long long xmm15[XMM_QUADWORD_SIZE];  /* 0xe8 */
    unsigned long long gsStackLow;                /* 0xf8 */
    unsigned long long gsStackHigh;               /* 0x100 */
    unsigned long long gsStackDeallocation;       /* 0x108 */
#endif
};

extern void CJThreadMcall(void *func, void **gCJThread);

extern void CJThreadMcallNosave(void *func, void **gCJThread);

extern void CJThreadExecute(void *nextCJThread, void **gCJThread);

#ifdef __OHOS__
extern void SingleCJThreadStoreSP();
#endif

extern void CJThreadContextGet(struct CJThreadContext *context);

extern void CJThreadContextSet(struct CJThreadContext *context);

extern void CJThreadContextInit(struct CJThreadContext *context, void *func, char *stackBaseAddr);

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif

#endif // RUNTIME_CJTHREAD_CONTEXT_H
