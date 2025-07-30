// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include <unistd.h>
#include "log.h"
#include "schdfd_impl.h"
#include "udpsock.h"

#ifdef __cplusplus
extern "C" {
#endif

int UdpsockDisconnect(SignedSocket connFd)
{
    struct sockaddr_storage peerAddr;
    socklen_t peerLen = sizeof(struct sockaddr_storage);
    int ret;

    ret = memset_s(&peerAddr, sizeof(struct sockaddr_storage), 0, sizeof(struct sockaddr_storage));
    if (ret != 0) {
        return ret;
    }
    peerAddr.ss_family = AF_UNSPEC;

    ret = UdpsockConnect(connFd, reinterpret_cast<const struct sockaddr *>(&peerAddr), peerLen);
    if (ret != 0) {
        LOG_ERROR(ret, "UdpsockConnect failed");
        return ret;
    }
    return 0;
}

#ifdef __cplusplus
}
#endif