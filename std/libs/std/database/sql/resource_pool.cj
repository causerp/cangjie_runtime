/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.database.sql

import std.collection.{Map, ArrayList}
import std.collection.concurrent.LinkedBlockingQueue
import std.time.DateTime
import std.sync.{Timer, CatchupStyle, AtomicBool, Mutex}

class ResourcePool<T> <: Pool<T> & Equatable<ResourcePool<T>> {
    let mux = Mutex()
    let idleEntry: LinkedBlockingQueue<Entry<T>>
    var options: Options<T>
    var ticker: Timer
    var entryCount: Int32
    var isclosed = AtomicBool(false)

    init(options: Options<T>) {
        this.options = options

        idleEntry = LinkedBlockingQueue<Entry<T>>(Int64(options.maxSize))
        entryCount = options.maxIdleSize
        ticker = Timer.once(Duration.hour) {=> ()}
        backgroundCheckIdleLife()
    }

    /**
     * Maximum number of connections in the connection pool. If the value is less than or equal to 0, the value is Int32.Max.
     * If the configured value is smaller than the current value, the setting takes effect only after idle connections are reclaimed.
     */
    mut prop maxSize: Int32 {
        get() {
            options.maxSize
        }
        set(value) {
            if (value <= 0) {
                options.maxSize = Int32.Max
            } else {
                options.maxSize = value
            }
        }
    }
    /**
     * Maximum number of idle connections. If the number of idle connections exceeds this value, the excess connections are disconnected.
     * If the value is less than or equal to 0, Int32.Max is used.
     */
    mut prop maxIdleSize: Int32 {
        get() {
            options.maxIdleSize
        }
        set(value) {
            if (value <= 0) {
                options.maxIdleSize = Int32.Max
            } else {
                options.maxIdleSize = value
            }
        }
    }

    func backgroundCheckIdleLife() {
        ticker.cancel()
        ticker = Timer.repeat(Duration.second, options.keepaliveTime, checkIdleLife, style: Delay)
    }

    func checkIdleLife(): Unit {
        let idleCount: Int64
        synchronized(mux) {
            idleCount = idleEntry.size
        }
        let list = ArrayList<Entry<T>>()

        for (_ in 0..idleCount) {
            let item = idleEntry.tryRemove()
            match (item) {
                case Some(v) => appendLegalIdleEntry(v, idleCount, list)
                case _ =>
                    eprintln("can not try get idle entry")
                    break
            }
        }
        for (entry in list) {
            this.release(entry)
        }
    }

    func getIdleEntry(timeout: Duration): Entry<T> {
        var item = idleEntry.remove(timeout)

        match (item) {
            case Some(v) => return v
            case None => throw SqlException("Acquired entries exceed maxSize(${maxSize}).")
        }
    }

    public func acquire(timeout: Duration): Option<Entry<T>> {
        mux.lock()
        if (idleEntry.size == 0 && entryCount < options.maxSize) {
            entryCount++
            mux.unlock()
            var value = options.constructor()
            match (value) {
                case Some(v) =>
                    let entry = Entry<T>(this, v)
                    return entry
                case None => throw SqlException("Constructor entry failed.")
            }
        }
        mux.unlock()
        return getIdleEntry(timeout)
    }

    public func release(entry: Entry<T>): Option<Unit> {
        match (entry.pool as ResourcePool<T>) {
            case Some(p) =>
                if (p != this) {
                    throw SqlException("The entry is owned by another pool.")
                }
            case None => throw SqlException("The entry is not owned by any pool.")
        }

        if (DateTime.now().toUnixTimeStamp() - entry.creationTime > options.maxLifeTime) {
            this.discard(entry)
        } else {
            idleEntry.add(entry)
        }
        return
    }

    public func discard(entry: Entry<T>): Option<Unit> {
        match (entry.pool as ResourcePool<T>) {
            case Some(p) =>
                if (p != this) {
                    throw SqlException("The entry is owned by another pool.")
                }
            case None => throw SqlException("The entry is not owned by any pool.")
        }
        synchronized(mux) {
            if (entryCount > 0) {
                entryCount--
            }
        }
        options.destructor(entry.value)
        return
    }

    public func isClosed(): Bool {
        return isclosed.load()
    }

    public func close(): Unit {
        if (!isclosed.compareAndSwap(false, true)) { // compareAndSwap return true if the value equal first parameter.
            return
        }
        for (_ in 0..idleEntry.size) {
            var item = idleEntry.tryRemove()
            match (item) {
                case Some(v) => this.discard(v)
                case None =>
                    eprintln("can not try get idle entry")
                    break
            }
        }
    }

    public operator func !=(rhs: ResourcePool<T>): Bool {
        return !(this == rhs)
    }

    public operator func ==(rhs: ResourcePool<T>): Bool {
        return refEq(this, rhs)
    }

    func appendLegalIdleEntry(v: Entry<T>, idleCount: Int64, list: ArrayList<Entry<T>>): Unit {
        var idle = v.idleDuration()
        var discardCount = 0i32
        if ((idle > options.idleTimeout && Int32(idleCount) - discardCount > options.maxIdleSize) || (DateTime.now().
            toUnixTimeStamp() - v.creationTime > options.maxLifeTime)) {
            try {
                this.discard(v)
            } catch (e: Exception) {
                eprintln("exception ${e.message}")
            }
            discardCount++
        } else {
            list.add(v)
        }
    }
}