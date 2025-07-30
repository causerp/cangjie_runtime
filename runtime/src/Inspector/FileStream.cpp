// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include <cerrno>
#include <climits>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <ios>
#include <ostream>
#include <unistd.h>
#include "Base/LogFile.h"
#include "FileStream.h"

namespace MapleRuntime {
void HeapProfilerStream::SetHandler(SendMsgCB sendMsgInit)
{
    if (sendMsg != nullptr) {
        return;
    }
    sendMsg = sendMsgInit;
}
bool HeapProfilerStream::SetMessageID(const std::string &message)
{
    std::string key = "\"id\":";
    size_t startPos = message.find(key);
    if (startPos == std::string::npos) {
        return false;
    }
    startPos += key.length();

    while (startPos < message.length() && std::isspace(message[startPos])) {
        ++startPos;
    }

    if (message[startPos] == '"') {
        size_t endPos = message.find('"', startPos + 1);
        if (endPos == std::string::npos) {
            return false;
        }
        messageId = CString(message.substr(startPos + 1, endPos - startPos - 1).c_str());
    } else {
        size_t endPos = message.find(',', startPos);
        if (endPos == std::string::npos) {
            endPos = message.find('}', startPos);
        }
        if (endPos == std::string::npos) {
            return false;
        }
        messageId = CString(message.substr(startPos, endPos - startPos).c_str());
    }
        return true;
}

CString HeapProfilerStream::GetMessageID()
{
    return messageId;
}

void HeapProfilerStream::SetContext(MsgType type)
{
    if (type == DUMPHEAPSNAPSHOT || type == ALLOCATION) {
        start = "{\"method\":\"HeapProfiler.addHeapSnapshotChunk\",\"params\":{\"chunk\":\"";
        end = "\"},\"profiler\":\"cangjie profiler\"}";
        return;
    } else if (type == STATSUPDATE) {
        start = "{\"method\":\"HeapProfiler.heapStatsUpdate\",\"params\":{\"statsUpdate\":";
        end = "},\"profiler\":\"cangjie profiler\"}";
        return;
    } else {
        start = "";
    }
    end = ",\"profiler\":\"cangjie profiler\"}";
}
int HeapProfilerStream::GetSize()
{
    static const int heapProfilerChunkSise = static_cast<int>(20 * 1024);
    return heapProfilerChunkSise;
}
bool HeapProfilerStream::WriteChunk(char* data, int32_t size)
{
    std::string chunk(data, size);
    std::string msg = start + chunk + end;
    sendMsg(msg);
    return true;
}
}
