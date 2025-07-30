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
 * This file defines the QueryResult interface.
 */

package std.database.sql

/**
 * The QueryResult interface is used to represent the result set of a query statement.
 *
 * @since 0.32.3
 */
public interface QueryResult <: Resource {

    /**
     * Retrieves the number, types, length and other properties of this {@code QueryResult} object's columns.
     *
     * @since 0.40.1
     */
    prop columnInfos: Array<ColumnInfo>

    /**
     * To move a line backward, next() must be called once to move to the first line, the second call to move to the second line, and so on.
     * End when false is returned. If the value is false, an exception is thrown when other get functions are invoked.
     *
     * @return true if the next row exists, false otherwise.
     *
     * @since 0.32.3
     */
    @Deprecated[message: "Use memeber funcation `func next(): Bool` instead."]
    func next(values: Array<SqlDbType>): Bool

    func next(): Bool

    @When[backend == "cjnative"]
    func get<T>(index: Int64): T

    @When[backend == "cjnative"]
    func getOrNull<T>(index: Int64): ?T
}
