// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include <dlfcn.h>

#include "SanitizerInterface.h"

#include "Base/Log.h"
#include "Base/Macros.h"

namespace MapleRuntime {
namespace Sanitizer {
using namespace std;
#define SANITIZER_SYMBOL_DECL(ret_type, func, argc, ...) \
    typedef ret_type (*FUNC_TYPE(func))(ARG_MAP(argc, ARG_TYPE, __VA_ARGS__)); \
    FUNC_TYPE(func) PTR_TO_REAL(func) = nullptr // default to nullptr
#include "SymbolList.def"
#undef SANITIZER_SYMBOL_DECL

__attribute__((constructor)) ATTR_UNUSED void InitSanitizer()
{
#define SANITIZER_SYMBOL_DECL(ret_type, func, argc, ...) \
    REAL(func) = reinterpret_cast<SANITIZER_FUNC_TYPE(func)>(dlsym(RTLD_DEFAULT, #func)); \
    CHECK_DETAIL(REAL(func) != nullptr, "sanitizer function " #func "not found")
#include "SymbolList.def"
#undef SANITIZER_SYMBOL_DECL
}
} // namespace Sanitizer
} // namespace MapleRuntime