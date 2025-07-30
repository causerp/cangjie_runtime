/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

/**
 * atexitCallback will be executed, when the program exits.
 */
@FastNative
foreign func CJ_CORE_AtExitCallbackListLock(): Unit

@FastNative
foreign func CJ_CORE_AtExitCallbackListUnlook(): Unit

// The node of atexitCallback function.
class AtexitCallbackNode {
    var atexitCallback: () -> Unit
    var next: ?AtexitCallbackNode = None

    init(callback: () -> Unit) {
        atexitCallback = callback
    }
}

var atexitCallbackHead: ?AtexitCallbackNode = None // atexitCallback list.
var callbacksRunningFlag: Bool = false // the flag whether callbacks is being executed

// Add an atexitCallback Function to list.
protected func CJ_CORE_AddAtexitCallback(callback: () -> Unit): Unit {
    if (callbacksRunningFlag) { // Prevent deadlock caused by calling CJ_CORE_AddAtexitCallback inside a callback function 
        return
    }

    var newNode = AtexitCallbackNode(callback)
    unsafe { CJ_CORE_AtExitCallbackListLock() }
    match (atexitCallbackHead) {
        case Some(_) => newNode.next = atexitCallbackHead
        case None => ()
    }
    atexitCallbackHead = Option<AtexitCallbackNode>.Some(newNode)
    unsafe { CJ_CORE_AtExitCallbackListUnlook() }
}

// Execute all atexitCallback functions. Reverse order of addition.
protected func CJ_CORE_ExecAtexitCallbacks(): Unit {
    if (callbacksRunningFlag) { // Prevent deadlock caused by calling CJ_CORE_ExecAtexitCallbacks inside a callback function 
        return
    }
    unsafe { CJ_CORE_AtExitCallbackListLock() }
    if (callbacksRunningFlag) { // Prevent multiple threads from calling CJ_CORE_ExecAtexitCallbacks, which causes the callback function to be executed multiple times.
        unsafe { CJ_CORE_AtExitCallbackListUnlook() }
        return
    }
    callbacksRunningFlag = true
    var currPos = atexitCallbackHead
    try {
        while (true) {
            match (currPos) {
                case Some(node) =>
                    node.atexitCallback()
                    currPos = node.next
                case None => break
            }
        }
        atexitCallbackHead = None
    } catch (t: Exception) {
        t.printStackTrace()
    } catch (t: Error) {
        t.printStackTrace()
    } finally {
        unsafe { CJ_CORE_AtExitCallbackListUnlook() }
    }
}
