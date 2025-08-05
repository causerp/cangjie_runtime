# Subprocess Operations

The following are examples of subprocess-related operations. Note that these examples are not supported on Windows platforms.

Code example:

```cangjie
import std.process.*
import std.io.*
import std.fs.*

// Using Linux platform commands as examples. The following use case requires pre-creating the "/root/code/Process/test" directory
main(): Int64 {
    let sleepProcess: SubProcess = launch("sleep", "10s", workingDirectory: Path("/root/code/Process/test"))
    println(sleepProcess.pid)
    println(sleepProcess.name)
    println(sleepProcess.command)
    sleepProcess.terminate(force: true)
    let rtnCode = sleepProcess.wait()
    println("sleepProcess rtnCode: ${rtnCode}")

    let echoProcess: SubProcess = launch("echo", "hello cangjie!", stdOut: ProcessRedirect.Pipe)
    let strReader: StringReader<InputStream> = StringReader(echoProcess.stdOutPipe)
    println(strReader.readToEnd())
    return 0
}
```

Possible execution results:

```text
65953
sleep
sleep
sleepProcess rtnCode: 9
hello cangjie!
```