# Syntax Tree Node Printing

The Cangjie AST package provides a rich set of syntax tree nodes for representing Cangjie source code. Given the variety of node types and their differing attributes, confusion may arise during usage. To address this, we've implemented a `dump` function for each AST node, enabling real-time inspection of the node's complete structure and eliminating the need for repeatedly consulting this manual.

Example:

<!-- verify -->

```cangjie
import std.ast.*

main() {
    let input = quote(var demo: Int64 = 1) // Assuming the current line number is 3
    let varDecl = parseDecl(input)
    varDecl.dump()
}
```

Execution result:

```text
VarDecl {
  -keyword: Token {
    value: "var"
    kind: VAR
    pos: 3: 23
  }
  -identifier: Token {
    value: "demo"
    kind: IDENTIFIER
    pos: 3: 27
  }
  -declType: PrimitiveType {
    -keyword: Token {
      value: "Int64"
      kind: INT64
      pos: 3: 33
    }
  }
  -assign: Token {
    value: "="
    kind: ASSIGN
    pos: 3: 39
  }
  -expr: LitConstExpr {
    -literal: Token {
      value: "1"
      kind: INTEGER_LITERAL
      pos: 3: 41
    }
  }
}
```