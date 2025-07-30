// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_EXCEPTION_MANAGER_H
#define MRT_EXCEPTION_MANAGER_H

#include <vector>

#include "Cangjie.h"
#include "Base/CString.h"
#include "Common/TypeDef.h"
#include "Exception/ExceptionCApi.h"

namespace MapleRuntime {
using ExceptionRaiser = void (*)(int, void*);
class ExceptionManager {
public:
    ExceptionManager() {}
    ~ExceptionManager() = default;

    enum ImplicitExceptionType : uint8_t {
        OOM = 0,       // OutOfMemoryError
        SOF = 1,       // StackOverflowError
        OOMR = 2,      // OutOfMemoryRecursionError
        INCOMP = 3,    // IncompatiblePackageExpection
        MAX_COUNT = 4, // implicit exception count
    };

    // runtime required lifecycle interfaces
    void Init()
    {
        uncaughtExceptionHandler.hapPath = nullptr;
    };
    void Fini() const {};

    static void OutOfMemory(); // should it be no-return
    static void StackOverflow(uint32_t adjustedSize, void* ip);
    static void IncompatiblePackageExpection(CString msg); // should it be no-return

    static void DumpException();
    static void ThrowException(const ExceptionRef& exception);
    static void* BeginCatch(ExceptionWrapper* mExceptionWrapper);

    static inline bool HasFatalException();
    static inline void ThrowPendingException();
    static inline bool HasPendingException();
    static inline void CheckAndThrowPendingException(const CString& msg);
    static inline void CheckAndDumpException();
    static inline ExceptionRef GetPendingException();
    static inline void ClearPendingException();
    static inline void* GetExceptionWrapper();
    static inline uint32_t GetExceptionTypeID();
    static inline void EndCatch();

    static void ThrowImplicitException(ImplicitExceptionType type);
    void RegisterExceptionRaiser(void* raiser)
    {
        exceptionRaiser = reinterpret_cast<ExceptionRaiser>(raiser);
    }

    ExceptionRaiser GetExceptionRaiser() const
    {
        return exceptionRaiser;
    }
#if defined(__OHOS__) && (__OHOS__ == 1)
    void RegisterUncaughtExceptionHandler(const CJUncaughtExceptionInfo& handler);
#endif
    CJUncaughtExceptionInfo GetUncaughtExceptionHandler() const
    {
        return uncaughtExceptionHandler;
    }

private:
#if defined(_WIN64)
    static constexpr uint32_t COMPENSATE_SIZE = 16;
#elif defined(__x86_64__)
    static constexpr uint32_t COMPENSATE_SIZE = 32;
#endif
    ExceptionRaiser exceptionRaiser = nullptr;
    static std::mutex gUncaughtExceptionHandlerMtx;
    CJUncaughtExceptionInfo uncaughtExceptionHandler;
};
} // namespace MapleRuntime

#endif // MRT_EXCEPTION_MANAGER_H
