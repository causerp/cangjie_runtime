// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "ExceptionCApi.h"

#include "Base/LogFile.h"
#include "Common/Runtime.h"
#include "Exception.h"
#include "ExceptionManager.h"
#include "Loader/ILoader.h"
#include "Mutator/Mutator.h"
#include "Mutator/MutatorManager.h"
#include "schedule.h"

namespace MapleRuntime {
// If there is an unhandled exception, the exception is thrown.
// This function is used at the end of the C2NStub function.
extern "C" void MRT_ThrowPendingException(void* sigContext)
{
    Mutator* mutator = Mutator::GetMutator();
    if (mutator == nullptr) {
        return;
    }
    ExceptionWrapper& mExceptionWrapper = mutator->GetExceptionWrapper();
#if defined(MRT_DEBUG) && (MRT_DEBUG == 1)
    DLOG(EXCEPTION, "throw pending exception");
    DLOG(EXCEPTION, "Struct ExceptionWrapper");
    DLOG(EXCEPTION, "  ExceptionRef\t:\t%p", mExceptionWrapper.GetExceptionRef());
    DLOG(EXCEPTION, "  isCaught\t:\t%d", mExceptionWrapper.IsCaught());
    DLOG(EXCEPTION, "  typeIndex\t:\t%lu", mExceptionWrapper.GetTypeIndex());
    DLOG(EXCEPTION, "  throwingOOME\t:\t%d", mExceptionWrapper.IsThrowingOOME());
    DLOG(EXCEPTION, "  fatalException\t:\t%d", mExceptionWrapper.IsFatalException());
    DLOG(EXCEPTION, "  ExceptionType\t:\t%s", mExceptionWrapper.GetExceptionTypeName());
#endif
    if (mExceptionWrapper.GetExceptionRef() != nullptr) {
        if (!mExceptionWrapper.IsThrowingSOFE()) {
            LOG(RTLOG_INFO, "Warning : An exception occurred in the Cangjie function, return value may be invalid!");
        }
        mExceptionWrapper.Reset();
        ExceptionHandling eh(mExceptionWrapper, sigContext);
    }
}
} // namespace MapleRuntime
