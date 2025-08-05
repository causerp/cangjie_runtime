# Macro With Context

The macro definitions are as follows:

```cangjie
// macro_definition.cj
macro package macro_definition

import std.ast.*

public macro Outter(input: Tokens): Tokens {
    return input
}

public macro Inner(input: Tokens): Tokens {
    assertParentContext("Outter")
    return input
}
```

The macro calls are as follows:

```cangjie
// macro_call.cj
package macro_calling

import macro_definition.*

main() {
    @Outter var a = 0
    @Inner var b = 0 // error: The macro call 'Inner' should with the surround code contains a call 'Outter'.
}
```

The compilation commands are as follows:

```text
# First compile the macro definition file
cjc macro_definition.cj --compile-macro

# Compile the file using macros
cjc macro_call.cj -o demo
```

As shown in the code above, the `Inner` macro uses the `assertParentContext` function during definition to check whether it is called within an `Outter` macro. In the given macro call scenario, since `Outter` and `Inner` don't have such a nesting relationship during invocation, the compiler will report an error.

The macro definitions are as follows:

```cangjie
// macro_definition.cj
macro package macro_definition

import std.ast.*

public macro Outter(input: Tokens): Tokens {
    let messages = getChildMessages("Inner")
    for (m in messages) {
        let value1 = m.getString("key1") // get value: "value1"
        let value2 = m.getString("key2") // get value: "value2"
        println("value1: ${value1}  value2: ${value2}")
    }
    return input
}

public macro Inner(input: Tokens): Tokens {
    assertParentContext("Outter")
    setItem("key1", "value1")
    setItem("key2", "value2")
    return input
}
```

The macro calls are as follows:

```cangjie
// macro_call.cj
import std.ast.*
import macro_definition.*

main() {
    @Outter(
        @Inner var cnt = 0
    )
    println(cnt)
}
```

The compilation commands are as follows:

```text
# First compile the macro definition file
cjc macro_definition.cj --compile-macro

# Compile the file using macros
cjc macro_call.cj -o demo
```

Compilation phase output:

```text
value1: value1  value2: value2
```

In the above code, the inner macro `Inner` sends messages to the outer macro through `setItem`; the `Outter` macro receives a set of message objects from `Inner` via the `getChildMessages` function (`Outter` can call `Inner` multiple times); finally, the corresponding values are retrieved using the message object's `getString` function.