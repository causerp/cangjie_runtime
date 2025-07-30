// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef HASH_UTILS_H
#define HASH_UTILS_H

#include "Base/CString.h"
#include "Base/Types.h"
namespace MapleRuntime {

struct HashString {
    // 211 is a proper prime, which can reduce the conflict rate.
    const U32 properPrime = 211;
    
    size_t operator()(const char* key) const
    {
        U32 hash = 0;
        while ((*key) != '\0') {
            U32 keyChar = *key;
            hash = hash * properPrime + keyChar;
            key += 1;
        }
        return hash;
    }
};
struct EqualString {
    bool operator()(const char* lhs, const char* rhs) const { return strcmp(lhs, rhs) == 0; }
};

} // namespace MapleRuntime

#endif // MRT_BASE_LOG_H
