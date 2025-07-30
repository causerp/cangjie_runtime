# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

set(COMMON_SRC_LIST
        "SanitizerSymbols.cpp"
)

if (ASAN_SUPPORT_FLAG)
    add_library(Sanitizer STATIC ${COMMON_SRC_LIST} "AddressSanitizer/AsanInterface.cpp")
elseif (TSAN_SUPPORT_FLAG)
    add_library(Sanitizer STATIC ${COMMON_SRC_LIST} "ThreadSanitizer/TsanInterface.cpp")
elseif (HWASAN_SUPPORT_FLAG)
    add_library(Sanitizer STATIC ${COMMON_SRC_LIST} "HwAddressSanitizer/HwasanInterface.cpp")
elseif (GWPASAN_SUPPORT_FLAG)
    add_library(Sanitizer STATIC
            "GwpAddressSanitizer/GwpAsanInterface.cpp"
    )
endif ()

target_include_directories(Sanitizer PRIVATE ${CMAKE_SOURCE_DIR}/src)