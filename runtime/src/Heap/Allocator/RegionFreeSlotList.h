// Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#ifndef MRT_REGION_FREE_SLOT_LIST_H
#define MRT_REGION_FREE_SLOT_LIST_H

#include <array>
#include <cstddef>
#include <cstdint>
#include <limits>
#include "Base/Globals.h"
#include "Base/Log.h"
#include "Base/LogFile.h"

namespace MapleRuntime {

class RegionInfo;

struct FreeSlotNode {
    static constexpr uintptr_t MAGIC_VALUE = 0xABCu;
    static constexpr size_t OFFSET_LEN = 32;
    static constexpr size_t SIZE_LEN = 20;
    static constexpr size_t MAGIC_LEN = 12;

    static FreeSlotNode* Cast(uintptr_t addr)
    {
        return reinterpret_cast<FreeSlotNode*>(addr);
    }

    uintptr_t nextOffset : OFFSET_LEN;
    uintptr_t slotSize : SIZE_LEN;
    uintptr_t magicBits : MAGIC_LEN;

    bool IsValidSlot() const { return magicBits == MAGIC_VALUE; }

    static FreeSlotNode MakeSlot(uint32_t next, uint32_t sz)
    {
        FreeSlotNode node;
        node.nextOffset = next;
        node.slotSize = sz;
        node.magicBits = MAGIC_VALUE;
        return node;
    }

    // --- Slot size classification (merged from RegionFreeSlot) ---

    static constexpr size_t SLOT_SIZES[] = {
        8, 16, 24, 32, 48, 64, 96, 128,
        192, 256, 384, 512,
        768, KB, 2 * KB, 4 * KB,
        8 * KB, 12 * KB, 16 * KB, 20 * KB, 24 * KB, 28 * KB, 32 * KB, 64 * KB, 128 * KB, 256 * KB, 512 * KB, 1 * MB,
        2 * MB
    };
    static constexpr size_t NUM_SLOTS = sizeof(SLOT_SIZES) / sizeof(SLOT_SIZES[0]);

    static constexpr size_t SMALL_SIZE_THRESHOLD = 256;
    static constexpr size_t KB_4 = 4 * KB;
    static constexpr size_t MEDIUM_SLOT_START = 10;
    static constexpr size_t MEDIUM_SLOT_END = 15;
    static constexpr size_t KB_THRESHOLD = SLOT_SIZES[MEDIUM_SLOT_END];
    static constexpr size_t FIRST_4KB_INDEX = MEDIUM_SLOT_END + 1;
    // Unit index (in KB_4) of the first size covered by the 4KB-multiple slots (8KB = 2 * KB_4).
    static constexpr size_t FIRST_4KB_UNIT_IDX = 2;
    static constexpr size_t KB_32 = SLOT_SIZES[NUM_SLOTS - 2];
    static constexpr size_t KB_64 = SLOT_SIZES[NUM_SLOTS - 1];
    static constexpr size_t MAX_SIZE = KB_64;

    static void InitSizeToSlotMap()
    {
        size_t slotIdx = 0;
        for (size_t allocSize = 0; allocSize <= SMALL_SIZE_THRESHOLD; allocSize++) {
            while (slotIdx < NUM_SLOTS - 1 && SLOT_SIZES[slotIdx] < allocSize) {
                slotIdx++;
            }
            smallSizeToSlotIdx[allocSize] = static_cast<uint8_t>(slotIdx);
        }
    }

    static size_t GetAlignedUpSlotIndex(size_t allocSize)
    {
        if (allocSize == 0) {
            return 0;
        }
        if (allocSize > MAX_SIZE) {
            return NUM_SLOTS;
        }
        if (allocSize <= SMALL_SIZE_THRESHOLD) {
            return smallSizeToSlotIdx[allocSize];
        }
        if (allocSize <= KB_THRESHOLD) {
            return GetMediumSlotIndex(allocSize);
        }
        return GetLargeSlotIndex(allocSize);
    }

    static size_t GetSlotSize(size_t allocSize)
    {
        size_t idx = GetAlignedUpSlotIndex(allocSize);
        if (idx >= NUM_SLOTS) {
            return 0;
        }
        return SLOT_SIZES[idx];
    }

    static size_t GetAlignedDownSlotIndex(size_t allocSize)
    {
        if (allocSize == 0) {
            return 0;
        }
        if (allocSize < SLOT_SIZES[0]) {
            return 0;
        }
        if (allocSize >= MAX_SIZE) {
            return NUM_SLOTS - 1;
        }
        for (size_t i = NUM_SLOTS - 1; i > 0; i--) {
            if (SLOT_SIZES[i] <= allocSize) {
                return i;
            }
        }
        return 0;
    }

private:
    static size_t GetMediumSlotIndex(size_t allocSize)
    {
        for (size_t i = MEDIUM_SLOT_START; i <= MEDIUM_SLOT_END; i++) {
            if (allocSize <= SLOT_SIZES[i]) {
                return i;
            }
        }
        return NUM_SLOTS;
    }

    static size_t GetLargeSlotIndex(size_t allocSize)
    {
        if (allocSize <= KB_32) {
            size_t unitIdx = (allocSize + KB_4 - 1) / KB_4;
            return FIRST_4KB_INDEX + (unitIdx - FIRST_4KB_UNIT_IDX);
        }
        return NUM_SLOTS - 1;
    }

    static std::array<uint8_t, SMALL_SIZE_THRESHOLD + 1> smallSizeToSlotIdx;
};

class RegionFreeSlotList {
public:
    static constexpr size_t NUM_SLOTS = FreeSlotNode::NUM_SLOTS;
    static constexpr size_t MIN_SLOT_SIZE = sizeof(FreeSlotNode);
    static constexpr uint32_t MAX_ENCODED_SLOT_SIZE =
        (static_cast<uint32_t>(1U) << FreeSlotNode::SIZE_LEN) - 1U;
    // Keep every split boundary aligned so that it can hold a FreeSlotNode.
    static constexpr uint32_t MAX_SLOT_SIZE =
        MAX_ENCODED_SLOT_SIZE & ~(static_cast<uint32_t>(MIN_SLOT_SIZE) - 1U);

    static_assert((MIN_SLOT_SIZE & (MIN_SLOT_SIZE - 1U)) == 0, "slot alignment must be a power of two");
    static_assert(MAX_SLOT_SIZE <= MAX_ENCODED_SLOT_SIZE, "slot size must fit in FreeSlotNode::size");
    static_assert(MAX_SLOT_SIZE >= MIN_SLOT_SIZE, "encoded slot size is too small");

    RegionFreeSlotList() : regionStart_(0), heads_{}, maxSlotIndex_(NUM_SLOTS), totalSlotSize_(0) {}

    void Init(uintptr_t regionStart)
    {
        regionStart_ = regionStart;
        for (size_t i = 0; i < NUM_SLOTS; i++) {
            heads_[i] = INVALID_OFFSET;
        }
        maxSlotIndex_ = NUM_SLOTS;
        totalSlotSize_ = 0;
    }

    size_t GetMaxAvailableSlotIndex() const { return maxSlotIndex_; }

    size_t GetTotalSlotSize() const { return totalSlotSize_; }

    size_t GetMaxAvailableSize() const
    {
        if (maxSlotIndex_ >= NUM_SLOTS) {
            return 0;
        }
        return FreeSlotNode::SLOT_SIZES[maxSlotIndex_];
    }

    void AddSlot(uint32_t offset, uint32_t size)
    {
        DCHECK(size >= MIN_SLOT_SIZE);
        totalSlotSize_ += size;

        uint32_t remainingSize = size;
        uint32_t currentOffset = offset;
        do {
            uint32_t slotSize = remainingSize > MAX_SLOT_SIZE ? MAX_SLOT_SIZE : remainingSize;
            // Keep a final fragment large enough to hold its node. This only
            // matters for a non-aligned caller; normal region sizes are 8-byte
            // aligned, but preserving the invariant here avoids creating an
            // unrepresentable tail.
            if (remainingSize > slotSize && remainingSize - slotSize < MIN_SLOT_SIZE) {
                slotSize -= static_cast<uint32_t>(MIN_SLOT_SIZE - (remainingSize - slotSize));
            }
            AddSingleSlot(currentOffset, slotSize);
            currentOffset += slotSize;
            remainingSize -= slotSize;
        } while (remainingSize != 0);
    }

    uintptr_t AllocateSlot(size_t requestedSize, uintptr_t regionStart)
    {
        size_t slotIdx = FreeSlotNode::GetAlignedUpSlotIndex(requestedSize);
        if (slotIdx >= NUM_SLOTS) {
            return 0;
        }
        if (maxSlotIndex_ >= NUM_SLOTS || slotIdx > maxSlotIndex_) {
            return 0;
        }

        for (size_t i = slotIdx; i <= maxSlotIndex_; i++) {
            if (heads_[i] != INVALID_OFFSET) {
                uint32_t slotOffset = heads_[i];
                FreeSlotNode node = ReadSlotNode(slotOffset);
                if (!node.IsValidSlot()) {
                    heads_[i] = INVALID_OFFSET;
                    if (i >= maxSlotIndex_) {
                        RecalculateMaxSlotIndex();
                    }
                    continue;
                }

                uint32_t nextOffset = node.nextOffset;
                heads_[i] = nextOffset;
                if (nextOffset == INVALID_OFFSET && i >= maxSlotIndex_) {
                    RecalculateMaxSlotIndex();
                }

                uint32_t slotSize = node.slotSize;
                totalSlotSize_ -= slotSize;
                if (slotSize > requestedSize) {
                    uint32_t remainderOffset = slotOffset + static_cast<uint32_t>(requestedSize);
                    uint32_t remainderSize = slotSize - static_cast<uint32_t>(requestedSize);
                    if (remainderSize >= MIN_SLOT_SIZE) {
                        AddSlot(remainderOffset, remainderSize);
                        DLOG(SWEEP, "split and add slot [%p, %p)",
                            reinterpret_cast<void*>(regionStart + remainderOffset),
                            reinterpret_cast<void*>(regionStart + remainderOffset + remainderSize));
                    }
                }
                DLOG(SWEEP, "allocate slot [%p, %p) slotSize=%u requestedSize=%zu",
                     reinterpret_cast<void*>(regionStart + slotOffset),
                     reinterpret_cast<void*>(regionStart + slotOffset + slotSize),
                     slotSize, requestedSize);
                return regionStart + slotOffset;
            }
        }
        return 0;
    }

private:
    static constexpr uint32_t INVALID_OFFSET = std::numeric_limits<uint32_t>::max();

    void AddSingleSlot(uint32_t offset, uint32_t size)
    {
        DCHECK(size >= MIN_SLOT_SIZE);
        DCHECK(size <= MAX_ENCODED_SLOT_SIZE);
        size_t slotIdx = FreeSlotNode::GetAlignedDownSlotIndex(size);
        if (slotIdx >= NUM_SLOTS) {
            slotIdx = NUM_SLOTS - 1;
        }
        uint32_t next = heads_[slotIdx];
        heads_[slotIdx] = offset;
        WriteSlotNode(offset, FreeSlotNode::MakeSlot(next, size));
        if (maxSlotIndex_ == NUM_SLOTS || slotIdx > maxSlotIndex_) {
            maxSlotIndex_ = slotIdx;
        }
    }

    uintptr_t regionStart_;
    std::array<uint32_t, NUM_SLOTS> heads_;
    size_t maxSlotIndex_;
    size_t totalSlotSize_;

    void RecalculateMaxSlotIndex()
    {
        for (size_t i = maxSlotIndex_; i > 0; i--) {
            if (heads_[i] != INVALID_OFFSET) {
                maxSlotIndex_ = i;
                return;
            }
        }
        maxSlotIndex_ = (heads_[0] != INVALID_OFFSET) ? 0 : NUM_SLOTS;
    }

    FreeSlotNode ReadSlotNode(uint32_t offset) const
    {
        FreeSlotNode *node = reinterpret_cast<FreeSlotNode*>(regionStart_ + offset);
        FreeSlotNode copy;
        copy.nextOffset = node->nextOffset;
        copy.slotSize = node->slotSize;
        copy.magicBits = node->magicBits;
        return copy;
    }

    void WriteSlotNode(uint32_t offset, FreeSlotNode node)
    {
        FreeSlotNode *ptr = reinterpret_cast<FreeSlotNode*>(regionStart_ + offset);
        ptr->nextOffset = node.nextOffset;
        ptr->slotSize = node.slotSize;
        ptr->magicBits = node.magicBits;
    }
};

} // namespace MapleRuntime
#endif // MRT_REGION_FREE_SLOT_LIST_H
