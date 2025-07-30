// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_EH_TABLE_H
#define MRT_EH_TABLE_H

#include "Common/TypeDef.h"

namespace MapleRuntime {
struct ScanResult {
    ScanResult() : typeIndex(0), landingPad(0), isCaught(false) {}

    ScanResult& operator=(const ScanResult& result)
    {
        if (&result == this) {
            return *this;
        }
        typeIndex = result.typeIndex;
        landingPad = result.landingPad;
        isCaught = result.isCaught;
        return *this;
    }

    ScanResult(const ScanResult& result)
    {
        typeIndex = result.typeIndex;
        landingPad = result.landingPad;
        isCaught = result.isCaught;
    }

    uint64_t typeIndex;
    uint64_t landingPad;
    bool isCaught;
};

// language-specific data area
struct EHTable {
    EHTable() = delete;
    explicit EHTable(const uint8_t* lsda) { BuildEHTable(lsda); }

    EHTable(const uint32_t* pc, const ExceptionWrapper& eWrapper, const uint32_t* startIp, const uint8_t* lsda,
            ScanResult& result)
    {
        BuildEHTable(lsda);
        ScanEHTable(pc, eWrapper, startIp, result);
    }

    ~EHTable()
    {
        callSiteTableStart = nullptr;
        callSiteTableEnd = nullptr;
        actionTableStart = nullptr;
        ttypeEncoding = nullptr;
        exceptionTypeStart = nullptr;
    }

    // TType encoding.
    enum class TTypeEncoding {
        ABS_PTR = 0,
        U_DATA_4 = 3,
        INDIR_PC_REL_S_DATA_4 = 155,
        INDIR_PC_REL_S_DATA_8 = 156,
    };

    void BuildEHTable(const uint8_t* lsda);
    void ScanEHTable(const uint32_t* pc, const ExceptionWrapper& eWrapper, const uint32_t* startIp,
                     ScanResult& result) const;
    uint8_t MatchActionTable(uint64_t actionEntryIdx, const ExceptionRef& exceptionRef, uint8_t flag) const;

    static uint64_t ReadULEB128(const uint8_t** data);
    static bool IsAbnormalEHTable(const uint8_t* lsda)
    {
        uint32_t* point = reinterpret_cast<uint32_t*>(reinterpret_cast<uintptr_t>(const_cast<uint8_t*>(lsda)));
        return *point == ABNORMAL_EH_TABLE_TAG;
    }

private:
    static int64_t ReadSLEB128(const uint8_t** data);

    void* ReadAbsPtr(const uint8_t* p) const;
    void* ReadUData4(const uint8_t* p) const;
    void* ReadIndirPcRelSData8(const uint8_t* p) const;
    void* ReadIndirPcRelSData4(const uint8_t* p) const;

    static constexpr uint32_t ABNORMAL_EH_TABLE_TAG = 0x55555555;
    static constexpr uint8_t SHIFT_LENGTH = 0x7;
    static constexpr uint8_t VALUE_MASK = 0x7F;
    static constexpr uint8_t BYTE_MAX_BIT = 0x80;

    const uint8_t* callSiteTableStart{ nullptr };
    const uint8_t* callSiteTableEnd{ nullptr };
    const uint8_t* actionTableStart{ nullptr };
    const uint8_t* ttypeEncoding{ nullptr };
    const uint8_t* exceptionTypeStart{ nullptr };
};
} // namespace MapleRuntime
#endif // MRT_EH_TABLE_H
