// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_SCHEDULE_RENAME_PART2_H
#define MRT_SCHEDULE_RENAME_PART2_H


#ifdef CANGJIE

/* sema */
#define SemaNew                                  CJ_SemaNew
#define SemaTryAcquire                           CJ_SemaTryAcquire
#define SemaAcquire                              CJ_SemaAcquire
#define SemaRelease                              CJ_SemaRelease
#define SemaDelete                               CJ_SemaDelete
#define SemaGetValue                             CJ_SemaGetValue

/* rawsock */
#define RawsockInit                               CJ_MRT_RawsockInit
#define RawsockRegisterSocketHooks                CJ_RawsockRegisterSocketHooks
#define RawsockCreate                             CJ_RawsockCreate
#define RawsockBind                               CJ_RawsockBind
#define RawsockListen                             CJ_RawsockListen
#define RawsockAccept                             CJ_RawsockAccept
#define RawsockBindConnect                        CJ_RawsockBindConnect
#define RawsockConnect                            CJ_RawsockConnect
#define RawsockWait                               CJ_RawsockWait
#define RawsockWaitSend                           CJ_RawsockWaitSend
#define RawsockWaitRecv                           CJ_RawsockWaitRecv
#define RawsockDisconnect                         CJ_RawsockDisconnect
/* windows api */
#define RawsockIsConnectionOriented               CJ_RawsockIsConnectionOriented
#define RawsockGetLocalDefaultAddr                CJ_RawsockGetLocalDefaultAddr
#define RawsockAcceptCoreInlock                   CJ_RawsockAcceptCoreInlock
#define RawsockConnectOriented                    CJ_RawsockConnectOriented

/* trace */
#define TraceFini                                 CJ_TraceFini
#define TraceStart                                CJ_TraceStart
#define TraceFullQueue                            CJ_TraceFullQueue
#define TraceParkUnlock                           CJ_TraceParkUnlock
#define TraceStop                                 CJ_TraceStop
#define TraceByte                                 CJ_TraceByte
#define TraceUint64                               CJ_TraceUint64
#define TraceFlush                                CJ_TraceFlush
#define TraceStackId                              CJ_TraceStackId
#define TraceBufAquire                            CJ_TraceBufAquire
#define TraceBufRelease                           CJ_TraceBufRelease
#define TraceEvent                                CJ_TraceEvent
#define TraceStackTableDump                       CJ_TraceStackTableDump
#define TraceDump                                 CJ_TraceDump
#define TraceReaderAvailable                      CJ_TraceReaderAvailable
#define TraceReaderGet                            CJ_TraceReaderGet
#define TraceRegister                             CJ_TraceRegister
#define TraceDeregister                           CJ_TraceDeregister

#endif

#endif // MRT_SCHEDULE_RENAME_PART2_H
