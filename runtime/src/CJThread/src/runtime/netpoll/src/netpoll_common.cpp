// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "log.h"
#include "securec.h"
#include "netpoll.h"
#include "netpoll_common.h"

#ifdef __cplusplus
extern "C" {
#endif

struct NetpollMetaData *NetpollMetaDataInit(void)
{
    int error;
    struct NetpollMetaData *metaData;

    metaData = (struct NetpollMetaData *)malloc(sizeof(struct NetpollMetaData));
    if (metaData == nullptr) {
        LOG_ERROR(errno, "malloc failed, size: %u", sizeof(struct NetpollMetaData));
        return nullptr;
    }
    error = memset_s(metaData, sizeof(struct NetpollMetaData), 0, sizeof(struct NetpollMetaData));
    if (error != 0) {
        LOG_ERROR(error, "memset_s failed");
        free(metaData);
        return nullptr;
    }

    return metaData;
}

#ifdef __cplusplus
}
#endif