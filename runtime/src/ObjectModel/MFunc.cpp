// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include <cmath>
#include "MFuncdesc.h"
#include "Utils/SLRUCache.h"

namespace MapleRuntime {
constexpr uint8_t probationalSegmentSize = 8;
constexpr uint8_t protectedSegmentSize = 8;
static SLRU g_stringPoolDictsCache(probationalSegmentSize, protectedSegmentSize);

// StrPoolDictSplitSize is defined through elapsed time test on dict loading
// and string decoding. The maximum size of 5000 can keep the elapsed time below
// 1 millisecond, which is a desired cost. When the string pool dict size
// is between 1000 and 5000, the split size will be correspondingly calculated
// by function GetStrPoolDictSplitSize().
static constexpr U32 StrPoolDictSplitMaxSize = 5000;
static constexpr U32 StrPoolDictSplitMinSize = 1000;

U32 GetStrPoolDictSplitSize(U32 TotalSize)
{
    // 10: supposed that TotalSize = SplitSize * n and SplitSize = 10 * n.
    U32 DesiredSize = static_cast<U32>(std::sqrt(TotalSize / 10) * 10);
    if (DesiredSize <= StrPoolDictSplitMinSize) {
        return StrPoolDictSplitMinSize;
    }
    if (DesiredSize >= StrPoolDictSplitMaxSize) {
        return StrPoolDictSplitMaxSize;
    }
    // 100: round the result to be a multiple of one hundred.
    constexpr U32 alignSize = 100;
    return DesiredSize / alignSize * alignSize;
}

// ULEB: The highest bit of each byte is used to indicate whether the encoding is complete,
// and the remaining 7 bits are used to represent the integer value
uint64_t ULEBDecodeSingleStr(std::vector<uint8_t>& bytes)
{
    uint64_t result = 0;
    uint32_t shift = 0;
    constexpr uint8_t IntValueBits = 7;
    for (auto byte : bytes) {
        result |= static_cast<uint64_t>(byte & 0x7f) << shift;
        if ((byte & 0x80) == 0) {
            break;
        }
        shift += IntValueBits;
    }
    bytes.erase(bytes.begin(), bytes.begin() + (shift / IntValueBits) + 1);
    return result;
}

CString ULEBDecode(CString& bytes, Uptr offset)
{
    // The offsets of subdictionaries are structured in assembly as follows:
    // .Lstr_pool_dict_offsets:
    //      .long   dictTotalSize
    //      .long   .Lstr_pool_dict.1-.Lstr_pool_dict_offsets
    //      .long   .Lstr_pool_dict.2-.Lstr_pool_dict_offsets
    //      ...
    U32 dictTotalSize = *(reinterpret_cast<const U32*>(offset));
    U32 strPoolDictSplitSize = GetStrPoolDictSplitSize(dictTotalSize);
    CString result;
    int p = 0;
    std::vector<uint8_t> tempCode;
    while (p < bytes.Length()) {
        tempCode.push_back(bytes[p]);
        if ((bytes[p] & 0x80) == 0) {
            uint64_t decode = ULEBDecodeSingleStr(tempCode);
            if (decode > dictTotalSize) {
                LOG(RTLOG_ERROR, "invalid index in stringpool");
                return result;
            }
            U32 subDictIdx = (decode - 1) / strPoolDictSplitSize + 1;
            // 4: offset value size, 4 bytes
            U32 subDictOffset = *(reinterpret_cast<const U32*>(offset + 4 * subDictIdx));
            // use a SLRU cache to save string loading time.
            std::vector<CString> subDictionary = g_stringPoolDictsCache.Get(offset + subDictOffset);
            if (subDictionary.empty()) {
                CString subDictStr = reinterpret_cast<const char*>(offset + subDictOffset);
                subDictionary = CString::Split(subDictStr, ',');
                g_stringPoolDictsCache.Put(offset + subDictOffset, subDictionary);
            }
            CString singleStr = subDictionary[(decode - 1) % strPoolDictSplitSize];
            result += singleStr;
            tempCode.clear();
        }
        p++;
    }
    return result;
}

struct SingleStr {
    const char *start;
    size_t len;
};

void Split(const char *str, uint64_t targetSeg,
           std::vector<SingleStr> &segments, size_t &totalLen)
{
    const char *p = str;
    const char *start = str;
    bool found = false;
    size_t index = 0;
    while (*p) {
        if (*p == ',') {
            if (index == targetSeg) {
                size_t len = p - start;
                segments.push_back({start, len});
                totalLen += len;
                found = true;
                break;
            }
            index++;
            start = p + 1;
        }
        ++p;
    }
    if (!found && index == targetSeg) {
        size_t len = p - start;
        segments.push_back({start, len});
        totalLen += len;
        found = true;
    }
    if (!found) {
        LOG(RTLOG_ERROR, "string not found in stringpool");
    }
}

CString Merge(const std::vector<SingleStr> &segments, size_t totalLen)
{
    auto size = totalLen + 1;
    char *res = reinterpret_cast<char*>(malloc(size));
    if (res == nullptr) {
        LOG(RTLOG_FATAL, "string decode: malloc failed! (size: %zu)", size);
    }
    char *dst = res;
    for (const auto &seg : segments) {
        auto ret = memcpy_s(dst, size, seg.start, seg.len);
        if (ret != EOK) {
            LOG(RTLOG_FATAL, "string decode: memcpy_s failed!");
        }
        dst += seg.len;
        size -= seg.len;
    }
    res[totalLen] = '\0';
    CString result = res;
    free(res);
    return result;
}

CString FastULEBDecode(CString &bytes, Uptr offset)
{
    // The offsets of subdictionaries are structured in assembly as follows:
    // .Lstr_pool_dict_offsets:
    //      .long   dictTotalSize
    //      .long   .Lstr_pool_dict.1-.Lstr_pool_dict_offsets
    //      .long   .Lstr_pool_dict.2-.Lstr_pool_dict_offsets
    //      ...
    U32 dictTotalSize = *(reinterpret_cast<const U32*>(offset));
    U32 strPoolDictSplitSize = GetStrPoolDictSplitSize(dictTotalSize);
    if (strPoolDictSplitSize == 0) {
        LOG(RTLOG_FATAL, "invalid dictionary split size in stringpool");
        return "";
    }
    int p = 0;
    std::vector<uint8_t> tempCode;
    std::vector<SingleStr> segments;
    size_t totalLen = 0;
    // 50: reserve enough space to avoid reallocation
    segments.reserve(50);
    while (p < bytes.Length()) {
        tempCode.push_back(bytes[p]);
        // 0x80 means the the highest bit is valid, if not, the encoding is complete.
        const char mask = 0x80;
        if ((bytes[p] & mask) == 0) {
            uint64_t decode = ULEBDecodeSingleStr(tempCode);
            if (decode > dictTotalSize) {
                LOG(RTLOG_ERROR, "invalid index in stringpool");
                return Merge(segments, totalLen);
            }
            U32 subDictIdx = (decode - 1) / strPoolDictSplitSize + 1;
            // 4: offset value size, 4 bytes
            U32 subDictOffset = *(reinterpret_cast<const U32*>(offset + 4 * subDictIdx));
            const char *subDictStr = reinterpret_cast<const char *>(offset + subDictOffset);
            Split(subDictStr, (decode - 1) % strPoolDictSplitSize, segments, totalLen);
            tempCode.clear();
        }
        p++;
    }
    return Merge(segments, totalLen);
}

CString MFuncDesc::GetStringFromDict(U32 offset) const
{
    Uptr base = reinterpret_cast<Uptr>(this);
    CString str = reinterpret_cast<const char*>(offset + base);
    if (str.IsEmpty()) {
        return CString();
    }

    return FastULEBDecode(str, dictOffsets + base);
}
}