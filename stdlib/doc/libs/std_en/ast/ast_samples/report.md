# Custom Error Reporting Interface

The Cangjie ast package provides a custom error reporting interface [diagReport](../ast_package_api/ast_package_funcs.md#func-diagreportdiagreportlevel-tokens-string-string). This allows macro definers to generate custom error messages when parsing incoming [Tokens](../ast_package_api/ast_package_classes.md#class-tokens) and encountering erroneous [Tokens](../ast_package_api/ast_package_classes.md#class-tokens) content.

The custom error reporting interface produces output in the same format as native compiler errors, enabling users to report both `WARNING` and `ERROR` level diagnostic messages.

## Correct Usage Example

Macro definition:

```cangjie
// macro_definition.cj
macro package macro_definition

import std.ast.*

public macro testDef(input: Tokens): Tokens {
    for (i in 0..input.size) {
        if (input[i].kind == IDENTIFIER) {
            diagReport(DiagReportLevel.ERROR, input[i..(i + 1)], "This expression is not allowed to contain identifier",
                "Here is the illegal identifier")
        }
    }
    return input
}
```

Macro invocation:

```cangjie
// macro_call.cj
package macro_calling

import std.ast.*
import macro_definition.*

main(): Int64 {
    let a = @testDef(1)
    let b = @testDef(a)
    let c = @testDef(1 + a)
    return 0
}
```

Compilation commands:

```text
# First compile the macro definition file
cjc macro_definition.cj --compile-macro

# Compile the file using macros
cjc macro_call.cj -o demo
```

Error messages:

```text
error: This expression is not allowed to contain identifier
 ==> call.cj:9:22:
  |
9 |     let b = @testDef(a)
  |                      ^ Here is the illegal identifier
  |

error: This expression is not allowed to contain identifier
  ==> call.cj:10:26:
   |
10 |     let c = @testDef(1 + a)
   |                          ^ Here is the illegal identifier
   |

2 errors generated, 2 errors printed.
```

## Non-Macro Expansion Context Example

```cangjie
import std.ast.*

func A(input: Tokens) {
    diagReport(DiagReportLevel.ERROR, input, "Message", "Hint") // This call occurs in regular function A, diagReport will not actually perform any operation
}

main() {
    let tokens = quote(var a = 0)
    A(tokens)
}
```