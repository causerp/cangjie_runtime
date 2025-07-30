// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_STREAM_H
#define MRT_STREAM_H
#include "Base/LogFile.h"
namespace MapleRuntime {
class Stream {
public:
    virtual ~Stream() = default;

    virtual void EndOfStream() = 0;

    // Get chunk's size
    virtual int GetSize() = 0;

    // Writes the chunk of data into the stream
    virtual bool WriteChunk(char* data, int32_t size) = 0;
};
}  // namespace MapleRuntime

#endif
