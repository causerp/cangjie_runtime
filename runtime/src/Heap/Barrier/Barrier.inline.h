// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_BARRIER_INLINE_H
#define MRT_BARRIER_INLINE_H

#include "Barrier.h"
#include "securec.h"

namespace MapleRuntime {
template<>
inline void Barrier::WriteField<int8_t>(BaseObject* obj, Field<int8_t>& field, int8_t val) const
{
    WriteI8(obj, field, val);
}

template<>
inline void Barrier::WriteField<int16_t>(BaseObject* obj, Field<int16_t>& field, int16_t val) const
{
    WriteI16(obj, field, val);
}

template<>
inline void Barrier::WriteField<int32_t>(BaseObject* obj, Field<int32_t>& field, int32_t val) const
{
    WriteI32(obj, field, val);
}

template<>
inline void Barrier::WriteField<int64_t>(BaseObject* obj, Field<int64_t>& field, int64_t val) const
{
    WriteI64(obj, field, val);
}

template<>
inline void Barrier::WriteField<float>(BaseObject* obj, Field<float>& field, float val) const
{
    WriteF32(obj, field, val);
}

template<>
inline void Barrier::WriteField<double>(BaseObject* obj, Field<double>& field, double val) const
{
    WriteF64(obj, field, val);
}
} // namespace MapleRuntime
#endif // ~MRT_BARRIER_INLINE_H
