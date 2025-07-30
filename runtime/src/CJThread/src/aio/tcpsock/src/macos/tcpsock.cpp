// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include <unistd.h>
#include "log.h"
#include "sock_impl.h"
#include "schdfd_impl.h"
#include "securec.h"
#include "tcpsock.h"

#ifdef __cplusplus
extern "C" {
#endif

int TcpsockKeepAliveSet(int fd, const struct SockKeepAliveCfg *cfg)
{
    int ret = 0;

    if (setsockopt(fd, SOL_SOCKET, SO_KEEPALIVE, &cfg->keepAlive, sizeof(unsigned int)) == -1) {
        ret = errno;
        LOG_ERROR(ret, "setsockopt failed, fd: %d, val: %u", fd, cfg->keepAlive);
        return ret;
    }

    // Setting it off does not require further configuration.
    if (cfg->keepAlive == 0) {
        return 0;
    }

    if (setsockopt(fd, IPPROTO_TCP, TCP_KEEPALIVE, &cfg->idle, sizeof(unsigned int)) == -1) {
        ret = errno;
        LOG_ERROR(ret, "setsockopt failed, fd: %d, val: %u", fd, cfg->idle);
        return ret;
    }

    if (setsockopt(fd, IPPROTO_TCP, TCP_KEEPINTVL, &cfg->interval, sizeof(unsigned int)) == -1) {
        ret = errno;
        LOG_ERROR(ret, "setsockopt failed, fd: %d, val: %u", fd, cfg->interval);
        return ret;
    }

    if (setsockopt(fd, IPPROTO_TCP, TCP_KEEPCNT, &cfg->count, sizeof(unsigned int)) == -1) {
        ret = errno;
        LOG_ERROR(ret, "setsockopt failed, fd: %d, val: %u", fd, cfg->count);
        return ret;
    }

    return 0;
}

#ifdef __cplusplus
}
#endif