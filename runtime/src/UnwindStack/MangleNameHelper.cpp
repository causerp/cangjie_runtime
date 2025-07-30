// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "MangleNameHelper.h"

#include <cctype>

#include "Utils/Demangler.h"

namespace MapleRuntime {
CString MangleNameHelper::RemoveGenericTypeName(const MapleRuntime::CString& rawName)
{
    MapleRuntime::CString name;
    int preBracketNum = 0;
    for (int i = 0; i < rawName.Length(); ++i) {
        if (preBracketNum == 0) {
            if (rawName[i] == '<') {
                ++preBracketNum;
            }
            name.Append(CString(rawName[i]));
        } else {
            if (rawName[i] == '<') {
                ++preBracketNum;
            } else if (rawName[i] == '>' && --preBracketNum == 0) {
                name.Append("...>");
            }
        }
    }
    return name;
}

void MangleNameHelper::Demangle()
{
    std::function<MapleRuntime::CString(const MapleRuntime::CString&)> genericTypefilter;
    if (stackTraceFormat == StackTraceFormatFlag::ALL) {
        genericTypefilter = [](const MapleRuntime::CString& str) { return str; };
    } else {
        genericTypefilter = [](const MapleRuntime::CString& str) { return RemoveGenericTypeName(str); };
    }
    const char POSTFIX_WITHOUT_TI[] = "$withoutTI";
    if (mangleName.EndsWith(POSTFIX_WITHOUT_TI)) {
        mangleName.Truncate(mangleName.Length() - strlen(POSTFIX_WITHOUT_TI));
    }
    auto demangler = CreateNativeDemangler(mangleName.Str(), "::", genericTypefilter);
    auto functionDemangleInfo = demangler.Demangle();
    methodName = functionDemangleInfo.GetFullName(demangler.ScopeResolution());
    className = functionDemangleInfo.GetPkgName();
    demangleName = className + (className.Length() > 0 ? "." : "") + methodName;
}

CString MangleNameHelper::GetSimpleClassName() const
{
    auto demangler = CreateNativeDemangler(mangleName.Str());
    return demangler.DemangleClassType();
}

bool MangleNameHelper::IsNeedFilt() const
{
    if (mangleName.IsEmpty()) {
        return false;
    }

    for (auto filtMangleName : filtMangleNameSet) {
        if (mangleName.Find(filtMangleName.Str()) == 0) {
            return true;
        }
    }
    return false;
}
} // namespace MapleRuntime
