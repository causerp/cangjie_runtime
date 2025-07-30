// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_FIELD_INLINE_H
#define MRT_FIELD_INLINE_H

#include "Base/LogFile.h"
#include "Common/BaseObject.h"
#if defined(CANGJIE_TSAN_SUPPORT)
#include "Sanitizer/SanitizerInterface.h"
#endif

namespace MapleRuntime {
template<typename T, bool isAtomic>
void Field<T, isAtomic>::SetFieldValue(const BaseObject* obj, T v, std::memory_order order)
{
    DLOG(BARRIER, "write obj %p(%zu)+%zu field @%p 0x%zx -> 0x%zx", obj, obj->GetSize(),
         BaseObject::FieldOffset(obj, this), this, value, v);

    if (isAtomic) {
#if defined(CANGJIE_TSAN_SUPPORT)
        Sanitizer::TsanAtomicStore(&value, v, order);
#else
        // it is weired that "std::atomic_store_explicit(&value, v, order)" leads to compiling failure
        __atomic_store(&value, &v, order);
#endif
    } else {
        value = v;
#if defined(CANGJIE_TSAN_SUPPORT)
        Sanitizer::TsanWriteMemory(&value, sizeof(T));
#endif
    }
}
} // namespace MapleRuntime
#endif // MRT_FIELD_INLINE_H
