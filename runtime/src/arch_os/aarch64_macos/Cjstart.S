// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

    .text
    .p2align        2               // -- Begin function __CJ_Init_Start
__CJ_Init_Start:                        // @__CJ_Init_Start
    .cfi_startproc
// %bb.0:
    str     x30, [sp, #-16]!        // 8-byte Folded Spill
    .cfi_def_cfa_offset 16
    .cfi_offset w30, -16
    adrp    x0, __CJMetadataStart@GOTPAGE
    ldr     x0, [x0, __CJMetadataStart@GOTPAGEOFF]
    ldr     x0, [x0]
    mov     w1, #1
    bl      _MRT_LibraryOnLoad
    ldr     x30, [sp], #16          // 8-byte Folded Reload
    ret
.Lfunc_end12:
    .cfi_endproc

    .text
    .p2align        2               // -- Begin function __CJ_Fini_End
__CJ_Fini_End:                        // @__CJ_Fini_End
    .cfi_startproc
// %bb.0:
    str     x30, [sp, #-16]!        // 8-byte Folded Spill
    .cfi_def_cfa_offset 16
    .cfi_offset w30, -16
    adrp    x0, __CJMetadataStart@GOTPAGE
    ldr     x0, [x0, __CJMetadataStart@GOTPAGEOFF]
    ldr     x0, [x0]
    bl      _MRT_LibraryUnLoad
    ldr     x30, [sp], #16          // 8-byte Folded Reload
    ret
.Lfunc_end:
    .cfi_endproc

    .section  __CJMETAHEADER,__cjmetaheader
    .p2align  4
    .long 0x12345678
    .long 0x80000000
    .quad 0
    .quad __CJMetaDataSize
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

    .section __DATA,__mod_init_func,mod_init_funcs
    .p2align 3
    .xword __CJ_Init_Start

    .section __DATA,__mod_term_func,mod_term_funcs
    .p2align 3
    .xword __CJ_Fini_End
