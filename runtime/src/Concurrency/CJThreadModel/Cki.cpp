// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "Cki.h"

namespace MapleRuntime {
namespace Cki {
CJThreadKey cjthreadKeyItems[SLOT_TABLE_SIZE];

int CreateCKI()
{
    for (int i = 0; i < CKI_SIZE; ++i) {
        if (CJThreadKeyCreate(&cjthreadKeyItems[i], nullptr)) {
            return -1;
        }
    }
    return 0;
}
} // namespace Cki
} // namespace MapleRuntime
