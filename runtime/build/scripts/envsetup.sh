#!/bin/bash

# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

# This script needs to be placed in the output directory of Runtime.
# ** NOTE: Please execute envsetup.sh in Cangjie Compiler before execute this script.
#          Please use `source' command to execute this script. **

# Get the absolute path of the current folder
shell_path=$(readlink -f /proc/$$/exe)
shell_name=${shell_path##*/}

# Get the absolute path of this script according to different shells.
case "${shell_name}" in
    "zsh")
        script_dir=$(cd "$(dirname "$(readlink -f "${(%):-%N}")")"; pwd)
        ;;
    "sh" | "bash")
        script_dir=$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"; pwd)
        ;;
    *)
        echo "[ERROR] Unsupported shell: ${shell_name}, please switch to bash, sh or zsh."
        return 1
        ;;
esac

# Create soft link
if [ -z "$CANGJIE_HOME" ]; then
    echo "Please execute envsetup.sh in Cangjie Compiler first"
elif [ -e "${CANGJIE_HOME}/runtime" ]; then
    rm -r ${CANGJIE_HOME}/runtime
    ln -s $script_dir ${CANGJIE_HOME}/runtime
else
    ln -s $script_dir ${CANGJIE_HOME}/runtime

fi