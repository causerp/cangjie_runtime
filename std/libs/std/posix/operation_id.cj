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
 * This is a library for posix.
 */

package std.posix

/**
 * The connection is disconnected; the default action is terminated.
 */
@Deprecated
public const SIGHUP: Int32 = 0x1

/**
 * Terminal interrupt character; default action termination.
 */
@Deprecated
public const SIGINT: Int32 = 0x2

/**
 * Terminal exit character; Default action termination + core.
 */
@Deprecated
public const SIGQUIT: Int32 = 0x3

/**
 * Invalid hardware instruction. Default action termination + core.
 */
@Deprecated
public const SIGILL: Int32 = 0x4

/**
 * Hardware fault; default action terminated + core.
 */
@Deprecated
public const SIGTRAP: Int32 = 0x5

/**
 * Abnormal termination; default action termination + core.
 */
@Deprecated
public const SIGABRT: Int32 = 0x6

/**
 * Hardware fault; default action terminated + core.
 */
@Deprecated
public const SIGIOT: Int32 = 0x6

/**
 * Hardware fault; default action terminated + core.
 */
@When[os != "macOS"]
@Deprecated
public const SIGBUS: Int32 = 0x7
@When[os == "macOS"]
@Deprecated
public const SIGBUS: Int32 = 0xA

/**
 * Arithmetic error; Default action termination + core.
 */
@Deprecated
public const SIGFPE: Int32 = 0x8

/**
 * Terminate;Default Action Terminate.
 */
@Deprecated
public const SIGKILL: Int32 = 0x9

/**
 * User Defined Signal; Default Action Termination.
 */
@When[os != "macOS"]
@Deprecated
public const SIGUSR1: Int32 = 0xA
@When[os == "macOS"]
@Deprecated
public const SIGUSR1: Int32 = 0x1E

/**
 * Invalid memory reference; Default action termination + core.
 */
@Deprecated
public const SIGSEGV: Int32 = 0xB

/**
 * User Defined Signal; Default Action Termination.
 */
@When[os != "macOS"]
@Deprecated
public const SIGUSR2: Int32 = 0xC
@When[os == "macOS"]
@Deprecated
public const SIGUSR2: Int32 = 0x1F

/**
 * Pipelines written to unread processes; default action terminates.
 */
@Deprecated
public const SIGPIPE: Int32 = 0xD

/**
 * The timer expires; the default action is terminated.
 */
@Deprecated
public const SIGALRM: Int32 = 0xE

/**
 * Terminate;Default Action Terminate.
 */
@Deprecated
public const SIGTERM: Int32 = 0xF

/**
 * Coprocessor stack failure; default action terminated.
 */
@When[os != "macOS"]
@Deprecated
public const SIGSTKFLT: Int32 = 0x10

/**
 * Subprocess status changes; default action ignored.
 */
@When[os != "macOS"]
@Deprecated
public const SIGCHLD: Int32 = 0x11
@When[os == "macOS"]
@Deprecated
public const SIGCHLD: Int32 = 0x14

/**
 * Continuation of the suspension process; Default Action Continue/Ignore.
 */
@When[os != "macOS"]
@Deprecated
public const SIGCONT: Int32 = 0x12
@When[os == "macOS"]
@Deprecated
public const SIGCONT: Int32 = 0x13

/**
 * Stop;Default Action Stop.
 */
@When[os != "macOS"]
@Deprecated
public const SIGSTOP: Int32 = 0x13
@When[os == "macOS"]
@Deprecated
public const SIGSTOP: Int32 = 0x11

/**
 * Terminal stop symbol; The default action stops the process.
 */
@When[os != "macOS"]
@Deprecated
public const SIGTSTP: Int32 = 0x14
@When[os == "macOS"]
@Deprecated
public const SIGTSTP: Int32 = 0x12

/**
 * Background read control tty; the default action stops the process.
 */
@Deprecated
public const SIGTTIN: Int32 = 0x15

/**
 * Background write control tty; the default action stops the process.
 */
@Deprecated
public const SIGTTOU: Int32 = 0x16

/**
 * Emergency (socket); default action ignored.
 */
@When[os != "macOS"]
@Deprecated
public const SIGURG: Int32 = 0x17
@When[os == "macOS"]
@Deprecated
public const SIGURG: Int32 = 0x10

/**
 * The CPU usage exceeds the upper limit. Default Action Termination or Termination + Core.
 */
@Deprecated
public const SIGXCPU: Int32 = 0x18

/**
 * The file length exceeds the upper limit. Default Action Termination or Termination + Core.
 */
@Deprecated
public const SIGXFSZ: Int32 = 0x19

/**
 * Virtual Time Alarm; Default Action Terminated.
 */
@Deprecated
public const SIGVTALRM: Int32 = 0x1A

/**
 * Summary Timeout; Default Action Terminated.
 */
@Deprecated
public const SIGPROF: Int32 = 0x1B

/**
 * Terminal window size changes; default action ignored.
 */
@Deprecated
public const SIGWINCH: Int32 = 0x1C

/**
 * Asynchronous IO; Default Action Terminate/Ignore.
 */
@When[os != "macOS"]
@Deprecated
public const SIGIO: Int32 = 0x1D
@When[os == "macOS"]
@Deprecated
public const SIGIO: Int32 = 0x17

/**
 * The power supply fails or restarts. Default Action Terminate/Ignore.
 */
@When[os != "macOS"]
@Deprecated
public const SIGPWR: Int32 = 0x1E

/**
 * Invalid system call; Default action termination + core.
 */
@When[os != "macOS"]
@Deprecated
public const SIGSYS: Int32 = 0x1F
@When[os == "macOS"]
@Deprecated
public const SIGSYS: Int32 = 0xC

/**
 * Obtain the user group ID.
 * Binding POSIX API is [dup2](https://man7.org/linux/man-pages/man2/getgid.2.html).
 *
 * @return the user group ID.
 *
 * @since 0.18.2
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public func getgid(): UInt32 {
    return unsafe { CJ_OS_Getgid() }
}

/**
 * Returns the real user ID of the calling process.
 * Binding POSIX API is [dup2](https://man7.org/linux/man-pages/man2/getuid.2.html).
 *
 * @return the user id.
 *
 * @since 0.18.2
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public func getuid(): UInt32 {
    return unsafe { CJ_OS_Getuid() }
}

/**
 * Sets the effective group ID of the calling process,requires appropriate permissions.
 * Binding POSIX API is [setgid](https://man7.org/linux/man-pages/man2/setgid.2.html).
 *
 * @param id to be set.
 * @return if the setting is successful, 0 is returned. If the setting fails, -1 is returned.
 *
 * @since 0.18.2
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public func setgid(id: UInt32): Int32 {
    return unsafe { CJ_OS_Setgid(id) }
}

/**
 * Sets the effective user ID of the calling process,requires appropriate permissions.
 * Binding POSIX API is [setuid](https://man7.org/linux/man-pages/man2/setuid.2.html).
 *
 * @param id to be set.
 * @return if the setting is successful, 0 is returned. If the setting fails, -1 is returned.
 *
 * @since 0.18.2
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public func setuid(id: UInt32): Int32 {
    return unsafe { CJ_OS_Setuid(id) }
}

/**
 * Returns the PGID of the process specified by pid.If pid is zero, the process ID of the calling process is used.
 * Binding POSIX API is [getpgid](https://man7.org/linux/man-pages/man2/getpgid.2.html).
 *
 * @param pid process id.
 * @return if the execution is successful, the process group ID is returned. If an error occurs, -1 is returned.
 *
 * @since 0.18.2
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public func getpgid(pid: Int32): Int32 {
    return unsafe { CJ_OS_Getpgid(pid) }
}

/**
 * Function description getgroup() is used to get the code of the group to which the current user belongs. The value of size is list.
 * Number of gid_ts that [] can hold. If the parameter size has a value of zero, this function returns only
 * Indicates the number of groups to which a user belongs.
 * Binding POSIX API is [getgroups](https://man7.org/linux/man-pages/man2/getgroups.2.html).
 *
 * @param size number of data stored in the @p gidArray.
 * @param gidArray stores group information.
 * @return the group identifier, or -1 for errors.
 *
 * @since 0.18.2
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public unsafe func getgroups(size: Int32, gidArray: CPointer<UInt32>): Int32 {
    return CJ_OS_Getgroups(size, gidArray)
}

/**
 * Returns the process ID (PID) of the calling process.
 * Binding POSIX API is [getpid](https://man7.org/linux/man-pages/man2/getpid.2.html).
 *
 * @return obtain the current process ID.
 *
 * @since 0.18.2
 */
@When[os == "Linux" || os == "Windows" || os == "macOS"]
@Deprecated
public func getpid(): Int32 {
    return unsafe { CJ_OS_Getpid() }
}

/**
 * Returns the process ID of the parent of the calling process.
 * Binding POSIX API is [getppid](https://man7.org/linux/man-pages/man2/getppid.2.html).
 *
 * @return obtain the ID of the current parent process.
 *
 * @since 0.18.2
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public func getppid(): Int32 {
    return unsafe { CJ_OS_Getppid() }
}

/**
 * Function description getpgrp() is used to get the ID of the group to which the current process belongs.
 * This function is equivalent to callinggetpgid(0);The return value returns the ID of the group to which the current process belongs.
 * Binding POSIX API is [getpgrp](https://man7.org/linux/man-pages/man2/getpgrp.2.html).
 *
 * @return obtains the ID of the group to which the current process belongs.
 *
 * @since 0.18.2
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public func getpgrp(): Int32 {
    return unsafe { CJ_OS_Getpgrp() }
}

/**
 * Function description setpgrp() sets the group ID to which the current process belongs to the process ID of the current process.
 * This function is equivalent to calling setpgid(0, 0).
 * Binding POSIX API is [setpgrp](https://man7.org/linux/man-pages/man2/setpgrp.2.html).
 *
 * @return if the operation is successful, the group ID is returned. If there is an error, -1 is returned.
 *
 * @since 0.18.2
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public func setpgrp(): Int32 {
    return unsafe { CJ_OS_Setpgrp() }
}

/**
 * Function description setpgid() sets the group ID specified by the parameter pid to the group ID specified by the parameter pgid.
 * If the value of pid is 0,the group ID of the current process is used.
 * Binding POSIX API is [setpgid](https://man7.org/linux/man-pages/man2/setpgid.2.html).
 *
 * @param pid process id.
 * @param pgrp Process group ID.
 * @return if the operation is successful, the group ID is returned. If there is an error, -1 is returned.
 *
 * @since 0.18.2
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public func setpgid(pid: Int32, pgrp: Int32): Int32 {
    return unsafe { CJ_OS_Setpgid(pid, pgrp) }
}

/**
 * Change the priority of the current thread.
 * Only the super user can use a negative inc value, which indicates that the priority is first and the process executes faster.
 * Binding POSIX API is [nice](https://man7.org/linux/man-pages/man2/nice.2.html).
 *
 * @param inc Priority of the current process,the range of the nice value is +19 (low priority) to -20.
 * @return on success, the new nice value is returned (but see NOTES below),on error, -1 is returned, and errno is set to indicate the error.
 * inc returns the maximum value 19 when the value is greater than 19.
 *
 * @since 0.18.2
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public func nice(inc: Int32): Int32 {
    return unsafe { CJ_OS_Nice(inc) }
}

/**
 * System call can be used to send any signal to any process group or process.
 * If pid is positive, then signal sig is sent to the process with the ID specified by pid.
 * If pid equals 0, then sig is sent to every process in the process group of the calling process.
 * If pid equals -1, then sig is sent to every process for which the calling process has permission to send signals,
 * except for process 1 (init), but see below.
 * If pid is less than -1, then sig is sent to every process in the process group whose ID is -pid.
 * Binding POSIX API is [kill](https://man7.org/linux/man-pages/man2/kill.2.html).
 *
 * @param pid Process ID.
 * @param sig indicates the signal ID
 * @return if the execution is successful, 0 is returned. if there is an error, -1 is returned.
 *
 * @since 0.18.2
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public func kill(pid: Int32, sig: Int32): Int32 {
    return unsafe { CJ_OS_Kill(pid, sig) }
}

/**
 * Sends the signal sig to the process group pgrp. If pgrp is 0, killpg() sends the signal to the calling process's process group.
 * Binding POSIX API is [killpg](https://man7.org/linux/man-pages/man2/killpg.2.html).
 *
 * @param pgid group ID
 * @param sig indicates the signal ID.
 * @return if the execution is successful, 0 is returned. if there is an error, -1 is returned.
 *
 * @since 0.18.2
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public func killpg(pgid: Int32, sig: Int32): Int32 {
    return unsafe { CJ_OS_Killpg(pgid, sig) }
}
