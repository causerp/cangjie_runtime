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

struct SecMap {
    const char* name;
    unsigned long* pSize;
    uintptr_t*     pStart;
};

static SecMap gSecMap[] = {
    { ".header",  &__CJMetadataSize,            &__CJMetadataStart       },
    { ".cjsdkv",  &__CJSDKVersionSize,          &__CJSDKVersion          },
    { ".cjmthd",  &__CJMethodInfoSize,          &__CJMethodInfo          },
    { ".cjinitF", &__CJGlobalInitFuncSize,      &__CJGlobalInitFunc      },
    { ".cjspdct", &__CJStringPoolDictSize,      &__CJStringPoolDict      },
    { ".cjsp",    &__CJStringPoolSize,          &__CJStringPool          },
    { ".cjsm",    &__CJStackMapSize,            &__CJStackMap            },
    { ".cjgctib", &__CJGCTibSize,               &__CJGCTib               },
    { ".cjgcrts", &__CJGCRootsSize,             &__CJGCRoots             },
    { ".cjtt",    &__CJTypeTemplateSize,        &__CJTypeTemplate        },
    { ".cjti",    &__CJTypeInfoSize,            &__CJTypeInfo            },
    { ".cjfield", &__CJTypeFieldsSize,          &__CJTypeFields          },
    { ".cjmtbl",  &__CJMTableSize,              &__CJMTable              },
    { ".cjinty",  &__CJInnerTypeExtensionsSize, &__CJInnerTypeExtensions },
    { ".cjouty",  &__CJOuterTypeExtensionsSize, &__CJOuterTypeExtensions },
    { ".cjsgt",   &__CJStaticGITableSize,       &__CJStaticGITable       },
    { ".cjgcflg", &__CJGCFlagsSize,             &__CJGCFlags             },
    { ".cjrflp",  &__CJGCReflectPkgInfoSize,    &__CJReflectPkgInfo      },
    { ".cjrflv",  &__CJReflectGVSize,           &__CJReflectGV           },
    { ".cjrflg",  &__CJReflectGISize,           &__CJReflectGI           },
};

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

    PIMAGE_DOS_HEADER pDosHeader = (PIMAGE_DOS_HEADER)hModule;
    if (pDosHeader->e_magic != IMAGE_DOS_SIGNATURE) {
        return;
    }

    PIMAGE_NT_HEADERS pNtHeaders = (PIMAGE_NT_HEADERS)((BYTE*)hModule + pDosHeader->e_lfanew);
    if (pNtHeaders->Signature != IMAGE_NT_SIGNATURE) {
        return;
    }

    WORD sectionCount = pNtHeaders->FileHeader.NumberOfSections;
    PIMAGE_SECTION_HEADER pSectionHeader = IMAGE_FIRST_SECTION(pNtHeaders);

    for (WORD i = 0; i < sectionCount; i++) {
        const char* secName = reinterpret_cast<const char*>(pSectionHeader->Name);
        for (const auto& m : gSecMap) {
            if (strncmp(secName, m.name, strlen(m.name)) == 0) {
                *m.pStart = reinterpret_cast<uintptr_t>(hModule) + pSectionHeader->VirtualAddress;
                *m.pSize  = pSectionHeader->Misc.VirtualSize;
                break;
            }
        }
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
