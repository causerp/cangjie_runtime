# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

if (COV MATCHES 0)
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../../third_party/third_party_bounds_checking_function/include)
    set(DEMANGLER_SRC
        ${CMAKE_CURRENT_SOURCE_DIR}/../Base/CString.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/../Base/FixedCString.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/Demangler.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/DeCompression.cpp)
    add_library(demangler STATIC ${DEMANGLER_SRC})
    # cjfilt
    add_executable(cjfilt ${CMAKE_CURRENT_SOURCE_DIR}/Demangler.cpp ${CMAKE_CURRENT_SOURCE_DIR}/DeCompression.cpp ${CMAKE_CURRENT_SOURCE_DIR}/Cjfilt.cpp)
    add_dependencies(cjfilt demangler)
    target_compile_definitions(cjfilt PRIVATE BUILD_LIB_CANGJIE_DEMANGLE)
    target_link_libraries(cjfilt PRIVATE demangler)
    # libcangjie-demangle
    add_library(cangjie-demangle STATIC
        ${CMAKE_CURRENT_SOURCE_DIR}/DeCompression.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/Demangler.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/CangjieDemangle.cpp)
    target_compile_definitions(cangjie-demangle PRIVATE BUILD_LIB_CANGJIE_DEMANGLE)
if (OHOS_FLAG IN_LIST OHOS_FLAG_LIST)
    add_library(cangjie-demangle-shared SHARED
        ${CMAKE_CURRENT_SOURCE_DIR}/DeCompression.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/Demangler.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/CangjieDemangle.cpp)
    target_compile_definitions(cangjie-demangle-shared PRIVATE BUILD_LIB_CANGJIE_DEMANGLE)
    install(TARGETS cangjie-demangle-shared LIBRARY DESTINATION runtime/lib/${TARGET_ARCH})
    set_target_properties(cangjie-demangle-shared PROPERTIES OUTPUT_NAME "cangjie-demangle")
endif()
    # demangleTest
    add_executable(demangleTest ${CMAKE_CURRENT_SOURCE_DIR}/Demangler.cpp ${CMAKE_CURRENT_SOURCE_DIR}/DeCompression.cpp ${CMAKE_CURRENT_SOURCE_DIR}/CheckDemangle.cpp)
    add_dependencies(demangleTest demangler cangjie-demangle)
    if (OHOS_FLAG IN_LIST OHOS_FLAG_LIST)
        target_link_libraries(demangleTest PRIVATE cangjie-demangle demangler boundscheck hilog_ndk.z hitrace_ndk.z)
    else ()
        target_link_libraries(demangleTest PRIVATE cangjie-demangle demangler boundscheck)
    endif ()
    if (WINDOWS_FLAG MATCHES 1)
        target_link_libraries(demangleTest PRIVATE unwind)
        target_link_libraries(cjfilt PRIVATE unwind)
    endif()
    # install
    install(TARGETS cjfilt DESTINATION bin)
    install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/CangjieDemangle.h DESTINATION include)
    install(TARGETS cangjie-demangle DESTINATION ${CMAKE_INSTALL_PREFIX}/runtime/lib/${TARGET_ARCH})
endif()
