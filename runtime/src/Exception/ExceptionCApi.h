// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_EXCEPTION_API_H
#define MRT_EXCEPTION_API_H

#include "Base/Globals.h"

namespace MapleRuntime {
// If there is an unhandled exception, the exception is thrown.
// This function is used at the end of the C2N_stub function.
// When used in the signal return check case, sigContext should be set.
extern "C" void MRT_ThrowPendingException(void* sigContext = nullptr);
} // namespace MapleRuntime
#endif // MRT_EXCEPTION_API_H
