/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.database.sql

import std.time.DateTime
import std.sync.AtomicBool

/**
 * connection pooled datasource implementation
 */
public class PooledDatasource <: Datasource {
    private static let defaultIdleTimeout = Duration.minute * 10
    private static let defaultMaxLifetime = Duration.minute * 30
    private static let defaultConnTimeout = Duration.second * 30
    private static let defaultHealthCheckPeriod = Duration.minute * 1
    private static const DEFAULT_MAX_CONNS = 10i32
    private static const DEFAULT_MAX_IDLE_CONNS = 0i32
    private let datasource: Datasource
    private var pool: ResourcePool<Connection>
    private let isclosed = AtomicBool(false)

    /**
     * Initialize a PooledDatasource with specific datasource.
     *
     * @param datasource implement by driver
     *
     * @since 0.20.4
     */
    public init(datasource: Datasource) {
        this.datasource = datasource
        func newConn(): Option<Connection> {
            var conn = datasource.connect()
            return conn
        }
        func closeConn(conn: Connection): Option<Unit> {
            conn.close()
        }
        let opt = Options<Connection>(
            DEFAULT_MAX_IDLE_CONNS,
            DEFAULT_MAX_CONNS,
            defaultIdleTimeout,
            defaultMaxLifetime,
            defaultHealthCheckPeriod,
            newConn,
            closeConn
        )
        pool = ResourcePool<Connection>(opt)
    }

    /**
     * Maximum duration for which connections are allowed to remain idle in the pool. Idle connections that exceed the duration may be reclaimed.
     *
     * @since 0.40.1
     */
    public mut prop idleTimeout: Duration {
        get() {
            pool.options.idleTimeout
        }
        set(value) {
            pool.options.idleTimeout = value
        }
    }

    /**
     * Duration since the connection was created, after which the connection is automatically closed.
     *
     * @since 0.40.1
     */
    public mut prop maxLifeTime: Duration {
        get() {
            pool.options.maxLifeTime
        }
        set(value) {
            pool.options.maxLifeTime = value
        }
    }

    /**
     * Interval for checking the health of an idle connection to prevent it from being timed out by the database or network infrastructure.
     *
     * @since 0.40.1
     */
    public mut prop keepaliveTime: Duration {
        get() {
            pool.options.keepaliveTime
        }
        set(value) {
            pool.options.keepaliveTime = value
        }
    }

    /**
     * Maximum number of connections in the connection pool. If the value is less than or equal to 0, the value is Int32.Max.
     * If the value is smaller than the current value, the setting does not take effect immediately. The setting takes effect only after idle connections are reclaimed and closed.
     *
     * @since 0.40.1
     */
    public mut prop maxSize: Int32 {
        get() {
            pool.maxSize
        }
        set(value) {
            pool.maxSize = value
        }
    }

    /**
     * Maximum number of idle connections. If the number of idle connections exceeds the value of this parameter, the idle connections will be closed. If the value is less than or equal to 0, the value is Int32.Max.
     *
     * @since 0.40.1
     */
    public mut prop maxIdleSize: Int32 {
        get() {
            pool.maxIdleSize
        }
        set(value) {
            pool.maxIdleSize = value
        }
    }

    var _connTimeout: Duration = defaultConnTimeout

    /**
     * Timeout interval for obtaining a connection from the pool. If the timeout interval expires, the system throws SqlException.
     *
     * @since 0.40.1
     */
    public mut prop connectionTimeout: Duration {
        get() {
            _connTimeout
        }
        set(value) {
            _connTimeout = value
            datasource.setOption(SqlOption.ConnectionTimeout, _connTimeout.toMilliseconds().toString())
        }
    }

    /**
     * setting database driver connection options, common keys are predefined in SqlOption.
     *
     * @since 0.40.1
     */
    public func setOption(key: String, value: String): Unit {
        datasource.setOption(key, value)
    }

    /**
     * Returns an available connection.
     *
     * @return a datasource connection instance.
     *
     * @since 0.40.1
     */
    public func connect(): Connection {
        var item = pool.acquire(_connTimeout)
        match (item) {
            case Some(entry) => return ProxyConnection(entry.value, entry)
            case None => throw SqlException("Can not acquire connection.")
        }
    }

    /**
     * Reports whether the connection is closed.
     *
     * @return true if closed, otherwise false.
     *
     * @since 0.40.1
     */
    public func isClosed(): Bool {
        return isclosed.load()
    }

    /**
     * closes all connections in the pool and rejects future connect calls. Blocks until all connections are returned to pool and closed.
     *
     * @since 0.40.1
     */
    public func close(): Unit {
        if (isclosed.load()) {
            return
        }
        isclosed.store(true)
        pool.close()
        datasource.close()
    }
}
