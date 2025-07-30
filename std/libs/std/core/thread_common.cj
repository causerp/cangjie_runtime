/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

@Intrinsic
func setThreadObject(thread: Thread): Unit

func handleException(ex: Exception): Unit {
    let exceptionHandler = Thread.exceptionHandler.load()
    try {
        match (exceptionHandler) {
            case Some(handler) => try {
                handler(Thread.currentThread, ex)
            } catch (e: Exception) {
                eprintln("Thread id: ${Thread.currentThread.id} throws an exception in the exception handler")
            }
            case None => ex.printStackTrace()
        }
    } catch (e: Exception) {
        eprintln("While handling the uncaught exception, another exception occurs.")
    } catch (e: Error) {
        eprintln("While handling the uncaught exception, another error occurs.")
    }
}

/**
 * Handler for all errors that are not caught by user code.
 * Make sure no new error/exception are thrown.
 */
func handleError(er: Error): Unit {
    try {
        match (er) {
            // No memory left for printing the stack trace, just print the error message.
            case _: OutOfMemoryError =>
                eprintln("An exception has occurred:")
                eprintln("OutOfMemoryError")
            case _ => er.printStackTrace()
        }
    } catch (e: Exception) {
        eprintln("While handling the uncaught error, another exception occurs.")
    } catch (e: Error) {
        eprintln("While handling the uncaught error, another error occurs.")
    }
}
