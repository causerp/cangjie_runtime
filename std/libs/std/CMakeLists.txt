# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

add_subdirectory(core)
add_subdirectory(runtime)
add_subdirectory(binary)
add_subdirectory(unicode)
add_subdirectory(sort)
add_subdirectory(sync)
add_subdirectory(math)
add_subdirectory(math/numeric)
add_subdirectory(objectpool)
add_subdirectory(argopt)
add_subdirectory(collection)
add_subdirectory(collection/concurrent)
add_subdirectory(convert)
add_subdirectory(io)
add_subdirectory(net)
add_subdirectory(posix)
add_subdirectory(process)
add_subdirectory(env)
add_subdirectory(overflow)
add_subdirectory(random)
add_subdirectory(ref)
add_subdirectory(regex)
add_subdirectory(reflect)
add_subdirectory(time)
add_subdirectory(deriving/api)
add_subdirectory(deriving/resolve)
add_subdirectory(deriving/impl)
add_subdirectory(deriving/builtins)
add_subdirectory(deriving)
add_subdirectory(unittest)
add_subdirectory(unittest/common)
add_subdirectory(unittest/prop_test)
add_subdirectory(unittest/diff)
add_subdirectory(fs)
add_subdirectory(unittest/mock/internal)
add_subdirectory(unittest/mock)
add_subdirectory(console)
add_subdirectory(crypto)
add_subdirectory(ast)
# No need to cross-compile ast and testmacro because they are always used on host platforms.
if(NOT CMAKE_CROSSCOMPILING)
    add_subdirectory(unittest/testmacro)
endif() # not cross-compiling
#No need if verify-only
add_subdirectory(database)
