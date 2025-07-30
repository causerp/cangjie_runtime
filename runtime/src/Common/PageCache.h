// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_PAGE_CACHE_H
#define MRT_PAGE_CACHE_H

#include "MemCommon.h"

namespace MapleRuntime {
class PageCache {
public:
    // Return the singleton object of PageCache
    static PageCache* GetInstance() { return &instance; }

    // Get a k-page Span
    Span* NewSpan(size_t k);

    std::mutex& GetPageMutex();

    // Pass in a small fixed-length memory block to obtain the Span object corresponding to the page it is located in.
    Span* MapObjectToSpan(void* obj);

    // Try to merge the pages before and after the span to alleviate the external fragmentation problem.
    void ReleaseSpanToPageCache(Span* span);

private:
    std::mutex pageMtx;
    SpanList pageCacheSpans[MAX_NPAGES];
    std::unordered_map<pageID, Span*> idSpanMap; // The mapping between page numbers and span objects.

private:
    PageCache() noexcept {}

    PageCache(const PageCache&) = delete;
    PageCache& operator=(const PageCache&) = delete;

    static PageCache instance;
};

class ScopedPageCacheMutex {
public:
    explicit ScopedPageCacheMutex() { PageCache::GetInstance()->GetPageMutex().lock(); }

    ~ScopedPageCacheMutex() { PageCache::GetInstance()->GetPageMutex().unlock(); }
};
} // namespace MapleRuntime
#endif