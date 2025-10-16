# Retrieving Various System Information

Below are examples for retrieving various system information. Note that these examples are not supported on Windows platforms.

Code example:

<!-- run -->

```cangjie
import std.posix.*

main(): Int64 {
    /* System name related */
    var os_info = getos()
    println("os info ==> ${os_info}")
    var hostname = gethostname()
    println("hostname ==> ${hostname}")
    var logname: String = getlogin()
    println("logname ==> ${logname}")

    /* Program execution path related functions */
    var changePath = "/"
    var chdir_result = chdir(changePath)
    println("chdir_result ==> ${chdir_result}")
    var cwd_path: String = getcwd()
    println("cwd_path ==> ${cwd_path}")

    /* System ID related functions getpgid */
    var arr: CString = unsafe { LibC.mallocCString(" ") }
    var a: CPointer<UInt8> = arr.getChars()
    var cp: CPointer<UInt32> = CPointer<UInt32>(a)
    var getg = unsafe { getgroups(0, cp) }
    var s: String = " "
    for (_ in 0..getg) {
        s = s + "\0"
    }
    println(getg)
    var local: UInt32 = 0
    for (temp in 0..getg) {
        unsafe { local = cp.read(Int64(temp)) }
        println("getgroups ==> ${local.toString()}")
    }
    unsafe { LibC.free(arr) }
    return 0
}
```

Execution results (may vary depending on the system):

```text
Linux version 4.15.0-159-generic (buildd@lgw01-amd64-055) (gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)) #167-Ubuntu SMP Tue Sep 21 08:55:05 UTC 2021
hostname ==> e124e6e0fe0f
logname ==> root
chdir_result ==> 0
cwd_path ==> /
1
getgroups ==> 1309868064
```