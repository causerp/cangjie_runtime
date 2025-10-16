/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 macro package std.deriving

// this is required to trigger static init
// do not remove unless ensued that it can be done without breaking it
import std.deriving.builtins
