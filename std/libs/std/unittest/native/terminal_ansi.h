/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/**
 * @file
 *
 * This file declares Color related apis.
 */

#ifndef CANGJIE_STD_TERMINAL_ANSI_H
#define CANGJIE_STD_TERMINAL_ANSI_H
#include <stdbool.h>
bool EnableANSITerminal(void);
void DisableANSITerminal(void);

#endif // CANGJIE_STD_TERMINAL_ANSI_H
