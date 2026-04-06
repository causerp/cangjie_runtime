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
#include <locale.h>
#include <stdatomic.h>

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
    double value;

#if HAS_STRTOD_L
    static locale_t cLocale = NULL;
    static atomic_int localeInitState = 0;

    if (atomic_load(&localeInitState) == 0) {
        int expected = 0;
        if (atomic_compare_exchange_strong(&localeInitState, &expected, 1)) {
            locale_t newLocale = newlocale(LC_NUMERIC_MASK, "C", (locale_t)0);
            cLocale = newLocale;
            atomic_store(&localeInitState, 2); // 2: locale initialization complete
        }
    }
    while (atomic_load(&localeInitState) == 1) {
    }
    if (cLocale != NULL) {
        value = strtod_l(str, &p, cLocale);
    } else {
        value = strtod(str, &p);
    }
#else
    value = strtod(str, &p);
#endif

    if (p == NULL || strlen(p) > 0) {
        return NULL;
    }
    double* floatNumber = (double*)malloc(sizeof(double));
    if (floatNumber == NULL) {
        return NULL;
    }
    *floatNumber = value;
    return floatNumber;
}