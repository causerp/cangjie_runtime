# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
    set(CJNATIVE_SYNC_SRCS
        atomic.cj
        monitor.cj
        ireentrant_mutex.cj
        lock_interface.cj
        mutex_cjnative.cj
        read_write_lock.cj
        reentrant_mutex.cj
        reentrant_read_write_mutex.cj
        native.cj
        barrier.cj
        sync_counter.cj
        sync_list.cj
        semaphore.cj
        timer.cj
        CACHE INTERNAL "")
endif()
