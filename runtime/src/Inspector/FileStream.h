// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_FILE_STREAM_H
#define MRT_FILE_STREAM_H

#include <cstdint>
#include <fstream>
#include <iosfwd>
#include <utility>
#include "Base/Panic.h"
#include "Inspector/Stream.h"

namespace MapleRuntime {
class StreamWriter {
public:
    explicit StreamWriter(Stream* stream)
        : stream_(stream), chunkSize_(stream->GetSize()), chunk_(chunkSize_), current_(0)
    {
    }

    void WriteString(const CString &str)
    {
        auto len = str.Length();
        ASSERT(len <= static_cast<size_t>(INT_MAX));
        if (len == 0) {
            return;
        }
        const char* cur = str.Str();
        const char* end = cur + len;
        while (cur < end) {
            int dstSize = chunkSize_ - current_;
            int writeSize = std::min(static_cast<int>(end - cur), dstSize);
            ASSERT(writeSize > 0);
            if (memcpy_s(chunk_.data() + current_, dstSize, cur, writeSize) != EOK) {
                LOG(RTLOG_ERROR, "memcpy_s failed");
            }
            cur += writeSize;
            current_ += writeSize;
            MaybeWriteChunk();
        }
    }

    void WriteChar(char c)
    {
        ASSERT(c != '\0');
        ASSERT(current_ < chunkSize_);
        chunk_[current_++] = c;
        MaybeWriteChunk();
    }

    void WriteNumber(int32_t num)
    {
        WriteString(CString(num));
    }

    void End()
    {
        if (current_ > 0) {
            WriteChunk();
        }
        stream_->EndOfStream();
    }

    void WriteContinueString(const CString &str)
    {
        auto len = str.Length();
        ASSERT(len <= static_cast<size_t>(INT_MAX));
        if (len == 0) {
            return;
        }
        int dstSize = chunkSize_ - current_;
        // To ensure that the character string is continuously written, write the data in buffer first.
        if (len > dstSize) {
            End();
        }
        WriteString(str);
    }
private:
    void MaybeWriteChunk()
    {
        ASSERT(current_ <= chunkSize_);
        if (current_ >= chunkSize_) {
            WriteChunk();
        }
    }

    void WriteChunk()
    {
        stream_->WriteChunk(chunk_.data(), current_);
        current_ = 0;
    }

    Stream* stream_ {nullptr};
    int chunkSize_ {0};
    std::vector<char> chunk_;
    int current_ {0};
};

enum MsgType : uint32_t {
    DUMPHEAPSNAPSHOT = 0,
    ALLOCATION = 1,
    HEAPUSAGE = 2,
    DISABLE = 3,
    END = 4,
    STATSUPDATE = 5,
};

class HeapProfilerStream : public Stream {
public:
    static HeapProfilerStream& GetInstance()
    {
        static HeapProfilerStream instance;
        return instance;
    }
    static HeapProfilerStream& GetHeapStatsInstance()
    {
        static HeapProfilerStream heapStatsInstance;
        return heapStatsInstance;
    }
    using SendMsgCB =  std::function<void(const std::string& message)>;
    HeapProfilerStream() : sendMsg(nullptr) {}
    void SetHandler(SendMsgCB sendMsgInit);
    bool SetMessageID(const std::string &message);
    CString GetMessageID();
    void SetContext(MsgType type);
    void EndOfStream() override {}
    int GetSize() override;
    bool WriteChunk(char* data, int32_t size) override;

private:
    std::string start;
    std::string end;
    SendMsgCB sendMsg;
    CString messageId;
};
}
#endif
