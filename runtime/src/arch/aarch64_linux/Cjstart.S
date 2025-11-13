// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

    .text
    .p2align        2               // -- Begin function __CJ_Init_Start
    .type   __CJ_Init_Start,@function
__CJ_Init_Start:                        // @__CJ_Init_Start
    .cfi_startproc
#if defined(ENABLE_BACKWARD_PTRAUTH_CFI)
    paciasp
#endif
// %bb.0:
    str     x30, [sp, #-16]!        // 8-byte Folded Spill
    .cfi_def_cfa_offset 16
    .cfi_offset w30, -16
    adrp    x0, __CJMetadataStart
    add     x0, x0, :lo12:__CJMetadataStart
    mov     w1, #1
    bl      MRT_LibraryOnLoad
    ldr     x30, [sp], #16          // 8-byte Folded Reload
#if defined(ENABLE_BACKWARD_PTRAUTH_CFI)
    autiasp
#endif
    ret
.Lfunc_end12:
    .size   __CJ_Init_Start, .Lfunc_end12-__CJ_Init_Start
    .cfi_endproc

    .section        .init_array.0,"aw",@init_array
    .p2align        3
    .xword  __CJ_Init_Start

    .text
    .p2align        2               // -- Begin function __CJ_Fini_End
    .type   __CJ_Fini_End,@function
__CJ_Fini_End:                        // @__CJ_Fini_End
    .cfi_startproc
// %bb.0:
#if defined(ENABLE_BACKWARD_PTRAUTH_CFI)
    paciasp
#endif
    str     x30, [sp, #-16]!        // 8-byte Folded Spill
    .cfi_def_cfa_offset 16
    .cfi_offset w30, -16
    adrp    x0, __CJMetadataStart
    add     x0, x0, :lo12:__CJMetadataStart
    bl      MRT_LibraryUnLoad
    ldr     x30, [sp], #16          // 8-byte Folded Reload
#if defined(ENABLE_BACKWARD_PTRAUTH_CFI)
    autiasp
#endif
    ret
.Lfunc_end:
    .size   __CJ_Fini_End, .Lfunc_end-__CJ_Fini_End
    .cfi_endproc

    .section        .fini_array.0,"aw",@fini_array
    .p2align        3
    .xword  __CJ_Fini_End

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
