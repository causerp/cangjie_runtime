# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
#
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

# Fails if LIB dynamically exports Cangjie package `flatbuffers` symbols.
# Those mangled names (_CN11flatbuffers* / _CGP11flatbuffers*) are also produced
# when stdx.syntax / stdx.chir statically embed the same package. Default
# visibility would let the ELF dynamic linker interpose one copy over the other.
#
# Expected -D:
#   LIB  path to libcangjie-std-ast.so (or another DSO that force-links the package)
#   NM   optional nm / llvm-nm executable

if(NOT DEFINED LIB OR "${LIB}" STREQUAL "")
    message(FATAL_ERROR "CheckFlatbuffersSymbolsHidden: LIB is not set")
endif()
if(NOT EXISTS "${LIB}")
    message(FATAL_ERROR "CheckFlatbuffersSymbolsHidden: library not found: ${LIB}")
endif()

set(_nm_candidates)
if(DEFINED NM AND NOT "${NM}" STREQUAL "")
    list(APPEND _nm_candidates "${NM}")
endif()
list(APPEND _nm_candidates nm llvm-nm)

set(_nm_out "")
set(_nm_ok FALSE)
foreach(_nm ${_nm_candidates})
    execute_process(
        COMMAND ${_nm} -D --defined-only "${LIB}"
        OUTPUT_VARIABLE _nm_out
        ERROR_VARIABLE _nm_err
        RESULT_VARIABLE _nm_rc
        OUTPUT_STRIP_TRAILING_WHITESPACE)
    if(_nm_rc EQUAL 0)
        set(_nm_ok TRUE)
        break()
    endif()
endforeach()

if(NOT _nm_ok)
    execute_process(
        COMMAND readelf --dyn-syms -W "${LIB}"
        OUTPUT_VARIABLE _nm_out
        ERROR_VARIABLE _nm_err
        RESULT_VARIABLE _nm_rc
        OUTPUT_STRIP_TRAILING_WHITESPACE)
    if(NOT _nm_rc EQUAL 0)
        message(FATAL_ERROR
            "CheckFlatbuffersSymbolsHidden: cannot read dynamic symbols of ${LIB}: ${_nm_err}")
    endif()
endif()

# Cangjie package mangling only. C++ N11flatbuffers / _ZN11flatbuffers from
# ast-support / FFI is a separate archive and is not the subject of this check.
string(REGEX MATCH "_C(N|GP)11flatbuffers" _hit "${_nm_out}")
if(_hit)
    message(FATAL_ERROR
        "CheckFlatbuffersSymbolsHidden: ${LIB} exports Cangjie flatbuffers package "
        "symbol(s) (e.g. ${_hit}). They must be hidden (link with "
        "--exclude-libs=libcangjie-flatbuffers.a) so a process that also loads "
        "stdx.syntax / stdx.chir cannot interpose a second copy.")
endif()
