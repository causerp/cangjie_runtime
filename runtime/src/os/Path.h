// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_OS_PATH_H
#define MRT_OS_PATH_H

#include "Base/CString.h"

namespace MapleRuntime {
namespace Os {
namespace Path {
CString GetBaseName(const char* path);
bool GetRealPath(const char* path, char* resolvedPath);
}; // namespace Path
}; // namespace Os
}; // namespace MapleRuntime
#endif // MRT_OS_PATH_H
