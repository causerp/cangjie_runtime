// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_CENTRAL_CACHE_H
#define MRT_CENTRAL_CACHE_H

#include "MemCommon.h"

namespace MapleRuntime {
class CentralCache {
public:
    // Singleton mode
    static CentralCache* GetInstance() { return &instance; }

    // Obtain a certain number of small fixed-length memory blocks from the central cache.
    size_t FetchRangeObj(void*& start, void*& end, size_t batchNum, size_t alignBytes);

    // Reclaim all small fixed-length memory blocks in the freelist to their corresponding spans.
    void ReleaseListToSpans(void* start, size_t index);

private:
    // Obtain a non-null span from a specified SpanList.
    Span* GetOneSpan(SpanList& list, size_t alignBytes);

    // Hash Bucket
    SpanList centralCacheSpans[NFREELIST];

private:
    CentralCache() noexcept {}

    CentralCache(const CentralCache&) = delete;
    CentralCache& operator=(const CentralCache&) = delete;

    static CentralCache instance;
};
} // namespace MapleRuntime
#endif // MRT_CENTRAL_CACHE_H