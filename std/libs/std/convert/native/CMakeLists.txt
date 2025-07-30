# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

file(GLOB convert_ffi_src ./*.c)
set(libname cangjie-std-convertFFI)

add_library(${libname} STATIC ${convert_ffi_src})
add_library(${libname}-objs OBJECT ${convert_ffi_src})
install_cangjie_library_ffi(${libname})
