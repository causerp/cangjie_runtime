// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_EXCEPTION_MANAGER_INLINE_H
#define MRT_EXCEPTION_MANAGER_INLINE_H

#include "Base/LogFile.h"
#include "Exception/Exception.h"
#include "ExceptionManager.h"
#include "Mutator/Mutator.h"
#include "Mutator/MutatorManager.h"
#include "schedule.h"

namespace MapleRuntime {
inline ExceptionRef ExceptionManager::GetPendingException()
{
    ExceptionWrapper& mExceptionWrapper = Mutator::GetMutator()->GetExceptionWrapper();
    return mExceptionWrapper.GetExceptionRef();
}

inline void ExceptionManager::ClearPendingException()
{
    ExceptionWrapper& mExceptionWrapper = Mutator::GetMutator()->GetExceptionWrapper();
    mExceptionWrapper.Reset();
    mExceptionWrapper.SetExceptionRef(nullptr);
}

inline void ExceptionManager::ThrowPendingException() { MRT_ThrowPendingException(); }

inline bool ExceptionManager::HasPendingException()
{
    ExceptionWrapper& mExceptionWrapper = Mutator::GetMutator()->GetExceptionWrapper();
    return (mExceptionWrapper.GetExceptionRef() != nullptr);
}

inline bool ExceptionManager::HasFatalException()
{
    ExceptionWrapper& eWrapper = Mutator::GetMutator()->GetExceptionWrapper();
    return eWrapper.IsFatalException();
}

inline void ExceptionManager::CheckAndThrowPendingException(const CString& msg)
{
    CHECK_DETAIL(ExceptionManager::HasPendingException(), "%s, but there is no pending exception.", msg.Str());
    ExceptionManager::ThrowPendingException();
}

inline void ExceptionManager::CheckAndDumpException()
{
    if (ExceptionManager::HasPendingException()) {
        ExceptionManager::DumpException();
    }
}

inline void* ExceptionManager::GetExceptionWrapper()
{
    ExceptionWrapper& mExceptionWrapper = Mutator::GetMutator()->GetExceptionWrapper();
    return reinterpret_cast<void*>(&mExceptionWrapper);
}

inline uint32_t ExceptionManager::GetExceptionTypeID()
{
    ExceptionWrapper& mExceptionWrapper = Mutator::GetMutator()->GetExceptionWrapper();
    return mExceptionWrapper.GetTypeIndex();
}

inline void ExceptionManager::EndCatch() {}
} // namespace MapleRuntime
#endif // MRT_EXCEPTION_MANAGER_INLINE_H
