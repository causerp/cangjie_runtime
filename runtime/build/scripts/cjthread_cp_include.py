# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

import sys
import os
import shutil

def copy_files(txt_file, target_dir):
    # 检查目标目录是否存在，如果不存在则创建
    print(target_dir)
    if not os.path.exists(target_dir):
        os.makedirs(target_dir)

    with open(txt_file, 'r') as file_list:
        for line in file_list:
            source_file = line.strip()  # 移除行尾的换行符
            path_expanded = os.path.expandvars(source_file)
            absolute_path = os.path.abspath(path_expanded)
            if os.path.isfile(absolute_path):  # 检查文件是否存在
                command = f"rsync -ua {absolute_path} {target_dir}"
                os.system(command)

if __name__ == "__main__":
    txt_file = sys.argv[1]
    target_dir = sys.argv[2]
    os.environ['CPU_FAMILY'] = sys.argv[3]
    os.environ['CPU_CORE'] = sys.argv[4]
    copy_files(txt_file, target_dir)