# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.
if (WINDOWS_FLAG MATCHES 1)
    set(CMAKE_C_COMPILER x86_64-w64-mingw32-gcc)
    set(CMAKE_CXX_COMPILER x86_64-w64-mingw32-g++)
    set(WARNING_FLAGS "-w")
    set(SECURE_CFLAG_FOR_SHARED_LIBRARY "-static ${SECURE_CFLAG_FOR_SHARED_LIBRARY} -Wl,--exclude-libs,libssp.a")
    set(CMAKE_C_FLAGS "${SECURE_CFLAG_FOR_SHARED_LIBRARY} ${WARNING_FLAGS}")
endif()

if (WINDOWS_FLAG MATCHES 1)
    # MSVCRT already provides most of secure functions,
    # so only files listed below need to be compiled from boundscheck library,
    # to avoid "multiple definition" error.
    # Refer to offiical manual of boundscheck library for more information.
    list(APPEND SRC_FILE src/memset_s.c src/snprintf_s.c src/vsnprintf_s.c src/secureprintoutput_a.c)
else()
    aux_source_directory(./src SRC_FILE)
endif()

if (MACOS_FLAG MATCHES 1)
    if (CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -shared")
    endif()
endif()

# Build shared library.
add_library(boundscheck SHARED ${SRC_FILE})
