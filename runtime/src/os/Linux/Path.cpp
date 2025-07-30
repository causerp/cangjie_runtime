// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "os/Path.h"

#include <libgen.h>
namespace MapleRuntime {
namespace Os {
CString Path::GetBaseName(const char* path)
{
    if (path == nullptr) {
        return nullptr;
    }
    return basename(const_cast<char*>(path));
}

bool Path::GetRealPath(const char* path, char* resolvedPath) { return (realpath(path, resolvedPath) != nullptr); }
} // namespace Os
} // namespace MapleRuntime
