/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

#include <stdint.h>
#include <stdlib.h>
#include <string.h>

char* CJ_TIME_GetLocalTimeZoneProperty()
{
#ifdef __android__
    FILE *fp = popen("getprop persist.sys.timezone", "r");
    if (!fp) {
        return NULL;
    }
    const size_t MAX_BUF_LENGTH = 64;
    char buf[MAX_BUF_LENGTH];
    if (fgets(buf, sizeof(buf), fp)) {
        pclose(fp);
        buf[strcspn(buf, "\n")] = '\0';
        return strdup(buf); // Need to free
    }
    pclose(fp);
#endif
    return NULL;
}