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
        return r11fp;
    }
    unsigned long long GetPC()
    {
        return r15pc;
    }

    unsigned int r4;
    unsigned int r5;
    unsigned int r6;
    unsigned int r7;
    unsigned int r8;
    unsigned int r9;
    unsigned int r10;
    unsigned int r11fp;
    unsigned int r13sp;
    unsigned int r14lr;
    unsigned int r15pc;

    unsigned long long d8;
    unsigned long long d9;
    unsigned long long d10;
    unsigned long long d11;
    unsigned long long d12;
    unsigned long long d13;
    unsigned long long d14;
    unsigned long long d15;

    unsigned int fpscr;
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