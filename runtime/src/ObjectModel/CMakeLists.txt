# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

set(SRC_LIST
    "MObject.cpp"
    "MClass.cpp"
    "MArray.cpp"
    "MFunc.cpp"
    "PackageInfo.cpp"
    "FieldInfo.cpp"
    "MethodInfo.cpp"
)
add_library(ObjectModel STATIC ${SRC_LIST})