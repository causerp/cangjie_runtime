# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
#
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

# Use `xcrun` to get MacOS SDK path and version. They are used for compiling Cangjie standard libraries.

execute_process(
    COMMAND xcrun --sdk macosx --show-sdk-path
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    RESULT_VARIABLE CANGJIE_MACOSX_SDK_PATH_AVAILABLE
    OUTPUT_VARIABLE CANGJIE_MACOSX_SDK_PATH
    ERROR_QUIET
    OUTPUT_STRIP_TRAILING_WHITESPACE)
if(${CANGJIE_MACOSX_SDK_PATH_AVAILABLE} EQUAL 0)
    message(STATUS "CANGJIE_MACOSX_SDK_PATH: ${CANGJIE_MACOSX_SDK_PATH}")
else()
    message(STATUS "CANGJIE_MACOSX_SDK_PATH: Not Available")
endif()

execute_process(
    COMMAND xcrun --sdk macosx --show-sdk-version
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    RESULT_VARIABLE CANGJIE_MACOSX_SDK_VERSION_AVAILABLE
    OUTPUT_VARIABLE CANGJIE_MACOSX_SDK_VERSION
    ERROR_QUIET
    OUTPUT_STRIP_TRAILING_WHITESPACE)
if(${CANGJIE_MACOSX_SDK_PATH_AVAILABLE} EQUAL 0)
    message(STATUS "CANGJIE_MACOSX_SDK_VERSION: ${CANGJIE_MACOSX_SDK_VERSION}")
else()
    message(STATUS "CANGJIE_MACOSX_SDK_VERSION: Not Available")
endif()
