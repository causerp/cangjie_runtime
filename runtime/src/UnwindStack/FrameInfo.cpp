// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "Base/Types.h"
#include "Common/StackType.h"
#include "Common/TypeDef.h"
#include "os/Loader.h"
#include "StackMap/StackMap.h"
#include "StackMetadataHelper.h"

namespace MapleRuntime {
void FrameInfo::ResolveProcInfo()
{
    startProc = GetFuncStartPC();
#ifdef __APPLE__
    FuncDescRef funcDesc = MFuncDesc::GetFuncDesc(mFrame.GetFA());
#else
    FuncDescRef funcDesc = MFuncDesc::GetFuncDesc(reinterpret_cast<Uptr>(startProc));
#endif
    lsdaStart = reinterpret_cast<uint8_t*>(funcDesc->GetEHTable());
}

void FrameInfo::PrintFrameInfo(uint32_t frameIdx) const
{
    if (frameIdx > 0 && fType == FrameType::NATIVE) {
        LOG(RTLOG_ERROR, "      ...");
        return;
    }
    CString methodName;
    CString fileName;
    uint32_t lineNumber = 0;
    CString outputStr(CString::FormatString("  #%d  %p", frameIdx, mFrame.GetIP()));
    if (fType == FrameType::MANAGED) {
        StackMetadataHelper stackMetadataHelper(*this);
        MangleNameHelper* mangleNameHelper = stackMetadataHelper.GetMangleNameHelper();
        mangleNameHelper->Demangle();
        if (mangleNameHelper->IsNeedFilt()) {
            methodName = mangleNameHelper->GetMangleName();
        } else {
            methodName = mangleNameHelper->GetDemangleName();
        }
        fileName = stackMetadataHelper.GetFilePathAndName();
        lineNumber = stackMetadataHelper.GetLineNumber();
        outputStr.Append(CString::FormatString(" in %s", methodName.IsEmpty() ? "?" : methodName.Str()));
        if (!fileName.IsEmpty()) {
            outputStr.Append(CString::FormatString(" at %s", fileName.Str()));
            if (lineNumber != 0) {
                outputStr.Append(CString::FormatString(":%d", lineNumber));
            }
        }
    } else {
        Os::Loader::BinaryInfo binInfo;
        (void)Os::Loader::GetBinaryInfoFromAddress(mFrame.GetIP(), &binInfo);
        fileName = CString(binInfo.filePathName);
        methodName = CString(binInfo.symbolName);
        outputStr.Append(CString::FormatString(" in %s", methodName.IsEmpty() ? "?" : methodName.Str()));
        if (!fileName.IsEmpty()) {
            outputStr.Append(CString::FormatString(" from %s", fileName.Str()));
        }
    }
    LOG(RTLOG_ERROR, outputStr.Str());
}

void SigHandlerFrameinfo::PrintFrameInfo(uint32_t frameIdx) const
{
    if (frameIdx > 0 && fType == FrameType::NATIVE) {
        FLOG(RTLOG_ERROR, "      ...");
        return;
    }

    constexpr size_t maxPrcessSize = 1024;
    char methodName[maxPrcessSize];
    char fileName[maxPrcessSize];
    uint32_t lineNumber = 0;
    char outputStr[maxPrcessSize];
    CHECK_IN_SIG(sprintf_s(outputStr, maxPrcessSize, "  #%d  %p", frameIdx, mFrame.GetIP()) != -1);
    if (fType == FrameType::MANAGED) {
        uintptr_t funcStartAddress = reinterpret_cast<uintptr_t>(GetFuncStartPC());
#ifdef __APPLE__
        FuncDescRef funcDesc = MFuncDesc::GetFuncDesc(mFrame.GetFA());
#else
        FuncDescRef funcDesc = MFuncDesc::GetFuncDesc(reinterpret_cast<Uptr>(GetFuncStartPC()));
#endif
        CHECK_IN_SIG(sprintf_s(methodName, maxPrcessSize, "%s", funcDesc->GetFuncName().Str()) != -1);
        CHECK_IN_SIG(sprintf_s(fileName, maxPrcessSize, "%s", funcDesc->GetFuncDir().Str()) != -1);
        if (*fileName != '\0') {
#ifdef _WIN64
            CHECK_IN_SIG(sprintf_s(fileName, maxPrcessSize, "%s%s", fileName, "\\") != -1);
            CHECK_IN_SIG(sprintf_s(fileName, maxPrcessSize, "%s%s", fileName, funcDesc->GetFuncFilename().Str()) != -1);
#else
            CHECK_IN_SIG(sprintf_s(fileName, maxPrcessSize, "%s%s", fileName, "/") != -1);
            CHECK_IN_SIG(sprintf_s(fileName, maxPrcessSize, "%s%s", fileName, funcDesc->GetFuncFilename().Str()) != -1);
#endif
        }

        StackMapBuilder stackMapBuild(funcStartAddress, reinterpret_cast<uintptr_t>(mFrame.GetIP()),
                                      reinterpret_cast<uintptr_t>(mFrame.GetFA()));
        MethodMap methodMap = stackMapBuild.Build<MethodMap>();
        lineNumber = methodMap.IsValid() ? methodMap.GetLineNum() : 0;
        CHECK_IN_SIG(
            sprintf_s(outputStr, maxPrcessSize, "%s in %s", outputStr, *methodName == '\0' ? "?" : methodName) != -1);
        if (*fileName != '\0') {
            CHECK_IN_SIG(sprintf_s(outputStr, maxPrcessSize, "%s at %s", outputStr, fileName) != -1);
            if (lineNumber != 0) {
                CHECK_IN_SIG(sprintf_s(outputStr, maxPrcessSize, "%s:%d", outputStr, lineNumber) != -1);
            }
        }
    } else {
        Os::Loader::BinaryInfo binInfo;
        CHECK_IN_SIG(Os::Loader::GetBinaryInfoFromAddress(mFrame.GetIP(), &binInfo) != -1);
        CHECK_IN_SIG(sprintf_s(fileName, maxPrcessSize, "%s", binInfo.filePathName.Str()) != -1);
        CHECK_IN_SIG(sprintf_s(methodName, maxPrcessSize, "%s", binInfo.symbolName.Str()) != -1);
        CHECK_IN_SIG(
            sprintf_s(outputStr, maxPrcessSize, "%s in %s", outputStr, *methodName == '\0' ? "?" : methodName) != -1);
        if (*fileName != '\0') {
            CHECK_IN_SIG(sprintf_s(outputStr, maxPrcessSize, "%s from %s", outputStr, fileName) != -1);
        }
    }
    FLOG(RTLOG_ERROR, outputStr);
}

const CString FrameInfo::GetFuncName() const
{
    if (fType == FrameType::MANAGED) {
        StackMetadataHelper stackMetadataHelper(*this);
        stackMetadataHelper.GetMangleNameHelper()->Demangle();
        return stackMetadataHelper.GetDemangleName();
    } else {
        Os::Loader::BinaryInfo binInfo;
        Os::Loader::GetBinaryInfoFromAddress(mFrame.GetIP(), &binInfo);
        return CString(binInfo.symbolName);
    }
}

const CString FrameInfo::GetFileName() const
{
    if (fType == FrameType::RUNTIME) {
        Os::Loader::BinaryInfo binInfo;
        Os::Loader::GetBinaryInfoFromAddress(mFrame.GetIP(), &binInfo);
        return CString(binInfo.filePathName);
    } else {
        StackMetadataHelper stackMetadataHelper(*this);
        return stackMetadataHelper.GetFilePathAndName();
    }
}

const CString FrameInfo::GetFileNameForTrace() const
{
    if (fType == FrameType::RUNTIME) {
        return CString("libcangjie-runtime.so");
    } else if (fType == FrameType::MANAGED) {
        StackMetadataHelper stackMetadataHelper(*this);
        return stackMetadataHelper.GetFileName();
    } else {
        Os::Loader::BinaryInfo binInfo;
        Os::Loader::GetBinaryInfoFromAddress(mFrame.GetIP(), &binInfo);
        return CString(binInfo.filePathName);
    }
}

uint32_t FrameInfo::GetFramePc() const
{
    auto pc = mFrame.GetIP();
    if (pc == nullptr) {
        return 0;
    }
    return *pc;
}

uint32_t FrameInfo::GetLineNum() const
{
    if (fType == FrameType::MANAGED) {
        StackMetadataHelper stackMetadataHelper(*this);
        return stackMetadataHelper.GetLineNumber();
    } else {
        return 0;
    }
}
} // namespace MapleRuntime
