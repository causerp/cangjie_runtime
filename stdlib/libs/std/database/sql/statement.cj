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
 * This file defines the Statement interface.
 */
package std.database.sql

/**
 * The Statement interface is bound to a Connection, that is the pre-execution interface of SQL statements.
 *
 * @since 0.32.3
 */
public interface Statement <: Resource {

    /**
     * Retrieves the number, types, length and other properties of this prepared {@code Statement} object's parameters.
     *
     * @since 0.43.2
     */
    prop parameterColumnInfos: Array<ColumnInfo>

    /**
     * setOption sets a string option on this statement
     *
     */
    func setOption(key: String, value: String): Unit

    /**
     * executes a prepared statement with the given arguments and returns a UpdateResult summarizing the effect of the statement.
     *
     * @return a update result
     *
     * SqlException - An exception occurs during the execution, for example, the network is interrupted, the server times out, or the number of parameters is incorrect.
     */
    @Deprecated[message: "Use memeber funcation `func update(): UpdateResult` instead."]
    func update(params: Array<SqlDbType>): UpdateResult

    /**
     * executes a prepared query statement with the given arguments and
     * @return the query results
     *
     * SqlException - An exception occurs during the execution, for example, the network is interrupted, the server times out, or the number of parameters is incorrect.
     */
    @Deprecated[message: "Use memeber funcation `func query(): QueryResult` instead."]
    func query(params: Array<SqlDbType>): QueryResult

    @When[backend == "cjnative"]
    func set<T>(index: Int64, value: T): Unit

    func setNull(index: Int64): Unit

    func update(): UpdateResult

    func query(): QueryResult
}
