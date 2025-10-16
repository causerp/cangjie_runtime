# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
#
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

# This script can merge multiple .a and .o files into a single .a file.
# At least one output file name and one input file is required.
# Usage: cmake -P MergeArchives.cmake [ARCHIVER <path to ar>] OUTPUT_FILENAME <output filename> INPUTS <input filenames>...

# Parse input arguments
math(EXPR UPPER_INDEX "${CMAKE_ARGC}-1")
set(ARGV)
foreach(i RANGE ${UPPER_INDEX})
    list(APPEND ARGV ${CMAKE_ARGV${i}})
endforeach()
set(oneValueArgs ARCHIVER OUTPUT_FILENAME)
set(multiValueArgs INPUTS)
cmake_parse_arguments(
    MERGE_AR
    ""
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGV})

# Check illegal arguments
list(LENGTH MERGE_AR_INPUTS MERGE_AR_INPUTS_LEN)
if("${MERGE_AR_INPUTS_LEN}" LESS 1)
    message("Input archives are required!")
    message(
        FATAL_ERROR
            "Usage: cmake -P MergeArchives.cmake [ARCHIVER <path to ar>] OUTPUT_FILENAME <output filename> INPUTS <input filenames>..."
    )
endif()
if("${MERGE_AR_OUTPUT_FILENAME}" STREQUAL "")
    message("Name of the output archive is required!")
    message(
        FATAL_ERROR
            "Usage: cmake -P MergeArchives.cmake [ARCHIVER <path to ar>] OUTPUT_FILENAME <output filename> INPUTS <input filenames>..."
    )
endif()
if("${MERGE_AR_ARCHIVER}" STREQUAL "")
    set(MERGE_AR_ARCHIVER ar)
endif()

# Extract object files and copy single objject files to the temp folder
string(RANDOM LENGTH 8 RANDOM_DIR_STR)
set(TEMPDIR ${MERGE_AR_OUTPUT_FILENAME}_${RANDOM_DIR_STR})
file(MAKE_DIRECTORY ${TEMPDIR})
set(OBJ_LIST)
foreach(f ${MERGE_AR_INPUTS})
    get_filename_component(extension ${f} LAST_EXT)
    get_filename_component(full_path ${f} ABSOLUTE)

    if("${extension}" STREQUAL ".a")
        execute_process(
            COMMAND ${MERGE_AR_ARCHIVER} x ${full_path}
            WORKING_DIRECTORY ${TEMPDIR}
            RESULT_VARIABLE extract_ret
            OUTPUT_VARIABLE extract_stdout
            ERROR_VARIABLE extract_stderr)
        if(NOT ("${extract_ret}" STREQUAL "0"))
            message("${extract_stdout}")
            message("${extract_stderr}")
            message(FATAL_ERROR "Extract archive ${full_path} failed!")
        endif()
        execute_process(
            COMMAND ${MERGE_AR_ARCHIVER} t ${full_path}
            WORKING_DIRECTORY ${TEMPDIR}
            RESULT_VARIABLE list_ret
            OUTPUT_VARIABLE list_stdout
            ERROR_VARIABLE list_stderr
            OUTPUT_STRIP_TRAILING_WHITESPACE)
        if(NOT ("${list_ret}" STREQUAL "0"))
            message("${list_stdout}")
            message("${list_stderr}")
            message(FATAL_ERROR "List contents in the archive ${full_path} failed!")
        endif()
        string(REPLACE "\n" ";" temp_obj_list "${list_stdout}")
        foreach(o ${temp_obj_list})
            get_filename_component(obj_filename ${o} NAME)
            # MacOS (BSD) ar generates __.SYMDEF files and these files will be archived in the .a file.
            # These files should be skipped.
            if("${obj_filename}" STREQUAL "__.SYMDEF SORTED" OR "${obj_filename}" STREQUAL "__.SYMDEF")
                continue()
            endif()
            get_filename_component(obj_extension ${o} LAST_EXT)
            if("${obj_extension}" STREQUAL ".obj")
                get_filename_component(obj_filename ${o} NAME_WLE)
                file(RENAME "${TEMPDIR}/${o}" "${TEMPDIR}/${obj_filename}.o")
                list(APPEND OBJ_LIST "${TEMPDIR}/${obj_filename}.o")
            else()
                list(APPEND OBJ_LIST "${TEMPDIR}/${o}")
            endif()
        endforeach()

    elseif("${extension}" STREQUAL ".o")
        file(COPY ${f} DESTINATION ${TEMPDIR})
        list(APPEND OBJ_LIST "${full_path}")

    elseif("${extension}" STREQUAL ".obj")
        get_filename_component(filename ${f} NAME_WLE)
        file(COPY ${f} DESTINATION ${TEMPDIR})
        file(RENAME "${TEMPDIR}/${filename}.obj" "${TEMPDIR}/${filename}.o")
        list(APPEND OBJ_LIST "${TEMPDIR}/${filename}.o")

    else()
        message("${f} seems neither an object file nor an archive file. Ignoring it.")
    endif()
endforeach()

# Test if ar supports -D option.
set(AR_CREATE_OPTION cr)
execute_process(
    COMMAND ${MERGE_AR_ARCHIVER} -crD dummy_archive.a
    WORKING_DIRECTORY ${TEMPDIR}
    RESULT_VARIABLE AR_SUPPORT_DETERMINISTIC_MODE
    OUTPUT_QUIET ERROR_QUIET)
if(${AR_SUPPORT_DETERMINISTIC_MODE} EQUAL 0)
    set(AR_CREATE_OPTION crD)
endif()

# Generate the script and drive ar to produce the output .a file
execute_process(
    COMMAND ${MERGE_AR_ARCHIVER} ${AR_CREATE_OPTION} ${MERGE_AR_OUTPUT_FILENAME} ${OBJ_LIST}
    RESULT_VARIABLE archive_ret
    OUTPUT_VARIABLE archive_stdout
    ERROR_VARIABLE archive_stderr)
if(NOT ("${archive_ret}" STREQUAL "0"))
    message("${archive_stdout}")
    message("${archive_stderr}")
    message(FATAL_ERROR "Generate merged archive failed! Error code=${ERR_CODE}")
endif()

# Clean up temp files
file(REMOVE_RECURSE ${TEMPDIR})
