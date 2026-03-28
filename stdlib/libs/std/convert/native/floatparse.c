/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

#define _GNU_SOURCE
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <locale.h>

#if defined(__APPLE__)
#include <xlocale.h>
#define HAS_STRTOD_L 1
#elif defined(__linux__)
#define HAS_STRTOD_L 1
#else
#define HAS_STRTOD_L 0
#endif

extern double* CJ_STRTOD(char* str)
{
    if (str == NULL) {
        return NULL;
    }
    char* p = NULL;
    errno = 0;
    double value;

#if HAS_STRTOD_L
    static locale_t c_locale = NULL;
    if (c_locale == NULL) {
        c_locale = newlocale(LC_NUMERIC_MASK, "C", (locale_t)0);
    }
    if (c_locale != NULL) {
        value = strtod_l(str, &p, c_locale);
    } else {
        value = strtod(str, &p);
    }
#else
    value = strtod(str, &p);
#endif

    if (p == NULL || strlen(p) > 0 || errno == ERANGE) {
        return NULL;
    }
    double* floatNumber = (double*)malloc(sizeof(double));
    if (floatNumber == NULL) {
        return NULL;
    }
    *floatNumber = value;
    return floatNumber;
}