// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_THREAD_CACHE_H
#define MRT_THREAD_CACHE_H
#include "MemCommon.h"

namespace MapleRuntime {
/* The essence of ThreadCache is a hash bucket
  | 8Byte  | -> 8Byte -> 8Byte
  | 16Byte | -> 16Byte
  | 32Byte | -> 32Byte -> 32Byte - 32Byte
  | ...    |
  | ...    |
  | 256KB  | -> 256KB

  The bucket is divided into a total of 208 table items,
  which is used to simplify bucket management while keeping memory fragmentation under control.
  The specific division rules are defined in class SizeManager.
*/
class ThreadCache {
public:
    ThreadCache() noexcept {}
    ThreadCache(const ThreadCache&) noexcept = delete;
    ThreadCache& operator=(const ThreadCache&) noexcept = delete;

    void* Allocate(size_t bytes);
    void Deallocate(void* ptr, size_t bytes);

private:
    // Return a segment of list to CentralCache
    void ReturnToCentralCache(FreeList& list, size_t bytes);
    // Obtain a batch of small fixed-length memory blocks from the CentralCache and return one of them
    void* FetchFromCentralCache(size_t index, size_t alignBytes);

    FreeList freeLists[NFREELIST]; // Hash bucket of small fixed-length memory blocks
};
} // namespace MapleRuntime
#endif