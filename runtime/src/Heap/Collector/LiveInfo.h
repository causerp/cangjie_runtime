// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_LIVE_INFO_H
#define MRT_LIVE_INFO_H
#include "Base/ImmortalWrapper.h"
#include "Base/Log.h"
#include "Base/MemUtils.h"
#include "Base/SysCall.h"
#include "Heap/Heap.h"
#if defined(__linux__) || defined(hongmeng) || defined(__APPLE__)
#include <sys/mman.h>
#endif

namespace MapleRuntime {
constexpr size_t kBitsPerByte = 8;
constexpr size_t kMarkedBytesPerBit = 8;
constexpr size_t kBitsPerWord = sizeof(uint64_t) * kBitsPerByte;
class RegionInfo;
struct RegionBitmap {
    static constexpr uint8_t factor = 16;
    std::atomic<uint16_t> partLiveBytes[factor];
    std::atomic<size_t> liveBytes;
    // 1 bit marks the 64 bits in region.
    // element count = region size / (8 * 64) = region size / 512, should be dynamically decided at runtime.
    std::atomic<size_t> wordCnt;
    std::atomic<uint64_t> markWords[0];

    static size_t GetRegionBitmapSize(size_t regionSize)
    {
        return sizeof(RegionBitmap) + ((regionSize / (kMarkedBytesPerBit * kBitsPerWord)) * sizeof(uint64_t));
    }

    struct BitMaskInfo {
        size_t headWordIdx;
        uint64_t headMaskBits;
        size_t tailWordCnt; // count of mask words excludes the start mask
        uint64_t lastMaskBits;
    };

    static void GetBitMaskInfo(size_t start, size_t byteCnt, BitMaskInfo& maskInfo)
    {
        size_t headWordIdx = (start / kMarkedBytesPerBit) / kBitsPerWord;
        size_t headMaskBitStart = (start / kMarkedBytesPerBit) % kBitsPerWord;
        maskInfo.headWordIdx = headWordIdx;

        size_t headBitCnt = kBitsPerWord - headMaskBitStart;
        size_t maskBitCnt = byteCnt / kMarkedBytesPerBit;
        if (maskBitCnt >= headBitCnt) {
            size_t tailBitCnt = maskBitCnt - headBitCnt;
            size_t tailWordCnt = (tailBitCnt + kBitsPerWord - 1) / kBitsPerWord;
            size_t lastBitCnt = tailBitCnt % kBitsPerWord;
            uint64_t lastMaskBits = (static_cast<uint64_t>(1) << lastBitCnt) - 1;
            maskInfo.headMaskBits = ~((static_cast<uint64_t>(1) << headMaskBitStart) - 1);
            maskInfo.tailWordCnt = tailWordCnt;
            maskInfo.lastMaskBits = lastMaskBits;
        } else {
            size_t headMaskBitEnd = headMaskBitStart + maskBitCnt;
            uint64_t headMaskBits = (static_cast<uint64_t>(1) << headMaskBitEnd) - 1;
            maskInfo.headMaskBits = (headMaskBits >> headMaskBitStart) << headMaskBitStart;
            maskInfo.tailWordCnt = 0;
            maskInfo.lastMaskBits = 0;
        }
    }

    bool ApplyBitMaskInfo(const BitMaskInfo& maskInfo, size_t byteCnt, size_t regionSize)
    {
        uint64_t old = markWords[maskInfo.headWordIdx].load();
        bool isMarked = ((old & maskInfo.headMaskBits) != 0);
        if (isMarked) {
            return isMarked;
        }
        old = markWords[maskInfo.headWordIdx].fetch_or(maskInfo.headMaskBits);
        isMarked = ((old & maskInfo.headMaskBits) != 0);
        if (isMarked) {
            return isMarked;
        }
        size_t markWordSize = regionSize / (kMarkedBytesPerBit * kBitsPerWord);
        uint8_t calFactor = factor > markWordSize ? markWordSize : factor;
        partLiveBytes[maskInfo.headWordIdx / (markWordSize / calFactor)].fetch_add(
            __builtin_popcountll(maskInfo.headMaskBits));
        liveBytes.fetch_add(byteCnt);

        if (maskInfo.tailWordCnt > 0) {
            size_t lastWordIdx = maskInfo.headWordIdx + maskInfo.tailWordCnt;
            if (maskInfo.lastMaskBits != 0) {
                for (size_t idx = maskInfo.headWordIdx + 1; idx < lastWordIdx; idx++) {
                    uint64_t zeros = markWords[idx].fetch_or(~static_cast<uint64_t>(0));
                    partLiveBytes[idx / (markWordSize / calFactor)].fetch_add(kBitsPerWord);
                    DCHECK(zeros == 0);
                }
                markWords[lastWordIdx].fetch_or(maskInfo.lastMaskBits);
                partLiveBytes[lastWordIdx / (markWordSize / calFactor)].fetch_add(
                    __builtin_popcountll(maskInfo.lastMaskBits));
            } else {
                for (size_t idx = maskInfo.headWordIdx + 1; idx <= lastWordIdx; idx++) {
                    uint64_t zeros = markWords[idx].fetch_or(~static_cast<uint64_t>(0));
                    partLiveBytes[idx / (markWordSize / calFactor)].fetch_add(kBitsPerWord);
                    DCHECK(zeros == 0);
                }
            }
        }
        return isMarked;
    }

    explicit RegionBitmap(size_t regionSize) : liveBytes(0), wordCnt(regionSize / (kMarkedBytesPerBit * kBitsPerWord))
    {}

    bool MarkBits(size_t start, size_t byteCnt, size_t regionSize)
    {
        BitMaskInfo maskInfo;
        GetBitMaskInfo(start, byteCnt, maskInfo);
        return ApplyBitMaskInfo(maskInfo, byteCnt, regionSize);
    }

    bool IsMarked(size_t start)
    {
        size_t headWordIdx = (start / kMarkedBytesPerBit) / kBitsPerWord;
        size_t headMaskBitStart = (start / kMarkedBytesPerBit) % kBitsPerWord;
        uint64_t mask = static_cast<uint64_t>(1) << headMaskBitStart;
        bool ret = ((markWords[headWordIdx].load() & mask) != 0);
        return ret;
    }

    uint64_t GetPreLiveBytes(size_t offset, size_t regionSize)
    {
        uint64_t preLiveBits = 0;
        ssize_t partStartIndex = 0;
        ssize_t index = offset / (kBitsPerWord * kMarkedBytesPerBit);
        size_t markWordSize = regionSize / (kMarkedBytesPerBit * kBitsPerWord);
        uint8_t calFactor = factor > markWordSize ? markWordSize : factor;
        int8_t partIndex = index / (markWordSize / calFactor) - 1;
        while (partIndex >= 0) {
            preLiveBits += partLiveBytes[partIndex--];
            partStartIndex += (markWordSize / calFactor);
        }
        size_t bitIndex = (offset / kMarkedBytesPerBit) % kBitsPerWord;
        uint64_t mask = (static_cast<uint64_t>(1) << bitIndex) - 1;
        size_t liveBits = __builtin_popcountll(markWords[index].load() & mask);
        if (index == partStartIndex) {
            return (preLiveBits + liveBits) * kMarkedBytesPerBit;
        }
        index--;
        while (index >= partStartIndex) {
            uint64_t makeBit = markWords[index].load();
            liveBits += __builtin_popcountll(makeBit);
            index--;
        }
        return (preLiveBits + liveBits) * kMarkedBytesPerBit;
    }
};
struct LiveInfo {
    static constexpr MAddress TEMPORARY_PTR = 0x1234;
    RegionInfo* bindedRegion = nullptr;
    RegionBitmap* markBitmap = nullptr;
    RegionBitmap* resurrectBitmap = nullptr;
    RegionBitmap* enqueueBitmap = nullptr;

    uint64_t GetPreLiveBytes(size_t offset, size_t regionSize)
    {
        uint64_t liveBytes = 0;
        if (markBitmap != nullptr) {
            liveBytes += markBitmap->GetPreLiveBytes(offset, regionSize);
        }
        if (resurrectBitmap != nullptr) {
            liveBytes += resurrectBitmap->GetPreLiveBytes(offset, regionSize);
        }
        return liveBytes;
    }
};

struct RouteInfo {
    static constexpr uint32_t INVALID_VALUE = std::numeric_limits<uint32_t>::max();
    uintptr_t toRegion1StartAddress = 0;
    uint32_t toRegion1UsedBytes = 0;
    uint32_t toRegion2Idx = 0;

    uintptr_t GetRoute(uint64_t preLiveBytes);

    void SetRouteInfo(uintptr_t to1, uint32_t to1used = 0, uint32_t to2 = INVALID_VALUE)
    {
        toRegion1StartAddress = to1;
        toRegion1UsedBytes = to1used;
        toRegion2Idx = to2;
    }
};
} // namespace MapleRuntime
#endif // MRT_LIVE_INFO_H
