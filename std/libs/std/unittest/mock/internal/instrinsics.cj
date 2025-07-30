/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.unittest.mock.internal

@Frozen
@Intrinsic
public unsafe func createMock<T>(handler: CallHandler): T

@Frozen
@Intrinsic
public unsafe func createSpy<T>(handler: CallHandler, objectToSpyOn: T): T
