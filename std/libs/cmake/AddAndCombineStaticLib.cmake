# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

function(add_and_combine_static_lib)
    set(oneValueArgs TARGET OUTPUT_NAME)
    set(multiValueArgs LIBRARIES DEPENDS)
    cmake_parse_arguments(
        COMBINE
        ""
        "${oneValueArgs}"
        "${multiValueArgs}"
        ${ARGV})

    set(TARGET_AR ar)
    if(CMAKE_CROSSCOMPILING)
        if(${CMAKE_C_COMPILER_ID} STREQUAL "Clang")
            set(TARGET_AR ${CANGJIE_TARGET_TOOLCHAIN}/llvm-ar)
        else()
            set(TARGET_AR ${CANGJIE_TARGET_TOOLCHAIN}/${TRIPLE}-ar)
        endif()
    endif()

    add_custom_command(
        OUTPUT ${COMBINE_OUTPUT_NAME}
        COMMAND
            ${CMAKE_COMMAND} -P ${PROJECT_SOURCE_DIR}/cmake/modules/MergeArchives.cmake ARCHIVER ${TARGET_AR}
            OUTPUT_FILENAME ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/${COMBINE_OUTPUT_NAME} INPUTS "\"${COMBINE_LIBRARIES}\""
        DEPENDS ${COMBINE_DEPENDS})
    add_custom_target(
        ${COMBINE_TARGET} ALL
        DEPENDS ${COMBINE_OUTPUT_NAME}
        COMMENT "Generating ${COMBINE_OUTPUT_NAME}")
    # Caller may get output file path through COMBINED_STATIC_LIB_LOC property.
    set_target_properties(${COMBINE_TARGET} PROPERTIES
        COMBINED_STATIC_LIB_LOC "${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/${COMBINE_OUTPUT_NAME}")
endfunction()
