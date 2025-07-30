// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "LogManager.h"

#include "Base/LogFile.h"

namespace MapleRuntime {
LogManager::LogManager() {}

void LogManager::Init() { LogFile::Init(); }

void LogManager::Fini() { LogFile::Fini(); }
} // namespace MapleRuntime
