// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

    .text
    .p2align  4, 0x90
__CJ_Init_Start:                        # @__CJ_Init_Start
.seh_proc __CJ_Init_Start
# %bb.0:
    subq  $40, %rsp
    .seh_stackalloc 40
    .seh_endprologue
    leaq  __CJMetadataStart(%rip), %rcx
    movq (%rcx), %rcx
    movl  $1, %edx
    callq MRT_LibraryOnLoad
    addq  $40, %rsp
    retq
    .seh_endproc
                                            # -- End function
    .section  .ctors,"dw"
    .p2align  3
    .quad __CJ_Init_Start

    .text
    .p2align  4, 0x90
__CJ_Fini_End:                        # @__CJ_Fini_End
.seh_proc __CJ_Fini_End
# %bb.0:
    subq  $40, %rsp
    .seh_stackalloc 40
    .seh_endprologue
    leaq  __CJMetadataStart(%rip), %rcx
    movq (%rcx), %rcx
    callq MRT_LibraryUnLoad
    addq  $40, %rsp
    retq
    .seh_endproc
                                            # -- End function
    .section  .dtors,"dw"
    .p2align  3
    .quad __CJ_Fini_End

    .section  .header
    .p2align  4
    .long 0x12345678
    .long 0x80000000
    .quad 0
    .quad __CJMetadataSize
    .quad __CJSDKVersion
    .quad __CJMethodInfo
    .quad __CJMethodInfoSize
    .quad __CJGlobalInitFunc
    .quad __CJGlobalInitFuncSize
    .quad __CJStringPoolDict
    .quad __CJStringPoolDictSize
    .quad __CJStringPool
    .quad __CJStringPoolSize
    .quad __CJStackMap
    .quad __CJStackMapSize
    .quad __CJGCTib
    .quad __CJGCTibSize
    .quad __CJGCRoots
    .quad __CJGCRootsSize
    .quad __CJTypeTemplate
    .quad __CJTypeTemplateSize
    .quad __CJTypeInfo
    .quad __CJTypeInfoSize
    .quad __CJTypeFields
    .quad __CJTypeFieldsSize
    .quad __CJMTable
    .quad __CJMTableSize
    .quad __CJInnerTypeExtensions
    .quad __CJInnerTypeExtensionsSize
    .quad __CJOuterTypeExtensions
    .quad __CJOuterTypeExtensionsSize
    .quad __CJStaticGITable
    .quad __CJStaticGITableSize
    .quad __CJGCFlags
    .quad __CJGCFlagsSize
    .quad __CJReflectPkgInfo
    .quad __CJGCReflectPkgInfoSize
    .quad __CJReflectGV
    .quad __CJReflectGVSize
    .quad __CJReflectGI
    .quad __CJReflectGISize
