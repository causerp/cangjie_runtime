# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

cmake_minimum_required(VERSION 3.16.3)
if (OHOS_FLAG MATCHES 1 OR OHOS_FLAG MATCHES 2)
    # Target OHOS is Linux-like system.
    set(CMAKE_SYSTEM_NAME Linux)
    set(CMAKE_C_COMPILER_WORKS 1)
    set(CMAKE_CXX_COMPILER_WORKS 1)
endif()

if (WINDOWS_FLAG MATCHES 1)
    set(CMAKE_SYSTEM_NAME Windows)
endif()
# Windows target must be set before project(CangjieRuntime).
if (WINDOWS_FLAG MATCHES 1)
    # Use target x86_64-w64-mingw32 instead of x86_64-windows-gnu
    # to make sure clang can find x86_64-w64-mingw32-ld (linker for cross-compiling)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -static -target x86_64-w64-mingw32 -pthread -femulated-tls")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -static -target x86_64-w64-mingw32 -pthread -femulated-tls")
    set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -static -target x86_64-w64-mingw32")
    if (NOT CMAKE_AR_PATH)
        set(CMAKE_AR_PATH "llvm-ar.exe")
    endif()
endif ()

# project name: CangjieRuntime
project(CangjieRuntime C CXX ASM)
include(${CMAKE_CURRENT_SOURCE_DIR}/config.cmake)

message("-- BUILD_CJTHREAD: " ${BUILD_CJTHREAD})
message("-- BUILD_RUNTIME: "   ${BUILD_RUNTIME})

if (SANITIZER_SUPPORT_FLAG MATCHES 1)
    add_compile_definitions(CANGJIE_SANITIZER_SUPPORT)
endif()

if (SANITIZER_SUPPORT_FLAG MATCHES 1 OR GWPASAN_SUPPORT_FLAG MATCHES 1)
    set(SANITIZER_LIB "-Wl,--whole-archive" "Sanitizer" "-Wl,--no-whole-archive")
    set(SANITIZER_LIB_STATIC "$<TARGET_OBJECTS:Sanitizer>")
endif ()

set(CJTHREAD_SAN_PRARM "cj")
if (ASAN_SUPPORT_FLAG MATCHES 1)
    set(CJTHREAD_SAN_PRARM "cjasan")
    add_compile_definitions(CANGJIE_ASAN_SUPPORT)
    add_compile_definitions(GENERAL_ASAN_SUPPORT_INTERFACE)
elseif (TSAN_SUPPORT_FLAG MATCHES 1)
    set(CJTHREAD_SAN_PRARM "cjtsan")
    add_compile_definitions(CANGJIE_TSAN_SUPPORT)
elseif (HWASAN_SUPPORT_FLAG MATCHES 1)
    set(CJTHREAD_SAN_PRARM "cjhwasan")
    add_compile_definitions(CANGJIE_HWASAN_SUPPORT)
    add_compile_definitions(GENERAL_ASAN_SUPPORT_INTERFACE)
elseif (GWPASAN_SUPPORT_FLAG MATCHES 1)
    add_compile_definitions(CANGJIE_GWPASAN_SUPPORT)
endif ()

set(OTHER_DEFINITIONS " ")
if (RUNTIME_FORWARD_PTRAUTH_CFI MATCHES 1)
    set(OTHER_DEFINITIONS "${OTHER_DEFINITIONS} -DRUNTIME_FORWARD_PTRAUTH_CFI=1")
    add_compile_definitions(ENABLE_FORWARD_PTRAUTH_CFI)
endif ()
if (RUNTIME_BACKWARD_PTRAUTH_CFI MATCHES 1)
    set(OTHER_DEFINITIONS "${OTHER_DEFINITIONS} -DRUNTIME_BACKWARD_PTRAUTH_CFI=1")
    add_compile_definitions(ENABLE_BACKWARD_PTRAUTH_CFI)
endif ()

if (BUILD_DEMANGLE)
    message("-- BUILD_DEMANGLE: " ${BUILD_DEMANGLE})
    add_subdirectory(src)
endif() # BUILD_DEMANGLE

if (BUILD_CJTHREAD) # BUILD_CJTHREAD
# build cjthread
if (WINDOWS_FLAG MATCHES 1)
    if (CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
        message("build cjthread for windows on windows")
        # build\build_cjthread_windows.bat -p windows_x86_64 Debug STATIC
        execute_process(COMMAND build\\build_cjthread_windows.bat -p windows_x86_64 ${CMAKE_BUILD_TYPE} STATIC ${CJTHREAD_SAN_PRARM} ${OTHER_DEFINITIONS} ${CMAKE_INSTALL_PREFIX} ${TARGET_ARCH})
    elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
        message("build cjthread for windows on linux")
        execute_process(COMMAND bash build/build_cjthread.sh -p cross_windows_x86_64 ${CMAKE_BUILD_TYPE} STATIC ${CJTHREAD_SAN_PRARM} ${OTHER_DEFINITIONS} ${CMAKE_INSTALL_PREFIX} ${TARGET_ARCH})
    else ()
        message("Only the Windows and Linux platforms are supported.")
    endif ()
elseif (OHOS_FLAG MATCHES 1) # for ohos-aarch64
    if (CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
        message("build cjthread for ohos on windows")
        execute_process(COMMAND build\\build_cjthread_windows.bat -p ohos_aarch64_cangjie ${CMAKE_BUILD_TYPE} STATIC ${CJTHREAD_SAN_PRARM} ${OTHER_DEFINITIONS} ${CMAKE_INSTALL_PREFIX} ${TARGET_ARCH})
    else ()
        message("build cjthread for ohos")
        execute_process(COMMAND bash build/build_cjthread.sh -p ohos_aarch64_cangjie ${CMAKE_BUILD_TYPE} STATIC ${CJTHREAD_SAN_PRARM} ${OTHER_DEFINITIONS} ${CMAKE_INSTALL_PREFIX} ${TARGET_ARCH})
    endif ()
elseif (OHOS_FLAG MATCHES 2) # for ohos-x86_64
    if (CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
        message("build cjthread for ohos on windows")
        execute_process(COMMAND build\\build_cjthread_windows.bat -p ohos_x86_64_cangjie ${CMAKE_BUILD_TYPE} STATIC ${CJTHREAD_SAN_PRARM} ${OTHER_DEFINITIONS} ${CMAKE_INSTALL_PREFIX} ${TARGET_ARCH})
    else ()
        message("build cjthread for ohos")
        execute_process(COMMAND bash build/build_cjthread.sh -p ohos_x86_64_cangjie ${CMAKE_BUILD_TYPE} STATIC ${CJTHREAD_SAN_PRARM} ${OTHER_DEFINITIONS} ${CMAKE_INSTALL_PREFIX} ${TARGET_ARCH})
    endif ()
elseif (MACOS_FLAG MATCHES 1)
    if (CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64")
        message("build cjthread for macos x86_64")
        execute_process(COMMAND bash build/build_cjthread.sh -p macos_x86_64 ${CMAKE_BUILD_TYPE} STATIC ${CJTHREAD_SAN_PRARM} ${OTHER_DEFINITIONS} ${CMAKE_INSTALL_PREFIX} ${TARGET_ARCH})
    else()
        message("build cjthread for macos aarch64")
        execute_process(COMMAND bash build/build_cjthread.sh -p macos_aarch64 ${CMAKE_BUILD_TYPE} STATIC ${CJTHREAD_SAN_PRARM} ${OTHER_DEFINITIONS} ${CMAKE_INSTALL_PREFIX} ${TARGET_ARCH})
    endif()
else ()
    if (CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64")
        message("build cjthread for aarch64")
        # bash build/build_cjthread.sh -p linux_aarch64_cangjie Debug STATIC ${CJTHREAD_SAN_PRARM}
        execute_process(COMMAND sh build/build_cjthread.sh -p linux_aarch64_cangjie ${CMAKE_BUILD_TYPE} STATIC ${CJTHREAD_SAN_PRARM} ${OTHER_DEFINITIONS} ${CMAKE_INSTALL_PREFIX} ${TARGET_ARCH})
    else ()
        # bash build/build_cjthread.sh -p linux_x86_64_cangjie Debug STATIC ${CJTHREAD_SAN_PRARM}
        message("build cjthread for x86_64")
        execute_process(COMMAND bash build/build_cjthread.sh -p linux_x86_64_cangjie ${CMAKE_BUILD_TYPE} STATIC ${CJTHREAD_SAN_PRARM} ${OTHER_DEFINITIONS} ${CMAKE_INSTALL_PREFIX} ${TARGET_ARCH})
    endif ()
endif () # WINDOWS_FLAG

message("build cjthread done!!!")
endif() # BUILD_CJTHREAD

if (BUILD_RUNTIME)
include_directories(${DOPRA_INCLUDE})

if (DOPRA_FLAG MATCHES 1)
    add_definitions(-DMRT_USE_CJTHREAD)
    add_definitions(-DMRT_USE_CJTHREAD_RENAME)
endif ()
if (MACOS_FLAG MATCHES 1)
    add_definitions(-D_XOPEN_SOURCE=600)
    add_definitions(-D_DARWIN_C_SOURCE)
    # add_definitions(-D__USE_GNU)
endif()

if (COPYGC_FLAG MATCHES 1)
    add_definitions(-DMRT_USE_COPYGC)
endif ()

if (DUMPADDRESS_FLAG MATCHES 1)
    add_definitions(-DMRT_DUMP_ADDRESS)
endif ()

if(CJ_SDK_VERSION)
    add_definitions(-DCJ_SDK_VERSION="${CJ_SDK_VERSION}")
endif()

if(VERSION_CHECK_FLAG MATCHES 0)
    add_definitions(-DDISABLE_VERSION_CHECK)
endif()

# add singal handle function for the coverage calculation
if (COV MATCHES 1)
    add_definitions(-DCOV_SIGNALHANDLE)
endif ()

link_directories(${DOPRA_LIBS})
link_directories(${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
if (MACOS_FLAG MATCHES 1)
    execute_process(COMMAND xcrun --show-sdk-path OUTPUT_VARIABLE output OUTPUT_STRIP_TRAILING_WHITESPACE)
    # set(output "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk")
    link_directories(${output}/usr/lib)
    link_directories(/usr/local/lib)
    set(CMAKE_OSX_DEPLOYMENT_TARGET 12.0.0)
endif()

link_directories(${BOUNDSCHECK_LIBS})
include_directories(${BOUNDSCHECK_INCLUDE})
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/src)
add_subdirectory(third_party/third_party_bounds_checking_function)
if (OHOS_FLAG MATCHES 0 AND WINDOWS_FLAG MATCHES 0 AND MACOS_FLAG MATCHES 0)
if (CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64")
    set(LINK_SCRIPTS "-Wl,-T${CMAKE_CURRENT_SOURCE_DIR}/build/lds/aarch64_linux/cjnative_runtime.lds")
    add_library(cjNativeStartAndEnd OBJECT ${CMAKE_CURRENT_SOURCE_DIR}/src/arch_os/aarch64_linux/CjNativeRuntimeStartAndEnd.s)
elseif (CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64")
    set(LINK_SCRIPTS "-Wl,-T${CMAKE_CURRENT_SOURCE_DIR}/build/lds/x86_64_linux/cjnative_runtime.lds")
    add_library(cjNativeStartAndEnd OBJECT ${CMAKE_CURRENT_SOURCE_DIR}/src/arch_os/x86_64_linux/CjNativeRuntimeStartAndEnd.s)
endif()
endif()

if (MACOS_FLAG MATCHES 1)
    set(COMMON_LINK_FLAGS "-rdynamic")
else()
    set(COMMON_LINK_FLAGS "-Wl,-z,relro -Wl,-z,now -Wl,-z,noexecstack -Wl,--gc-sections -rdynamic ${LINK_SCRIPTS}")
endif()

if (COV MATCHES 1)
    set_target_properties(cangjie-runtime PROPERTIES LINK_FLAGS "${COMMON_LINK_FLAGS} ${CMAKE_COV_FLAGS}")
    target_compile_definitions(cangjie-runtime PUBLIC COMPILE_DYNAMIC)
    target_compile_options(cangjie-runtime PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(Base PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(CjFile PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(Common PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(Concurrency PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(Exception PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(Heap PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(Allocator PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(Barrier PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(Collector PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(Loader PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(Mutator PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(ObjectModel PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(Inspector PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(Signal PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(BinaryFile PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(CjFileLoader PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(UnwindStack PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(Sync PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(WCollector PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(CjSemanticVersion PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    target_compile_options(CpuProfiler PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    if (DOPRA_FLAG MATCHES 1)
        target_compile_options(cjthreadmodel PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    elseif (DOPRA_FLAG MATCHES 0)
        target_compile_options(threadmodel PUBLIC "SHELL:${CMAKE_COV_FLAGS}")
    endif ()
else ()
    if (WINDOWS_FLAG MATCHES 1)
        set_target_properties(cangjie-runtime PROPERTIES LINK_FLAGS " -Wl,--gc-sections")
    elseif (WINDOWS_FLAG MATCHES 0)
        set_target_properties(cangjie-runtime PROPERTIES LINK_FLAGS "${COMMON_LINK_FLAGS}")
        target_compile_definitions(cangjie-runtime PUBLIC COMPILE_DYNAMIC)
    endif ()
endif ()

# Difference in Windows: remove signal module
# Signal processing use sigaction() as signal-catching function currently, it`s linux related, which can get context when signal was triggered. In Windows, signal() is the only function we can use, but there is no context.
if (WINDOWS_FLAG MATCHES 1)
    list(APPEND LINK_LIBS "boundscheck" "Base" "Common" "Concurrency" "Loader" "Inspector" "Exception" "Heap" "Mutator" "ObjectModel" "UnwindStack"
    "Allocator" "Barrier" "Collector" "WCollector" "BinaryFile" "CjFile" "CjFileLoader" "CjSemanticVersion" "Sync" "dbghelp" "ws2_32" "shlwapi" "CpuProfiler" ${SANITIZER_LIB})
elseif (WINDOWS_FLAG MATCHES 0)
    list(APPEND LINK_LIBS "boundscheck" "Base" "Common" "Concurrency" "Loader" "Inspector" "Exception" "Heap" "Mutator" "ObjectModel" "UnwindStack" "Signal"
    "Allocator" "Barrier" "Collector" "WCollector" "BinaryFile" "CjFile" "CjFileLoader" "CjSemanticVersion" "Sync" "CpuProfiler" ${SANITIZER_LIB})
endif()

if (DOPRA_FLAG MATCHES 1)
    if (MACOS_FLAG MATCHES 1)
        list(APPEND LINK_LIBS "cjthreadmodel" "cangjie-thread")
    else()
        list(APPEND LINK_LIBS "cjthreadmodel" "-Wl,--whole-archive" "cangjie-thread" "-Wl,--no-whole-archive")
    endif()
elseif (DOPRA_FLAG MATCHES 0)
    list(APPEND LINK_LIBS "threadmodel")
endif ()

if (ASAN_FLAG MATCHES 1)
    list(APPEND LINK_LIBS "-fsanitize=address")
endif()

if (HWASAN_FLAG MATCHES 1)
    list(APPEND LINK_LIBS "-fsanitize=hwaddress -fno-emulated-tls -fno-lto -fno-sanitize=cfi")
endif()

if (DOPRA_FLAG MATCHES 1 AND OHOS_FLAG MATCHES 0 AND WINDOWS_FLAG MATCHES 0) # linux
    if (COV MATCHES 1) # linux - cov
        target_link_libraries(cangjie-runtime "-Wl,--start-group -Wl,--version-script=${CMAKE_CURRENT_SOURCE_DIR}/src/local_export.map"
            "-lstdc++ -lpthread -ldl" ${LINK_LIBS} "cjNativeStartAndEnd" "-Wl,--end-group")
    else ()
        if (MACOS_FLAG MATCHES 1) # macos
            target_link_libraries(cangjie-runtime ${LINK_LIBS} "-Wl,-no_compact_unwind -nodefaultlibs -lc++ -lm -lc -lpthread -ldl")
        else() # normal
            target_link_libraries(cangjie-runtime "-Wl,--start-group -Wl,--version-script=${CMAKE_CURRENT_SOURCE_DIR}/src/${EXPORT_MAP}"
                ${LINK_LIBS} "cjNativeStartAndEnd" "-Wl,--end-group -nodefaultlibs -Wl,-Bdynamic -lstdc++ -lm -lc -lgcc_s -lpthread -ldl")
        endif()
    endif ()
elseif (DOPRA_FLAG MATCHES 1 AND OHOS_FLAG IN_LIST OHOS_FLAG_LIST AND WINDOWS_FLAG MATCHES 0) # OHOS
    target_link_libraries(cangjie-runtime "-Wl,--start-group -Wl,--version-script=${CMAKE_CURRENT_SOURCE_DIR}/src/${EXPORT_MAP}"
        "-lstdc++" ${LINK_LIBS} "-Wl,--end-group -lunwind -lclang_rt.builtins -lhilog_ndk.z -lhitrace_ndk.z")
elseif (DOPRA_FLAG MATCHES 1 AND OHOS_FLAG MATCHES 0 AND WINDOWS_FLAG MATCHES 1) # Windows
    target_link_libraries(cangjie-runtime PRIVATE "-Wl,--start-group"
        "-Wl,--version-script=${CMAKE_CURRENT_SOURCE_DIR}/src/local_export.map" "-lstdc++" ${LINK_LIBS} "-Wl,--end-group -Wl,--no-insert-timestamp")
elseif (DOPRA_FLAG MATCHES 0 AND WINDOWS_FLAG MATCHES 0) # thread module
    target_link_libraries(cangjie-runtime "-Wl,--start-group -Wl,--version-script=${CMAKE_CURRENT_SOURCE_DIR}/src/${EXPORT_MAP}"
        ${LINK_LIBS} "-Wl,--end-group -nodefaultlibs -Wl,-Bdynamic -lstdc++ -lm -lc -lgcc_s -lpthread -ldl")
elseif (DOPRA_FLAG MATCHES 0 AND WINDOWS_FLAG MATCHES 1) # thread module on windows
    target_link_libraries(cangjie-runtime "-Wl,--start-group -Wl,--version-script=${CMAKE_CURRENT_SOURCE_DIR}/src/local_export.map"
        ${LINK_LIBS} "-Wl,--end-group -nodefaultlibs -Wl,-Bdynamic -lstdc++ -lc -lgcc_s -Wl,--no-insert-timestamp")
endif ()


# setting for cjthread trace
if (DOPRA_FLAG MATCHES 1 AND RUNTIME_TRACE_FLAG MATCHES 1)
    file(WRITE ${CMAKE_BINARY_DIR}/null.c "")
    if (MACOS_FLAG MATCHES 1)
        link_libraries("-Wl" "cjthread-trace" "-Wl" "boundscheck")
    elseif(WINDOWS_FLAG MATCHES 1)
        link_libraries("-Wl,--whole-archive" "cjthread-trace" "-Wl,--no-whole-archive" "boundscheck")
    else()
        link_libraries("-Wl,--whole-archive" "cjthread-trace" "-Wl,--no-whole-archive" "boundscheck" "-Wl,-z,relro -Wl,-z,now")
    endif()
    add_library(cangjie-trace SHARED null.c)
    if (WINDOWS_FLAG MATCHES 1)
        target_link_libraries(cangjie-trace cangjie-runtime)
        target_link_options(cangjie-trace PRIVATE "-Wl,--no-insert-timestamp")
    endif()
    install(TARGETS cangjie-trace DESTINATION runtime/lib/${TARGET_ARCH})
endif()

install(TARGETS cangjie-runtime DESTINATION runtime/lib/${TARGET_ARCH})

install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/src/RuntimeConfig.h
        ${CMAKE_CURRENT_SOURCE_DIR}/src/Cangjie.h
        DESTINATION include)

# install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/build/scripts/envsetup.sh DESTINATION ${CMAKE_INSTALL_PREFIX})

if (WINDOWS_FLAG MATCHES 1)
    add_library(cjstart OBJECT ${CMAKE_CURRENT_SOURCE_DIR}/src/arch_os/x86_64_windows/Cjstart.S)
    install(PROGRAMS ${CMAKE_CURRENT_SOURCE_DIR}/build/lds/x86_64_windows/cjld.lds
            ${CMAKE_CURRENT_SOURCE_DIR}/build/lds/x86_64_windows/cld.lds
            ${CMAKE_CURRENT_SOURCE_DIR}/build/lds/x86_64_windows/cjld.shared.lds
            DESTINATION lib/${TARGET_ARCH})
elseif (MACOS_FLAG MATCHES 1)
    if (CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64")
        add_library(cjstart OBJECT ${CMAKE_CURRENT_SOURCE_DIR}/src/arch_os/X86_64_macos/Cjstart.S)
        add_library(section OBJECT ${CMAKE_CURRENT_SOURCE_DIR}/src/arch_os/section.cpp)
    else()
        add_library(cjstart OBJECT ${CMAKE_CURRENT_SOURCE_DIR}/src/arch_os/Aarch64_macos/Cjstart.S)
        add_library(section OBJECT ${CMAKE_CURRENT_SOURCE_DIR}/src/arch_os/section.cpp)
    endif()
elseif (CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64")
    add_library(cjstart OBJECT ${CMAKE_CURRENT_SOURCE_DIR}/src/arch_os/aarch64_linux/Cjstart.S)
    install(PROGRAMS ${CMAKE_CURRENT_SOURCE_DIR}/build/lds/aarch64_linux/cjld.lds
            ${CMAKE_CURRENT_SOURCE_DIR}/build/lds/aarch64_linux/discard_eh_frame.lds
            ${CMAKE_CURRENT_SOURCE_DIR}/build/lds/aarch64_linux/cld.lds
            ${CMAKE_CURRENT_SOURCE_DIR}/build/lds/aarch64_linux/cjld.shared.lds
            DESTINATION lib/${TARGET_ARCH})
else()
    add_library(cjstart OBJECT ${CMAKE_CURRENT_SOURCE_DIR}/src/arch_os/x86_64_linux/Cjstart.S)
    install(PROGRAMS ${CMAKE_CURRENT_SOURCE_DIR}/build/lds/x86_64_linux/cjld.lds
            ${CMAKE_CURRENT_SOURCE_DIR}/build/lds/x86_64_linux/discard_eh_frame.lds
            ${CMAKE_CURRENT_SOURCE_DIR}/build/lds/x86_64_linux/cld.lds
            ${CMAKE_CURRENT_SOURCE_DIR}/build/lds/x86_64_linux/cjld.shared.lds
            DESTINATION lib/${TARGET_ARCH})
endif()
install(PROGRAMS $<TARGET_OBJECTS:cjstart>
        RENAME cjstart.o
        DESTINATION lib/${TARGET_ARCH})
if (MACOS_FLAG MATCHES 1)
    install(PROGRAMS $<TARGET_OBJECTS:section>
        RENAME section.o
        DESTINATION lib/${TARGET_ARCH})
endif()

if (CMAKE_BUILD_TYPE MATCHES "^(Release|MinSizeRel)$")
    message("strip: ${CMAKE_INSTALL_PREFIX}")
    set(STRIP_PROGRAM strip)
    if(OHOS_FLAG IN_LIST OHOS_FLAG_LIST)
        # System installed `strip` may not support aarch64 targets. We use llvm-strip in OHOS toolchain.
        if (CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
            set(STRIP_PROGRAM $ENV{OHOS_ROOT}/prebuilts/clang/ohos/windows-x86_64/llvm/bin/llvm-strip)
        endif()
        if (CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
            set(STRIP_PROGRAM $ENV{OHOS_ROOT}/prebuilts/clang/ohos/linux-x86_64/llvm/bin/llvm-strip)
        endif()
        if (CMAKE_HOST_SYSTEM_NAME MATCHES "Darwin")
            set(STRIP_PROGRAM $ENV{OHOS_ROOT}/prebuilts/clang/ohos/${CMAKE_HOST_SYSTEM_NAME}-${CMAKE_HOST_SYSTEM_PROCESSOR}/llvm/bin/llvm-strip)
        endif()
    endif()
    if (WINDOWS_FLAG MATCHES 1)
        install(CODE "execute_process(COMMAND ${STRIP_PROGRAM} -p ${CMAKE_INSTALL_PREFIX}/runtime/lib/${TARGET_ARCH}/libcangjie-runtime.dll)"
            COMPONENT cangjie-runtime)
        if (ASAN_SUPPORT_FLAG MATCHES 0)
        install(CODE "execute_process(COMMAND ${STRIP_PROGRAM} ${CMAKE_INSTALL_PREFIX}/bin/cjfilt.exe)"
            COMPONENT cjfilt)
        endif()
        if (RUNTIME_TRACE_FLAG MATCHES 1)
        install(CODE "execute_process(COMMAND ${STRIP_PROGRAM} -p ${CMAKE_INSTALL_PREFIX}/runtime/lib/${TARGET_ARCH}/libcangjie-trace.dll)"
            COMPONENT cangjie-trace)
        endif()
    elseif (MACOS_FLAG MATCHES 1)
        install(CODE "execute_process(COMMAND ${STRIP_PROGRAM} -x ${CMAKE_INSTALL_PREFIX}/runtime/lib/${TARGET_ARCH}/libcangjie-runtime.dylib)"
                COMPONENT cangjie-runtime)
        if (ASAN_SUPPORT_FLAG MATCHES 0)
        install(CODE "execute_process(COMMAND ${STRIP_PROGRAM} -u -r ${CMAKE_INSTALL_PREFIX}/bin/cjfilt)"
                COMPONENT cjfilt)
        endif()
        if (RUNTIME_TRACE_FLAG MATCHES 1)
        install(CODE "execute_process(COMMAND ${STRIP_PROGRAM} ${CMAKE_INSTALL_PREFIX}/runtime/lib/${TARGET_ARCH}/libcangjie-trace.dylib)"
            COMPONENT cangjie-trace)
        endif()
    else()
        install(CODE "execute_process(COMMAND ${STRIP_PROGRAM} ${CMAKE_INSTALL_PREFIX}/runtime/lib/${TARGET_ARCH}/libcangjie-runtime.so)"
                COMPONENT cangjie-runtime)
        install(CODE "execute_process(COMMAND ${STRIP_PROGRAM} -g ${CMAKE_INSTALL_PREFIX}/lib/${TARGET_ARCH}/cjstart.o)"
                COMPONENT cjstart)
        if (OHOS_FLAG IN_LIST OHOS_FLAG_LIST)
        install(CODE "execute_process(COMMAND ${STRIP_PROGRAM} ${CMAKE_INSTALL_PREFIX}/runtime/lib/${TARGET_ARCH}/libcangjie-demangle.so)"
                COMPONENT cangjie-demangle)
        endif()
        if (ASAN_SUPPORT_FLAG MATCHES 0)
        install(CODE "execute_process(COMMAND ${STRIP_PROGRAM} ${CMAKE_INSTALL_PREFIX}/bin/cjfilt)"
                COMPONENT cjfilt)
        endif()
        if (RUNTIME_TRACE_FLAG MATCHES 1)
        install(CODE "execute_process(COMMAND ${STRIP_PROGRAM} ${CMAKE_INSTALL_PREFIX}/runtime/lib/${TARGET_ARCH}/libcangjie-trace.so)"
            COMPONENT cangjie-trace)
        endif()
    endif()
endif () # CMAKE_BUILD_TYPE MATCHES "^(Release|MinSizeRel)$"


if (WINDOWS_FLAG MATCHES 0 AND MACOS_FLAG MATCHES 0 AND OHOS_FLAG MATCHES 0)
    add_library(cangjie-runtime-static STATIC)
    target_sources(cangjie-runtime-static PRIVATE
        $<TARGET_OBJECTS:runtime>
        $<TARGET_OBJECTS:Base>
        $<TARGET_OBJECTS:CjFile>
        $<TARGET_OBJECTS:Concurrency>
        $<TARGET_OBJECTS:Common>
        $<TARGET_OBJECTS:Exception>
        $<TARGET_OBJECTS:Heap>
        $<TARGET_OBJECTS:Allocator>
        $<TARGET_OBJECTS:Barrier>
        $<TARGET_OBJECTS:Collector>
        $<TARGET_OBJECTS:Loader>
        $<TARGET_OBJECTS:Inspector>
        $<TARGET_OBJECTS:Mutator>
        $<TARGET_OBJECTS:ObjectModel>
        $<TARGET_OBJECTS:Signal>
        $<TARGET_OBJECTS:BinaryFile>
        $<TARGET_OBJECTS:CjFileLoader>
        $<TARGET_OBJECTS:UnwindStack>
        $<TARGET_OBJECTS:Sync>
        $<TARGET_OBJECTS:WCollector>
        $<TARGET_OBJECTS:cjthreadmodel>
        $<TARGET_OBJECTS:CjSemanticVersion>
        $<TARGET_OBJECTS:CpuProfiler>
        ${SANITIZER_LIB_STATIC}
    )
install(TARGETS cangjie-runtime-static ARCHIVE DESTINATION lib/${TARGET_ARCH})
set_target_properties(cangjie-runtime-static PROPERTIES OUTPUT_NAME "cangjie-runtime")

set(OBJCOPY_PROGRAM objcopy)
set(STRIP_PROGRAM strip)

install(CODE "execute_process(COMMAND ${OBJCOPY_PROGRAM} --rename-section .text=.text_runtime \
            ${CMAKE_INSTALL_PREFIX}/lib/${TARGET_ARCH}/libcangjie-runtime.a)"
        COMPONENT cangjie-runtime)
install(CODE "execute_process(COMMAND ${STRIP_PROGRAM} --strip-unneeded ${CMAKE_INSTALL_PREFIX}/lib/${TARGET_ARCH}/libcangjie-runtime.a)"
        COMPONENT cangjie-runtime)
endif()

endif() # BUILD_RUNTIME
