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
    .p2align  4, 0x90
    .type   __CJ_Register_PGO,@function
__CJ_Register_PGO:                        # @__CJ_Register_PGO
    .cfi_startproc
# %bb.0:
    pushq %rax                            # Allocate stack space and save %rax
    .cfi_def_cfa_offset 16
    mov  CJ_MRT_RegisterProfDumpFunc@GOTPCREL(%rip), %rax  # Load function pointer
    test  %rax, %rax                      # Check if function pointer is null
    je  .Lret0                            # If null, skip registration
    lea  __llvm_profile_write_file(%rip), %rdi  # Load address of profile write function as argument
    callq CJ_MRT_RegisterProfDumpFunc@PLT  # Call the registration function
.Lret0:
    popq  %rax                            # Restore %rax
    .cfi_def_cfa_offset 8
    retq                                  # Return
.Lfunc_end:
    .size __CJ_Register_PGO, .Lfunc_end-__CJ_Register_PGO
    .cfi_endproc
                                            # -- End function
    .section  .init_array.10,"aw",@init_array
    .p2align  3
    .quad __CJ_Register_PGO

    .weak CJ_MRT_RegisterProfDumpFunc
