// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "log.h"
#include "schdfd_impl.h"
#include "securec.h"
#include "udpsock.h"

#ifdef __cplusplus
extern "C" {
#endif

SOCKET UdpsockCreate(int domain, int type, int protocol, int *socketError)
{
    SOCKET sockFd;
    int ret;
    if (type != SOCK_DGRAM) {
        *socketError = ERRNO_SOCK_ARG_INVALID;
        LOG_ERROR(ERRNO_SOCK_ARG_INVALID, "udp socket type invalid: %d", type);
        return -1;
    }
    // create socket and set NONBLOCK, SOCK_CLOEXEC
    sockFd = WSASocket(domain, SOCK_DGRAM, protocol, nullptr,
                       0, WSA_FLAG_OVERLAPPED);
    if (sockFd == INVALID_SOCKET) {
        *socketError = WSAGetLastError();
        LOG_ERROR(*socketError, "udp socket failed, domain: %u, protocol: %d", domain, protocol);
        return -1;
    }
    ret = SchdfdRegisterAndNetpollAdd(sockFd);
    if (ret != 0) {
        *socketError = ret;
        LOG_ERROR(ret, "udpsock SchdfdRegisterAndNetpollAdd failed, fd: %d", sockFd);
        return -1;
    }

    LOG_INFO(0, "udp socket create success, fd: %d", sockFd);
    return sockFd;
}

int UdpsockDisconnect(SignedSocket connFd)
{
    struct sockaddr_storage peerAddr;
    socklen_t peerLen = sizeof(struct sockaddr_storage);
    int ret;

    memset_s(&peerAddr, sizeof(struct sockaddr_storage), 0, sizeof(struct sockaddr_storage));
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