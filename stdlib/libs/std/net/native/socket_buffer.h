/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

#ifndef CANGJIE_SOCKET_BUFFER_H
#define CANGJIE_SOCKET_BUFFER_H

#include "utils.h"

#if defined(__MINGW64__)
#include <ws2tcpip.h>
#else
#include <sys/socket.h>
#endif

int32_t CJ_MRT_SockSend(long long sock, const char* buf, unsigned int len, int flags);
int32_t CJ_MRT_SockSendto(long long sock, const char* buf, unsigned int len, int flags, const struct SockAddr* addr);
int32_t CJ_MRT_SockSendTimeout(long long sock, const char* buf, unsigned int len, int flags, unsigned long long times);
int32_t CJ_MRT_SockRecv(long long sock, const char* buf, unsigned int len, int flags);
int32_t CJ_MRT_SockRecvTimeout(long long sock, const char* buf, unsigned int len, int flags, unsigned long long times);
int32_t CJ_MRT_SockRecvfromTimeout(
    long long sock, void* buf, unsigned int len, int flags, struct SockAddr* addr, unsigned long long timeout);
int32_t CJ_MRT_SockClose(long long sock);
int32_t CJ_SockShutdown(long long sock);

#endif // CANGJIE_SOCKET_BUFFER_H
