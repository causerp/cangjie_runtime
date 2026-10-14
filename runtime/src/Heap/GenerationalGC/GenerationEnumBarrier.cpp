// Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information

#include "GenerationEnumBarrier.h"
#include "Mutator/Mutator.h"
#include "ObjectModel/MArray.h"
#include "ObjectModel/RefField.inline.h"
#include "Collector/CopyCollector.h"
#if defined(CANGJIE_TSAN_SUPPORT)
#include "Sanitizer/SanitizerInterface.h"
#endif

namespace MapleRuntime {
void GenerationEnumBarrier::WriteReference(BaseObject *obj, RefField<false> &field, BaseObject *ref) const
{
    EnumBarrier::WriteReference(obj, field, ref);
    rsetUpdateBarrier_.WriteReference(obj, &field, ref);
}

void GenerationEnumBarrier::WriteStruct(BaseObject* obj, MAddress dst, size_t dstLen, MAddress src, size_t srcLen) const
{
    if (obj != nullptr) {
        MRT_ASSERT(dst > reinterpret_cast<MAddress>(obj), "WriteStruct struct addr is less than obj!");
        Mutator* mutator = Mutator::GetMutator();
        obj->ForEachRefInStruct(
            [=](RefField<>& dstField) {
                mutator->RememberObjectInSatbBuffer(ReadReference(obj, dstField));
                MAddress offset = reinterpret_cast<MAddress>(&dstField) - dst;
                RefField<>* srcField = reinterpret_cast<RefField<>*>(src + offset);
                BaseObject* newRef = ReadReference(nullptr, *srcField);
                mutator->RememberObjectInSatbBuffer(newRef);
                rsetUpdateBarrier_.WriteReference(obj, &dstField, newRef);
            },
            dst, dst + srcLen);
    }
    std::atomic_thread_fence(std::memory_order_seq_cst);
    CHECK_DETAIL(memcpy_s(reinterpret_cast<void*>(dst), dstLen, reinterpret_cast<void*>(src), srcLen) == EOK,
                 "memcpy_s failed");

    if (obj != nullptr) {
        obj->ForEachRefInStruct(
            [=](RefField<>& refField) {
                RefField<> oldField(refField);
                RefField<> toBeUpdated(oldField);
                BaseObject* untagged = ReadReference(nullptr, toBeUpdated);
                RefField<> newField = theCollector.GetAndTryTagRefField(untagged);
                if (oldField.GetFieldValue() != newField.GetFieldValue()) {
                    refField.CompareExchange(oldField.GetFieldValue(), newField.GetFieldValue());
                }
            },
            dst, dst + dstLen);
    }

#if defined(CANGJIE_TSAN_SUPPORT)
    Sanitizer::TsanWriteMemoryRange(reinterpret_cast<void*>(dst), dstLen);
    Sanitizer::TsanReadMemoryRange(reinterpret_cast<void*>(src), srcLen);
#endif
}

void GenerationEnumBarrier::AtomicWriteReference(BaseObject* obj, RefField<true>& field, BaseObject* ref,
                                                 MemoryOrder order) const
{
    EnumBarrier::AtomicWriteReference(obj, field, ref, order);
    rsetUpdateBarrier_.WriteReference(obj, &field, ref);
}

BaseObject* GenerationEnumBarrier::AtomicSwapReference(BaseObject* obj, RefField<true>& field, BaseObject* ref,
                                                       MemoryOrder order) const
{
    BaseObject* oldRef = EnumBarrier::AtomicSwapReference(obj, field, ref, order);
    rsetUpdateBarrier_.WriteReference(obj, &field, ref);
    return oldRef;
}

bool GenerationEnumBarrier::CompareAndSwapReference(BaseObject* obj, RefField<true>& field, BaseObject* oldRef,
                                                    BaseObject* newRef, MemoryOrder succOrder,
                                                    MemoryOrder failOrder) const
{
    bool success = EnumBarrier::CompareAndSwapReference(obj, field, oldRef, newRef, succOrder, failOrder);
    if (success) {
        rsetUpdateBarrier_.WriteReference(obj, &field, newRef);
    }
    return success;
}

void GenerationEnumBarrier::CopyStructArray(BaseObject* dstObj, MAddress dstField, MIndex dstSize, BaseObject* srcObj,
                                            MAddress srcField, MIndex srcSize) const
{
    EnumBarrier::CopyStructArray(dstObj, dstField, dstSize, srcObj, srcField, srcSize);
    if (dstObj->HasRefField()) {
        MArray* dstArray = static_cast<MArray*>(dstObj);
        dstArray->ForEachRefFieldInRange(
            [&](RefField<false>& field) {
                BaseObject* target = field.GetTargetObject();
                rsetUpdateBarrier_.WriteReference(dstObj, &field, target);
            },
            dstField, dstField + dstSize);
    }
}
} // namespace MapleRuntime
