// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_REF_FIELD_H
#define MRT_REF_FIELD_H

#include <atomic>
#include <cstdlib>
#include <functional>
#include <limits>

#include "Base/Log.h"
#include "Common/TypeDef.h"
#if defined(CANGJIE_TSAN_SUPPORT)
#include "Sanitizer/SanitizerInterface.h"
#endif

namespace MapleRuntime {
class BaseObject;

/* there are several similar terms about object address:
    1. address: the start position of any virtual memory block.
    2. object-ref: an address pointing to some object, RawRoot and RawRef are object-ref.
    3. ref-field: field in object or class pointing to some object.
        global/static reference is also treated (implemented) as ref-field.
        ref-field is implemented in tagged-pointer.
*/
template<bool isAtomic = false>
class RefField {
public:
    // size in bytes
    static constexpr size_t GetSize() { return sizeof(fieldVal); }

    BaseObject* GetTargetObject(std::memory_order order = std::memory_order_relaxed) const
    {
        if (isAtomic) {
#if defined(CANGJIE_TSAN_SUPPORT)
            MAddress value = static_cast<MAddress>(Sanitizer::TsanAtomicLoad(&fieldVal, order));
#else
            MAddress value = __atomic_load_n(&fieldVal, order);
#endif
            return reinterpret_cast<BaseObject*>(RefField<>(value).GetAddress());
        } else {
#if defined(CANGJIE_TSAN_SUPPORT)
            Sanitizer::TsanReadMemory(&fieldVal, GetSize());
#endif
            return reinterpret_cast<BaseObject*>(this->GetAddress());
        }
    }

    MAddress GetFieldValue(std::memory_order order = std::memory_order_relaxed) const
    {
        if (isAtomic) {
#if defined(CANGJIE_TSAN_SUPPORT)
            MAddress value = static_cast<MAddress>(Sanitizer::TsanAtomicLoad(&fieldVal, order));
#else
            MAddress value = __atomic_load_n(&fieldVal, order);
#endif
            return value;
        } else {
#if defined(CANGJIE_TSAN_SUPPORT)
            Sanitizer::TsanReadMemory(&fieldVal, GetSize());
#endif
            return fieldVal;
        }
    }

    void SetTargetObject(const BaseObject* obj, std::memory_order order = std::memory_order_relaxed);
    void SetFieldValue(MAddress value, std::memory_order order = std::memory_order_relaxed);

    bool CompareExchange(MAddress expectedValue, MAddress newValue,
                         std::memory_order succOrder = std::memory_order_relaxed,
                         std::memory_order failOrder = std::memory_order_relaxed)
    {
        CHECK(std::numeric_limits<MAddress>::max() > newValue);
#if defined(CANGJIE_TSAN_SUPPORT)
        // tsan will get expectedValue's address for us, just pass the real value
        auto ret = Sanitizer::TsanAtomicCompareExchange(&fieldVal, expectedValue, newValue, succOrder, failOrder);
        return (ret == expectedValue);
#else
        return __atomic_compare_exchange(&fieldVal, &expectedValue, &newValue, false, succOrder, failOrder);
#endif
    }

    bool CompareExchange(const BaseObject* expectedObj, const BaseObject* newObj,
                         std::memory_order succOrder = std::memory_order_relaxed,
                         std::memory_order failOrder = std::memory_order_relaxed)
    {
        return CompareExchange(reinterpret_cast<MAddress>(expectedObj), reinterpret_cast<MAddress>(newObj), succOrder,
                               failOrder);
    }

    MAddress Exchange(MAddress newRef, std::memory_order order = std::memory_order_relaxed)
    {
        CHECK(fieldVal < std::numeric_limits<RefFieldValue>::max());
        MAddress ret = 0;
#if defined(CANGJIE_TSAN_SUPPORT)
        ret = Sanitizer::TsanAtomicExchange(&fieldVal, newRef, order);
#else
        __atomic_exchange(&fieldVal, &newRef, &ret, order);
#endif
        return static_cast<MAddress>(ret);
    }

    MAddress Exchange(const BaseObject* obj, std::memory_order order = std::memory_order_relaxed)
    {
        return Exchange(reinterpret_cast<MAddress>(obj), order);
    }

    MAddress GetAddress() const { return address; }

    bool IsTagged() const { return isTagged == 1; }
    uint16_t GetTagID() const { return tagID; }

    ~RefField() = default;
    explicit RefField(MAddress val) : fieldVal(val) {}
    RefField(const RefField& ref) : fieldVal(ref.fieldVal) {}
    explicit RefField(const BaseObject* obj) : fieldVal(0) { address = reinterpret_cast<MAddress>(obj); }
    RefField(const BaseObject* obj, uint16_t tagged, uint16_t tagid)
        : address(reinterpret_cast<MAddress>(obj)), isTagged(tagged), tagID(tagid), padding(0) {}

    RefField(RefField&& ref) : fieldVal(ref.fieldVal) {}
    RefField() = delete;
    RefField& operator=(const RefField&) = delete;
    RefField& operator=(const RefField&&) = delete;

private:
#ifdef USE_32BIT_REF
    using RefFieldValue = U32;
#else
    using RefFieldValue = MAddress;
#endif

    union {
        struct {
            MAddress address : 48;
            MAddress isTagged : 1;
            MAddress tagID : 1;
            MAddress padding : 14;
        };
        RefFieldValue fieldVal;
    };
};

using RefFieldVisitor = std::function<void(RefField<>&)>;
} // namespace MapleRuntime
#endif // MRT_REF_FIELD_H
