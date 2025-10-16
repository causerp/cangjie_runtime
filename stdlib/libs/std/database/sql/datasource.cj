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
 * This file defines the Datasource interface.
 */

package std.database.sql

/**
 * This Datasource interface is used to process the connection to the database.
 *
 * @since 0.32.3
 */
public interface Datasource <: Resource {

    /**
     * setting database driver connection options, common keys are predefined in SqlOption.
     *
     * @since 0.40.1
     */
    func setOption(key: String, value: String): Unit

    /**
     * Returns an available connection.
     *
     * @return a datasource connection instance.
     *
     * @since 0.32.3
     */
    func connect(): Connection
}
