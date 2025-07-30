# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

#!/bin/bash
set -e

CURRENT_PATH="$(readlink -f "$0")"
PROJECT_PATH="$(dirname $CURRENT_PATH)/../../"
TEST_PATH="$PROJECT_PATH/test_tools/tests/cjthread_test"

echo "-----------------------------------------------------------------"
echo "clean cjthread project begin..."
# clean all construct file

if [ -d "${PROJECT_PATH}/output" ]; then
    rm -rf ${PROJECT_PATH}/output
fi

if [ -d "${PROJECT_PATH}/build/cjthread_build" ]; then
    rm -rf ${PROJECT_PATH}/build/cjthread_build
fi

if [ -d "${TEST_PATH}/cjthread_sdv/build" ]; then
    rm -rf ${TEST_PATH}/cjthread_sdv/build
fi

if [ -d "${TEST_PATH}/cjthread_sdv/bin" ]; then
    rm -rf ${TEST_PATH}/cjthread_sdv/bin
fi

if [ -d "${TEST_PATH}/dtest/build" ]; then
    rm -rf ${TEST_PATH}/dtest/build
fi

if [ -d "${TEST_PATH}/dtest/lib" ]; then
    rm -rf ${TEST_PATH}/dtest/lib
fi

rm -f ${PROJECT_PATH}/Test_Report_*
rm -f ${PROJECT_PATH}/result.xml
rm -f ${PROJECT_PATH}/test_syscall.txt

echo "clean cjthread project end..."
echo "-----------------------------------------------------------------"


