// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef CANGJIERUNTIME_TSANATOMICWRAPPER_H
#define CANGJIERUNTIME_TSANATOMICWRAPPER_H

#include <cstddef>
#include <cstdint>

#include "Sanitizer/SanitizerMacros.h"
#include "Sanitizer/SanitizerSymbols.h"

namespace MapleRuntime {
namespace Sanitizer {
// We can get type's size statically using template and so that we can
// just redirect them to the exact tsan function with just right size
// In this case, the reinterpret_cast will always safe to perform
template<typename T, std::size_t Size>
struct TsanAtomicWrapper {};

#define ATOMIC_OPERATIONS(type, size) \
    static inline T Load(const T* addr, int mo) \
    { \
        return REAL(__tsan_atomic##size##_load)(reinterpret_cast<const uint##size##_t*>(addr), mo); \
    } \
    static inline void Store(const T* addr, T val, int mo) \
    { \
        return REAL(__tsan_atomic##size##_store)(reinterpret_cast<const uint##size##_t*>(addr), \
                                                 reinterpret_cast<uint##size##_t&>(val), mo); \
    } \
    static inline T FetchAdd(const T* addr, T val, int mo) \
    { \
        return REAL(__tsan_atomic##size##_fetch_add)(reinterpret_cast<const uint##size##_t*>(addr), \
                                                     reinterpret_cast<uint##size##_t&>(val), mo); \
    } \
    static inline T FetchSub(const T* addr, T val, int mo) \
    { \
        return REAL(__tsan_atomic##size##_fetch_sub)(reinterpret_cast<const uint##size##_t*>(addr), \
                                                     reinterpret_cast<uint##size##_t&>(val), mo); \
    } \
    static inline T FetchAnd(const T* addr, T val, int mo) \
    { \
        return REAL(__tsan_atomic##size##_fetch_and)(reinterpret_cast<const uint##size##_t*>(addr), \
                                                     reinterpret_cast<uint##size##_t&>(val), mo); \
    } \
    static inline T FetchOr(const T* addr, T val, int mo) \
    { \
        return REAL(__tsan_atomic##size##_fetch_or)(reinterpret_cast<const uint##size##_t*>(addr), \
                                                    reinterpret_cast<uint##size##_t&>(val), mo); \
    } \
    static inline T FetchXor(const T* addr, T val, int mo) \
    { \
        return REAL(__tsan_atomic##size##_fetch_xor)(reinterpret_cast<const uint##size##_t*>(addr), \
                                                     reinterpret_cast<uint##size##_t&>(val), mo); \
    } \
    static inline T FetchNand(const T* addr, T val, int mo) \
    { \
        return REAL(__tsan_atomic##size##_fetch_nand)(reinterpret_cast<const uint##size##_t*>(addr), \
                                                      reinterpret_cast<uint##size##_t&>(val), mo); \
    } \
    static inline T Exchange(const T* addr, T val, int mo) \
    { \
        return REAL(__tsan_atomic##size##_exchange)(reinterpret_cast<const uint##size##_t*>(addr), \
                                                    reinterpret_cast<uint##size##_t&>(val), mo); \
    } \
    static inline T CompareExchange(const T* addr, T expVal, T newVal, int mo, int fmo) \
    { \
        return REAL(__tsan_atomic##size##_compare_exchange_val)(reinterpret_cast<const uint##size##_t*>(addr), \
                                                                reinterpret_cast<uint##size##_t>(expVal), \
                                                                reinterpret_cast<uint##size##_t&>(newVal), mo, fmo); \
    }

template<typename T>
// atomic operations for 1 byte (8 bits)
struct TsanAtomicWrapper<T, 1> {
    ATOMIC_OPERATIONS(T, 8)
};

template<typename T>
// atomic operations for 2 byte (16 bits)
struct TsanAtomicWrapper<T, 2> {
    ATOMIC_OPERATIONS(T, 16)
};

template<typename T>
// atomic operations for 4 byte (32 bits)
struct TsanAtomicWrapper<T, 4> {
    ATOMIC_OPERATIONS(T, 32)
};

template<typename T>
// atomic operations for 8 byte (64 bits)
struct TsanAtomicWrapper<T, 8> {
    ATOMIC_OPERATIONS(T, 64)
};
#undef ATOMIC_OPERATIONS
} // namespace Sanitizer
} // namespace MapleRuntime

#endif // CANGJIERUNTIME_TSANATOMICWRAPPER_H
