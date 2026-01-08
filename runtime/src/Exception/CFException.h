// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_CF_EXCEPTION_H
#define MRT_CF_EXCEPTION_H

#include <mach-o/loader.h>
#include <mutex>

#include "Exception/Exception.h"

namespace MapleRuntime {

// this is arm64 setting, not support arm32.
typedef struct mach_header_64 mach_header_target;
typedef struct segment_command_64 segment_command_target;
typedef struct section_64 section_target;
static const uint32_t MH_MAGIC_TARGET = MH_MAGIC_64;
static const uint32_t LC_SEGMENT_TARGET = LC_SEGMENT_64;

// Core Foundation Exception
class CFException {
public:
    CFException() {}
    ~CFException() = default;
    static void ReportBacktraceToIosIpsLog(ExceptionWrapper& eWrapper);
private:
    static mach_header_target* FindCoreFoundationMachHeader();
    static char* FindExceptionBacktraceSectionAddr(unsigned long *bufferSize);
    static void WriteBacktraceToBuffer(ExceptionWrapper& eWrapper, char* buffer, unsigned long bufferSize);
    template <int n>
    static bool BufferEqualsString(const char(&buffer)[n], const char* str) {
        return strncmp(buffer, str, n) == 0;
    }

    static std::mutex writeMutex;
};
} // namespace MapleRuntime
#endif // MRT_CF_EXCEPTION_H
