# Arbitrary Process Operations

Below are examples of arbitrary process-related operations. Note that these examples are not supported on the Windows platform.

Code example:

<!-- run -->

```cangjie
import std.process.*

main(): Int64 {
    let echoProcess: SubProcess = launch("sleep", "10s")
    let ofProcess: Process = findProcess(echoProcess.pid)
    println(ofProcess.pid)
    println(ofProcess.name)
    println(ofProcess.command)
    ofProcess.terminate(force: true)
    return 0
}
```

Possible execution results:

```text
70753
sleep
sleep
```