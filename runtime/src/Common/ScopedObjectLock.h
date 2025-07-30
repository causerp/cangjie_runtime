// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_SCOPED_LOCK_OBJECT_H
#define MRT_SCOPED_LOCK_OBJECT_H
#include "Common/BaseObject.h"
namespace MapleRuntime {
class ScopedObjectLock {
public:
    ATTR_NO_INLINE explicit ScopedObjectLock(BaseObject& obj)
    {
        do {
            ObjectState::ObjectStateCode state = obj.GetObjectState().GetStateCode();
            if (state == ObjectState::FORWARDING) {
                sched_yield();
                continue;
            } else if (state == ObjectState::LOCKED || state == ObjectState::FORWARDED ||
                       state == ObjectState::NORMAL) {
                fromCopy = &obj;
            } else {
                LOG(RTLOG_FATAL, "this state need to be dealt with when lock object, state: %u\n", state);
                return;
            }
            StateWord curState = fromCopy->GetStateWord();
            if (fromCopy->TryLockObject(curState)) {
                return;
            }
        } while (true);
    }
    ~ScopedObjectLock()
    {
        CHECK_DETAIL(fromCopy != nullptr, "from copy is nullptr when unlock object\n");
        fromCopy->UnlockObject(ObjectState::NORMAL);
    }

private:
    BaseObject* fromCopy = { nullptr };
};
} // namespace MapleRuntime
#endif // ~MRT_SCOPED_LOCK_OBJECT_H
