# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

add_subdirectory(native)

set(CONCURRENT_COLLECTION_SRCS
    concurrent_map_interface.cj
    concurrent_hash_map.cj
    blocking_queue.cj
    non_blocking_queue.cj
    array_blocking_queue.cj
    CACHE INTERNAL ""
)