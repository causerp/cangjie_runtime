// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "StackMetadataHelper.h"

#include "StackMap/StackMap.h"

namespace MapleRuntime {
// Normally, the file-level line number information will be returned.
// If it returns 0, it means that the file-level line number information
// cannot be found.
uint32_t StackMetadataHelper::GetLineNumber() const
{
    StackMapBuilder stackMapBuild(funcStartAddress, reinterpret_cast<uintptr_t>(funcPC), 0, funcDesc);

    MethodMap methodMap = stackMapBuild.Build<MethodMap>();
    // If the matching stackmap information is not found by pc,
    // the line number is 0
    return methodMap.IsValid() ? methodMap.GetLineNum() : 0;
}
} // namespace MapleRuntime
