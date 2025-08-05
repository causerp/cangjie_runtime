# Example of Manipulating AST Objects

After obtaining a node of type [ClassDecl](../ast_package_api/ast_package_classes.md#class-classdecl), you can perform operations such as addition, deletion, modification, and query on the node. The code is shown below:

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
    let decl = parseDecl(input) // Get a Decl declaration node
    var classDecl = match (decl as ClassDecl) { // The specific type of decl is ClassDecl, perform type conversion.
        case Some(v) => v
        case None => throw Exception()
    }
    var identifier = classDecl.identifier
    // Add a member function to the node to get the value of a
    var funcdecl = FuncDecl(quote(func getValue() {a}))
    classDecl.body.decls.add(funcdecl)
    println("Identifier value is ${identifier.value}")
    println("ClassDecl body size is ${classDecl.body.decls.size}")
    0
}
```

Execution result:

```text
Identifier value is Data
ClassDecl body size is 3
```