// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#ifndef MRT_WAITQUEUE_IMPL_H
#define MRT_WAITQUEUE_IMPL_H

#include "schedule_impl.h"
#include "timer.h"
#include "waitqueue.h"
#include "list.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif

/**
 * @brief Internal structure of the waitqueue
 */
struct WaitqueueInner {
    pthread_mutex_t mutex;
    std::atomic<unsigned int> nwait;
    std::atomic<unsigned int> timerNwait;
    // Note: The non-cyclic linked list link is used here. The cyclic linked list dulink
    // cannot be used. Because the object is allocated in cangjie memory, the circular
    // linked list creates a self-reference problem.
    struct Link head;
    // Note: tail cannot point to the cangjie heap memory.
    // When the linked list is empty, it must be left empty.
    struct Link *tail;
};

/**
 * @brief Structure of the node inserted into waitqueue, which contains cjthread timer.
 */
struct WaitqueueNode {
    struct Link listNode;
    struct WaitqueueInner *queue;
    struct CJThread *cjthread;
    int *timeout;
    TimerHandle timer;
};

/**
 * @brief Create a new waitqueue node
 * @param  cjthread         [IN]  cjthread which to create waitqueue node
 * @param  queue            [IN]  waitqueue
 * @retval If the operation succeeds, the node pointer is returned.
 * If the operation fails, the node pointer is returned.
 */
struct WaitqueueNode *WaitqueueNodeNew(struct CJThread *cjthread, struct WaitqueueInner *queue);

/**
 * @brief Unlock the waiting queue.
 * @par Unlock the waiting queue.
 * @param  arg              [IN]  arg
 * @param  handle           [IN]  cjthread handle
 * @retval If the operation is successful, 0 is returned. If the operation fails, an error code is returned.
 */
int WaitqueueParkUnlock(void *arg, CJThreadHandle handle);

/**
 * @brief Wakes up a specified cjthread from the wait queue.
 * @par Wakes up a specified cjthread from the wait queue.
 * @param  arg              [IN]  arg
 * @retval If the operation is successful, 0 is returned. If the operation fails, an error code is returned.
 */
void WaitqueueCallback(void *arg);

/**
 * @brief Adds a specified cjthread to the queue.
 * @par After checking the callback function, add a specified cjthread to the queue,
 * obtain the current cjthread, and create an sp node.
 * @param  queue            [IN]  queue
 * @param  callbackFunc     [IN]  callback function
 * @param  arg              [IN]  arg
 * @param  sp               [IN]  pointer to a node
 * @param  head             [IN]  indicates whether to insert the queue head.
 * @retval If the operation is successful, 0 is returned. If the operation fails, an error code is returned.
 */
int WaitqueuePush(struct WaitqueueInner *queue, WqCallbackFunc callbackFunc,
                  void *arg, struct WaitqueueNode **sp, bool head);

/**
 * @brief Execute the callback function and check the result.
 * @par Execute the callback function and check the result.
 * @param  callbackFunc     [IN]  callback function
 * @param  arg              [IN]  arg
 * @retval If the operation is successful, 0 is returned. If the operation fails, an error code is returned.
 */
int WaitqueueCallbackCheck(WqCallbackFunc callbackFunc, void *arg);

/**
 * @brief Check the parameters before waking up the cjthread
 * @par Check the parameters before waking up the cjthread
 * @param  queue            [IN]  queue
 * @param  callbackFunc     [IN]  callback function
 * @param  arg              [IN]  arg
 * @retval If the operation is successful, 0 is returned. If the operation fails, an error code is returned.
 */
int WaitqueueWakePreparation(const struct WaitqueueInner *queue, WqCallbackFunc callbackFunc,
                             void *arg);

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif
#endif /* MRT_WAITQUEUE_IMPL_H */
