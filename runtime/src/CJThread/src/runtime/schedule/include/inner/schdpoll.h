// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_SCHDPOLL_H
#define MRT_SCHDPOLL_H

#include <pthread.h>
#include <atomic>
#include <stdbool.h>
#include "netpoll.h"
#include "schedule_impl.h"
#include "external.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif

/* Maximum number of events returned by a netpoll */
#define SCHDPOLL_EVENT_NUM 64

/* Maximum number of cjthreads returned by SchdpollAcquire at a time */
#define SCHDPOLL_ACQUIRE_MAX_NUM (SCHDPOLL_EVENT_NUM * 2)

/**
 * @brief Schdpoll waiter state
 */
enum SchdpollDescState {
    PD_NOWAIT = 0,          /* No cjthreads are currently waiting on the fd */
    PD_READY = 1,           /* Event ready on fd */
    PD_CLOSING = 2          /* fd is closing */
};

#if defined (MRT_LINUX)
/**
 * @brief SchdpollCallback
 */
struct SchdpollCallback {
    int fd;
    void *func;
    void *arg;
};

/**
 * @brief pd type
 */
enum SchdpollDescType {
    SCHDPOLL_CJTHREAD,              /* use cjthread */
    SCHDPOLL_CALLBACK,              /* use callback */
    SCHDPOLL_CALLBACK_FD_OUTSIDE,   /* fd is added to epoll externally. Special processing */
    SCHDPOLL_CALLBACK_EVENT
};

struct SchdpollNotifyUsrInfo {
    int fd;
    int events;
    void *func;
    void *arg;
};

/**
 * @brief CJThread IO poll object descriptor -- pd
 */
struct SchdpollDesc {
    FdHandle fd;
    enum SchdpollDescType type;
    struct CJThreadDesc cjthread;
    struct SchdpollCallback callback;
    struct SchdpollDesc *next;
};

/**
 * @brief Callback processing function of schdpoll
 */
typedef int (*SchdpollEventProcFunc)(struct epoll_event *event, void *data);

/**
 * @brief Callback processing function with fd of schdpoll
 */
typedef unsigned int (*SchdpollFdEventProcFunc)(int fd, int events, void *param);

#elif defined (MRT_MACOS)

struct SchdpollDesc {
    struct CJThreadDesc cjthread;
    struct SchdpollDesc *next;
};

#endif

/**
 * @brief Add the fd to the event monitoring of the shcdpoll module and return the pd pointer
 * corresponding to the fd.
 * @par Description: Add fd to the event monitoring of the shcdpoll module. Before calling
 * other APIs of this module, you need to call this API to add the fd to the monitoring.
 * @param fd    [IN] fd to be monitored.
 * @retval # If a non-null value function is successfully operated, the pd pointer is returned.
 * @retval #NULL is returned when the operation fails.
 */
struct SchdpollDesc *SchdpollAdd(FdHandle fd);

/**
 * @brief Delete the fd from the event monitoring of shcdpoll module and release pd resources.
 * @param fd    [IN] Monitored fd.
 * @param pd    [IN] pd corresponding to fd.
 * @param netpollState [IN] if a netpoll listening event has been added, perform netpoll_del
 * @retval #0 The function is successfully operated.
 * @retval # An error code is returned when a non-zero value function fails to be operated.
 */
int SchdpollDel(struct Schedule *schedule, FdHandle fd, struct SchdpollDesc *pd, int netpollState);

/**
* @brief Wait for the corresponding fd event to arrive and call CJThreadPark to release cjthread.
* @par Wait for the corresponding fd event to arrive and call CJThreadPark to release the
* cjthread. Wake up when an event arrives.
* @param pd    [IN] Pointer to pd.
* @param type    [IN] Type of the event to be monitored. For details, see SchdpollEventType.
* @retval #true The monitored event arrives.
* @retval #false pd enters the disabled state.
 */
bool SchdpollWait(struct SchdpollDesc *pd, enum SchdpollEventType type);

/**
 * @brief Obtain the cjthread to be woken up.
 * @par Obtains the cjthread that needs to be woken up on the pd.
 * @param pd    [IN] Pointer to pd.
 * @param type    [IN] Event type to be woken up. For details, see SchdpollEventType.
 * @param ioready    [IN] Indicates whether the current status is an event. If an event arrives,
 * set this parameter to true. If an event does not arrive, set this parameter to false.
 * @retval # The cjthread that needs to be woken up for a non-null value.
 * @retval #NULL No cjthread needs to be woken up on the PD.
 */
struct CJThread *SchdpollReady(struct SchdpollDesc *pd, enum SchdpollEventType type, bool ioready);

/**
 * @brief Access the netpoll to obtain the ready cjthread.
 * @par Description: Access netpoll to get ready cjthread. This function invokes NetpollWait
 * to obtain events.
 * @param schedule    [IN] Home scheduler.
 * @param buf    [IN] Cache for storing ready cjthreads.
 * @param bufLen    [IN] Cache size.
 * @param timeout    [IN] NetpollWait timeout interval, in ms.
 * @retval Returns the number of ready cjthreads.
 */
int SchdpollAcquire(struct Schedule *schedule, void *buf[], unsigned int bufLen, int timeout);

#ifdef MRT_LINUX
/**
* @brief Obtain the internal epoll handle.
* @retval epoll handle
 */
int SchdpollInnerFd(void);

/**
 * @brief Add a callback function to schdpoll. When fd receives a listening event, the
 * corresponding callback function is triggered.
 * @attention: The function that takes a long time cannot be transferred.
 * @param fd    [IN] Listened fd.
 * @param events    [IN] Listened events.
 * @param func    [IN] Callback function.
 * @param arg    [IN] Function parameter.
 * @retval The pd pointer is returned if the operation is successful.
 */
struct SchdpollDesc *SchdpollCallbackAdd(int fd, int events, void *func, void *arg, enum SchdpollDescType type);
#endif

#if defined (MRT_LINUX) || defined (MRT_MACOS)
void SchdpollFreePd();
#endif


#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif
#endif /* MRT_SCHDPOLL_H */
