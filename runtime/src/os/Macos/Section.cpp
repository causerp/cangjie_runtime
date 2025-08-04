// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include <algorithm>
#include <cstdint>
#include <dlfcn.h>
#include <initializer_list>
#include <mach-o/dyld.h>
#include <mach-o/getsect.h>
#include <cassert>

extern "C" {
// CJMetadataHeader
unsigned long _CJMetadataSize;
uintptr_t _CJMetadataStart;

// CJSDKVersion
unsigned long _CJSDKVersionSize;
uintptr_t _CJSDKVersion;

// CJMethodInfo
unsigned long _CJMethodInfoSize;
uintptr_t _CJMethodInfo;

// CJGlobalInitFunc
unsigned long _CJGlobalInitFuncSize;
uintptr_t _CJGlobalInitFunc;

// CJStringPoolDict
unsigned long _CJStringPoolDictSize;
uintptr_t _CJStringPoolDict;

// CJStringPool
unsigned long _CJStringPoolSize;
uintptr_t _CJStringPool;

// CJStackMap
unsigned long _CJStackMapSize;
uintptr_t _CJStackMap;

// CJGCTib
unsigned long _CJGCTibSize;
uintptr_t _CJGCTib;

// CJGCRoots
unsigned long _CJGCRootsSize;
uintptr_t _CJGCRoots;

// CJTypeTemplate
unsigned long _CJTypeTemplateSize;
uintptr_t _CJTypeTemplate;

// CJTypeInfo
unsigned long _CJTypeInfoSize;
uintptr_t _CJTypeInfo;

// CJTypeInfoFields
unsigned long _CJTypeFieldsSize;
uintptr_t _CJTypeFields;

// CJMTable
unsigned long _CJMTableSize;
uintptr_t _CJMTable;

unsigned long _CJInnerTypeExtensionsSize;
uintptr_t _CJInnerTypeExtensions;

unsigned long _CJOuterTypeExtensionsSize;
uintptr_t _CJOuterTypeExtensions;

// Static GI
unsigned long _CJStaticGITableSize;
uintptr_t _CJStaticGITable;

// CJGCFlags
unsigned long _CJGCFlagsSize;
uintptr_t _CJGCFlags;

// CJReflectPkgInfo
unsigned long _CJGCReflectPkgInfoSize;
uintptr_t _CJReflectPkgInfo;

// CJReflectGV
unsigned long _CJReflectGVSize;
uintptr_t _CJReflectGV;

// CJReflectGI
unsigned long _CJReflectGISize;
uintptr_t _CJReflectGI;

int _CJMetaDataSize;

static void InitSectionInformation(const struct mach_header_64* mhp)
{
    _CJMetadataStart =
        reinterpret_cast<uintptr_t>(getsectiondata(mhp, "__CJMETAHEADER", "__cjmetaheader", &_CJMetadataSize));
    _CJSDKVersion =
        reinterpret_cast<uintptr_t>(getsectiondata(mhp, "__CJ_METADATA", "__cjsdkversion", &_CJSDKVersionSize));
    _CJMethodInfo =
        reinterpret_cast<uintptr_t>(getsectiondata(mhp, "__CJ_METADATA", "__cjmethodinfo", &_CJMethodInfoSize));
    _CJGlobalInitFunc =
        reinterpret_cast<uintptr_t>(getsectiondata(mhp, "__CJ_METADATA", "__cjglobalFunc", &_CJGlobalInitFuncSize));
    _CJStringPoolDict =
        reinterpret_cast<uintptr_t>(getsectiondata(mhp, "__CJ_METADATA", "__cjstrpooldict", &_CJStringPoolDictSize));
    _CJStringPool =
        reinterpret_cast<uintptr_t>(getsectiondata(mhp, "__CJ_METADATA", "__cjstrpool", &_CJStringPoolSize));
    _CJStackMap = reinterpret_cast<uintptr_t>(getsectiondata(mhp, "__CJ_METADATA", "__cjstackmap", &_CJStackMapSize));
    _CJGCTib = reinterpret_cast<uintptr_t>(getsectiondata(mhp, "__CJ_METADATA", "__cjgctib", &_CJGCTibSize));
    _CJGCRoots = reinterpret_cast<uintptr_t>(getsectiondata(mhp, "__CJ_METADATA", "__cjgcroots", &_CJGCRootsSize));
    _CJTypeTemplate =
        reinterpret_cast<uintptr_t>(getsectiondata(mhp, "__CJ_METADATA", "__cjtemplate", &_CJTypeTemplateSize));
    _CJTypeInfo = reinterpret_cast<uintptr_t>(getsectiondata(mhp, "__CJ_METADATA", "__cjtypeinfo", &_CJTypeInfoSize));
    _CJTypeFields =
        reinterpret_cast<uintptr_t>(getsectiondata(mhp, "__CJ_METADATA", "__cj_fields", &_CJTypeFieldsSize));
    _CJMTable = reinterpret_cast<uintptr_t>(getsectiondata(mhp, "__CJ_METADATA", "__cjmtable", &_CJMTableSize));
    _CJInnerTypeExtensions = reinterpret_cast<uintptr_t>(
        getsectiondata(mhp, "__CJ_METADATA", "__cjinnerty_eds", &_CJInnerTypeExtensionsSize));
    _CJOuterTypeExtensions = reinterpret_cast<uintptr_t>(
        getsectiondata(mhp, "__CJ_METADATA", "__cjouterty_eds", &_CJOuterTypeExtensionsSize));
    _CJStaticGITable =
        reinterpret_cast<uintptr_t>(getsectiondata(mhp, "__CJ_METADATA", "__cjstatic_gi", &_CJStaticGITableSize));
    _CJGCFlags = reinterpret_cast<uintptr_t>(getsectiondata(mhp, "__CJ_METADATA", "__cjgcflags", &_CJGCFlagsSize));
    _CJReflectPkgInfo =
        reinterpret_cast<uintptr_t>(getsectiondata(mhp, "__CJ_METADATA", "__cjref_pkginfo", &_CJGCReflectPkgInfoSize));
    _CJReflectGV = reinterpret_cast<uintptr_t>(getsectiondata(mhp, "__CJ_METADATA", "__cjref_gv", &_CJReflectGVSize));
    _CJReflectGI = reinterpret_cast<uintptr_t>(getsectiondata(mhp, "__CJ_METADATA", "__cjref_gi", &_CJReflectGISize));
}

__attribute__((constructor)) void InitData()
{
    // 1. Obtain the name of the current shared library based on the specified symbol.
    Dl_info info;
    const void* addr = reinterpret_cast<const void*>(&InitSectionInformation);
    dladdr(addr, &info);
    const char* dylib_name = info.dli_fname;

    // 2. Traverse all shared libraries and find the index of the current shared library.
    int count = _dyld_image_count();
    int index = -1;
    for (int i = 0; i < count; ++i) {
        const char* name = _dyld_get_image_name(i);
        if (strcmp(name, dylib_name) == 0) {
            index = i;
            break;
        }
    }

    // 3. Init section information use index
    assert(index != -1);
    const struct mach_header_64* mhp = reinterpret_cast<const struct mach_header_64*>(_dyld_get_image_header(index));
    InitSectionInformation(mhp);

    // 4. And last, init _CJMetaDataSize
    std::initializer_list<uintptr_t> addrs{
        _CJSDKVersion,     reinterpret_cast<uintptr_t>(_CJSDKVersion + _CJSDKVersionSize),
        _CJMethodInfo,     reinterpret_cast<uintptr_t>(_CJMethodInfo + _CJMethodInfoSize),
        _CJGlobalInitFunc, reinterpret_cast<uintptr_t>(_CJGlobalInitFunc + _CJGlobalInitFuncSize),
        _CJStringPoolDict, reinterpret_cast<uintptr_t>(_CJStringPoolDict + _CJStringPoolDictSize),
        _CJStringPool,     reinterpret_cast<uintptr_t>(_CJStringPool + _CJStringPoolSize),
        _CJStackMap,       reinterpret_cast<uintptr_t>(_CJStackMap + _CJStackMapSize),
        _CJGCTib,          reinterpret_cast<uintptr_t>(_CJGCTib + _CJGCTibSize),
        _CJGCRoots,        reinterpret_cast<uintptr_t>(_CJGCRoots + _CJGCRootsSize),
        _CJTypeTemplate,        reinterpret_cast<uintptr_t>(_CJTypeTemplate + _CJTypeTemplateSize),
        _CJTypeInfo,       reinterpret_cast<uintptr_t>(_CJTypeInfo + _CJTypeInfoSize),
        _CJTypeFields,      reinterpret_cast<uintptr_t>(_CJTypeFields + _CJTypeFieldsSize),
        _CJMTable,         reinterpret_cast<uintptr_t>(_CJMTable + _CJMTableSize),
        _CJInnerTypeExtensions, reinterpret_cast<uintptr_t>(_CJInnerTypeExtensions + _CJInnerTypeExtensionsSize),
        _CJOuterTypeExtensions, reinterpret_cast<uintptr_t>(_CJOuterTypeExtensions + _CJOuterTypeExtensionsSize),
        _CJStaticGITable,  reinterpret_cast<uintptr_t>(_CJStaticGITable + _CJStaticGITableSize),
        _CJGCFlags,        reinterpret_cast<uintptr_t>(_CJGCFlags + _CJGCFlagsSize),
        _CJReflectPkgInfo, reinterpret_cast<uintptr_t>(_CJReflectPkgInfo + _CJGCReflectPkgInfoSize),
        _CJReflectGV,      reinterpret_cast<uintptr_t>(_CJReflectGV + _CJReflectGVSize),
        _CJReflectGI,      reinterpret_cast<uintptr_t>(_CJReflectGI + _CJReflectGISize),
    };
    uintptr_t start = std::min<uintptr_t>(addrs);
    uintptr_t end = std::max<uintptr_t>(addrs);
    _CJMetaDataSize = end - start;
};
}
