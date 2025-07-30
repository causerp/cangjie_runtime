// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_TRACE_IMPL_H
#define MRT_TRACE_IMPL_H

#include <pthread.h>
#include <atomic>
#include <cstdbool>
#include "list.h"
#ifdef MRT_WINDOWS
#include <windows.h>
#else
#include <dlfcn.h>
#endif

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif

/* (event type)1byte + (arg num)1byte + (time)1-8byte + (0-9) * (extra arg)1-8byte + (stackId)1-8byte = 90 */
#define TRACE_EVENT_MAXSIZE (90)
/* (event type)1byte + (arg num)1byte + (stackId)1-8byte + (PCs)1byte + frames(240) = 251 */
#define TRACE_STACK_EVENT_MAXSIZE (251)
#define TRACE_HEADER "Cangjie trace"
#define TRACE_HEADER_LENGTH (32)
#define TRACE_PATH_LENGTH (256)
#define TRACE_EFFECTIVE_EVENT (0x00ff)
#define TRACE_EFFECTIVE_ARG_NUM (0x00ff)
#define TRACE_BUF_LENGTH ((64 << 10) - sizeof(struct TraceBufHeader))
#define TRACE_UINT64_SHIFTS (7)
#define TRACE_UINT64_SHIFT_THRESHOLD (0x80)
#define TRACE_STACK_ARG_NUM (4)
#define TRACE_EXIT_STRING "CJ_CJThreadExit"
#define TRACE_RESCHED_STRING "CJ_CJThreadResched"
#define TRACE_NET_BLOCK_STRING "CJ_SchdpollWait"
#define TRACE_NET_UNBLOCK_STRING "CJ_SchdpollReady"
#define TRACE_UNBLOCK_STRING "CJ_CJThreadReady"
#define TRACE_UNKNOWN_STRING "?"
#define TRACE_RUNTIME_STRING "libcangjie-runtime.so"    /* string id is 1 */

#ifdef MRT_WINDOWS
typedef HMODULE DlHandle ;
#else
typedef void *DlHandle;
#endif

typedef void (*TraceRegisterFunc)(void);

typedef void (*TraceDeregisterFunc)(void);

/**
 * arg: trace type
 * ret: true or false
 */
typedef bool (*TraceStartFunc)(unsigned short traceType);

/**
 * ret: true or false
 */
typedef bool (*TraceStopFunc)(void);

/**
 * arg: event typ, backstack layers, mutator, number of extra arg, extra arg list
 */
typedef void (*TraceEventFunc)(TraceEvent event, int skip, void *mutator, int argNum, va_list args);

/**
 * arg: length of array
 * ret: pointer of array
 */
typedef unsigned char *(*TraceDumpFunc)(int *len);

/**
 * ret: nullptr or CJThread pointer
 */
typedef struct CJThread *(*TraceReaderGetFunc)(void);

struct TraceHooks {
    TraceDeregisterFunc traceDeregister;
    TraceStartFunc traceStart;
    TraceStopFunc traceStop;
    TraceEventFunc traceRecordEvent;
    TraceDumpFunc traceDump;
    TraceReaderGetFunc traceReaderGet;
};

struct TraceBufHeader {
    struct Dulink dulink;
    unsigned long long lastTicks;               /* last Event Occurred Event */
    int pos;                                    /* array offset */
};

struct TraceBuf {
    struct TraceBufHeader header;
    unsigned char arr[TRACE_BUF_LENGTH];        /* Path for storing trace events */
};

struct Trace {
    bool mutexInitFlag;                         /* lock creation flag. The lock is created
                                                 * only once and is destroyed when the
                                                 * schedule exits. */
    DlHandle dlHandle;                          /* trace dll handle */
    unsigned short openType;                    /* trace enable flag */
    bool shutdown;                              /* trace disable flag */
    pthread_mutex_t lock;
    /* ------------------------lock protection range-------------------- */
    bool headerWritten;
    bool footerWritten;
    unsigned long long ticksStart;
    unsigned long long ticksEnd;
    unsigned long long timeStart;
    unsigned long long timeEnd;
    struct Dulink fullBufHead;                  /* list of traceBufs to be output */
    struct Dulink freeBufHead;                  /* list of idle traceBufs */
    struct TraceBuf *reading;                   /* traceBuf of trace data being output */
    struct CJThread *reader;                    /* cjthread for outputting trace data */
    struct CJThread *stopCJThread;              /* cjthread for stop trace */
    /* ------------------------lock protection range-------------------- */
    std::atomic<int> eventCount;                /* event count */
    pthread_mutex_t bufLock;                    /* lock that protects the buf */
    struct TraceBuf *buf;                       /* global traceBuf */
    struct TraceHooks hooks;                    /* trace hooks */
    std::atomic<unsigned long long> stringId;   /* string event id */
    std::atomic<unsigned long long> stackId;    /* stack event id */
};

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif
#endif /* MRT_TRACE_IMPL_H */