// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_CJSEMANTICVERSION_H
#define MRT_CJSEMANTICVERSION_H

#include "Base/CString.h"

namespace MapleRuntime {
enum class VersionType {
    MAJOR = 0,
    MINOR,
    PATCH,
    VERSION_TYPE_NUMBER
};

struct SemanticVersionInfo {
    size_t major;
    size_t minor;
    size_t patch;

    SemanticVersionInfo() {}
    explicit SemanticVersionInfo(CString& version);
    ~SemanticVersionInfo() {}
};

class CjSemanticVersion {
public:
    CjSemanticVersion();
    ~CjSemanticVersion() {}
    const char* GetRuntimeSDKVersion();
    bool CheckPackageCompatibility(CString& packageName, CString& binaryVersion);
    void ThrowException(CString& packageName, CString& binaryVersion);
private:
    bool IsCompatible(CString& binaryVersion);
    bool IsSemver(CString& version);
    bool IsCorePackage(CString& packageName);
    bool IsUnstableVersion(SemanticVersionInfo& version);

    SemanticVersionInfo runtimeSemanticVersionInfo;
    SemanticVersionInfo stableSemanticVersionInfo;
};
} // namespace MapleRuntime
#endif // MRT_CJSEMANTICVERSION_H
