# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

# This script needs to be placed in the output directory of Cangjie compiler.
# ** NOTE: Please use `source' command to execute this script. **

# Get the absolute path of the current folder
script_path=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

# Create soft link
ln -s $script_path ${CANGJIE_HOME}/runtime