// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#ifndef MRT_MOBJECT_INLINE_H
#define MRT_MOBJECT_INLINE_H

// language dependence
#include <type_traits>

// cross module dependence
#include "Heap/Barrier/Barrier.inline.h"
#include "Heap/Heap.h"
#include "HeapManager.inline.h"

// module internal dependence
#include "Field.h"
#include "MClass.inline.h"
#include "MObject.h"

namespace MapleRuntime {
template<typename T0, typename T1>
inline T0* MObject::Cast(T1 o)
{
    static_assert(std::is_same<T1, void*>::value || std::is_same<T1, MAddress>::value, "wrong type");
    return reinterpret_cast<T0*>(o);
}

template<typename T0, typename T1>
inline T0* MObject::CastNonNull(T1 o)
{
    DCHECK(o != 0);
    return Cast<T0>(o);
}

inline bool MObject::IsArray() const { return GetTypeInfo()->IsArrayType(); }

inline bool MObject::IsPrimitiveArray() const
{
    TypeInfo* componentTypeInfo = GetTypeInfo()->GetComponentTypeInfo();
    return componentTypeInfo == nullptr ? false : componentTypeInfo->IsPrimitiveType();
}

inline bool MObject::IsStructArray() const
{
    TypeInfo* componentTypeInfo = GetTypeInfo()->GetComponentTypeInfo();
    return componentTypeInfo == nullptr ? false : (componentTypeInfo->IsStructType() || componentTypeInfo->IsTuple());
}

inline bool MObject::IsSubType(TypeInfo& mClass) { return GetTypeInfo()->IsSubType(&mClass); }

template<typename T>
inline T MObject::Load(size_t offset) const
{
    Field<T>& field = GetField<T>(offset);
    return field.GetFieldValue();
}

template<typename T>
inline void MObject::Store(size_t offset, T value)
{
    Field<T>& field = GetField<T>(offset);
    Heap::GetBarrier().WriteField(this, field, value);
}

inline MObject* MObject::LoadRef(size_t offset)
{
    RefField<>& ref = GetRefField<false>(offset);
    return static_cast<MObject*>(Heap::GetBarrier().ReadReference(this, ref));
}

inline void MObject::StoreRef(size_t offset, MObject* value)
{
    RefField<>& ref = GetRefField<false>(offset);
    Heap::GetBarrier().WriteReference(this, ref, value);
}
} // namespace MapleRuntime
#endif // MRT_MOBJECT_INLINE_H
