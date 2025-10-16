# Process Information Operations

The following are examples of process information operations. Note that these examples are not supported on the Windows platform.

Code example:

<!-- run -->

```cangjie
import std.posix.*

main(): Int64 {
    var result = nice(200)
    print("${result}")
    var result1 = kill(0, SIGCHLD)
    println(result1)
    var result2 = killpg(0, SIGURG)
    println("result ==> ${result2}")
    if (isatty(0) && isatty(1) && isatty(2)) {
        print("true01 ")
    } else {
        print("false01 ")
    }
    if (isatty(-23) || isatty(4) || isatty(455) || isatty(43332)) {
        print("true02 ")
    } else {
        println("false02")
    }
    return 0
}
```

Execution result:

```text
190
result ==> 0
true01 false02
```