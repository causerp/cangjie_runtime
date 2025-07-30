// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_MFUNC_DESC_INLINE_H
#define MRT_MFUNC_DESC_INLINE_H

#include "Common/StackType.h"
#include "MFuncdesc.h"

namespace MapleRuntime {
inline Uptr* MFuncDesc::GetStackMap() const { return stackMap.GetDataRef(); }

inline U32 MFuncDesc::GetCodeSize() const { return codeSize; }

inline Uptr* MFuncDesc::GetEHTable() const
{
#ifdef __APPLE__
    return reinterpret_cast<Uptr*>(ehTable.refOffset);
#else
    return ehTable.GetDataRef();
#endif
}

inline CString MFuncDesc::GetFuncName() const { return GetStringFromDict(name); }

inline CString MFuncDesc::GetFuncDir() const { return GetStringFromDict(directory); }

inline CString MFuncDesc::GetFuncFilename() const { return GetStringFromDict(filename); }

inline int8_t MFuncDesc::GetStackTraceFormat() const
{
    Uptr base = reinterpret_cast<Uptr>(this);
    // 1: stack trace format flag size, 1 bytes
    return *(reinterpret_cast<const int8_t*>(dictOffsets + base - 1));
}

inline FuncDescRef MFuncDesc::GetFuncDesc(FrameAddress* fa)
{
    return reinterpret_cast<FuncDescRef>(
        *reinterpret_cast<U64*>(reinterpret_cast<uintptr_t>(fa) - STACK_OFFSET_IN_APPLE));
}

inline FuncDescRef MFuncDesc::GetFuncDesc(Uptr startPC)
{
    DataRefOffset32<MFuncDesc>* offset =
        reinterpret_cast<DataRefOffset32<MFuncDesc>*>(startPC - START_PC_OFFSET);
    return offset->GetDataRef();
}
} // namespace MapleRuntime
#endif // MRT_MFUNC_DESC_INLINE_H
