/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

#if defined(_WIN32) && defined(__MINGW64__)
#include <winsock2.h>
#include <ws2tcpip.h>
#else
#include <netdb.h>
#include <sys/socket.h>
#include <sys/types.h>
#endif

#include <stdbool.h>
#include <stdlib.h>
#include "securec.h"
#include "utils.h"

#define BUF_SIZE 200

#if defined(_WIN32) && defined(__MINGW64__)
extern char* CJ_SOCKET_GetErrMessage(int n)
{
    LPVOID lpMsgBuf = NULL;
    char* buffer = NULL;
    FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS, NULL,
        (DWORD)n, MAKELANGID(LANG_ENGLISH, SUBLANG_DEFAULT), (LPTSTR)&lpMsgBuf, 0, NULL);
    if (lpMsgBuf == NULL) {
        return NULL;
    }
    buffer = strdup((const char*)lpMsgBuf);
    LocalFree(lpMsgBuf);
    return buffer;
}
#else
extern char* CJ_SOCKET_GetErrMessage(int n)
{
    char* buf = (char*)malloc(BUF_SIZE * sizeof(char));
    if (buf == NULL) {
        return NULL;
    }
#if defined(_GNU_SOURCE)
    if (strerror_r(n, buf, BUF_SIZE) == NULL) {
#else
    if (strerror_r(n, buf, BUF_SIZE) != 0) {
#endif
        free(buf);
        return NULL;
    }

    return buf;
}
#endif

extern int32_t CJ_GetOptionInt(int64_t sock, int32_t level, int32_t optname)
{
    int32_t optval = 0; // windows may update bytes only partially leaving garbage so we have to pass 0 here
    socklen_t optlen = (socklen_t)sizeof(optval);
    int32_t ret = CJ_SockOptionGet(sock, level, optname, &optval, &optlen);
    if (ret != 0) {
        return -1;
    }
    return optval;
}

extern int32_t CJ_SetOptionInt(int64_t sock, int32_t level, int32_t optname, int32_t optval)
{
    socklen_t optlen = (socklen_t)sizeof(optval);
    int32_t ret = CJ_SockOptionSet(sock, level, optname, &optval, optlen);
    return ret;
}

extern struct sockaddr* CJ_SOCKET_GetAddrFromAddrinfo(const struct addrinfo* info)
{
    return info->ai_addr;
}

extern struct SockAddr* CJ_RawAddressCreate(struct sockaddr_storage* arr, socklen_t size)
{
    struct SockAddr* sockaddr = malloc(sizeof(struct SockAddr));
    if (sockaddr == NULL) {
        return NULL;
    }
    sockaddr->sockaddr = arr;
    sockaddr->addrLen = size;
    return sockaddr;
}

extern socklen_t CJ_RawAddressLenGet(struct SockAddr* addrPtr)
{
    return addrPtr->addrLen;
}

extern void CJ_RawAddressDestroy(struct SockAddr* addrPtr)
{
    if (addrPtr != NULL) {
        free(addrPtr);
    }
    return;
}