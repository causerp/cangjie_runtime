// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_CALLEE_SAVED_REGISTER_CONTEXT_H
#define MRT_CALLEE_SAVED_REGISTER_CONTEXT_H

#include <cstdint>

namespace MapleRuntime {
#ifdef _WIN64
struct XMMReg {
    uint64_t low;
    uint64_t high;
};
#endif
struct CalleeSavedRegisterContext {
#if (defined(__linux__) || defined(__APPLE__)) && defined(__x86_64__)
    // rbx-r15 correspond to callee saved registers bitmap respectively in stackmap.
    uint64_t rbx;
    uint64_t r12;
    uint64_t r13;
    uint64_t r14;
    uint64_t r15;
    uint64_t rbp;
    uint64_t rsp;
#elif defined(__aarch64__)
    // x19-x28 correspond to callee saved registers bitmap respectively in stackmap.
    uint64_t x19;
    uint64_t x20;
    uint64_t x21;
    uint64_t x22;
    uint64_t x23;
    uint64_t x24;
    uint64_t x25;
    uint64_t x26;
    uint64_t x27;
    uint64_t x28;
    uint64_t x29;
    uint64_t x30;
    uint64_t d8;
    uint64_t d9;
    uint64_t d10;
    uint64_t d11;
    uint64_t d12;
    uint64_t d13;
    uint64_t d14;
    uint64_t d15;
    uint64_t sp;
#elif defined(_WIN64)
    // rbx-r15 correspond to callee saved registers bitmap respectively in stackmap.
    uint64_t rbx;
    uint64_t rsi;
    uint64_t rdi;
    uint64_t r12;
    uint64_t r13;
    uint64_t r14;
    uint64_t r15;
    uint64_t padding;
    XMMReg xmm6;
    XMMReg xmm7;
    XMMReg xmm8;
    XMMReg xmm9;
    XMMReg xmm10;
    XMMReg xmm11;
    XMMReg xmm12;
    XMMReg xmm13;
    XMMReg xmm14;
    XMMReg xmm15;
    uint64_t rbp;
    uint64_t rsp;
    void SetXMMValueByIdx(uint32_t xmmIdx, XMMReg* value)
    {
        constexpr uint64_t calleeSaveXMMIdxOffest = 8; // 8: 7 non-xmm reg + padding
        uint64_t* baseSlotAddr = reinterpret_cast<uint64_t*>(this);
        uint64_t* calleeSaveXMMAddrStart = baseSlotAddr + calleeSaveXMMIdxOffest;
        uint64_t* slotAddr = calleeSaveXMMAddrStart + 2 * xmmIdx; // 2: 16bytes for xmm reg
        *slotAddr = value->low;
        *(++slotAddr) = value->high;
    }
#endif
    void SetValueByIdx(uint32_t idx, uint64_t value)
    {
        uint64_t* baseSlotAddr = reinterpret_cast<uint64_t*>(this);
        uint64_t* slotAddr = baseSlotAddr + idx;
        *slotAddr = value;
    }
};
} // namespace MapleRuntime
#endif // ~MRT_CALLEE_SAVED_REGISTER_CONTEXT_H
