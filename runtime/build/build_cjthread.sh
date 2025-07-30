# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

#!/bin/bash
# CI shell script for calling build.py
set -e

MACHINE="$(uname -m)"

if [ "${MACHINE}" = "x86_64" ]; then
    platform="linux_x86_64"
elif [ "${MACHINE}" = "aarch64" ]; then
    platform="linux_aarch64"
fi

script_abs="$(readlink -f "$0")"
export PROJECT_PATH="$(dirname $script_abs)/../"
export CJTHREAD_PATH="${PROJECT_PATH}/src/CJThread"
export BUILD_PATH="${PROJECT_PATH}/build/cjthread_build"

# example
# 1. make static lib
# sh build/build_cjthread.sh -p linux_x86_64 Debug SHARED
# sh build/build_cjthread.sh -p linux_x86_64 Debug SHARED asan
# sh build/build_cjthread.sh -p linux_x86_64_gcov Debug SHARED
# 2. make test
# sh build/build_cjthread.sh -t cjthread_sdv -s src -a linux_x86_64 -m Debug

if [ "$1" = "clean" ];then
    cd "${PROJECT_PATH}"
    /bin/bash ./build/scripts/clean_history.sh
elif [ "$1" = "-t" ];then
    cd "${PROJECT_PATH}"/test_tools/tests/cjthread_test/cjthread_sdv/src
    /bin/bash build_test.sh "$@"
elif [ "$1" = "lcov" ];then
    cd "${PROJECT_PATH}"/test_tools/tests/cjthread_test/cjthread_sdv/src
    /bin/bash build_lcov.sh "$@"
elif [ "$1" = "-p" ];then
    if [ -d "${BUILD_PATH}" ]; then
      rm -r ${BUILD_PATH}
    fi
    if [ ! -d "${BUILD_PATH}" ]; then
      mkdir ${BUILD_PATH}
    fi

    if [ -d "$7" ]; then
      rm -r $7
    fi
    if [ ! -d "${PROJECT_PATH}/output" ]; then
      mkdir -p ${PROJECT_PATH}/output/temp/lib
      mkdir -p ${PROJECT_PATH}/output/temp/include
    fi

    cd "${BUILD_PATH}"
    echo "CJTHREAD BUILDING: target:$2, build type: $3, libtype: $4, building stage: $5, other definitions: $6, path: ${CJTHREAD_PATH}"
    cmake -DTARGET="$2" -DCMAKE_BUILD_TYPE="$3" -DLIBTYPE="$4" -DBUILDING_STAGE="$5" $6 -DCMAKE_INSTALL_PREFIX="$7" -DTARGET_ARCH="$8" ${CJTHREAD_PATH}
    make -j32 && make install
fi

exit 0
