// Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information

#include "GenerationForwardBarrier.h"
#include "ObjectModel/MArray.h"

namespace MapleRuntime {
void GenerationForwardBarrier::WriteStruct(BaseObject* obj, MAddress dst, size_t dstLen, MAddress src,
                                           size_t srcLen) const
{
    ForwardBarrier::WriteStruct(obj, dst, dstLen, src, srcLen);
    if (obj != nullptr) {
        obj->ForEachRefInStruct(
            [&](RefField<>& dstField) {
                BaseObject* target = dstField.GetTargetObject();
                rsetUpdateBarrier_.WriteReference(obj, &dstField, target);
            },
            dst, dst + srcLen);
    }
}

void GenerationForwardBarrier::AtomicWriteReference(BaseObject* obj, RefField<true>& field, BaseObject* ref,
                                                    MemoryOrder order) const
{
    ForwardBarrier::AtomicWriteReference(obj, field, ref, order);
    rsetUpdateBarrier_.WriteReference(obj, &field, ref);
}

BaseObject* GenerationForwardBarrier::AtomicSwapReference(BaseObject* obj, RefField<true>& field, BaseObject* ref,
                                                          MemoryOrder order) const
{
    BaseObject* oldRef = ForwardBarrier::AtomicSwapReference(obj, field, ref, order);
    rsetUpdateBarrier_.WriteReference(obj, &field, ref);
    return oldRef;
}

bool GenerationForwardBarrier::CompareAndSwapReference(BaseObject* obj, RefField<true>& field, BaseObject* oldRef,
                                                       BaseObject* newRef, MemoryOrder succOrder,
                                                       MemoryOrder failOrder) const
{
    bool success = ForwardBarrier::CompareAndSwapReference(obj, field, oldRef, newRef, succOrder, failOrder);
    if (success) {
        rsetUpdateBarrier_.WriteReference(obj, &field, newRef);
    }
    return success;
}

void GenerationForwardBarrier::CopyStructArray(BaseObject* dstObj, MAddress dstField, MIndex dstSize,
                                               BaseObject* srcObj, MAddress srcField, MIndex srcSize) const
{
    ForwardBarrier::CopyStructArray(dstObj, dstField, dstSize, srcObj, srcField, srcSize);
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
