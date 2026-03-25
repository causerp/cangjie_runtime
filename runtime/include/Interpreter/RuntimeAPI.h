// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#ifndef MRT_INTERPRETER_RUNTIME_API_H
#define MRT_INTERPRETER_RUNTIME_API_H

#include "Cangjie.h"

#ifndef INTERPRETER_ENABLED
#if (defined(__linux__) || defined(__IOS__)) && (defined(__x86_64__) || defined(__aarch64__))
#define INTERPRETER_ENABLED
#endif
#endif

#ifdef INTERPRETER_ENABLED
typedef const char* INT_InterpreterArg;
typedef const INT_InterpreterArg* INT_InterpreterArgs;

/*
 * @struct InterpreterParam
 * @brief Data structure for interpreter configuration parameters.
 */
struct InterpreterParam {
    /* Interpreter dynamic library name. */
    const char* interpreterLibName;
    /* Number of startup arguments passed to interpreter. */
    int interpreterArgsCount;
    /* Startup argument list passed to interpreter. */
    INT_InterpreterArgs interpreterArgs;
    /* Optional app library handle used by interpreter to resolve application symbols. */
    void* appLibHandle;
};

CANGJIE_RT_API_DECLS_BEGIN

/*
 * @brief Initialize interpreter part of Cangjie runtime environment.
 * @attention This API should be invoked after InitCJRuntime succeeds.
 * @param param [IN] a structure pointer to interpreter configuration parameters.
 * @retval Return 0 if OK. Otherwise, return an error code.
 */
MRT_EXPORT enum RTErrorCode InitCJInterpreter(const struct InterpreterParam* param);

CANGJIE_RT_API_DECLS_END
#endif

#endif // MRT_INTERPRETER_RUNTIME_API_H
