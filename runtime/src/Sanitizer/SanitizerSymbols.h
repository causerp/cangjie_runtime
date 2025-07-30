// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef CANGJIERUNTIME_SANITIZERSYMBOLS_H
#define CANGJIERUNTIME_SANITIZERSYMBOLS_H

#include <cstdint>

#include "Base/Macros.h"
#include "SanitizerMacros.h"

namespace MapleRuntime {
namespace Sanitizer {
#define SANITIZER_SYMBOL_DECL(ret_type, func, argc, ...) \
    typedef ret_type (*FUNC_TYPE(func))(ARG_MAP(argc, ARG_TYPE, __VA_ARGS__)); \
    extern FUNC_TYPE(func) PTR_TO_REAL(func) // default to nullptr
#include "SymbolList.def"
#undef SANITIZER_SYMBOL_DECL
} // namespace Sanitizer
} // namespace MapleRuntime

#endif // CANGJIERUNTIME_SANITIZERSYMBOLS_H
