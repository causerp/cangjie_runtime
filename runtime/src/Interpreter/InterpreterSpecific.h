// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#ifndef MRT_INTERPRETER_SPECIFIC_H
#define MRT_INTERPRETER_SPECIFIC_H

#include "Interpreter/RuntimeAPI.h"
#include "Options.h"
#ifdef INTERPRETER_ENABLED

#include "Common/StackType.h"
#include "Interpreter/RTInterface.h"
#include "Mutator/Mutator.h"
#include <cstdio>
#include <cstdlib>

namespace MapleRuntime {

void IterateFramesWithState(
    DYN_CJThreadSpecificData cjThreadData, void (*callback)(DYN_VisitingState, void*), void* ctx);

void VisitInterpreterGlobalRoots(DYN_RootVisitor visitor);

void VisitInterpreterFrameRootsExpansion(
    DYN_VisitingState state, FrameInfo frameDesc, DYN_RootVisitor stackPtrVisitor, DYN_RootVisitor derivedPtrVisitor);
void VisitInterpreterFrameRootsMarking(DYN_VisitingState state, FrameInfo frameDesc, DYN_RootVisitor rootVisitor);
void VisitInterpreterFrameRootsAdjusting(
    DYN_VisitingState state, FrameInfo frameDesc, DYN_RootVisitor rootVisitor, DYN_RootVisitor derivedPtrVisitor);

void InterpreterCJThreadStart(DYN_CJThreadSpecificData* mutator);
void InterpreterCJThreadDestroy(DYN_CJThreadSpecificData* mutator);
DYN_CJThreadHandle NewCJThread(void* execute, DYN_ObjRef future, void* scheduler);

void FillInterpretedFrameInfo(uintptr_t fp, uintptr_t ip, INT_InterpretedFrameInfo* fInfo);

struct DYN_TypeInfo* TypeInfoProvider(char* sig);
uint32_t GetInstanceSize(struct DYN_TypeInfo* typeInfoPtr);
DYN_FuncPtr* GetMTable(struct DYN_TypeInfo* ti, struct DYN_TypeInfo* itf);
struct DYN_TypeInfo* GetMethodOuterTI(struct DYN_TypeInfo* ti, struct DYN_TypeInfo* itf, uint64_t index);
void UpdateVMT(struct DYN_TypeInfo* ti, struct DYN_TypeInfo* itf, struct DYN_ExtensionData* extensionData);
uint32_t GetTypeInfoUUID(struct DYN_TypeInfo* ti);

DYN_ObjRef ObjectAllocate(struct DYN_TypeInfo* tpe);

void SafePoint();

bool IsPendingSafePoint(DYN_ThreadLocalData* tlData);

DYN_ObjRef GetPendingException();
DYN_ObjRef GetAndClearPendingException();
bool InstanceOf(DYN_ObjRef ref, struct DYN_TypeInfo* ti);

RTErrorCode InitInterpreter(const InterpreterParam& interpreterParam);

bool IsC2IStubAddr(const uintptr_t addr);
bool IsI2IAdapterStartAddr(const uintptr_t addr);
bool IsI2NStubAddr(const uintptr_t addr);
bool IsInterpreterPrologueAddr(const uintptr_t addr);

uintptr_t GetCommonInterpreterLandingPad();

} // namespace MapleRuntime

#endif // INTERPRETER_ENABLED

#endif // MRT_INTERPRETER_SPECIFIC_H
