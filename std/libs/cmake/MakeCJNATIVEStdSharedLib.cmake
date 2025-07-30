# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
#
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

macro(to_link_library_option lib_name)
    if(DARWIN)
        set(${lib_name} -l${${lib_name}})
    else()
        set(${lib_name} -l:lib${${lib_name}}${CMAKE_SHARED_LIBRARY_SUFFIX})
    endif()
endmacro()

function(make_cangjie_lib target_name)
    set(options IS_SHARED IS_STATIC ALLOW_UNDEFINED)
    set(oneValueArgs)
    set(multiValueArgs
        DEPENDS
        OBJECTS
        FORCE_LINK_ARCHIVES
        FLAGS
        CANGJIE_STD_LIB_LINK
        CANGJIE_STD_LIB_DEPENDS
        CANGJIE_STD_LIB_INDIRECT_DEPENDS)

    cmake_parse_arguments(
        CANGJIE_LIBRARY
        "${options}"
        "${oneValueArgs}"
        "${multiValueArgs}"
        ${ARGN})

    string(CONCAT make_lib_task "make_lib_for_" ${target_name})

    set(clang_compiler "${CMAKE_C_COMPILER}")
    if(OHOS)
        list(APPEND flags_to_compile -z relro -z now -z noexecstack)
        # Unfortunately, a bug in library `winpthread` our ld.lld depends causes deadlock occasionally
        # while linking. We disable multi-threading for now until we have a work-around.
        list(APPEND flags_to_compile --threads=1)
        set(clang_compiler "$ENV{CANGJIE_HOME}/third_party/llvm/bin/ld.lld")
        set(linker_ld_library_path "$ENV{CANGJIE_HOME}/third_party/llvm/lib")
    elseif(DARWIN)
        set(clang_compiler "$ENV{CANGJIE_HOME}/third_party/llvm/bin/ld64.lld")
        set(linker_ld_library_path "$ENV{CANGJIE_HOME}/third_party/llvm/lib")
    elseif(NOT MINGW)
        list(APPEND flags_to_compile "-Wl,-z,relro,-z,now,-z,noexecstack")
    endif()

    if(MINGW)
        list(APPEND flags_to_compile "${LINKER_OPTION_PREFIX}--no-insert-timestamp")
    endif()

    if(DARWIN)
        if("${CMAKE_SYSTEM_PROCESSOR}" STREQUAL "aarch64")
            list(APPEND flags_to_compile -arch arm64)
        elseif("${CMAKE_SYSTEM_PROCESSOR}" STREQUAL "x86_64")
            list(APPEND flags_to_compile -arch x86_64)
        endif()
        list(APPEND flags_to_compile -syslibroot "${CANGJIE_MACOSX_SDK_PATH}")
        list(APPEND flags_to_compile -platform_version macos 12.0.0 "${CANGJIE_MACOSX_SDK_VERSION}")
    endif()

    set(target_lib_full_name)
    string(TOLOWER ${TARGET_TRIPLE_DIRECTORY_PREFIX}_${CJNATIVE_BACKEND} output_cj_lib_dir)
    string(TOLOWER ${TARGET_TRIPLE_DIRECTORY_PREFIX}_${CJNATIVE_BACKEND} output_std_cj_lib_dir)
    set(output_cj_lib_dir ${output_cj_lib_dir}${SANITIZER_SUBPATH})
    set(output_std_cj_lib_dir ${output_std_cj_lib_dir}${SANITIZER_SUBPATH})
    if(CANGJIE_LIBRARY_IS_SHARED)
        if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
            if(NOT OHOS AND NOT DARWIN)
                if(CANGJIE_DISCARD_EH_FRAME)
                    list(APPEND flags_to_compile "-Wl,-T" ${RUNTIME_COMMON_LIB_DIR}/discard_eh_frame.lds)
                endif()
                list(APPEND flags_to_compile "-Wl,-T,${RUNTIME_COMMON_LIB_DIR}/cjld.shared.lds")
            elseif(NOT DARWIN)
                list(APPEND flags_to_compile "-T" ${RUNTIME_COMMON_LIB_DIR}/cjld.shared.lds)
            endif()
            if(DARWIN)
                list(APPEND flags_to_compile "${RUNTIME_COMMON_LIB_DIR}/section.o")
            endif()
            list(APPEND flags_to_compile "${RUNTIME_COMMON_LIB_DIR}/cjstart.o")
            
            set(target_system_name ${CMAKE_SYSTEM_NAME})
            if(OHOS)
                set(target_system_name "linux_ohos")
            endif()
            string(TOLOWER "${target_system_name}_${CMAKE_SYSTEM_PROCESSOR}_${CJNATIVE_BACKEND}" tmpdir)
            list(APPEND flags_to_compile "-L${RUNTIME_COMMON_LIB_DIR}/../../runtime/lib/${tmpdir}")
            set(runtime_link_option "cangjie-runtime")
            to_link_library_option(runtime_link_option)
            list(APPEND flags_to_compile "${runtime_link_option}")
        endif()
        # Hot reload relies on .gnu.hash section.
        if(MINGW)
            list(APPEND flags_to_compile "-static")
            # Use -fstack-protector-all to let gcc help judge which libssp to link against. Don't use simply -lssp.
            list(APPEND flags_to_compile "-fstack-protector-all")
        elseif(NOT DARWIN)
            # MinGW ld doesn't support --hash-style
            list(APPEND flags_to_compile "${LINKER_OPTION_PREFIX}--hash-style=both")
        endif()
        foreach(libpath ${CANGJIE_TARGET_LIB})
            list(APPEND flags_to_compile "-L${libpath}")
        endforeach()
        if(MINGW)
            list(APPEND flags_to_compile "-L${CMAKE_BINARY_DIR}/bin")
        endif()
        list(APPEND flags_to_compile "-L${CMAKE_BINARY_DIR}/lib/${output_std_cj_lib_dir}")
        list(APPEND flags_to_compile "-L$ENV{CANGJIE_HOME}/runtime/lib/${output_cj_lib_dir}")
        list(APPEND flags_to_compile "-L$ENV{CANGJIE_HOME}/lib/${output_cj_lib_dir}")
        if(NOT DARWIN)
            # In cross-compilation, we need -L (above one) for library searching and -rpath-link (below one) for
            # secondary dependencies (DSOs) searching.
            list(APPEND flags_to_compile
                "${LINKER_OPTION_PREFIX}-rpath-link=$ENV{CANGJIE_HOME}/runtime/lib/${output_cj_lib_dir}")
        endif()
        list(APPEND flags_to_compile "-L${CMAKE_BINARY_DIR}/lib")
        if(WIN32)
            # For Windows target, CMake will place dll in "bin" directory.
            list(APPEND flags_to_compile "-L${CMAKE_BINARY_DIR}/bin")
        endif()
        if(CMAKE_C_COMPILER_ID STREQUAL "Clang" OR CMAKE_C_COMPILER_ID STREQUAL "AppleClang")
            if(OHOS)
                list(APPEND flags_to_compile "-lclang_rt.builtins")
            elseif(DARWIN)
                # If native code (C or C++) uses compiler built-in features, the following library needs to be linked.
                # For example for `__builtin_cpu_init()` function, clang will generate references to `___cpu_model`
                # symbol, which is supplied by libclang_rt.osx.a.
                list(APPEND flags_to_compile "-lclang_rt.osx")
            elseif(${CMAKE_SYSTEM_PROCESSOR} STREQUAL "x86_64")
                list(APPEND flags_to_compile "-lclang_rt-builtins")
            endif()
        endif()
        if(MINGW)
            list(APPEND flags_to_compile "-lclang_rt-builtins")
        endif()
        set(boundscheck_link_option "boundscheck")
        to_link_library_option(boundscheck_link_option)
        list(APPEND flags_to_compile "${boundscheck_link_option}")
        if(NOT DARWIN)
            list(APPEND flags_to_compile "-lm")
        endif()
        if(OHOS)
            list(APPEND flags_to_compile "-lc")
            list(APPEND flags_to_compile "-lunwind")
        endif()
        if(NOT DARWIN AND NOT CANGJIE_LIBRARY_ALLOW_UNDEFINED AND NOT CANGJIE_ENABLE_HWASAN)
            # Extra checkes when generating cangjie shared libraries. If symbols are used in Cangjie but not
            # defined in the shared library, an error will be reported. If any of such errors are reported,
            # we are likely missing some dependencies to link or functions to implement (e.g. using an
            # unimplemented native function in Cangjie).
            list(APPEND flags_to_compile "${LINKER_OPTION_PREFIX}--no-undefined")
        endif()
        # undefined reference is not allow while linking MachO shared library by default. The following options
        # could suppress ld64 from reporting undefined reference errors.
        if(DARWIN AND CANGJIE_LIBRARY_ALLOW_UNDEFINED)
            list(APPEND flags_to_compile "-undefined" "suppress" "-flat_namespace")
        endif()
        # For bep, in debug mode, we cannot have the symbol of object's absolute path
        if(NOT DARWIN)
            if(CMAKE_BUILD_TYPE MATCHES Debug OR CMAKE_BUILD_TYPE MATCHES RelWithDebInfo)
                list(APPEND flags_to_compile "-g")
            else()
                list(APPEND flags_to_compile "-s")
            endif()
        endif()

        if(CANGJIE_LIBRARY_IS_SHARED)
            if(DARWIN)
                list(APPEND flags_to_compile "-dylib")
            else()
                list(APPEND flags_to_compile "-shared")
            endif()

            set(target_lib_full_name
                ${CMAKE_BINARY_DIR}/lib/${output_std_cj_lib_dir}/libcangjie-${target_name}${CMAKE_SHARED_LIBRARY_SUFFIX})
        else()
            set(target_lib_full_name ${CMAKE_BINARY_DIR}/bin/${target_name}${CMAKE_EXECUTABLE_SUFFIX})
        endif()
        if(CMAKE_C_COMPILER_ID STREQUAL "Clang")
            if(OHOS)
                list(APPEND flags_to_compile "-m")
                if("${CMAKE_SYSTEM_PROCESSOR}" STREQUAL aarch64)
                    list(APPEND flags_to_compile "aarch64linux")
                else()
                    list(APPEND flags_to_compile "elf_x86_64")
                endif()
            elseif(NOT DARWIN)
                list(APPEND flags_to_compile "--target=${TRIPLE}")
            endif()
        endif()
        if(CANGJIE_TARGET_TOOLCHAIN AND NOT OHOS)
            list(APPEND flags_to_compile "-B${CANGJIE_TARGET_TOOLCHAIN}")
        endif()
        if(OHOS)
            list(APPEND flags_to_compile "-L${CMAKE_SYSROOT}/usr/lib/${CMAKE_SYSTEM_PROCESSOR}-linux-ohos")
        endif()
        if(CMAKE_SYSROOT)
            list(APPEND flags_to_compile "--sysroot=${CMAKE_SYSROOT}")
        endif()
        if(DARWIN)
            list(APPEND flags_to_compile "-lSystem")
        endif()

        # All shared libraries of standard library are placed in the same location. Adding $ORIGIN into RPATH so
        # standard libraries can find each other.
        if(NOT CMAKE_SKIP_RPATH AND ${CMAKE_SYSTEM_NAME} MATCHES "Linux")
            list(APPEND flags_to_compile ${LINKER_OPTION_PREFIX}--disable-new-dtags ${LINKER_OPTION_PREFIX}-rpath="\\$$ORIGIN")
        endif()
        if(DARWIN)
            list(APPEND flags_to_compile -install_name "@rpath/libcangjie-${target_name}${CMAKE_SHARED_LIBRARY_SUFFIX}")
            list(APPEND flags_to_compile -rpath "@loader_path")
        endif()

        if(WIN32)
            list(APPEND set_env_path "LIBRARY_PATH=${CMAKE_BINARY_DIR}/lib/;${ENV_LIBRARY_PATH}")
        else()
            list(APPEND set_env_path "LIBRARY_PATH=${CMAKE_BINARY_DIR}/lib/:${ENV_LIBRARY_PATH}")
            list(APPEND set_env_path "LD_LIBRARY_PATH=${linker_ld_library_path}:${ENV_LD_LIBRARY_PATH}")
        endif()

        set(link_std_libraries_flag)
        foreach(library_name ${CANGJIE_LIBRARY_CANGJIE_STD_LIB_DEPENDS})
            set(lib_link_option "cangjie-${library_name}")
            to_link_library_option(lib_link_option)
            list(APPEND link_std_libraries_flag "${lib_link_option}")
        endforeach()

        foreach(library_name ${CANGJIE_LIBRARY_CANGJIE_STD_LIB_LINK})
            if(DARWIN)
                list(APPEND link_std_libraries_flag
                -L$ENV{CANGJIE_HOME}/runtime/lib/${output_cj_lib_dir} -lcangjie-${library_name})
            else()
                list(APPEND link_std_libraries_flag  -L $ENV{CANGJIE_HOME}/runtime/lib/${output_cj_lib_dir} -l:libcangjie-${library_name}${CMAKE_SHARED_LIBRARY_SUFFIX})
            endif()

        endforeach()

        foreach(indirect_library_name ${CANGJIE_LIBRARY_CANGJIE_STD_LIB_INDIRECT_DEPENDS})
            if(DARWIN)
                list(APPEND link_std_libraries_flag
                    -lcangjie-${indirect_library_name})
            else()
                list(APPEND link_std_libraries_flag ${LINKER_OPTION_PREFIX}--as-needed)
                list(APPEND link_std_libraries_flag
                    -l:libcangjie-${indirect_library_name}${CMAKE_SHARED_LIBRARY_SUFFIX})
                list(APPEND link_std_libraries_flag ${LINKER_OPTION_PREFIX}--no-as-needed)
            endif()
        endforeach()

        set(force_link_archives_option)
        foreach(force_link_archive ${CANGJIE_LIBRARY_FORCE_LINK_ARCHIVES})
            set(archive_path "${force_link_archive}")
            if(TARGET ${force_link_archive})
                get_target_property(target_location ${force_link_archive} COMBINED_STATIC_LIB_LOC)
                if(NOT target_location)
                    set(archive_path $<TARGET_FILE:${force_link_archive}>)
                else()
                    set(archive_path "${target_location}")
                endif()
            endif()
            if(DARWIN)
                list(APPEND force_link_archives_option "-force_load")
                list(APPEND force_link_archives_option "${archive_path}")
            else()
                list(APPEND force_link_archives_option "${LINKER_OPTION_PREFIX}--whole-archive")
                list(APPEND force_link_archives_option "${archive_path}")
                list(APPEND force_link_archives_option "${LINKER_OPTION_PREFIX}--no-whole-archive")
            endif()
        endforeach()

        add_custom_target(
            ${target_name} ALL
            COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/lib/${output_std_cj_lib_dir}
            COMMAND ${CMAKE_COMMAND} -E env ${set_env_path} ${clang_compiler} ${CANGJIE_LIBRARY_OBJECTS} ${force_link_archives_option}
                    ${CANGJIE_LIBRARY_FLAGS}  ${link_std_libraries_flag} ${flags_to_compile} -o ${target_lib_full_name}
            BYPRODUCTS ${target_lib_full_name}
            DEPENDS
                ${CANGJIE_LIBRARY_DEPENDS}
                ${CANGJIE_LIBRARY_CANGJIE_STD_LIB_DEPENDS}
                ${CANGJIE_LIBRARY_CANGJIE_STD_LIB_INDIRECT_DEPENDS}
                ${CANGJIE_LIBRARY_OBJECTS}
                boundscheck
            COMMENT "Generating ${target_lib_full_name}")
    else()
        message(FATAL_ERROR "only support SHARED or EXE for now")
    endif()

    if(CANGJIE_LIBRARY_IS_SHARED)
        install(FILES ${target_lib_full_name} DESTINATION runtime/lib/${output_cj_lib_dir})
        if(target_name STREQUAL "std-regex")
            file(GLOB PCRE2_DYNAMIC_LIB
                ${CMAKE_BINARY_DIR}/third_party/pcre2/bin/libpcre2-8.dll
                ${CMAKE_BINARY_DIR}/third_party/pcre2/lib/libpcre2-8.so*
                ${CMAKE_BINARY_DIR}/third_party/pcre2/lib/libpcre2-8.*dylib
            )
            message("PCRE2_DYNAMIC_LIB: ${PCRE2_DYNAMIC_LIB}")
            install(FILES ${PCRE2_DYNAMIC_LIB} DESTINATION runtime/lib/${output_cj_lib_dir})
        endif()
    endif()
endfunction()
