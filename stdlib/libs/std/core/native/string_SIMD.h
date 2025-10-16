/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

#ifndef CANGJIE_STRING_SIMD_H
#define CANGJIE_STRING_SIMD_H

#include <stdint.h>

int64_t FastStrstr(const uint8_t* org, int64_t ol, const uint8_t* sub, int64_t sl);

int64_t FastSize(const uint8_t* str, int64_t len);

#endif // CANGJIE_STRING_SIMD_H
