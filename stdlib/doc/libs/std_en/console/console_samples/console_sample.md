# Console Example

Below is a Console example that receives two pieces of user input and returns these messages verbatim to the user via standard output.

Example:

<!-- compile -->
```cangjie
import std.console.*

main() {
    Console.stdOut.write("Please enter message 1: ")
    var c = Console.stdIn.readln() // Input: Hello, what day is it today?
    var r = c.getOrThrow()
    Console.stdOut.writeln("Input message 1: " + r)

    Console.stdOut.write("Please enter message 2: ")
    c = Console.stdIn.readln() // Input: Hello, what's the date today?
    r = c.getOrThrow()
    Console.stdOut.writeln("Input message 2: " + r)

    return
}
```

Execution result:

```text
Please enter message 1: Hello, what day is it today?
Input message 1: Hello, what day is it today?
Please enter message 2: Hello, what's the date today?
Input message 2: Hello, what's the date today?
```