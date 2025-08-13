# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
    set(REFLECT_SRCS
        class_type_info_cjnative.cj
        constants.cj
        exception.cj
        function_info_cjnative.cj
        interface_type_info_cjnative.cj
        intrinsic_cjnative.cj
        modifier_info.cj
        package_info_cjnative.cj
        parameter_info_cjnative.cj
        primitive_type_info_cjnative.cj
        struct_type_info_cjnative.cj
        type_info_cjnative.cj
        utils.cj
        variable_info_cjnative.cj
        CACHE INTERNAL "")
endif()