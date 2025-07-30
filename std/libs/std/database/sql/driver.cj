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
 * This file defines the Driver interface.
 */

package std.database.sql

/**
 * The Driver interface is used to obtain datasource instance objects.
 *
 * @since 0.32.3
 */
public interface Driver {
    /**
     * driver name
     *
     * @since 0.40.1
     */
    prop name: String

    /**
     * driver version
     *
     * @since 0.40.1
     */
    prop version: String

    /**
     * Indicates whether the driver is preferred work with the connection pool.
     * If not, the connection pool is not recommended.
     *
     * @since 0.40.1
     */
    prop preferredPooling: Bool

    /**
     * Use the connectionString and opts to obtain the datasource instance.
     *
     * @param connectionString: the datasource connection string
     * @param opts: key,value tuple, the options for datasource instance, common keys are predefined in SqlOption.
     * @return a datasource instance.
     *
     * @since 0.40.1
     */
    func open(connectionString: String, opts: Array<(String, String)>): Datasource
}
