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
    callq MRT_LibraryUnLoad
    addq  $40, %rsp
    retq
    .seh_endproc
                                            # -- End function
    .section  .dtors,"dw"
    .p2align  3
    .quad __CJ_Fini_End

    .section  .cjmetadata.rw.header
    .p2align  4
    .long 0x12345678
    .long 0x80000000
    .long 0
    .long __CJMetadataSize
    .quad __CJSDKVersion
    .quad __CJMethodInfo
    .long __CJMethodInfoSize
    .quad __CJGlobalInitFunc
    .long __CJGlobalInitFuncSize
    .quad __CJStringPoolDict
    .long __CJStringPoolDictSize
    .quad __CJStringPool
    .long __CJStringPoolSize
    .quad __CJStackMap
    .long __CJStackMapSize
    .quad __CJGCTib
    .long __CJGCTibSize
    .quad __CJGCRoots
    .long __CJGCRootsSize
    .quad __CJTypeTemplate
    .long __CJTypeTemplateSize
    .quad __CJTypeInfo
    .long __CJTypeInfoSize
    .quad __CJTypeFields
    .long __CJTypeFieldsSize
    .quad __CJMTable
    .long __CJMTableSize
    .quad __CJInnerTypeExtensions
    .long __CJInnerTypeExtensionsSize
    .quad __CJOuterTypeExtensions
    .long __CJOuterTypeExtensionsSize
    .quad __CJStaticGITable
    .long __CJStaticGITableSize
    .quad __CJGCFlags
    .long __CJGCFlagsSize
    .quad __CJReflectPkgInfo
    .long __CJGCReflectPkgInfoSize
    .quad __CJReflectGV
    .long __CJReflectGVSize
    .quad __CJReflectGI
    .long __CJReflectGISize
