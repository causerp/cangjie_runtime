// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "CFException.h"

#include <dlfcn.h>
#include <CoreFoundation/CoreFoundation.h>
#include <cinttypes>

namespace MapleRuntime {
mach_header_target* CFException::FindCoreFoundationMachHeader() {
    Dl_info info;
    if (dladdr(reinterpret_cast<void*>(&CFRunLoopRun), &info) ==0) {
        LOG(RTLOG_ERROR, "can not find CFRunLoopRun function");
        return nullptr;
    } else {
        return reinterpret_cast<mach_header_target*>(info.dli_fbase);
    }
}

char* CFException::FindExceptionBacktraceSectionAddr(unsigned long *bufferSize) {
    mach_header_target* header = FindCoreFoundationMachHeader();
    if (header == nullptr) {
        LOG(RTLOG_ERROR, "can not find mach_header_target");
        return nullptr;
    }
    if (header->magic != MH_MAGIC_TARGET) {
        LOG(RTLOG_ERROR, "Head magic is error");
        return nullptr;
    }
    uintptr_t textVmaddr = 0;

    load_command* loadCommand = reinterpret_cast<load_command*>(header + 1);
    for (uint32_t loadCommandIndex = 0; loadCommandIndex < header->ncmds; ++loadCommandIndex) {
        if (loadCommand->cmd == LC_SEGMENT_TARGET) {
            segment_command_target* segmentCommand = reinterpret_cast<segment_command_target*>(loadCommand);
            if (BufferEqualsString(segmentCommand->segname, "__TEXT")) {
                textVmaddr = segmentCommand->vmaddr;
            }

            if (BufferEqualsString(segmentCommand->segname, "__DATA")) {
                section_target* sections = reinterpret_cast<section_target*>(segmentCommand + 1);
                for (uint32_t sectionIndex = 0; sectionIndex < segmentCommand->nsects; ++sectionIndex) {
                    section_target* section = &sections[sectionIndex];

                    if (BufferEqualsString(section->sectname, "__cf_except_bt") && BufferEqualsString(section->segname, "__DATA")) {
                        *bufferSize = section->size;
                        return reinterpret_cast<char*>(reinterpret_cast<uintptr_t>(header) + section->addr - textVmaddr);
                    }
                }
            }
        }

        loadCommand = reinterpret_cast<load_command*>(reinterpret_cast<uintptr_t>(loadCommand) + loadCommand->cmdsize);
    }

    return nullptr;
}

void CFException::WriteBacktraceToBuffer(ExceptionWrapper& eWrapper, char* buffer, unsigned long bufferSize) {
    if (bufferSize < 2) {
        LOG(RTLOG_ERROR, "The buffer size required for backtrace is less than 2.");
        return;
    }

    std::vector<uint64_t>& liteFrameInfos = eWrapper.GetLiteFrameInfos();
    char* bufferPointer = buffer;
    unsigned long remainingBytes = bufferSize;

    *(bufferPointer++) = '(';
    --remainingBytes;

    uint32_t count = 0;
    for (auto frameInfo : liteFrameInfos) {
        if (count % 3 == 0) {
            int bytes = snprintf(bufferPointer, remainingBytes, "0x%" PRIxPTR " ", static_cast<uintptr_t>(frameInfo));

            if (bytes < 0 || static_cast<unsigned long>(bytes) >= remainingBytes) {
                break;
            }

            bufferPointer += bytes;
            remainingBytes -= bytes;
        }
        count++;
    }

    *(bufferPointer - 1) = ')'; // Replace last space.
    *bufferPointer = '\0';
}

std::mutex CFException::writeMutex;
void CFException::ReportBacktraceToIosIpsLog(ExceptionWrapper& eWrapper) {
    unsigned long bufferSize = 0;
    char* buffer = FindExceptionBacktraceSectionAddr(&bufferSize);
    if (buffer == nullptr) {
        return;
    }
    std::lock_guard<std::mutex> lock(writeMutex);
    WriteBacktraceToBuffer(eWrapper, buffer, bufferSize);
}
} // namespace MapleRuntime
