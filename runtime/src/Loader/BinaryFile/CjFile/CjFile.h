// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_CJFILE_H
#define MRT_CJFILE_H
#include "Base/Types.h"
#include "BaseFile.h"
#include "CjFileMeta.h"

namespace MapleRuntime {
class CJFile : public BaseFile {
public:
    explicit CJFile(CString path, Uptr addr) : BaseFile(path), cJFileMetaBegin(addr){};
    ~CJFile() override = default;

    void RegisterFile() override;
    void UnregisterFile() override;

    void LoadCJFileMeta();
    Uptr GetFileMetaAddr() const override;
    const CJFileMeta& GetCJFileMeta() const;
    bool IsAddrInCJFile(Uptr addr) const override;
    Uptr GetPackageInfoBase() override;
    U32 GetPackageInfoTotalSize() override;
    Uptr GetExtensionDataBase() override;
    U32 GetExtensionDataSize() override;
    Uptr GetInnerTypeExtensionsBase() override;
    U32 GetInnerTypeExtensionsSize() override;
    Uptr GetOuterTypeExtensionsBase() override;
    U32 GetOuterTypeExtensionsSize() override;
    Uptr GetStaticGIBase() override;
    U32 GetStaticGISize() override;
    Uptr GetTypeInfoBase() override;
    U32 GetTypeInfoTotalSize() override;
    CString GetSDKVersion() const override;

    void GetGlobalInitFunc(std::vector<Uptr> &globalInitFuncs) const override;
#if defined(_WIN64)
    void LoadWinCJFileMeta();
#elif defined(__APPLE__)
    void LoadMacCJFileMeta();
#else
    void LoadLinuxCJFileMeta();
#endif

private:
    Uptr* GetGlobalInitFuncPtr(const CJFileMeta& cFileMeta) const;
    U32 GetGlobalInitFuncSize(const CJFileMeta& cFileMeta) const;
    CJFileMeta cJFileMeta;
    Uptr cJFileMetaBegin;
    Uptr cJFileMetaEnd;
};
using CJFileRef = CJFile*;
} // namespace MapleRuntime
#endif // MRT_CJFILE_H
