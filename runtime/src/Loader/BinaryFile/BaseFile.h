// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_BASE_FILE_H
#define MRT_BASE_FILE_H

#include "Base/CString.h"
#include "Base/Types.h"
#include "os/Path.h"
namespace MapleRuntime {
enum class FileType {
    C_FILE, // cangjie File
    UNKNOWN
};

class BaseFile {
public:
    explicit BaseFile(const CString nameStr) : realPath(nameStr)
    {
        baseName = Os::Path::GetBaseName(realPath.Str());
    }
    static BaseFile* CreateCJFile(FileType type, CString filePath, Uptr cfileMetaAddr);
    virtual ~BaseFile() = default;
    virtual void RegisterFile() = 0;
    virtual void UnregisterFile() = 0;

    virtual bool IsAddrInCJFile(Uptr addr) const = 0;
    virtual Uptr GetPackageInfoBase() = 0;
    virtual U32 GetPackageInfoTotalSize() = 0;
    virtual void GetGlobalInitFunc(std::vector<Uptr> &globalFuncs) const = 0;
    virtual Uptr GetFileMetaAddr() const = 0;
    virtual Uptr GetExtensionDataBase() = 0;
    virtual U32 GetExtensionDataSize() = 0;
    virtual Uptr GetInnerTypeExtensionsBase() = 0;
    virtual U32 GetInnerTypeExtensionsSize() = 0;
    virtual Uptr GetOuterTypeExtensionsBase() = 0;
    virtual U32 GetOuterTypeExtensionsSize() = 0;
    virtual Uptr GetStaticGIBase() = 0;
    virtual U32 GetStaticGISize() = 0;
    virtual Uptr GetTypeInfoBase() = 0;
    virtual U32 GetTypeInfoTotalSize() = 0;
    virtual CString GetSDKVersion() const = 0;

    virtual const CString& GetRealPath() const;
    const CString& GetBaseName() const;
    void SetFileCompatibility(bool isComp) { isCompatible = isComp; }
    bool IsCompatible() const { return isCompatible; }
private:
    CString realPath; // file real path
    CString baseName;
    bool isCompatible { false };
};
} // namespace MapleRuntime
#endif
