// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_DEMANGLER_H
#define MRT_DEMANGLER_H

#include <algorithm>

#include "Demangler/Demangler.h"

namespace MapleRuntime {
inline Cangjie::Demangler<MapleRuntime::CString> CreateNativeDemangler(const CString& mangled)
{
#ifdef __APPLE__
    return Cangjie::Demangler<MapleRuntime::CString>(mangled, true, "::", [](const CString& str) { return str; });
#else
    return Cangjie::Demangler<MapleRuntime::CString>(mangled);
#endif
}

inline Cangjie::Demangler<MapleRuntime::CString> CreateNativeDemangler(const CString& mangled, const CString& scopeRes)
{
#ifdef __APPLE__
    return Cangjie::Demangler<MapleRuntime::CString>(mangled, true, scopeRes, [](const CString& str) { return str; });
#else
    return Cangjie::Demangler<MapleRuntime::CString>(mangled, scopeRes);
#endif
}

inline Cangjie::Demangler<MapleRuntime::CString> CreateNativeDemangler(const CString& mangled, const CString& scopeRes,
    std::function<CString(const CString&)> genericParamFilter)
{
#ifdef __APPLE__
    return Cangjie::Demangler<MapleRuntime::CString>(mangled, true, scopeRes, genericParamFilter);
#else
    return Cangjie::Demangler<MapleRuntime::CString>(mangled, scopeRes, genericParamFilter);
#endif
}
} // namespace MapleRuntime

#endif // MRT_DEMANGLER_H
