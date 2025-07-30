// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

    .text
    .p2align  4, 0x90
__CJ_Init_Start:                        # @__CJ_Init_Start
    .cfi_startproc
# %bb.0:
    pushq %rax
    .cfi_def_cfa_offset 16
    leaq  __CJMetadataStart(%rip), %rdi
    movl  $1, %esi
    callq MRT_LibraryOnLoad@PLT
    popq  %rax
    .cfi_def_cfa_offset 8
    retq
.Lfunc_end:
    .size __CJ_Init_Start, .Lfunc_end-__CJ_Init_Start
    .cfi_endproc
                                            # -- End function
    .section  .init_array.0,"aw",@init_array
    .p2align  3
    .quad __CJ_Init_Start

    .text
    .p2align  4, 0x90
__CJ_Fini_End:                        # @__CJ_Fini_End
     .cfi_startproc
# %bb.0:
    pushq %rax
    .cfi_def_cfa_offset 16
    leaq  __CJMetadataStart(%rip), %rdi
    callq MRT_LibraryUnLoad@PLT
    popq  %rax
    .cfi_def_cfa_offset 8
    retq
.Lfunc_fini_end:
    .size __CJ_Fini_End, .Lfunc_fini_end-__CJ_Fini_End
    .cfi_endproc
                                            # -- End function
    .section  .fini_array.0,"aw",@fini_array
    .p2align  3
    .quad __CJ_Fini_End

    .section  .cjmetadata.rw.header
    .p2align  4
    .long 0x12345678
    .long 0x80000000
    .long 0
    .long __CJMetaDataSize
    .long __CJSDKVersion
    .long __CJMethodInfo
    .long __CJMethodInfoSize
    .long __CJGlobalInitFunc
    .long __CJGlobalInitFuncSize
    .long __CJStringPoolDict
    .long __CJStringPoolDictSize
    .long __CJStringPool
    .long __CJStringPoolSize
    .long __CJStackMap
    .long __CJStackMapSize
    .long __CJGCTib
    .long __CJGCTibSize
    .long __CJGCRoots
    .long __CJGCRootsSize
    .long __CJTypeTemplate
    .long __CJTypeTemplateSize
    .long __CJTypeInfo
    .long __CJTypeInfoSize
    .long __CJTypeFields
    .long __CJTypeFieldsSize
    .long __CJMTable
    .long __CJMTableSize
    .long __CJInnerTypeExtensions
    .long __CJInnerTypeExtensionsSize
    .long __CJOuterTypeExtensions
    .long __CJOuterTypeExtensionsSize
    .long __CJStaticGITable
    .long __CJStaticGITableSize
    .long __CJGCFlags
    .long __CJGCFlagsSize
    .long __CJReflectPkgInfo
    .long __CJGCReflectPkgInfoSize
    .long __CJReflectGV
    .long __CJReflectGVSize
    .long __CJReflectGI
    .long __CJReflectGISize
