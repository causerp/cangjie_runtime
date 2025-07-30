// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "PageCache.h"

namespace MapleRuntime {
PageCache PageCache::instance;

std::mutex& PageCache::GetPageMutex() { return pageMtx; }

// Get a Span of a k-page.
Span* PageCache::NewSpan(size_t k)
{
    CHECK(k > 0 && k < MAX_NPAGES);
    // 1. Check if the corresponding SpanList bucket contains a Span based on direct addressing using k.
    if (!pageCacheSpans[k].Empty()) {
        Span* kSpan = pageCacheSpans[k].PopFront();

        for (size_t i = 0; i < kSpan->pageNum; ++i) {
            idSpanMap[kSpan->pageId + i] = kSpan;
        }

        return kSpan;
    }
    // 2. find bigger bucket
    for (size_t n = k + 1; n < MAX_NPAGES; ++n) {
        if (!pageCacheSpans[n].Empty()) {
            Span* kSpan = new Span();
            Span* nSpan = pageCacheSpans[n].PopFront();

            kSpan->pageNum = k;
            kSpan->pageId = nSpan->pageId;

            nSpan->pageNum -= k;
            nSpan->pageId += k;
            pageCacheSpans[nSpan->pageNum].PushFront(nSpan);

            for (size_t i = 0; i < kSpan->pageNum; ++i) {
                idSpanMap[kSpan->pageId + i] = kSpan;
            }

            return kSpan;
        }
    }
    // 3. No suitable Span is available; allocate a 128KB Span.
    Span* bigSpan = new Span;

    void* ptr = SystemAlloc(MAX_NPAGES - 1);

    bigSpan->pageNum = MAX_NPAGES - 1;
    bigSpan->pageId = reinterpret_cast<pageID>(ptr) >> PAGE_SHIFT;

    pageCacheSpans[MAX_NPAGES - 1].PushFront(bigSpan);

    return NewSpan(k);
}

Span* PageCache::MapObjectToSpan(void* obj)
{
    CHECK(obj != nullptr);
    ScopedPageCacheMutex mtx;
    pageID id = (reinterpret_cast<pageID>(obj) >> PAGE_SHIFT);
    auto ret = idSpanMap.find(id);
    if (ret != idSpanMap.end()) {
        return ret->second;
    } else {
        CHECK_DETAIL(false, "MapObjectToSpan false");
        return nullptr;
    }
}

void PageCache::ReleaseSpanToPageCache(Span* span)
{
    ScopedPageCacheMutex mtx;
    // Merge forward
    while (1) {
        pageID prevId = span->pageId - 1;
        auto ret = idSpanMap.find(prevId);
        if (ret == idSpanMap.end()) {
            break;
        }

        Span* prevSpan = ret->second;
        if (prevSpan->isUse) {
            break;
        }

        if (prevSpan->pageNum + span->pageNum > MAX_NPAGES - 1) {
            break;
        }

        span->pageNum += prevSpan->pageNum;
        span->pageId = prevSpan->pageId;

        pageCacheSpans[prevSpan->pageNum].Erase(prevSpan);
        delete prevSpan;
    }

    // Merge backward
    while (1) {
        pageID nextId = span->pageId + span->pageNum;
        auto ret = idSpanMap.find(nextId);
        if (ret == idSpanMap.end()) {
            break;
        }

        Span* nextSpan = ret->second;
        if (nextSpan->isUse) {
            break;
        }

        if (span->pageNum + nextSpan->pageNum > MAX_NPAGES - 1) {
            break;
        }

        span->pageNum += nextSpan->pageNum;

        pageCacheSpans[nextSpan->pageNum].Erase(nextSpan);
        delete nextSpan;
    }

    // Hang the merged Span into the bucket.
    // Update the mapping relationship.
    pageCacheSpans[span->pageNum].PushFront(span);
    span->isUse = false;
    for (size_t i = 0; i < span->pageNum; ++i) {
        idSpanMap[span->pageId + i] = span;
    }
}
} // namespace MapleRuntime