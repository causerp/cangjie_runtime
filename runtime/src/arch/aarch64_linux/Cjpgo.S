// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// This function registers the LLVM profile write function with the MRT profile dump
// registration mechanism. It is called during program initialization to set up PGO (Profile-Guided
// Optimization) data dumping.
//
// The function checks if CJ_MRT_RegisterProfDumpFunc is available (not null), and if so, passes
// the address of __llvm_profile_write_file to it for registration.

    .text
    .p2align        2               // Align to 4 bytes for optimal performance
    .type   __CJ_Register_PGO,@function
__CJ_Register_PGO:                        // Function entry point
    .cfi_startproc
#if defined(ENABLE_BACKWARD_PTRAUTH_CFI)
    paciasp                         // Sign the return address for pointer authentication
#endif
// Entry point: Save callee-saved registers and set up stack frame
    str     x30, [sp, #-16]!        // Allocate 16 bytes on stack (8 for x30, 8 for alignment)
    .cfi_def_cfa_offset 16
    .cfi_offset w30, -16

// Load the address of CJ_MRT_RegisterProfDumpFunc from GOT
    adrp    x1, :got:CJ_MRT_RegisterProfDumpFunc
    ldr     x1, [x1, :got_lo12:CJ_MRT_RegisterProfDumpFunc]
// If the function pointer is null (function not available), skip registration
    cbz     x1, .Lret0

// Load the address of __llvm_profile_write_file from GOT as the argument
    adrp    x0, :got:__llvm_profile_write_file
    ldr     x0, [x0, :got_lo12:__llvm_profile_write_file]
// Call the registration function through register for consistency
    blr     x1

.Lret0:                                 // Return label
    ldr     x30, [sp], #16          // Restore x30 and deallocate stack
#if defined(ENABLE_BACKWARD_PTRAUTH_CFI)
    autiasp                         // Authenticate the return address
#endif
    ret
.Lfunc_end12:
    .size   __CJ_Register_PGO, .Lfunc_end12-__CJ_Register_PGO
    .cfi_endproc

    .section        .init_array.10,"aw",@init_array
    .p2align        3
    .xword  __CJ_Register_PGO

    .weak CJ_MRT_RegisterProfDumpFunc
