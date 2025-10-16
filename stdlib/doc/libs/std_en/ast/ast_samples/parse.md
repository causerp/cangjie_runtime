# Example of Parsing Cangjie Source Code into AST Objects

## Example of Using parseDecl Function to Parse Cangjie Source Code into Decl Object

Here is a class named Data:

```text
class Data {
    var a: Int32
    init(a_: Int32) {
        a = a_
    }
}
```

Using the parsing function to convert the above code into a Decl object, the code is shown below:

<!-- verify -->

```cangjie
import std.ast.*

main() {
    let input: Tokens = quote(
        class Data {
            var a: Int32
            init(a_: Int32) {
                a = a_
            }
        }
    )
    let decl = parseDecl(input) // Obtain a Decl declaration node
    var classDecl = match (decl as ClassDecl) { // The specific type of decl is ClassDecl, perform type conversion.
        case Some(v) => v
        case None => throw Exception()
    }
    classDecl.dump()
}
```

Execution result:

```text
ClassDecl {
  -keyword: Token {
    value: "class"
    kind: CLASS
    pos: 5: 9
  }
  -identifier: Token {
    value: "Data"
    kind: IDENTIFIER
    pos: 5: 15
  }
  -body: Body {
    -decls: 0, VarDecl {
      -keyword: Token {
        value: "var"
        kind: VAR
        pos: 6: 13
      }
      -identifier: Token {
        value: "a"
        kind: IDENTIFIER
        pos: 6: 17
      }
      -declType: PrimitiveType {
        -keyword: Token {
          value: "Int32"
          kind: INT32
          pos: 6: 20
        }
      }
    }
    -decls: 1, FuncDecl {
      -keyword: Token {
        value: "init"
        kind: INIT
        pos: 7: 13
      }
      -identifier: Token {
        value: "init"
        kind: IDENTIFIER
        pos: 7: 13
      }
      -funcParams: 0, FuncParam {
        -identifier: Token {
          value: "a_"
          kind: IDENTIFIER
          pos: 7: 18
        }
        -colon: Token {
          value: ":"
          kind: COLON
          pos: 7: 20
        }
        -paramType: PrimitiveType {
          -keyword: Token {
            value: "Int32"
            kind: INT32
            pos: 7: 22
          }
        }
      }
      -block: Block {
        -nodes: 0, AssignExpr {
          -leftExpr: RefExpr {
            -identifier: Token {
              value: "a"
              kind: IDENTIFIER
              pos: 8: 17
            }
          }
          -assign: Token {
            value: "="
            kind: ASSIGN
            pos: 8: 19
          }
          -rightExpr: RefExpr {
            -identifier: Token {
              value: "a_"
              kind: IDENTIFIER
              pos: 8: 21
            }
          }
        }
      }
    }
  }
}
```

## Example of Using parseProgram Function to Parse Cangjie Source Code into Program Object

The content of the Cangjie source file test_macro_define.cj to be parsed is as follows:

```text
/**
* This cj file serves as input parameter for testing parseProgram();
**/
macro package m

internal import std.ast.*
internal import base as mybase

public macro M(input: Tokens) {
    return input
}
```

Using the parseProgram function to parse the above code into a Program node object, the code is shown below:

<!-- verify -->

```cangjie
internal import std.ast.*
internal import std.fs.*
internal import std.io.*

main() {
    let path: String = "./test_macro_define.cj"
    let file: File = File(path, Read)
    let reader: StringReader<File> = StringReader(file)
    let code: String = reader.readToEnd() // Read source file content as string

    let tokens: Tokens = cangjieLex(code)
    let fileNode = parseProgram(tokens) // Parse into Program node
    fileNode.dump()

    return 0
}
```

Execution result:

```text
Program {
  -packageHeader: PackageHeader {
      -keywordM: Token {
        value: "macro"
        kind: MACRO
      }
      -keywordP: Token {
        value: "package"
        kind: PACKAGE
      }
      -packageIdentifier: Token {
        value: "m"
        kind: IDENTIFIER
      }
    }
  -importLists: 0, ImportList {
    -modifier: Token {
      value: "internal"
      kind: INTERNAL
    }
    -keywordI: Token {
      value: "import"
      kind: IMPORT
    }
    -importKind: All
    prefixPath: 0: Token {
      value: "std"
      kind: IDENTIFIER
    }
    prefixPath: 1: Token {
      value: "ast"
      kind: IDENTIFIER
    }
    -identifier: Token {
      value: "*"
      kind: MUL
    }
  }
  -importLists: 1, ImportList {
    -modifier: Token {
      value: "internal"
      kind: INTERNAL
    }
    -keywordI: Token {
      value: "import"
      kind: IMPORT
    }
    -importKind: Alias
    -identifier: Token {
      value: "base"
      kind: IDENTIFIER
    }
    -importAlias 0: Token {
      value: "as"
      kind: AS
    }
    -importAlias 1: Token {
      value: "mybase"
      kind: IDENTIFIER
    }
  }
  -decls: 0, MacroDecl {
    -modifiers: 0, Modifier {
      -keyword: Token {
        value: "public"
        kind: PUBLIC
      }
    }
    -keyword: Token {
      value: "macro"
      kind: MACRO
    }
    -identifier: Token {
      value: "M"
      kind: IDENTIFIER
    }
    -funcParams: 0, FuncParam {
      -identifier: Token {
        value: "input"
        kind: IDENTIFIER
      }
      -colon: Token {
        value: ":"
        kind: COLON
      }
      -paramType: RefType {
        -identifier: Token {
          value: "Tokens"
          kind: IDENTIFIER
        }
      }
    }
    -block: Block {
      -nodes: 0, ReturnExpr {
        -keyword: Token {
          value: "return"
          kind: RETURN
        }
        -expr: RefExpr {
          -identifier: Token {
            value: "input"
            kind: IDENTIFIER
          }
        }
      }
    }
  }
}
```