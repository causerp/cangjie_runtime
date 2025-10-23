/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.runtime

import std.sync.*
import std.collection.*

@When[backend == "cjnative"]
@Intrinsic
func intrinsicRefEqFunc<A,R>(a: (A)->R, b: (A)->R): Bool

/**
 * Check Whether two functions are the same
 */
@When[backend == "cjnative"]
func refEq<A,R>(a: (A)->R, b: (A)->R): Bool {
    return intrinsicRefEqFunc(a, b)
}

@When[os != "Windows"]
public type SignalHandlerFunc = (Int32) -> Bool

@When[os != "Windows"]
private let mtx = Mutex()

@When[os != "Windows"]
class SignalManager {
    static const MAX_SIG_NUM: Int32 = 32
    static let sigSlot = Array<ArrayList<SignalHandlerFunc>>(Int64(MAX_SIG_NUM), { _ => ArrayList<SignalHandlerFunc>()})
    // This memory allocation is globally unique and will only be released along with the program upon termination.
    static let ptrAction = LibC.malloc<SignalAction>(count: 1)
    static init() {
        let action = SignalAction(signalHandler)
        unsafe {
            ptrAction.write(action)
        }
    }
}

/**
 * Provides a way to register signal handlers in Cangjie.
 * It uses a mutex to ensure thread safety when accessing the signal slots. 
 */
@When[os != "Windows"]
public func registerSignalHandler(sig: Signal, handler: SignalHandlerFunc) {
    if (sig.value <= 0 || sig.value >= SignalManager.MAX_SIG_NUM) {
        throw IllegalArgumentException("Signal value must > 0 and < ${SignalManager.MAX_SIG_NUM}.")
    }
    let slot = SignalManager.sigSlot[Int64(sig.value)]
    synchronized(mtx) {
        if (slot.size == 0) {
            regSigChain(sig)
        }
        for (i in 0..slot.size) {
            if (refEq<Int32, Bool>(slot[i], handler)) {
                return
            }
        }
        slot.add(handler)
    }
}

/**
 * Provides a way to unregister signal handlers in Cangjie.
 * It uses a mutex to ensure thread safety when accessing the signal slots. 
 */
@When[os != "Windows"]
public func unregisterSignalHandler(sig: Signal, handler: SignalHandlerFunc) {
    if (sig.value <= 0 || sig.value >= SignalManager.MAX_SIG_NUM) {
        throw IllegalArgumentException("Signal value must > 0 and < ${SignalManager.MAX_SIG_NUM}.")
    }
    let slot = SignalManager.sigSlot[Int64(sig.value)]
    synchronized(mtx) {
        slot.removeIf({f => refEq<Int32, Bool>(f, handler)})
        if (slot.size == 0) {
            unregSigChain(sig)
        }
    }
}

/**
 * Provides a way to reset signal handlers in Cangjie.
 * It uses a mutex to ensure thread safety when accessing the signal slots. 
 */
@When[os != "Windows"]
public func resetSignalHandler(sigs: Array<Signal>): Unit {
    synchronized(mtx) {
        if (sigs.size == 0) {
            for (i in 0..SignalManager.sigSlot.size) {
                if (!SignalManager.sigSlot[i].isEmpty()) {
                    SignalManager.sigSlot[i].clear()
                    unregSigChain(Signal(Int32(i), ""))
                }
            }
        } else {
            for (sig in sigs) {
                if (sig.value <= 0 || sig.value >= SignalManager.MAX_SIG_NUM) {
                    throw IllegalArgumentException("Signal value must > 0 and < ${SignalManager.MAX_SIG_NUM}.")
                }
                SignalManager.sigSlot[Int64(sig.value)].clear()
                unregSigChain(sig)
            }
        }
    }
}

@When[os != "Windows"]
@C
func signalHandler(sig: Int32, _: CPointer<Unit>, _: CPointer<Unit>): Bool {
    if (sig <= 0 || sig >= SignalManager.MAX_SIG_NUM) {
        return false
    }
    let slot = SignalManager.sigSlot[Int64(sig)]
    synchronized(mtx) {
        for (fn in slot) {
            let result = fn(sig)
            if (result) {
                return true
            }
        }
    }
    return false
}

@When[os != "Windows"]
func regSigChain(sig: Signal) {
    unsafe {
        CJ_MCC_AddSignalHandler(sig.value, SignalManager.ptrAction)
    }
}

@When[os != "Windows"]
func unregSigChain(sig: Signal) {
    unsafe {
        CJ_MCC_RemoveSignalHandler(sig.value, signalHandler)
    }
}

@When[os != "Windows"]
type SigHandlerCFunc = CFunc<(Int32, CPointer<Unit>, CPointer<Unit>) -> Bool>

@When[os != "Windows"]
@C
struct SignalAction {
    let saHandler: SigHandlerCFunc
    let scMask = 0u64
    let scFlags = 0u64
    init(fn: SigHandlerCFunc) {
        saHandler = fn
    }
}

@When[os != "Windows"]
foreign func CJ_MCC_AddSignalHandler(signal: Int32, sa: CPointer<SignalAction>): Unit

@When[os != "Windows"]
foreign func CJ_MCC_RemoveSignalHandler(signal: Int32, fn: SigHandlerCFunc): Unit

@When[os != "Windows"]
public class Signal {
    public static const SIGHUP = Signal(0x1, "hangup")

    public static const SIGINT = Signal(0x2, "interrupt")

    public static const SIGQUIT = Signal(0x3, "quit")

    public static const SIGTRAP = Signal(0x5, "trace/breakpoint trap")

    public static const SIGALRM = Signal(0xe, "alarm clock")

    public static const SIGTERM = Signal(0xf, "terminated")

    let _value: Int32
    let _comment: String

    public const init(value: Int32, comment: String) {
        this._value = value
        this._comment = comment
    }

    public prop value: Int32 {
        get() {
            this._value
        }
    }
}