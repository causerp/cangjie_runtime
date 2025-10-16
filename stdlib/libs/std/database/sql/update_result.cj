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
 * This file defines the UpdateResult interface.
 */
package std.database.sql

/**
 * The UpdateResult interface indicates the result of executing the Insert, Update, and Delete statements.
 *
 * @since 0.32.3
 */
public interface UpdateResult {

    /**
     * Number of rows affected by the Insert, Update, and Delete statements.
     *
     * @since 0.32.3
     */
    prop rowCount: Int64

    /**
     * This is the last ROW ID automatically generated after the Insert statement is executed. 0 if not supported.
     *
     * @since 0.32.3
     */
    prop lastInsertId: Int64
}
