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
 * This file defines the Connection interface.
 */

package std.database.sql

import std.collection.Map

/**
 * This Connection interface executes SQL statements and processes transactions.
 *
 * @since 0.32.3
 */
public interface Connection <: Resource {

    /**
     * Indicates the state of the Connection during the most recent network operation performed on the connection.
     *
     * @since 0.40.1
     */
    prop state: ConnectionState

    /**
     * Retrieves metadata about the database, common keys are predefined in SqlOption.
     *
     * @since 0.40.1
     */
    func getMetaData(): Map<String, String>

    /**
     * Return a pre-executed Statement object instance through the input SQL statement.
     *
     * @param sql : pre-executed SQL statement.
     * @return an instance object that can execute SQL statements.
     *
     * SqlException - An error occurs on the server side or the connection is interrupted.
     *
     * @since 0.40.1
     */
    func prepareStatement(sql: String): Statement

    /**
     * create a transaction instance
     * SqlException - Parallel transactions are not supported.
     *
     * @since 0.40.1
     */
    func createTransaction(): Transaction
}
