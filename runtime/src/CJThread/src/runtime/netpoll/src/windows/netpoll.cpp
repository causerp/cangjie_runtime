// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include <cstdlib>
#include "securec.h"
#include "log.h"
#include "netpoll_common.h"
#include "netpoll.h"

#ifdef __cplusplus
extern "C" {
#endif

/* netpoll exit */
void NetpollExit(NetpollFd npfd)
{
    struct NetpollMetaData *meta = reinterpret_cast<struct NetpollMetaData *>(npfd);
    if (meta == nullptr) {
        return;
    }
    free(meta);
}

/* Create the global public epoll_fd. */
int NetpollCreateImpl(struct NetpollMetaData *metaData)
{
    int error;
    metaData->epfd = CreateIoCompletionPort(INVALID_HANDLE_VALUE, nullptr, 0, 0);
    if (metaData->epfd == nullptr) {
        error = static_cast<int>(GetLastError());
        LOG_ERROR(error, "CreateIoCompletionPort failed");
        return error;
    }
    return 0;
}

/* Module initialization interface. After initialization, the bottom-layer epoll implementation
 * cannot be modified.
 */
NetpollFd NetpollCreate(void)
{
    int error;
    struct NetpollMetaData *metaData;

    metaData = NetpollMetaDataInit();
    if (metaData == nullptr) {
        return nullptr;
    }

    error = NetpollCreateImpl(metaData);
    if (error != 0) {
        free(metaData);
        return nullptr;
    }

    return metaData;
}

/* Add fd to Netpoll monitoring. */
int NetpollAdd(NetpollFd npfd, HANDLE fd, void *data, unsigned int events)
{
    (void)data;
    (void)events;
    HANDLE ret;
    int error;
    struct NetpollMetaData *meta = reinterpret_cast<struct NetpollMetaData *>(npfd);

    if (meta == nullptr) {
        LOG_ERROR(ERRNO_NETPOLL_UNINIT, "netpoll uninited");
        return ERRNO_NETPOLL_UNINIT;
    }

    ret = CreateIoCompletionPort(fd, meta->epfd, 0, 0);
    if (ret == nullptr) {
        error = static_cast<int>(GetLastError());
        LOG_ERROR(error, "netpoll add failed, epfd: %llu, fd: %llu", meta->epfd, fd);
        return error;
    }

    return 0;
}

/* In Windows, fd cannot be removed from IOCP monitoring unless the FD is disabled. */
int NetpollDel(NetpollFd npfd, HANDLE fd)
{
    (void)npfd;
    (void)fd;

    return 0;
}

int NetpollWait(NetpollFd npfd, OVERLAPPED_ENTRY *entries, int maxentries, DWORD timeoutms)
{
    int error;
    int eventsNum;
    WINBOOL ret;
    struct NetpollMetaData *meta = reinterpret_cast<struct NetpollMetaData *>(npfd);

    if (meta == nullptr) {
        LOG_ERROR(ERRNO_NETPOLL_UNINIT, "netpoll uninited");
        return -1;
    }

    ret = GetQueuedCompletionStatusEx(meta->epfd, entries, (ULONG)maxentries,
                                      (PULONG)&eventsNum, timeoutms, FALSE);
    if (ret == FALSE) {
        error = static_cast<int>(GetLastError());
        if (error == WAIT_TIMEOUT) {
            return 0;
        }
        LOG_ERROR(error, "netpoll wait failed, epfd: %llu, maxevents: %lu", meta->epfd, maxentries);
        return -1;
    }

    return eventsNum;
}

#ifdef __cplusplus
}
#endif