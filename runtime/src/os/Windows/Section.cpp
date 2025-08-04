// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#include <windows.h>
#include <iostream>
#include <initializer_list>

extern "C" {
// CJMetadataHeader
unsigned long __CJMetadataSize;
uintptr_t __CJMetadataStart;

// CJSDKVersion
unsigned long __CJSDKVersionSize;
uintptr_t __CJSDKVersion;

// CJMethodInfo
unsigned long __CJMethodInfoSize;
uintptr_t __CJMethodInfo;

// CJGlobalInitFunc
unsigned long __CJGlobalInitFuncSize;
uintptr_t __CJGlobalInitFunc;

// CJStringPoolDict
unsigned long __CJStringPoolDictSize;
uintptr_t __CJStringPoolDict;

// CJStringPool
unsigned long __CJStringPoolSize;
uintptr_t __CJStringPool;

// CJStackMap
unsigned long __CJStackMapSize;
uintptr_t __CJStackMap;

// CJGCTib
unsigned long __CJGCTibSize;
uintptr_t __CJGCTib;

// CJGCRoots
unsigned long __CJGCRootsSize;
uintptr_t __CJGCRoots;

// CJTypeTemplate
unsigned long __CJTypeTemplateSize;
uintptr_t __CJTypeTemplate;

// CJTypeInfo
unsigned long __CJTypeInfoSize;
uintptr_t __CJTypeInfo;

// CJTypeInfoFields
unsigned long __CJTypeFieldsSize;
uintptr_t __CJTypeFields;

// CJMTable
unsigned long __CJMTableSize;
uintptr_t __CJMTable;

unsigned long __CJInnerTypeExtensionsSize;
uintptr_t __CJInnerTypeExtensions;

unsigned long __CJOuterTypeExtensionsSize;
uintptr_t __CJOuterTypeExtensions;

// Static GI
unsigned long __CJStaticGITableSize;
uintptr_t __CJStaticGITable;

// CJGCFlags
unsigned long __CJGCFlagsSize;
uintptr_t __CJGCFlags;

// CJReflectPkgInfo
unsigned long __CJGCReflectPkgInfoSize;
uintptr_t __CJReflectPkgInfo;

// CJReflectGV
unsigned long __CJReflectGVSize;
uintptr_t __CJReflectGV;

// CJReflectGI
unsigned long __CJReflectGISize;
uintptr_t __CJReflectGI;

__attribute__((constructor(0))) __declspec(dllexport) void InitData()
{
    HMODULE hModule = NULL;
    if (!GetModuleHandleEx(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS,
                           reinterpret_cast<LPCSTR>(&InitData),
                           &hModule)) {
        return;
    }
    if (hModule == NULL) {
        return;
    }

    PIMAGE_DOS_HEADER dosHeader = (PIMAGE_DOS_HEADER)hModule;
    if (dosHeader->e_magic != IMAGE_DOS_SIGNATURE) {
        return;
    }

    PIMAGE_NT_HEADERS ntHeaders = (PIMAGE_NT_HEADERS)((BYTE*)hModule + dosHeader->e_lfanew);
    if (ntHeaders->Signature != IMAGE_NT_SIGNATURE) {
        return;
    }

    PIMAGE_SECTION_HEADER sectionHeader = IMAGE_FIRST_SECTION(ntHeaders);

    for (UINT i = 0; i < ntHeaders->FileHeader.NumberOfSections; i++) {
        const char* secName = reinterpret_cast<const char*>(sectionHeader->Name);

        if (strncmp(secName, ".header", sizeof(".header") - 1) == 0) {
            __CJMetadataStart = reinterpret_cast<uintptr_t>(hModule) +
                                sectionHeader->VirtualAddress;
            __CJMetadataSize = sectionHeader->Misc.VirtualSize;
        } else if (strncmp(secName, ".cjsdkv", sizeof(".cjsdkv") - 1) == 0) {
            __CJSDKVersion = reinterpret_cast<uintptr_t>(hModule) +
                             sectionHeader->VirtualAddress;
            __CJSDKVersionSize = sectionHeader->Misc.VirtualSize;
        } else if (strncmp(secName, ".cjmthd", sizeof(".cjmthd") - 1) == 0) {
            __CJMethodInfo = reinterpret_cast<uintptr_t>(hModule) +
                             sectionHeader->VirtualAddress;
            __CJMethodInfoSize = sectionHeader->Misc.VirtualSize;
        } else if (strncmp(secName, ".cjinitF", sizeof(".cjinitF") - 1) == 0) {
            __CJGlobalInitFunc = reinterpret_cast<uintptr_t>(hModule) +
                             sectionHeader->VirtualAddress;
            __CJGlobalInitFuncSize = sectionHeader->Misc.VirtualSize;
        } else if (strncmp(secName, ".cjspdct", sizeof(".cjspdct") - 1) == 0) {
            __CJStringPoolDict = reinterpret_cast<uintptr_t>(hModule) +
                             sectionHeader->VirtualAddress;
            __CJStringPoolDictSize = sectionHeader->Misc.VirtualSize;
        } else if (strncmp(secName, ".cjsp", sizeof(".cjsp") - 1) == 0) {
            __CJStringPool = reinterpret_cast<uintptr_t>(hModule) +
                             sectionHeader->VirtualAddress;
            __CJStringPoolSize = sectionHeader->Misc.VirtualSize;
        } else if (strncmp(secName, ".cjsm", sizeof(".cjsm") - 1) == 0) {
            __CJStackMap = reinterpret_cast<uintptr_t>(hModule) +
                             sectionHeader->VirtualAddress;
            __CJStackMapSize = sectionHeader->Misc.VirtualSize;
        } else if (strncmp(secName, ".cjgctib", sizeof(".cjgctib") - 1) == 0) {
            __CJGCTib = reinterpret_cast<uintptr_t>(hModule) +
                             sectionHeader->VirtualAddress;
            __CJGCTibSize = sectionHeader->Misc.VirtualSize;
        } else if (strncmp(secName, ".cjgcrts", sizeof(".cjgcrts") - 1) == 0) {
            __CJGCRoots = reinterpret_cast<uintptr_t>(hModule) +
                             sectionHeader->VirtualAddress;
            __CJGCRootsSize = sectionHeader->Misc.VirtualSize;
        } else if (strncmp(secName, ".cjtt", sizeof(".cjtt") - 1) == 0) {
            __CJTypeTemplate = reinterpret_cast<uintptr_t>(hModule) +
                             sectionHeader->VirtualAddress;
            __CJTypeTemplateSize = sectionHeader->Misc.VirtualSize;
        } else if (strncmp(secName, ".cjti", sizeof(".cjti") - 1) == 0) {
            __CJTypeInfo = reinterpret_cast<uintptr_t>(hModule) +
                             sectionHeader->VirtualAddress;
            __CJTypeInfoSize = sectionHeader->Misc.VirtualSize;
        } else if (strncmp(secName, ".cjfield", sizeof(".cjfield") - 1) == 0) {
            __CJTypeFields = reinterpret_cast<uintptr_t>(hModule) +
                             sectionHeader->VirtualAddress;
            __CJTypeFieldsSize = sectionHeader->Misc.VirtualSize;
        } else if (strncmp(secName, ".cjmtlb", sizeof(".cjmtlb") - 1) == 0) {
            __CJMTable = reinterpret_cast<uintptr_t>(hModule) +
                             sectionHeader->VirtualAddress;
            __CJMTableSize = sectionHeader->Misc.VirtualSize;
        } else if (strncmp(secName, ".cjinty", sizeof(".cjinty") - 1) == 0) {
            __CJInnerTypeExtensions = reinterpret_cast<uintptr_t>(hModule) +
                             sectionHeader->VirtualAddress;
            __CJInnerTypeExtensionsSize = sectionHeader->Misc.VirtualSize;
        } else if (strncmp(secName, ".cjouty", sizeof(".cjouty") - 1) == 0) {
            __CJOuterTypeExtensions = reinterpret_cast<uintptr_t>(hModule) +
                             sectionHeader->VirtualAddress;
            __CJOuterTypeExtensionsSize = sectionHeader->Misc.VirtualSize;
        } else if (strncmp(secName, ".cjsgt", sizeof(".cjsgt") - 1) == 0) {
            __CJStaticGITable = reinterpret_cast<uintptr_t>(hModule) +
                             sectionHeader->VirtualAddress;
            __CJStaticGITableSize = sectionHeader->Misc.VirtualSize;
        } else if (strncmp(secName, ".cjgcflg", sizeof(".cjgcflg") - 1) == 0) {
            __CJGCFlags = reinterpret_cast<uintptr_t>(hModule) +
                             sectionHeader->VirtualAddress;
            __CJGCFlagsSize = sectionHeader->Misc.VirtualSize;
        } else if (strncmp(secName, ".cjrflp", sizeof(".cjrflp") - 1) == 0) {
            __CJReflectPkgInfo = reinterpret_cast<uintptr_t>(hModule) +
                             sectionHeader->VirtualAddress;
            __CJGCReflectPkgInfoSize = sectionHeader->Misc.VirtualSize;
        } else if (strncmp(secName, ".cjrflv", sizeof(".cjrflv") - 1) == 0) {
            __CJReflectGV = reinterpret_cast<uintptr_t>(hModule) +
                             sectionHeader->VirtualAddress;
            __CJReflectGVSize = sectionHeader->Misc.VirtualSize;
        } else if (strncmp(secName, ".cjrflg", sizeof(".cjrflg") - 1) == 0) {
            __CJReflectGI = reinterpret_cast<uintptr_t>(hModule) +
                             sectionHeader->VirtualAddress;
            __CJReflectGISize = sectionHeader->Misc.VirtualSize;
        }
        ++sectionHeader;
    }

    std::initializer_list<uintptr_t> addrs{
        __CJSDKVersion,     reinterpret_cast<uintptr_t>(__CJSDKVersion + __CJSDKVersionSize),
        __CJMethodInfo,     reinterpret_cast<uintptr_t>(__CJMethodInfo + __CJMethodInfoSize),
        __CJGlobalInitFunc, reinterpret_cast<uintptr_t>(__CJGlobalInitFunc + __CJGlobalInitFuncSize),
        __CJStringPoolDict, reinterpret_cast<uintptr_t>(__CJStringPoolDict + __CJStringPoolDictSize),
        __CJStringPool,     reinterpret_cast<uintptr_t>(__CJStringPool + __CJStringPoolSize),
        __CJStackMap,       reinterpret_cast<uintptr_t>(__CJStackMap + __CJStackMapSize),
        __CJGCTib,          reinterpret_cast<uintptr_t>(__CJGCTib + __CJGCTibSize),
        __CJGCRoots,        reinterpret_cast<uintptr_t>(__CJGCRoots + __CJGCRootsSize),
        __CJTypeTemplate,        reinterpret_cast<uintptr_t>(__CJTypeTemplate + __CJTypeTemplateSize),
        __CJTypeInfo,       reinterpret_cast<uintptr_t>(__CJTypeInfo + __CJTypeInfoSize),
        __CJTypeFields,      reinterpret_cast<uintptr_t>(__CJTypeFields + __CJTypeFieldsSize),
        __CJMTable,         reinterpret_cast<uintptr_t>(__CJMTable + __CJMTableSize),
        __CJInnerTypeExtensions, reinterpret_cast<uintptr_t>(__CJInnerTypeExtensions + __CJInnerTypeExtensionsSize),
        __CJOuterTypeExtensions, reinterpret_cast<uintptr_t>(__CJOuterTypeExtensions + __CJOuterTypeExtensionsSize),
        __CJStaticGITable,  reinterpret_cast<uintptr_t>(__CJStaticGITable + __CJStaticGITableSize),
        __CJGCFlags,        reinterpret_cast<uintptr_t>(__CJGCFlags + __CJGCFlagsSize),
        __CJReflectPkgInfo, reinterpret_cast<uintptr_t>(__CJReflectPkgInfo + __CJGCReflectPkgInfoSize),
        __CJReflectGV,      reinterpret_cast<uintptr_t>(__CJReflectGV + __CJReflectGVSize),
        __CJReflectGI,      reinterpret_cast<uintptr_t>(__CJReflectGI + __CJReflectGISize),
    };
    uintptr_t start = std::min<uintptr_t>(addrs);
    uintptr_t end = std::max<uintptr_t>(addrs);
    __CJMetadataSize = end - start;
}

}
