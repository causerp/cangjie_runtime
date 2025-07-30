// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_CJFILE_META_H
#define MRT_CJFILE_META_H
#include "ObjectModel/ExtensionData.h"
namespace MapleRuntime {
enum CFileTable {
    // RW Section
    FUNC_DESC_TABLE,
    GLOBAL_INIT_FUNC_TABLE,
    STRING_POOL_DICT_TABLE,
    STRING_POOL_TABLE,
    STACK_MAP_TABLE, // StackMap Table
    GC_TIB_TABLE,
    GC_ROOT_TABLE,
    TYPE_TEMPLATE_TABLE,
    TYPE_INFO_TABLE,
    TYPE_FIELDS_TABLE,
    EXTENSION_DATA_TABLE,
    INNER_TYPE_EXTENSIONS_TABLE,
    OUTER_TYPE_EXTENSIONS_TABLE,
    STATIC_GI_TABLE,
    GC_FLAGS_TABLE,
    PACKINFO_TABLE,
    REFLECT_GV_TABLE,
    REFLECT_GI_TABLE,
    C_FILE_MAX
};

#pragma pack(4)
#ifdef __APPLE__
using TableDesc = struct {
    U64 *tableAddr;
    U32 *tableSize;
};
#else
using TableDesc = struct {
#if defined(_WIN64)
    U64 tableAddr;
#else
    U32 tableOffset;
#endif
    U32 tableSize;
};
#endif
#pragma pack()

#ifdef __APPLE__
using CJFileHeader = struct {
    U32 magic;
    U32 version;
    U64 checkSum;
    U32 *cJFileSize;
    U64 *cJSDKVersionPtr;
    TableDesc tables[C_FILE_MAX];
};
#elif defined(_WIN64)
using CJFileHeader = struct {
    U32 magic;
    U32 version;
    U32 checkSum;
    U32 cJFileSize;
    U64 cJSDKVersionPtr;
    TableDesc tables[C_FILE_MAX];
};
#else
using CJFileHeader = struct {
    U32 magic;
    U32 version;
    U32 checkSum;
    U32 cJFileSize;
    U32 cJSDKVersionOffset;
    TableDesc tables[C_FILE_MAX];
};
#endif

using CJStackMapTable = struct {
    U32 stackMapTotalSize;
    void* stackMapBasePtr;
};

using CJTypeInfoTable = struct {
    U32 typeInfoTotalSize;
    TypeInfo* typeInfoBasePtr;
};

using CJFuncDescTable = struct {
    U32 funcDescTotalSize;
    FuncDescRef funcDescBasePtr;
};

using CJGlobalInitFuncTable = struct {
    U32 globalInitFuncTotalSize;
    Uptr* globalInitFuncBasePtr;
};

using CJGcTibTable = struct {
    U32 gcTibTotalSize;
    void* gcTibBasePtr;
};

using CJExtensionDataTable = struct {
    U32 extensionDataTotalSize;
    ExtensionData* extensionDataBasePtr;
};

using CJInnerTypeExtensionTable = struct {
    U32 innerTyExtensionTotalSize;
    void *innerTyExtensionBasePtr;
};

using CJOuterTypeExtensionTable = struct {
    U32 outerTyExtensionTotalSize;
    void *outerTyExtensionBasePtr;
};

using CJStaticGITable = struct {
    U32 staticGITotalSize;
    void* staticGIBasePtr;
};

using CJGCFlagsTable = struct {
    U8 withSafepoint;
    U8 withBarrier;
    U8 hasStackPointerMap;
};

using CJPackageInfoTable = struct {
    U32 packageInfoTotalSize;
    Uptr packageInfoBasePtr;
};

using CJFileMeta = struct CJFileMetadata {
    CJStackMapTable stackMapTbl;
    CJTypeInfoTable typeInfoTbl;
    CJFuncDescTable funcDescTbl;
    CJGlobalInitFuncTable globalInitFuncTbl;
    CJGcTibTable gcTibTbl;
    CJExtensionDataTable extensionDataTbl;
    CJInnerTypeExtensionTable innerTyExtensionTbl;
    CJOuterTypeExtensionTable outerTyExtensionTbl;
    CJStaticGITable staticGITbl;
    CJGCFlagsTable gcFlagsTbl;
    CJPackageInfoTable packageInfoTbl;
    Uptr gcRootsAddr;
    U32 gcRootSize;
};
} // namespace MapleRuntime
#endif // MRT_CJFILE_META_H
