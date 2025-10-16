# File Information Operations

The following are examples of file information-related operations. Note that these examples are not supported on the Windows platform.

Code example:

<!-- verify -->

```cangjie
import std.posix.*

main(): Int64 {
    var result1: Bool = isType("/notdirs", S_IFDIR)
    println("result ==> ${result1}")
    var result2: Bool = isDir("/dev")
    println("result ==> ${result2}")
    var result3 = access("./oscfg.cfg", F_OK)
    println("result ==> ${result3}")
    var result4 = chmod("oscfg.cfg", UInt32(S_IXUSR))
    println("result ==> ${result4}")
    return 0
}
```

Execution results:

```text
result ==> false
result ==> true
result ==> -1
result ==> -1
```