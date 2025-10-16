/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.sync

import std.time.DateTime

const MAX_TIMEOUT_NS: Int64 = 0x7FFF_FFFF_FFFF_FFFF
let MAX_TIMEOUT_DURATION: Duration = Duration.nanosecond * MAX_TIMEOUT_NS

class NotifyOnce {
    let m = Monitor()
    var notified: Bool = false

    func notify(): Unit {
        synchronized(m) {
            if (!notified) {
                notified = true
                m.notify()
            }
        }
    }

    func wait(timeout!: Duration = Duration.Max): Bool {
        if (timeout >= MAX_TIMEOUT_DURATION) {
            waitWithoutTimeout()
        } else {
            waitWithTimeout(timeout)
        }
        return notified
    }

    private func waitWithoutTimeout(): Unit {
        synchronized(m) {
            // In case of spurious-wakeup, we should put `wait` inside a while loop.
            while (!notified) {
                m.wait()
            }
        }
    }

    private func waitWithTimeout(timeout: Duration): Unit {
        var restOfTimeout = timeout
        synchronized(m) {
            // In case of spurious-wakeup, we should put `wait` inside a while loop.
            while (!notified && restOfTimeout > Duration.Zero) {
                let startTime = DateTime.nowUTC()
                m.wait(timeout: timeout)
                let endTime = DateTime.nowUTC()
                restOfTimeout -= (endTime - startTime)
            }
        }
    }
}

// Linked-list node
class SyncNode {
    let n = NotifyOnce()
    var next: ?SyncNode = None
}

// SyncList is used to achieve "unpark-all" behaviour
class SyncList {
    private var head: ?SyncNode = None
    private let m = Monitor()

    private func addWaiter(node: SyncNode) {
        node.next = head
        head = node
    }

    func waitIf(pred: () -> Bool, timeout!: Duration = Duration.Max): Unit {
        if (!pred()) {
            return
        }
        let node = SyncNode()
        synchronized(m) {
            if (!pred()) {
                return
            }
            addWaiter(node)
        }
        node.n.wait(timeout: timeout)
    }

    func waitInLock(unlock: () -> Unit, timeout!: Duration = Duration.Max): Bool {
        let node = SyncNode()
        synchronized(m) {
            addWaiter(node)
        }
        unlock()
        node.n.wait(timeout: timeout)
    }

    // Release one sema and remove it from the head of queue
    func notifyOne(): Bool {
        synchronized(m) {
            if (let Some(current) <- head) {
                head = current.next
                current.n.notify()
                return true
            }
            return false
        }
    }

    // Notify all node in linked-list which head is the first node.
    // After this method, head node would be None
    func notifyAll(): Bool {
        synchronized(m) {
            if (let None <- head) {
                return false
            }
            while (let Some(current) <- head) {
                head = current.next
                current.n.notify()
            }
            return true
        }
    }
}
