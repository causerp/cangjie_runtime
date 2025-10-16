# Environment-Related Operations

## Current Process Operations

Code example:

<!-- compile -->

```cangjie
import std.env.*

main(): Int64 {
    println(getProcessId())
    println(getCommand())
    println(getCommandLine().toString())
    println(getWorkingDirectory().toString())
    atExit(printText)
    exit(0)
    return 0
}

func printText(): Unit {
    println("hello cangjie!")
}
```

Possible execution results (where "main" represents the current process execution command name, and the process exits after callback execution):

```text
28481
main
[./main]
/root/code/workpalce/cangjie
hello cangjie!
```

## Console Example

Below is a Console example that receives two pieces of user input and echoes them back to the user through standard output.

<!-- compile -->

```cangjie
import std.env.*

main() {
    getStdOut().write("Please enter message 1: ")
    var c = getStdIn().readln() // Input: Hello, what day is it today?
    var r = c.getOrThrow()
    getStdOut().writeln("Entered message 1: " + r)

    getStdOut().write("Please enter message 2: ")
    c = getStdIn().readln() // Input: Hello, what's the date today?
    r = c.getOrThrow()
    getStdOut().writeln("Entered message 2: " + r)

    return
}
```

Execution results:

```text
Please enter message 1: Hello, what day is it today?
Entered message 1: Hello, what day is it today?
Please enter message 2: Hello, what's the date today?
Entered message 2: Hello, what's the date today?
```