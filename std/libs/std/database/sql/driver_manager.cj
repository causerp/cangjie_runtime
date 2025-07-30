/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.database.sql

import std.collection.HashMap
import std.sync.Mutex
import std.sort.sort

/**
 * Load an Cangjie database driver based on name.
 *
 * @since 0.40.1
 */
public class DriverManager {
    static let _regMut = Mutex()
    static let _drivers = HashMap<String, Driver>()
    init() {}
    /**
     * makes a database driver available by the provided name. This method is thread safe.
     * SqlException - the driverName already registered.
     *
     * @since 0.40.1
     */
    public static func register(driverName: String, driver: Driver): Unit {
        synchronized(_regMut) {
            if (_drivers.contains(driverName)) {
                throw SqlException("Duplicate database driver (${driverName}).")
            }
            _drivers.add(driverName, driver)
        }
    }

    /**
     * Unregister the database driver by name. This method is thread safe.
     *
     * @since 0.40.1
     */
    public static func deregister(driverName: String): Unit {
        synchronized(_regMut) {
            _drivers.remove(driverName)
        }
    }

    /**
     * This command is used to obtain the registered database driver by name.
     * If the registered database driver does not exist, None is returned. This method is thread safe.
     *
     * @since 0.40.1
     */
    public static func getDriver(driverName: String): Option<Driver> {
        synchronized(_regMut) {
            _drivers.get(driverName)
        }
    }

    /**
     * Returns a list of registered database driver names (sorted). This method is thread safe.
     *
     * @since 0.40.1
     */
    public static func drivers(): Array<String> {
        synchronized(_regMut) {
            let arr = _drivers.keys().toArray()
            sort(arr, stable: true)
            return arr
        }
    }
}
