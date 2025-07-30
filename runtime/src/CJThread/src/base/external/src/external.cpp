// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include <cstdlib>
#include "external.h"

#ifdef __cplusplus
extern "C" {
#endif

struct SchdfdManager *SchdfdManagerInit()
{
    struct SchdfdManager *schdfdManager = (struct SchdfdManager *)malloc(sizeof(SchdfdManager));
    if (schdfdManager == nullptr) {
        return nullptr;
    }
    schdfdManager->initLock = PTHREAD_MUTEX_INITIALIZER;
    for (int i = 0; i < SCHDFD_SLOTS_MAX_LAYER; i++) {
        schdfdManager->slots[i] = nullptr;
    }
    return schdfdManager;
}

void FreeSchdfdManager(struct SchdfdManager *schdfdManager)
{
    if (schdfdManager == nullptr) {
        return;
    }
    struct SchdfdFd* schdfdFd;
    auto slots = schdfdManager->slots;
    for (int i = 0; i < SCHDFD_SLOTS_MAX_LAYER; i++) {
        if (slots[i] == nullptr) {
            continue;
        }
        for (int j = 0; j < SCHDFD_SLOTS_LAYER_MAX_LINE_NUM; j++) {
            if (slots[i][j] == nullptr) {
                continue;
            }
            for (int k = 0; k < SCHDFD_SLOTS_LINE_MAX_FD_NUM; k++) {
                schdfdFd = slots[i][j][k].schdFd;
                FreeSchdfdFd(schdfdFd);
            }
            free(slots[i][j]);
            slots[i][j] = nullptr;
        }
        free(slots[i]);
        slots[i] = nullptr;
    }

    free(schdfdManager);
}

void FreeSchdfdFd(struct SchdfdFd *schdfdFd)
{
    if (schdfdFd == nullptr) {
        return;
    }
    if (schdfdFd->pd != nullptr) {
        free(schdfdFd->pd);
        schdfdFd->pd = nullptr;
    }
    free(schdfdFd);
}

#ifdef __cplusplus
}
#endif