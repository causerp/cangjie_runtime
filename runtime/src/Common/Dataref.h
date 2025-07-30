// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_DATAREF_H
#define MRT_DATAREF_H

#include <cstdlib>

#include "Base/Log.h"
#include "Base/Types.h"
namespace MapleRuntime {
// DataRefOffset aims to represent a reference to data in maple file, which is already an offset.
// DataRefOffset is meant to have pointer size.
// All Xx32 data types defined in this file aim to use 32 bits to save 64-bit address, and thus are
// specific for 64-bit platforms.
template<typename T>
struct DataRefOffset32 {
    I32 refOffset;

    inline T* GetDataRef() const
    {
        T* dataRef = nullptr;
        if (refOffset != 0) {
            Sptr ref = static_cast<Sptr>(refOffset);
            ref += reinterpret_cast<Sptr>(this);
            dataRef = reinterpret_cast<T*>(static_cast<Uptr>(ref));
        }
        return dataRef;
    }
};

template<typename T>
struct DataRefOffset64 {
    I64 refOffset;

    inline T* GetDataRef() const
    {
        T* dataRef = nullptr;
        if (refOffset != 0) {
            Sptr ref = static_cast<Sptr>(refOffset);
            ref += reinterpret_cast<Sptr>(this);
            dataRef = reinterpret_cast<T*>(static_cast<Uptr>(ref));
        }
        return dataRef;
    }
};
} // namespace MapleRuntime
#endif // MRT_DATAREF_H
