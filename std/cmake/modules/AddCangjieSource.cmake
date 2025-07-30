# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

set(CANGJIE_NATIVE_CANGJIE_TOOLS_PATH ${CMAKE_BINARY_DIR}/bin)
set(CANGJIE_LIB_DIR "modules")
set(CANGJIE_EXECUTABLE_OUTPUT_DIR ${CMAKE_BINARY_DIR}/bin)
set(CJNATIVE_BACKEND "cjnative")

# Compile cangjie files into an object file(as a library or executable)
# Usage:
# add_cangjie_library(
#     target_name                 # The target name you want to generate
#     IS_STDLIB                   # This is a kind of stdlib
#     IS_PACKAGE                  # This is a package
#     IS_PRELUDE                  # This option will append a option to cjc: --no-prelude
#
#     [BACKEND]                   # Specify the backend, default is cjnative
#     [OUTPUT_NAME]               # Specify the output file name
#     [OUTPUT_DIR]                # Specify the lib name, and will install to the directory with this name
#     [PACKAGE_NAME]              # Package name of target cangjie source file
#     [MODULE_NAME]               # Module name of target cangjie source file and we will generate product to a directory with this name
#     [BACKEND_OPTS]              # This argument is backend-options passed to backend
#     [WHEN_CONFIG_NAME_OPTS]     # This argument is other options passed to cjc
#     [WHEN_CONFIG_VALUES_OPTS]   # This argument is other options passed to cjc
#     [CONFIG_OPTS]               # This argument is other options passed to cjc
#     [SOURCE_DIR]                # Input source directory
#     [DISABLE_REFLECTION]        # Disable reflection for specific package
#
#     [SOURCES]                   # Input source files
#     [DEPENDS]                   # This target should be dependent on these targets
#     [NO_SUB_PKG]                # This package doesn't have sub-packages
#     )
function(add_cangjie_library target_name)
    set(options
        IS_PRELUDE
        IS_PACKAGE
        IS_STDLIB
        IS_CJNATIVE_BACKEND
        IS_JS_BACKEND
        DISABLE_REFLECTION
        NO_SUB_PKG
        NO_SANCOV)
    set(one_value_args
        OUTPUT_NAME
        OUTPUT_DIR
        PACKAGE_NAME
        MODULE_NAME
        WHEN_CONFIG_NAME_OPTS
        WHEN_CONFIG_VALUES_OPTS
        CONFIG_OPTS
        SOURCE_DIR)
    set(multi_value_args SOURCES BACKEND_OPTS DEPENDS FFI)
    cmake_parse_arguments(
        CANGJIELIB
        "${options}"
        "${one_value_args}"
        "${multi_value_args}"
        ${ARGN})

    # pre-process source files
    set(source_files)
    foreach(file ${CANGJIELIB_SOURCES})
        get_filename_component(file_path ${file} PATH)
        if(IS_ABSOLUTE "${file_path}")
            list(APPEND source_files "${file}")
        else()
            list(APPEND source_files "${CANGJIELIB_SOURCE_DIR}/${file}")
        endif()
    endforeach()

    set(BACKEND)
    if(CANGJIELIB_IS_CJNATIVE_BACKEND)
        set(BACKEND "cjnative")
    endif()
    # setting output directory
    set(output_dir)
    set(output_bc_dir)
    if(CANGJIELIB_IS_STDLIB)
        if(NOT ("${CANGJIELIB_MODULE_NAME}" STREQUAL ""))
            set(output_dir "${CANGJIE_LIB_DIR}/${TARGET_TRIPLE_DIRECTORY_PREFIX}_${BACKEND}/${CANGJIELIB_MODULE_NAME}")
            set(output_bc_dir "${CANGJIE_LIB_DIR}/${TARGET_TRIPLE_DIRECTORY_PREFIX}_${BACKEND}_bc/${CANGJIELIB_MODULE_NAME}")
        else()
            set(output_dir "${CANGJIE_LIB_DIR}/${TARGET_TRIPLE_DIRECTORY_PREFIX}_${BACKEND}")
            set(output_bc_dir "${CANGJIE_LIB_DIR}/${TARGET_TRIPLE_DIRECTORY_PREFIX}_${BACKEND}_bc")
        endif()
        if(NOT ("${CANGJIELIB_OUTPUT_DIR}" STREQUAL ""))
            set(output_dir "${output_dir}/${CANGJIELIB_OUTPUT_DIR}")
            set(output_bc_dir "${output_bc_dir}/${CANGJIELIB_OUTPUT_DIR}")
        endif()
    endif()

    set(cangjie_compile_flags)
    if(CMAKE_BUILD_TYPE MATCHES Debug)
        list(APPEND cangjie_compile_flags "-g")
    elseif(CMAKE_BUILD_TYPE MATCHES RelWithDebInfo)
        list(APPEND cangjie_compile_flags "-g")
        if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
            # -g will enable aggressive-parallel-compile, so we need limit --apc to 1 to disable it forcibly.
            list(APPEND cangjie_compile_flags "--apc=1")
        endif()
    else()
       if( CANGJIELIB_IS_CJNATIVE_BACKEND)
            list(APPEND cangjie_compile_flags "--trimpath")
            list(APPEND cangjie_compile_flags "${CMAKE_SOURCE_DIR}/src/")
        endif()
    endif()

    set(MKDIR_TEMP_FILES_CMD)
    # append backend-options
    list(LENGTH CANGJIELIB_OPTS options_length)
    if(NOT (options_length EQUAL 0))
        list(APPEND cangjie_compile_flags ${CANGJIELIB_OPTS})
    endif()
    # append config options
    if(NOT ("${CANGJIELIB_CONFIG_OPTS}" STREQUAL ""))
        list(APPEND cangjie_compile_flags "--cfg=\"${CANGJIELIB_CONFIG_OPTS}\"")
    endif()

    if(NOT ("${CANGJIELIB_MODULE_NAME}" STREQUAL ""))
        set(output_full_name "${CMAKE_BINARY_DIR}/${output_dir}/${CANGJIELIB_MODULE_NAME}.${CANGJIELIB_PACKAGE_NAME}")
    else()
        set(output_full_name "${CMAKE_BINARY_DIR}/${output_dir}/${CANGJIELIB_PACKAGE_NAME}")
    endif()
    
    set(output_full_name_prefix "${CMAKE_BINARY_DIR}/${output_dir}/${CANGJIELIB_PACKAGE_NAME}")
    if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
        set(output_full_name "${output_full_name}.a") # set output path and output name
        if(NOT ("${CANGJIELIB_MODULE_NAME}" STREQUAL ""))
            set(output_lto_bc_full_name "${CMAKE_BINARY_DIR}/${output_bc_dir}/lib${CANGJIELIB_MODULE_NAME}.${CANGJIELIB_PACKAGE_NAME}")
        else()
            set(output_lto_bc_full_name "${CMAKE_BINARY_DIR}/${output_bc_dir}/lib${CANGJIELIB_PACKAGE_NAME}")
        endif()        
        
        set(output_lto_bc_full_name "${output_lto_bc_full_name}.bc") # set output path and output name
    endif()

    foreach(build_args ${CANGJIE_BUILD_ARGS})
        list(APPEND cangjie_compile_flags "${build_args}")
    endforeach()

    if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
        list(APPEND cangjie_compile_flags "--output-type=staticlib")
    endif()

    # set compiler path
    if(CMAKE_CROSSCOMPILING)
        set(CANGJIE_NATIVE_CANGJIE_TOOLS_PATH ${CMAKE_BINARY_DIR}/../build/bin)
    endif()
    # Do not use ${CMAKE_EXECUTABLE_SUFFIX} here, because its value is determined by the target platform, not the host.
    # Determine the suffix according to the host instead.
    set(cangjie_compiler_tool "cjc$<$<BOOL:${CMAKE_HOST_WIN32}>:.exe>")

    # create building task
    if(CANGJIELIB_IS_PRELUDE)
        set(no_prelude "--no-prelude") # not to import prelude libraries while compiling core library
    endif()
    # no-sub-pkg
    if(CANGJIELIB_NO_SUB_PKG)
        set(no_sub_pkg "--no-sub-pkg")
    endif()

    set(output_argument "--output") # output argument to specify the output file dir and name
    set(module_name_argument) # module name argument to specify which module the project belongs to
    set(CJNATIVE_PATH)
    if(CMAKE_CROSSCOMPILING)
        # When cross-compiling stdlib, use the installed llvm tools,
        # in case the backend is compiled from source in previous native-building step
        set(CJNATIVE_PATH $ENV{CANGJIE_HOME}/third_party/llvm/bin)
        # $ENV{CANGJIE_HOME}
    else()
        set(CJNATIVE_PATH $ENV{CANGJIE_HOME}/third_party/llvm/bin)
    endif()
    set(COMPILE_CMD)
    if(CANGJIELIB_IS_PACKAGE)
        set(COMPILE_CMD
            ${cangjie_compiler_tool}
            ${no_prelude}
            ${no_sub_pkg}
            ${cangjie_compile_flags}
            -p
            ${CANGJIELIB_SOURCE_DIR}
            ${module_name_argument})
    else()
        set(COMPILE_CMD
            ${cangjie_compiler_tool}
            ${no_prelude}
            ${cangjie_compile_flags}
            ${source_files}
            ${module_name_argument})
    endif()
    if(CMAKE_CROSSCOMPILING)
        set(COMPILE_CMD ${COMPILE_CMD} "--target=${TRIPLE}")
        if(NOT ("${CANGJIE_TARGET_TOOLCHAIN}" STREQUAL ""))
            set(COMPILE_CMD ${COMPILE_CMD} "-B${CANGJIE_TARGET_TOOLCHAIN}")
        endif()
    endif()

    set(COMPILE_BC_CMD
        ${COMPILE_CMD}
        --lto=full
        ${output_argument}
        ${output_lto_bc_full_name})
    set(COMPILE_CMD ${COMPILE_CMD} ${output_argument} ${output_full_name})
    if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
        list(APPEND COMPILE_CMD "$<IF:$<CONFIG:MinSizeRel>,-Os,-O2>")
        # .bc files is for LTO mode and LTO mode does not support -Os and -Oz.
        list(APPEND COMPILE_BC_CMD "-O2")
    endif()

    set(ENV{LD_LIBRARY_PATH} $ENV{LD_LIBRARY_PATH}:${CMAKE_BINARY_DIR}/lib)
    string(TOLOWER ${TARGET_TRIPLE_DIRECTORY_PREFIX}_${BACKEND} output_cj_lib_dir)

    add_custom_target(
        ${target_name} ALL
        COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/${output_dir}
        ${MKDIR_TEMP_FILES_CMD}
        COMMAND ${CMAKE_COMMAND} -E env "CANGJIE_PATH=${CMAKE_BINARY_DIR}/modules/${output_cj_lib_dir}"  "LIBRARY_PATH=${CMAKE_BINARY_DIR}/lib"
                ${COMPILE_CMD}
        BYPRODUCTS ${output_full_name}
        DEPENDS ${CANGJIELIB_DEPENDS} ${CANGJIELIB_SOURCE_DIR}
        COMMENT "Generating ${target_name}")
    if(CANGJIE_CODEGEN_CJNATIVE_BACKEND
       AND NOT WIN32
       AND NOT DARWIN)
        add_custom_target(
            ${target_name}_bc ALL
            COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/${output_bc_dir}
            COMMAND ${CMAKE_COMMAND} -E env "CANGJIE_PATH=${CMAKE_BINARY_DIR}/modules/${output_cj_lib_dir}" "LIBRARY_PATH=${CMAKE_BINARY_DIR}/lib"
                     ${COMPILE_BC_CMD}
            BYPRODUCTS ${output_lto_bc_full_name}
            # ${target_name}_bc depends on ${target_name} so they will not run simultaneously. <target> and <target>_bc
            # compile the same package, which means they may write the same bc cache file. Running simultaneously
            # may cause IO error on windows in some cases.
            DEPENDS ${CANGJIELIB_DEPENDS} ${CANGJIELIB_SOURCE_DIR} ${target_name}
            COMMENT "Generating ${target_name}_bc")
    endif()

    if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
        set(TARGET_AR ar)
        if(CMAKE_CROSSCOMPILING)
            if(CMAKE_C_COMPILER_ID STREQUAL "Clang")
                set(TARGET_AR ${CANGJIE_TARGET_TOOLCHAIN}/llvm-ar)
            else()
                set(TARGET_AR ${CANGJIE_TARGET_TOOLCHAIN}/${TRIPLE}-ar)
            endif()
        endif()
        if(CMAKE_HOST_UNIX)
            set(MOVE_CMD mv)
        elseif(CMAKE_HOST_WIN32)
            set(MOVE_CMD move)
        endif()
        add_custom_command(
            TARGET ${target_name}
            POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E make_directory ${target_name} && cd ${target_name}
            COMMAND ${CMAKE_COMMAND} -E remove_directory tmp
            COMMAND ${CMAKE_COMMAND} -E make_directory tmp && cd tmp
            COMMAND ${TARGET_AR} x ${output_full_name}
            COMMAND ${MOVE_CMD} *.o ${output_full_name_prefix}.o
            COMMAND cd ..
            COMMAND ${CMAKE_COMMAND} -E remove_directory tmp
            BYPRODUCTS ${output_full_name_prefix}.o)
    endif()

    # install
    if(NOT ("${CANGJIELIB_MODULE_NAME}" STREQUAL ""))
        set(file_name "${CANGJIELIB_MODULE_NAME}.${CANGJIELIB_PACKAGE_NAME}")
    else()
        set(file_name "${CANGJIELIB_PACKAGE_NAME}")
    endif()
    set(install_files "${CMAKE_BINARY_DIR}/${output_dir}/${file_name}.cjo")
    
    if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
    else()
        list(APPEND install_files "${CMAKE_BINARY_DIR}/${output_dir}/${file_name}.bchir")
        list(APPEND install_files "${CMAKE_BINARY_DIR}/${output_dir}/${file_name}.pdba")
    endif()

    if(CANGJIE_CODEGEN_CJNATIVE_BACKEND
       AND NOT WIN32
       AND NOT DARWIN)
        list(APPEND install_files ${output_lto_bc_full_name})
    endif()
    if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
        install(FILES ${install_files} DESTINATION ${output_dir})
    endif()
endfunction()

set(CJNATIVE_BACKEND "cjnative")
# Install cangjie library FFI
function(install_cangjie_library_ffi lib_name)
    # set install dir
    string(TOLOWER ${TARGET_TRIPLE_DIRECTORY_PREFIX} output_lib_dir)
    if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
        install(TARGETS ${lib_name} DESTINATION lib/${output_lib_dir}_${CJNATIVE_BACKEND})
    endif()
endfunction()

function(install_cangjie_library_ffi_s lib_name)
    # set install dir
    string(TOLOWER ${TARGET_TRIPLE_DIRECTORY_PREFIX} output_lib_dir)
    if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
        install(TARGETS ${lib_name} DESTINATION runtime/lib/${output_lib_dir}_${CJNATIVE_BACKEND})
    endif()
endfunction()
