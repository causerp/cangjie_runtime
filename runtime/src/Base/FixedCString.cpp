// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "CString.h"

namespace MapleRuntime {
FixedCString::FixedCString() { length = 0; }

FixedCString::FixedCString(const char* initStr)
{
    if (initStr != nullptr) {
        size_t initLen = strlen(initStr);
        PRINT_FATAL_IF(initLen > C_STRING_MAX_SIZE, "FixedCString::Init failed");
        if (*initStr != '\0') {
            PRINT_FATAL_IF(memcpy_s(mem, C_STRING_MAX_SIZE, initStr, initLen) != EOK,
                           "FixedCString::FixedCString memcpy_s failed");
        }
        length = initLen;
        mem[length] = '\0';
    }
}

FixedCString::FixedCString(const FixedCString& other)
{
    size_t initLen = other.Length();
    PRINT_FATAL_IF(initLen > C_STRING_MAX_SIZE, "FixedCString::Init failed");
    if (!other.IsEmpty()) {
        PRINT_FATAL_IF(memcpy_s(mem, C_STRING_MAX_SIZE, other.Str(), initLen) != EOK,
                       "FixedCString::FixedCString memcpy_s failed");
    }
    length = initLen;
    mem[length] = '\0';
}

FixedCString& FixedCString::operator=(const FixedCString& other)
{
    if (this == &other) {
        return *this;
    }
    size_t initLen = other.Length();
    PRINT_FATAL_IF(initLen > C_STRING_MAX_SIZE, "FixedCString::Init failed");
    if (!other.IsEmpty()) {
        PRINT_FATAL_IF(memcpy_s(mem, C_STRING_MAX_SIZE, other.Str(), initLen) != EOK,
                       "FixedCString::operator= memcpy_s failed");
    }
    length = initLen;
    mem[length] = '\0';
    return *this;
}

FixedCString::~FixedCString() {}

size_t FixedCString::Length() const { return length; }

const char* FixedCString::Str() const noexcept { return mem; }
} // namespace MapleRuntime
