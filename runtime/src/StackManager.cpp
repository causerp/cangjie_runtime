// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "StackManager.h"
#include <cstdint>

#include "Base/SysCall.h"
#include "Common/StackType.h"
#include "ExceptionManager.inline.h"
#include "Mutator/Mutator.h"
#include "ObjectManager.inline.h"
#include "UnwindStack/EhStackInfo.h"
#include "UnwindStack/GcStackInfo.h"
#include "UnwindStack/PrintSignalStackInfo.h"
#include "UnwindStack/PrintStackInfo.h"
#include "UnwindStack/StackGrowStackInfo.h"
#ifdef _WIN64
#include "UnwindWin.h"
#endif
#ifdef __APPLE__
#include <dlfcn.h>
#include <libproc.h>
#endif
#include "Inspector/CjHeapData.h"
#include "Heap/Allocator/AllocBuffer.h"
#ifdef CANGJIE_SANITIZER_SUPPORT
#include "Sanitizer/SanitizerInterface.h"
#include "StackMap/StackMap.h"
#endif
#include "CpuProfiler/CpuProfiler.h"

#define LIBCANGJIE_RUNTIME "libcangjie-runtime"
#define LIBCANGJIE_STD_CORE "libcangjie-std-core"
#define LIBCANGJIE_CJTHREAD_TRACE "libcangjie-trace"

namespace MapleRuntime {
Uptr StackManager::rtStartAddr = ULLONG_MAX;
Uptr StackManager::rtEndAddr = 0;
Uptr StackManager::cjcSoStartAddr = ULLONG_MAX;
Uptr StackManager::cjcSoEndAddr = 0;
Uptr StackManager::traceSoStartAddr = ULLONG_MAX;
Uptr StackManager::traceSoEndAddr = 0;

#if defined (COMPILE_DYNAMIC)
extern "C" Uptr* g_runtimeDynamicStart;
extern "C" Uptr* g_runtimeDynamicEnd;
#else
extern "C" Uptr* g_runtimeStaticStart;
extern "C" Uptr* g_runtimeStaticEnd;
#endif

StackManager::StackManager() {}

void StackManager::Init()
{
    InitAddressScope();
    InitStackGrowConfig();
}

void StackManager::Fini() const {}

#if defined(MRT_DEBUG) && (MRT_DEBUG == 1)
void StackManager::PrintStackTrace(UnwindContext* uwContext)
{
    PrintStackInfo printStackInfo(uwContext);
    printStackInfo.FillInStackTrace();
    printStackInfo.PrintStackTrace();
}
#endif

void StackManager::PrintSignalStackTrace(UnwindContext* uwContext, uintptr_t pc, uintptr_t fa)
{
    PrintSignalStackInfo printSignalStackInfo(uwContext);
    if (uwContext->GetUnwindContextStatus() == UnwindContextStatus::RISKY) {
        printSignalStackInfo.GetSignalStack()[printSignalStackInfo.GetStackIndex()] = SigHandlerFrameinfo(
            MachineFrame(reinterpret_cast<FrameAddress*>(fa), reinterpret_cast<uint32_t*>(pc)), FrameType::NATIVE);
        printSignalStackInfo.SetStackIndex(printSignalStackInfo.GetStackIndex() + 1);
    }
    printSignalStackInfo.FillInStackTrace();
    printSignalStackInfo.PrintStackTrace();
}

void StackManager::PrintStackTraceForCpuProfile(UnwindContext* unContext, unsigned long long int cjThreadId)
{
    PrintStackInfo printStackInfo(unContext);
    printStackInfo.FillInStackTrace();
    auto stacks = printStackInfo.GetStack();
    std::vector<uint64_t> funcDescRefs;
    std::vector<FrameType> frameTypes;
    std::vector<uint32_t> lineNumbers;
    for (auto& frame : stacks) {
#ifdef __APPLE__
        FuncDescRef funcDesc = MFuncDesc::GetFuncDesc(frame.mFrame.GetFA());
#else
        FuncDescRef funcDesc = MFuncDesc::GetFuncDesc(reinterpret_cast<Uptr>(frame.GetFuncStartPC()));
#endif
        StackMapBuilder stackMapBuild(reinterpret_cast<uintptr_t>(frame.GetFuncStartPC()),
            reinterpret_cast<uintptr_t>(frame.mFrame.GetIP()), 0, reinterpret_cast<uint64_t*>(funcDesc));
        MethodMap methodMap = stackMapBuild.Build<MethodMap>();
        uint32_t lineNum = methodMap.IsValid() ? methodMap.GetLineNum() : 0;
        funcDescRefs.emplace_back(reinterpret_cast<uint64_t>(funcDesc));
        frameTypes.emplace_back(frame.GetFrameType());
        lineNumbers.emplace_back(lineNum);
    }
    CpuProfiler::GetInstance().GetGenerator().Post(cjThreadId, funcDescRefs, frameTypes, lineNumbers);
}

void StackManager::RecordLiteFrameInfos(std::vector<uint64_t>& liteFrameInfos, size_t steps)
{
    PrintStackInfo printStackInfo;
    printStackInfo.FillInStackTrace();
    printStackInfo.ExtractLiteFrameInfoFromStack(liteFrameInfos, steps);
}

void StackManager::GetStackTraceByLiteFrameInfos(const std::vector<uint64_t>& liteFrameInfos,
                                                 std::vector<StackTraceElement>& stackTrace)
{
    StackInfo::GetStackTraceByLiteFrameInfos(liteFrameInfos, stackTrace);
}

void StackManager::GetStackTraceByLiteFrameInfo(const uint64_t ip, const uint64_t pc, const uint64_t funcDesc,
                                                StackTraceElement& ste)
{
    StackInfo::GetStackTraceByLiteFrameInfo(ip, pc, funcDesc, ste);
}

void StackManager::VisitStackRoots(const UnwindContext& topFrame, const RootVisitor& func, Mutator& mutator)
{
    GCStackInfo gcStackInfo(&topFrame);
    gcStackInfo.FillInStackTrace();
    gcStackInfo.VisitStackRoots(func, mutator);
}

void StackManager::VisitHeapReferencesOnStack(const UnwindContext& topFrame, const RootVisitor& rootVisitor,
                                              const DerivedPtrVisitor& derivedPtrVisitor, Mutator& mutator)
{
    GCStackInfo gcStackInfo(&topFrame);
    gcStackInfo.FillInStackTrace();
    gcStackInfo.VisitHeapReferencesOnStack(rootVisitor, derivedPtrVisitor, mutator);
}

void StackManager::VisitStackPtrMap(const UnwindContext& topFrame, const StackPtrVisitor& traceAndFixPtrVisitor,
                                    const StackPtrVisitor& fixPtrVisitor, const DerivedPtrVisitor& derivedPtrVisitor,
                                    Mutator& mutator)
{
    // Reuse gcStackInfo for stack unwind.
    StackGrowStackInfo stackInfo(&topFrame);
    stackInfo.FillInStackTrace();
    stackInfo.RecordStackPtrs(traceAndFixPtrVisitor, fixPtrVisitor, derivedPtrVisitor, mutator);
}

void StackManager::InitStackGrowConfig()
{
    auto cjStackGrow = std::getenv("cjStackGrow");
    if (cjStackGrow == nullptr) {
        return;
    }
    if (strlen(cjStackGrow) != 1) {
        LOG(RTLOG_ERROR, "unsupported cjStackGrow, cjStackGrow should be 0 or 1.\n");
        return;
    }

    switch (cjStackGrow[0]) {
        case '0':
            CangjieRuntime::stackGrowConfig = StackGrowConfig::STACK_GROW_OFF;
            return;
        case '1':
            CangjieRuntime::stackGrowConfig = StackGrowConfig::STACK_GROW_ON;
            return;
        default:
            LOG(RTLOG_ERROR, "unsupported cjStackGrow, cjStackGrow should be 0 or 1.\n");
    }
    return;
}

#if defined(MRT_DEBUG) && (MRT_DEBUG == 1)
std::vector<FrameInfo> GetCurrentStack(StackMode mode)
{
    switch (mode) {
        case StackMode::EH: {
            EHStackInfo ehStackInfo;
            ehStackInfo.FillInStackTrace();
            return ehStackInfo.GetStack();
        }
        case StackMode::GC: {
            GCStackInfo gcStackInfo;
            gcStackInfo.FillInStackTrace();
            return gcStackInfo.GetStack();
        }
        case StackMode::PRINT: {
            PrintStackInfo printStackInfo;
            printStackInfo.FillInStackTrace();
            return printStackInfo.GetStack();
        }
        default:
            LOG(RTLOG_FATAL, "StackMode is invalid");
    }
}
#endif

#if defined(__linux__) || defined(hongmeng)
static void GetSoAddrScope(const CString& str, Uptr& startAddr, Uptr& endAddr)
{
    int pos1 = str.Find('-');
    int pos2 = str.Find(' ');
    if (pos1 < 0 || pos2 < pos1) {
        return;
    }
    constexpr int8_t baseValue = 16;
    Uptr start = std::strtoull(str.SubStr(0, static_cast<uint64_t>(pos1)).Str(), nullptr, baseValue);
    startAddr = start < startAddr ? start : startAddr;
    Uptr end = std::strtoull(str.SubStr(pos1 + 1, static_cast<uint64_t>(pos2 - pos1)).Str(), nullptr, baseValue);
    endAddr = end > endAddr ? end : endAddr;
}


static void GetEachSoAddrScope(FILE* file, std::vector<CString>& soNameVec)
{
    const int bufSize = 1024;
    char buf[bufSize] = { '\0' };
    while (fgets(buf, bufSize, file) != nullptr) {
        CString lineStr(buf);
        int protPos = lineStr.Find(' ');
        if (protPos < 0) {
            continue;
        }
        constexpr uint8_t protLen = 4;
        if (lineStr.SubStr(protPos + 1, protLen).Find('x') < 0) {
            continue;
        }
        char* baseName = CString::BaseName(lineStr);
        auto it = std::find(soNameVec.begin(), soNameVec.end(), baseName);
        if (it != soNameVec.end()) {
            if (strcmp(baseName, LIBCANGJIE_RUNTIME ".so\n") == 0) {
                GetSoAddrScope(lineStr, StackManager::rtStartAddr, StackManager::rtEndAddr);
            } else if  (strcmp(baseName, "cjc\n") == 0) {
                GetSoAddrScope(lineStr, StackManager::cjcSoStartAddr, StackManager::cjcSoEndAddr);
            }
        }
    }
}
#endif

#ifdef __APPLE__
static bool EndWith(const char* str, const char* suffix)
{
    if (str == nullptr || suffix == nullptr) {
        return false;
    }
    size_t strLen = strlen(str);
    size_t suffixLen = strlen(suffix);
    if (suffixLen > strLen) {
        return false;
    }
    return strncmp(str + strLen - suffixLen, suffix, suffixLen) == 0;
}

static void InitAddressInfoOnDarwin(const char* dylib, Uptr& start, Uptr& end)
{
    int pid = GetPid();
    struct proc_regionwithpathinfo info;
    Uptr curAddr = 0;
    while (proc_pidinfo(pid, PROC_PIDREGIONPATHINFO, curAddr, &info, sizeof(info)) > 0) {
        const char* path = info.prp_vip.vip_path;
        Uptr priAddr = info.prp_prinfo.pri_address;
        Uptr priSize = info.prp_prinfo.pri_size;
        if (EndWith(path, dylib) && start == ULLONG_MAX && end == 0) {
            start = priAddr;
            end = priAddr + priSize;
            break;
        }
        curAddr = priAddr + priSize;
    }
}
#endif

void StackManager::InitAddressScope()
{
#if defined(_WIN64)
    Runtime& runtime = Runtime::Current();
    WinModuleManager& winModuleManager = runtime.GetWinModuleManager();
    const WinModule* rtModule = winModuleManager.GetWinModuleByName(LIBCANGJIE_RUNTIME ".dll");
    if (rtModule != nullptr) {
        rtStartAddr = rtModule->GetImageBaseStart();
        rtEndAddr = rtModule->GetImageBaseEnd();
    }
    const WinModule* cjcModule = winModuleManager.GetWinModuleByName("cjc.exe");
    if (cjcModule != nullptr) {
        cjcSoStartAddr = cjcModule->GetImageBaseStart();
        cjcSoEndAddr = cjcModule->GetImageBaseEnd();
    }
#elif defined(__APPLE__)
    InitAddressInfoOnDarwin("/" LIBCANGJIE_RUNTIME ".dylib", StackManager::rtStartAddr, StackManager::rtEndAddr);
    InitAddressInfoOnDarwin("/cjc", StackManager::cjcSoStartAddr, StackManager::cjcSoEndAddr);
#elif defined(__OHOS__) || defined(__HOS__)
    CString procFileName("/proc/self/maps");
    FILE* file = fopen(procFileName.Str(), "r");
    if (file == nullptr) {
        LOG(RTLOG_ERROR, "StackManager::InitAddressScope(): fail to open the file");
        return;
    }
    std::vector<CString> soNameVec = { LIBCANGJIE_RUNTIME ".so\n", "cjc\n" };
    GetEachSoAddrScope(file, soNameVec);
    std::fclose(file);
#else
#if defined (COMPILE_DYNAMIC)
    StackManager::rtStartAddr = reinterpret_cast<Uptr>(&g_runtimeDynamicStart);
    StackManager::rtEndAddr = reinterpret_cast<Uptr>(&g_runtimeDynamicEnd);
#else
    StackManager::rtStartAddr = reinterpret_cast<Uptr>(&g_runtimeStaticStart);
    StackManager::rtEndAddr = reinterpret_cast<Uptr>(&g_runtimeStaticEnd);
#endif
    CString procFileName("/proc/self/maps");
    FILE* file = fopen(procFileName.Str(), "r");
    if (file == nullptr) {
        LOG(RTLOG_ERROR, "StackManager::InitAddressScope(): fail to open the file");
        return;
    }
    std::vector<CString> soNameVec = { "cjc\n" };
    GetEachSoAddrScope(file, soNameVec);
    std::fclose(file);
#endif
}

void InitAddressScopeForCJthreadTrace()
{
#ifdef _WIN64
    Runtime& runtime = Runtime::Current();
    WinModuleManager& winModuleManager = runtime.GetWinModuleManager();
    const WinModule* traceModule = winModuleManager.GetWinModuleByName(LIBCANGJIE_CJTHREAD_TRACE ".dll");
    if (traceModule != nullptr) {
        StackManager::traceSoStartAddr = traceModule->GetImageBaseStart();
        StackManager::traceSoEndAddr = traceModule->GetImageBaseEnd();
    }
#elif defined(__APPLE__)
    InitAddressInfoOnDarwin("/" LIBCANGJIE_CJTHREAD_TRACE ".dylib", StackManager::traceSoStartAddr,
                            StackManager::traceSoEndAddr);
#else
    CString procFileName("/proc/self/maps");
    FILE* file = fopen(procFileName.Str(), "r");
    if (file == nullptr) {
        LOG(RTLOG_ERROR, "StackManager::InitAddressScope(): fail to open the file");
        return;
    }

    const int bufSize = 1024;
    char buf[bufSize] = { '\0' };
    while (fgets(buf, bufSize, file) != nullptr) {
        CString lineStr(buf);
        int protPos = lineStr.Find(' ');
        if (protPos < 0) {
            continue;
        }
        constexpr uint8_t protLen = 4;
        if (lineStr.SubStr(protPos + 1, protLen).Find('x') < 0) {
            continue;
        }
        char* baseName = CString::BaseName(lineStr);
        if (strcmp(baseName, LIBCANGJIE_CJTHREAD_TRACE ".so\n") == 0) {
            GetSoAddrScope(lineStr, StackManager::traceSoStartAddr, StackManager::traceSoEndAddr);
        }
    }
    
    std::fclose(file);
    if (StackManager::traceSoStartAddr == ULLONG_MAX && StackManager::traceSoEndAddr == 0) {
        LOG(RTLOG_FATAL, "can not find Runtime trace so");
    }
#endif
}

bool StackManager::IsRuntimeFrame(Uptr pc)
{
#if defined(ENABLE_BACKWARD_PTRAUTH_CFI)
    pc = PtrauthStripInstPointer(pc);
#endif
#ifdef CANGJIE_HWASAN_SUPPORT
    pc = Sanitizer::UntagAddr(pc);
#endif
    return (pc > rtStartAddr && pc < rtEndAddr) ||
        (pc > cjcSoStartAddr && pc < cjcSoEndAddr) ||
        (pc > traceSoStartAddr && pc < traceSoEndAddr);
}
} // namespace MapleRuntime
