// Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#ifndef MRT_RSET_UPDATE_BARRIER_H
#define MRT_RSET_UPDATE_BARRIER_H

#include "RememberSet.h"
#include "ObjectModel/RefField.h"

namespace MapleRuntime {

class RSetUpdateBarrier {
public:
    RSetUpdateBarrier() = default;
    ~RSetUpdateBarrier() = default;

    void WriteReference(BaseObject* obj, RefField<>* field, BaseObject* target);
    void WriteReference(BaseObject* obj, RefField<true>* field, BaseObject* target)
    {
        WriteReference(obj, reinterpret_cast<RefField<>*>(field), target);
    }
};

} // namespace MapleRuntime

#endif // MRT_RSET_UPDATE_BARRIER_H
