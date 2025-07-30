// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_MANGLE_NAME_H
#define MRT_MANGLE_NAME_H

#include <set>

#include "Base/CString.h"
#include "Base/Macros.h"

namespace MapleRuntime {
enum class StackTraceFormatFlag : int8_t {
    SIMPLE = 0,
    DEFAULT,
    ALL
};

class MangleNameHelper {
public:
    explicit MangleNameHelper(CString name, StackTraceFormatFlag format = StackTraceFormatFlag::DEFAULT)
        : mangleName(name), demangleName(""), packName(""), className(""), methodName(""), stackTraceFormat(format) {}
    MangleNameHelper() = delete;
    ~MangleNameHelper() = default;

    // Return true if mangleName is in the filtMangleNameSet.
    bool IsNeedFilt() const;

    CString GetPackName() const { return packName; }

    CString GetClassName() const { return className; }

    CString GetMethodName() const { return methodName; }

    CString GetMangleName() const { return mangleName; }

    CString GetDemangleName() const { return demangleName; }

    CString GetPackClassName() const
    {
        if (packName != "" && className != "") {
            return packName + "." + className;
        } else {
            return packName + className;
        }
    }

    CString GetSimpleClassName() const;

    static CString RemoveGenericTypeName(const MapleRuntime::CString& rawName);

    void Demangle();

private:
    CString mangleName;
    // demangle name
    CString demangleName;
    // demangle packName.
    CString packName;
    // demangle className.
    CString className;
    // demangle methodName.
    CString methodName;
    StackTraceFormatFlag stackTraceFormat;

    // Filter out the basic library functions when the exception stacktrace is dumped
    std::set<CString> filtMangleNameSet = {
#ifdef __APPLE__
        "_user.main",
        "_cj_entry$",
        "__CNat",
        "_rt$",
#else
        "user.main",
        "cj_entry$",
        "_CNat",
        "rt$",
#endif
    };

    DISABLE_CLASS_COPY_AND_ASSIGN(MangleNameHelper);
};
} // namespace MapleRuntime
#endif // MRT_MANGLE_NAME_H
