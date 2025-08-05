# Example of Traversing AST Objects with Custom Visitor Functions

Define behavior for visiting variable declaration nodes: Inherit from [Visitor](../ast_package_api/ast_package_classes.md#class-visitor) and override the visit function to find undefined variables, storing their lexical tokens.

<!-- verify -->

```cangjie
import std.ast.*

class MyVisitor <: Visitor {
    public var uninitializedVars = Tokens() // Stores variable lexical tokens
    public override func visit(varDecl: VarDecl) {
        try {
            varDecl.expr
        } catch (e: ASTException) {
            uninitializedVars.append(varDecl.identifier)
        }
        breakTraverse() // Will not continue traversing child nodes of varDecl
        return
    }
}

main(): Int64 {
    let input = quote(
        var a : Int64
    )
    let varDecl = parseDecl(input)
    let visitor = MyVisitor() // MyVisitor defines processing for varDecl nodes
    varDecl.traverse(visitor) // Implements processing for varDecl nodes
    println("Uninitialized VarDecl size is ${visitor.uninitializedVars.size}")
    0
}
```

Execution result:

```text
Uninitialized VarDecl size is 1
```