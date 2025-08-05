# Class

## class Annotation

```cangjie
public class Annotation <: Node {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents compiler-built-in annotation nodes.

An [Annotation](ast_package_classes.md#class-annotation) node: `@CallingConv[xxx]`, `@Attribute[xxx]`, `@When[condition]`, etc.

Parent Type:

- [Node](#class-node)

### prop arguments

```cangjie
public mut prop arguments: ArrayList<Argument>
```

Function: Gets or sets the parameter sequence in [Annotation](ast_package_classes.md#class-annotation), such as `xxx` in `@CallingConv[xxx]`.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Argument](ast_package_classes.md#class-argument)>

### prop at

```cangjie
public mut prop at: Token
```

Function: Gets or sets the `@` operator or `@!` operator in the [Annotation](ast_package_classes.md#class-annotation) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not an `@` or `@!` operator.

### prop attributes

```cangjie
public mut prop attributes: Tokens
```

Function: Gets or sets the attribute values set in `Attribute`, used only for `@Attribute`, such as `xxx` in `@Attribute[xxx]`.

Type: [Tokens](ast_package_classes.md#class-tokens)

### prop condition

```cangjie
public mut prop condition: Expr
```

Function: Gets or sets the conditional expression in conditional compilation, used for `@When`, such as `xxx` in `@When[xxx]`.

Type: [Expr](ast_package_classes.md#class-expr)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when there is no conditional expression in the [Annotation](ast_package_classes.md#class-annotation) node.

### prop identifier

```cangjie
public mut prop identifier: Token
```

Function: Gets or sets the identifier of the [Annotation](ast_package_classes.md#class-annotation) node, such as `CallingConv` in `@CallingConv[xxx]`.

Type: [Token](ast_package_structs.md#struct-token)

### init()

```cangjie
public init()
```

Function: Constructs a default [Annotation](ast_package_classes.md#class-annotation) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs an [Annotation](ast_package_classes.md#class-annotation) object based on input tokens.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The token collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [Annotation](ast_package_classes.md#class-annotation) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as an [Annotation](ast_package_classes.md#class-annotation) node.

## class Argument

```cangjie
public class Argument <: Node {
    public init()
}
```

Function: Represents function call argument nodes.

For example, `arg:value` in `foo(arg:value)`.

Parent Type:

- [Node](#class-node)

### prop colon

```cangjie
public mut prop colon: Token
```

Function: Gets or sets the ":" operator in the [Argument](ast_package_classes.md#class-argument) node, which may be an [ILLEGAL](ast_package_enums.md#illegal) token.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not a ":" operator.

### prop expr

```cangjie
public mut prop expr: Expr
```

Function: Gets or sets the expression in the [Argument](ast_package_classes.md#class-argument) node, such as `value` in `arg:value`.

Type: [Expr](ast_package_classes.md#class-expr)

### prop identifier

```cangjie
public mut prop identifier: Token
```

Function: Gets or sets the identifier in the [Argument](ast_package_classes.md#class-argument) node, such as `arg` in `arg:value`, which may be an [ILLEGAL](ast_package_enums.md#illegal) token.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the get/set [Token](ast_package_structs.md#struct-token) type is not an [IDENTIFIER](ast_package_enums.md#identifier) identifier or when the literal value of [Token](ast_package_structs.md#struct-token) is empty.

### prop keyword

```cangjie
public mut prop keyword: Token
```

Function: Gets or sets the keyword `inout` in the [Argument](ast_package_classes.md#class-argument) node, which may be a lexical unit of [ILLEGAL](ast_package_enums.md#illegal).

Type: [Token](ast_package_structs.md#struct-token)

### init()

```cangjie
public init()
```

Function: Constructs a default [Argument](ast_package_classes.md#class-argument) object.

## class ArrayLiteral

```cangjie
public class ArrayLiteral <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents an [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt) literal node.

[ArrayLiteral](ast_package_classes.md#class-arrayliteral) node: Represented in the format `[element1, element2, ... , elementN]`, where each `element` is an expression.

Parent Type:

- [Expr](#class-expr)

### prop elements

```cangjie
public mut prop elements: ArrayList<Expr>
```

Function: Gets or sets the list of expressions in [ArrayLiteral](ast_package_classes.md#class-arrayliteral).

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Expr](ast_package_classes.md#class-expr)>

### prop lSquare

```cangjie
public mut prop lSquare: Token
```

Function: Gets or sets the "[" in [ArrayLiteral](ast_package_classes.md#class-arrayliteral).

Type: [Token](ast_package_structs.md#struct-token)

Exception:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not "[".

### prop rSquare

```cangjie
public mut prop rSquare: Token
```

Function: Gets or sets the "]" in [ArrayLiteral](ast_package_classes.md#class-arrayliteral).

Type: [Token](ast_package_structs.md#struct-token)

Exception:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not "]".

### init()

```cangjie
public init()
```

Function: Constructs a default [ArrayLiteral](ast_package_classes.md#class-arrayliteral) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs an [ArrayLiteral](ast_package_classes.md#class-arrayliteral) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The collection of lexical units ([Tokens](ast_package_classes.md#class-tokens)) to construct the [ArrayLiteral](ast_package_classes.md#class-arrayliteral) type.

Exception:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as an [ArrayLiteral](ast_package_classes.md#class-arrayliteral) node.

## class AsExpr

```cangjie
public class AsExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a type-checking expression.

An [AsExpr](ast_package_classes.md#class-asexpr) expression: `e as T`, with type [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>. Here, e can be any type of expression, and T can be any type.

Parent Type:

- [Expr](#class-expr)

### prop expr

```cangjie
public mut prop expr: Expr
```

Function: Gets or sets the expression node in [AsExpr](ast_package_classes.md#class-asexpr).

Type: [Expr](ast_package_classes.md#class-expr)

### prop keyword

```cangjie
public mut prop keyword: Token
```

Function: Gets or sets the `as` operator in [AsExpr](ast_package_classes.md#class-asexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exception:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not the `as` operator.

### prop shiftType

```cangjie
public mut prop shiftType: TypeNode
```

Function: Gets or sets the target type in [AsExpr](ast_package_classes.md#class-asexpr).Type: [TypeNode](ast_package_classes.md#class-typenode)

### init()

```cangjie
public init()
```

Function: Constructs a default [AsExpr](ast_package_classes.md#class-asexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs an [AsExpr](ast_package_classes.md#class-asexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical token collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [AsExpr](ast_package_classes.md#class-asexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into an [AsExpr](ast_package_classes.md#class-asexpr) node.

## class AssignExpr

```cangjie
public class AssignExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents an assignment expression node.

Used to modify the value of the left operand to the value of the right operand. An [AssignExpr](ast_package_classes.md#class-assignexpr) node: `a = b`.

Parent Type:

- [Expr](#class-expr)

### prop assign

```cangjie
public mut prop assign: Token
```

Function: Gets or sets the assignment operator (e.g., `=`) in the [AssignExpr](ast_package_classes.md#class-assignexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not an assignment operator.

### prop leftExpr

```cangjie
public mut prop leftExpr: Expr
```

Function: Gets or sets the left operand in the [AssignExpr](ast_package_classes.md#class-assignexpr) node.

Type: [Expr](ast_package_classes.md#class-expr)

### prop rightExpr

```cangjie
public mut prop rightExpr: Expr
```

Function: Gets or sets the right operand in the [AssignExpr](ast_package_classes.md#class-assignexpr) node.

Type: [Expr](ast_package_classes.md#class-expr)

### init()

```cangjie
public init()
```

Function: Constructs a default [AssignExpr](ast_package_classes.md#class-assignexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs an [AssignExpr](ast_package_classes.md#class-assignexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical token collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [AssignExpr](ast_package_classes.md#class-assignexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into an [AssignExpr](ast_package_classes.md#class-assignexpr) node.

## class BinaryExpr

```cangjie
public class BinaryExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a binary operation expression node.

A [BinaryExpr](ast_package_classes.md#class-binaryexpr) node: `a + b`, `a - b`, etc.

Parent Type:

- [Expr](#class-expr)

### prop leftExpr

```cangjie
public mut prop leftExpr: Expr
```

Function: Gets or sets the left-hand expression node of the operator in the [BinaryExpr](ast_package_classes.md#class-binaryexpr) node.

Type: [Expr](ast_package_classes.md#class-expr)

### prop op

```cangjie
public mut prop op: Token
```

Function: Gets or sets the binary operator in the [BinaryExpr](ast_package_classes.md#class-binaryexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

### prop rightExpr

```cangjie
public mut prop rightExpr: Expr
```

Function: Gets or sets the right-hand expression node of the operator in the [BinaryExpr](ast_package_classes.md#class-binaryexpr) node.

Type: [Expr](ast_package_classes.md#class-expr)

### init()

```cangjie
public init()
```

Function: Constructs a default [BinaryExpr](ast_package_classes.md#class-binaryexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [BinaryExpr](ast_package_classes.md#class-binaryexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical token collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [BinaryExpr](ast_package_classes.md#class-binaryexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed into a [BinaryExpr](ast_package_classes.md#class-binaryexpr) node.

## class Block

```cangjie
public class Block <: Expr {
    public init()
}
```

Function: Represents a block node.

[Block](ast_package_classes.md#class-block) is a structure composed of a matched pair of curly braces and an optional sequence of expression declarations within them, referred to as a "block".

Parent Type:

- [Expr](#class-expr)

### prop lBrace

```cangjie
public mut prop lBrace: Token
```

Function: Gets or sets the "{" for the [Block](ast_package_classes.md#class-block).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "{".

### prop nodes

```cangjie
public mut prop nodes: ArrayList<Node>
```

Function: Gets or sets the sequence of expressions or declarations within the [Block](ast_package_classes.md#class-block).

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Node](ast_package_classes.md#class-node)>

### prop rBrace

```cangjie
public mut prop rBrace: Token
```

Function: Gets or sets the "}" for the [Block](ast_package_classes.md#class-block).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "}".

### init()

```cangjie
public init()
```

Function: Constructs a default [Block](ast_package_classes.md#class-block) object.

> **Note:**
>
> A [Block](ast_package_classes.md#class-block) node cannot exist independently without expression or declaration nodes, hence no additional constructors are provided.

## class Body

```cangjie
public class Body <: Node {
    public init()
    public init(decls: ArrayList<Decl>)
}
```

Function: Represents the structure composed of `{}` and an internal set of declaration nodes within Class types, Struct types, Interface types, and extensions.

Parent Type:

- [Node](#class-node)

### prop decls

```cangjie
public mut prop decls: ArrayList<Decl>
```

Function: Gets or sets the collection of declaration nodes within the [Body](ast_package_classes.md#class-body).

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Decl](ast_package_classes.md#class-decl)>

### prop lBrace

```cangjie
public mut prop lBrace: Token
```

Function: Gets or sets the `{` lexical token.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not a `{` lexical token.

### prop rBrace

```cangjie
public mut prop rBrace: Token
```

Function: Gets or sets the `}` lexical token.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not a `}` lexical token.

### init()

```cangjie
public init()
```

Function: Constructs a default [Body](ast_package_classes.md#class-body) object.

### init(ArrayList\<Decl>)

```cangjie
public init(decls: ArrayList<Decl>)
```

Function: Constructs a [Body](ast_package_classes.md#class-body) object.

Parameters:

- decls: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Decl](ast_package_classes.md#class-decl)> - The list of declarations to construct a [Body](ast_package_classes.md#class-body) type.

## class CallExpr

```cangjie
public class CallExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a function call node.

A [CallExpr](ast_package_classes.md#class-callexpr) node consists of an expression followed by an argument list, e.g., `foo(100)`.

Parent Type:

- [Expr](#class-expr)

### prop arguments

```cangjie
public mut prop arguments: ArrayList<Argument>
```

Function: Gets or sets the function arguments in the [CallExpr](ast_package_classes.md#class-callexpr) node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Argument](ast_package_classes.md#class-argument)>

### prop callFunc

```cangjie
public mut prop callFunc: Expr
```

Function: Gets or sets the function call node in the [CallExpr](ast_package_classes.md#class-callexpr) node.

Type: [Expr](ast_package_classes.md#class-expr)

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" token in the [CallExpr](ast_package_classes.md#class-callexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not "(".

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" token in the [CallExpr](ast_package_classes.md#class-callexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not ")".

### init()

```cangjie
public init()
```

Function: Constructs a default [CallExpr](ast_package_classes.md#class-callexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [CallExpr](ast_package_classes.md#class-callexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The collection of lexical units ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [CallExpr](ast_package_classes.md#class-callexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into a [CallExpr](ast_package_classes.md#class-callexpr) node.

## class ClassDecl

```cangjie
public class ClassDecl <: Decl {
    public init()
    public init(inputs: Tokens)
}
```

Function: Class declaration node.

A class definition uses the `class` keyword, followed by (in order): optional modifiers, the `class` keyword, the class name, optional type parameters, optional parent class or interface specification, optional generic constraints, and the class body definition.

Parent Type:

- [Decl](#class-decl)

### prop body

```cangjie
public mut prop body: Body
```

Function: Gets or sets the class body of the [ClassDecl](ast_package_classes.md#class-classdecl) node.

Type: [Body](ast_package_classes.md#class-body)

### prop superTypeBitAnds

```cangjie
public mut prop superTypeBitAnds: Tokens
```

Function: Gets or sets the sequence of `&` operator lexical units in the parent class or interface declaration of the [ClassDecl](ast_package_classes.md#class-classdecl) node, which may be empty.

Type: [Tokens](ast_package_classes.md#class-tokens)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Tokens](ast_package_classes.md#class-tokens) is not a sequence of `&` lexical units.

### prop superTypes

```cangjie
public mut prop superTypes: ArrayList<TypeNode>
```

Function: Gets or sets the parent class or interfaces of the [ClassDecl](ast_package_classes.md#class-classdecl) node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[TypeNode](ast_package_classes.md#class-typenode)>

### prop upperBound

```cangjie
public mut prop upperBound: Token
```

Function: Gets or sets the `<:` operator.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not a `<:` operator.

### init()

```cangjie
public init()
```

Function: Constructs a default [ClassDecl](ast_package_classes.md#class-classdecl) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [ClassDecl](ast_package_classes.md#class-classdecl) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to be constructed into a [ClassDecl](ast_package_classes.md#class-classdecl) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed into a [ClassDecl](ast_package_classes.md#class-classdecl) node.

## class ConstPattern

```cangjie
public class ConstPattern <: Pattern {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a constant pattern node.

A constant pattern can be an integer literal, character byte literal, floating-point literal, character literal, boolean literal, string literal, or other literals, such as `1` in `case 1 => 0`.

Parent Type:

- [Pattern](#class-pattern)

### prop litConstExpr

```cangjie
public mut prop litConstExpr: LitConstExpr
```

Function: Gets or sets the literal expression in the [ConstPattern](ast_package_classes.md#class-constpattern) node.

Type: [LitConstExpr](ast_package_classes.md#class-litconstexpr)

### init()

```cangjie
public init()
```

Function: Constructs a default [ConstPattern](ast_package_classes.md#class-constpattern) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [ConstPattern](ast_package_classes.md#class-constpattern) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to be constructed into a [ConstPattern](ast_package_classes.md#class-constpattern) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed into a [ConstPattern](ast_package_classes.md#class-constpattern) node.

## class Constructor

```cangjie
public class Constructor <: Node {
    public init()
}
```

Function: Represents a [Constructor](ast_package_classes.md#class-constructor) node in an `enum` type.

A [Constructor](ast_package_classes.md#class-constructor) node: Year and Month([Float32](../../core/core_package_api/core_package_intrinsics.md#float32), [Float32](../../core/core_package_api/core_package_intrinsics.md#float32)) in enum TimeUnit { Year | Month([Float32](../../core/core_package_api/core_package_intrinsics.md#float32), [Float32](../../core/core_package_api/core_package_intrinsics.md#float32))}.

> **Note:**
>
> A [Constructor](ast_package_classes.md#class-constructor) may have no parameters or a set of parameters of different types.

Parent Type:

- [Node](#class-node)

### prop identifier

```cangjie
public mut prop identifier: Token
```

Function: Gets or sets the identifier lexical unit of the [Constructor](ast_package_classes.md#class-constructor).

Type: [Token](ast_package_structs.md#struct-token)

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" lexical unit in the [Constructor](ast_package_classes.md#class-constructor) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" lexical unit in the [Constructor](ast_package_classes.md#class-constructor) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not ")".

### prop typeArguments

```cangjie
public mut prop typeArguments: ArrayList<TypeNode>
```

Function: Gets or sets the collection of optional parameter type nodes for the [Constructor](ast_package_classes.md#class-constructor) node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[TypeNode](ast_package_classes.md#class-typenode)>

### init()

```cangjie
public init()
```

Function: Constructs a default [Constructor](ast_package_classes.md#class-constructor) object.

## class Decl

```cangjie
public open class Decl <: Node
```

Function: The parent class of all declaration nodes, inheriting from the [Node](ast_package_classes.md#class-node) class, providing common interfaces for all declaration nodes.

> **Note:**
>
> Class definitions, interface definitions, function definitions, variable definitions, enum definitions, struct definitions, extension definitions, type alias definitions, macro definitions, etc., all belong to [Decl](ast_package_classes.md#class-decl) nodes.

Parent Types:

- [Node](#class-node)

### prop annotations

```cangjie
public mut prop annotations: ArrayList<Annotation>
```

Function: Gets or sets the list of annotations applied to the [Decl](ast_package_classes.md#class-decl) node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Annotation](ast_package_classes.md#class-annotation)>

### prop constraintCommas

```cangjie
public mut prop constraintCommas: Tokens
```

Function: Gets or sets the sequence of "," lexical units in the [Decl](ast_package_classes.md#class-decl) node, which may be empty.

Type: [Tokens](ast_package_classes.md#class-tokens)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Tokens](ast_package_classes.md#class-tokens) is not a sequence of "," lexical units.

### prop genericConstraint

```cangjie
public mut prop genericConstraint: ArrayList<GenericConstraint>
```

Function: Gets or sets the generic constraints of the definition node, which may be empty, such as `where T <: Comparable<T>` in `func foo<T>() where T <: Comparable<T> {}`.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[GenericConstraint](ast_package_classes.md#class-genericconstraint)>

### prop genericParam

```cangjie
public mut prop genericParam: GenericParam
```

Function: Gets or sets the parameter list. The type parameter list is enclosed in `<>`, with multiple type parameters separated by commas.

Type: [GenericParam](ast_package_classes.md#class-genericparam)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the node does not define a type parameter list.

### prop identifier

```cangjie
public mut open prop identifier: Token
```

Function: Gets or sets the identifier of the definition node, such as `foo` in `class foo {}`.

Type: [Token](ast_package_structs.md#struct-token)

### prop isGenericDecl

```cangjie
public mut prop isGenericDecl: Bool
```

Function: Determines whether it is a generic node.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if it is a generic node; otherwise, returns false.

### prop keyword

```cangjie
public mut prop keyword: Token
```

Function: Gets or sets the keyword of the definition node.

Type: [Token](ast_package_structs.md#struct-token)

### prop modifiers

```cangjie
public mut prop modifiers: ArrayList<Modifier>
```

Function: Gets or sets the list of modifiers for the modified node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Modifier](ast_package_classes.md#class-modifier)>

### func getAttrs()

```cangjie
public func getAttrs(): Tokens
```

Function: Gets the attributes of the current node (generally set via the built-in `Attribute` to assign attribute values to a declaration).

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The attributes of the current node.

### func hasAttr(String)

```cangjie
public func hasAttr(attr: String): Bool
```

Function: Determines whether the current node has a specific attribute (generally set via the built-in `Attribute` to assign attribute values to a declaration).

Parameters:

- attr: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The attribute to check for existence in the node.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the current node has the attribute; otherwise, returns false.

## class DoWhileExpr

```cangjie
public class DoWhileExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a `do-while` expression.

Parent Types:

- [Expr](#class-expr)

### prop block

```cangjie
public mut prop block: Block
```

Function: Gets or sets the block expression within [DoWhileExpr](ast_package_classes.md#class-dowhileexpr).

Type: [Block](ast_package_classes.md#class-block)

### prop condition

```cangjie
public mut prop condition: Expr
```

Function: Gets or sets the conditional expression in the [DoWhileExpr](ast_package_classes.md#class-dowhileexpr) keyword.

Type: [Expr](ast_package_classes.md#class-expr)

### prop keywordD

```cangjie
public mut prop keywordD: Token
```

Function: Gets or sets the `do` keyword in the [DoWhileExpr](ast_package_classes.md#class-dowhileexpr) node, where the 'D' in keywordD is the capitalized first letter of the keyword `do`, representing the `do` keyword.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not the `do` keyword.

### prop keywordW

```cangjie
public mut prop keywordW: Token
```

Function: Gets or sets the `while` keyword in the [DoWhileExpr](ast_package_classes.md#class-dowhileexpr) node, where the 'W' in keywordW is the capitalized first letter of the keyword `while`, representing the `while` keyword.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not the `while` keyword.

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" following the `while` keyword in [DoWhileExpr](ast_package_classes.md#class-dowhileexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" following the `while` keyword in [DoWhileExpr](ast_package_classes.md#class-dowhileexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not ")".

### init()

```cangjie
public init()
```

Function: Constructs a default [DoWhileExpr](ast_package_classes.md#class-dowhileexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [DoWhileExpr](ast_package_classes.md#class-dowhileexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [DoWhileExpr](ast_package_classes.md#class-dowhileexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [DoWhileExpr](ast_package_classes.md#class-dowhileexpr) node.

## class EnumDecl

```cangjie
public class EnumDecl <: Decl {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents an `Enum` declaration node.

Enum declarations use the `enum` keyword, defined in sequence as: optional modifiers, the enum keyword, enum name, optional type parameters, optional parent interface specification, optional generic constraints, and enum body definition.

Parent Types:

- [Decl](#class-decl)

### prop constructors

```cangjie
public mut prop constructors: ArrayList<Constructor>
```

Function: Gets or sets the constructor members within the [EnumDecl](ast_package_classes.md#class-enumdecl) node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Constructor](ast_package_classes.md#class-constructor)>

### prop annotations

```cangjie
public mut prop annotations: ArrayList<Annotation>
```

Function: Gets or sets the list of annotations applied to the [EnumDecl](ast_package_classes.md#class-enumdecl) node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Annotation](ast_package_classes.md#class-annotation)>

### prop decls

```cangjie
public mut prop decls: ArrayList<Decl>
```

Function: Gets or sets members within an [EnumDecl](ast_package_classes.md#class-enumdecl) node excluding the constructor.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Decl](ast_package_classes.md#class-decl)>

### prop ellipsis

```cangjie
public mut prop ellipsis: Token
```

Function: Gets or sets the optional `...` lexical token in an [EnumDecl](ast_package_classes.md#class-enumdecl) node, which may be of type [ILLEGAL](ast_package_enums.md#illegal).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not a `...` lexical token.

### prop lBrace

```cangjie
public mut prop lBrace: Token
```

Function: Gets or sets the `{` lexical token type for an [EnumDecl](ast_package_classes.md#class-enumdecl) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not a `{` lexical token type.

### prop rBrace

```cangjie
public mut prop rBrace: Token
```

Function: Gets or sets the `}` lexical token type for an [EnumDecl](ast_package_classes.md#class-enumdecl) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not a `}` lexical token type.

### prop superTypeBitAnds

```cangjie
public mut prop superTypeBitAnds: Tokens
```

Function: Gets or sets the sequence of `&` operator lexical tokens in the parent interface declaration of an [EnumDecl](ast_package_classes.md#class-enumdecl) node, which may be empty.

Type: [Tokens](ast_package_classes.md#class-tokens)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Tokens](ast_package_classes.md#class-tokens) is not a sequence of `&` lexical tokens.

### prop superTypes

```cangjie
public mut prop superTypes: ArrayList<TypeNode>
```

Function: Gets or sets the parent interfaces of an [EnumDecl](ast_package_classes.md#class-enumdecl) node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[TypeNode](ast_package_classes.md#class-typenode)>

### prop upperBound

```cangjie
public mut prop upperBound: Token
```

Function: Gets or sets the `<:` operator.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not a `<:` operator.

### init()

```cangjie
public init()
```

Function: Constructs a default [EnumDecl](ast_package_classes.md#class-enumdecl) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs an [EnumDecl](ast_package_classes.md#class-enumdecl) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical token collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [EnumDecl](ast_package_classes.md#class-enumdecl) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into an [EnumDecl](ast_package_classes.md#class-enumdecl) node.

## class EnumPattern

```cangjie
public class EnumPattern <: Pattern {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents an enum pattern node.

Used to match enum `constructor`, such as `Year(n)` in `case Year(n) => 1`.

Parent Type:

- [Pattern](#class-pattern)

### prop commas

```cangjie
public mut prop commas: Tokens
```

Function: Gets or sets the sequence of "," lexical tokens in an [EnumPattern](ast_package_classes.md#class-enumpattern) node, which may be empty.

Type: [Tokens](ast_package_classes.md#class-tokens)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Tokens](ast_package_classes.md#class-tokens) is not a sequence of "," lexical tokens.

### prop constructor

```cangjie
public mut prop constructor: Expr
```

Function: Gets or sets the constructor expression node within an [EnumPattern](ast_package_classes.md#class-enumpattern) node.

Type: [Expr](ast_package_classes.md#class-expr)

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the lexical token for "(" in an [EnumPattern](ast_package_classes.md#class-enumpattern) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not "(".

### prop patterns

```cangjie
public mut prop patterns: ArrayList<Pattern>
```

Function: Gets or sets the list of pattern nodes within the parameterized constructor of an [EnumPattern](ast_package_classes.md#class-enumpattern) node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Pattern](ast_package_classes.md#class-pattern)>

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the lexical token for ")" in an [EnumPattern](ast_package_classes.md#class-enumpattern) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not ")".

### init()

```cangjie
public init()
```

Function: Constructs a default [EnumPattern](ast_package_classes.md#class-enumpattern) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs an [EnumPattern](ast_package_classes.md#class-enumpattern) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical token collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [EnumPattern](ast_package_classes.md#class-enumpattern) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into an [EnumPattern](ast_package_classes.md#class-enumpattern) node.

## class ExceptTypePattern

```cangjie
public class ExceptTypePattern <: Pattern {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a node for exception pattern states.

Example: `e: Exception1 | Exception2`.

Parent Type:

- [Pattern](#class-pattern)

### prop colon

```cangjie
public mut prop colon: Token
```

Function: Gets or sets the lexical token for the ":" operator in an [ExceptTypePattern](ast_package_classes.md#class-excepttypepattern) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not a ":" operator.

### prop pattern

```cangjie
public mut prop pattern: Pattern
```

Function: Gets or sets the pattern node within an [ExceptTypePattern](ast_package_classes.md#class-excepttypepattern) node.

Type: [Pattern](ast_package_classes.md#class-pattern)

### prop types

```cangjie
public mut prop types: ArrayList<TypeNode>
```

Function: Gets or sets the type list within an [ExceptTypePattern](ast_package_classes.md#class-excepttypepattern) node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[TypeNode](ast_package_classes.md#class-typenode)>

### init()

```cangjie
public init()
```

Function: Constructs a default [ExceptTypePattern](ast_package_classes.md#class-excepttypepattern) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs an [ExceptTypePattern](ast_package_classes.md#class-excepttypepattern) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical token collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [ExceptTypePattern](ast_package_classes.md#class-excepttypepattern) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into an [ExceptTypePattern](ast_package_classes.md#class-excepttypepattern) node.

## class Expr

```cangjie
public open class Expr <: Node
```

Function: The parent class for all expression nodes, inheriting from the [Node](ast_package_classes.md#class-node) node.The `toTokens` method of expression nodes adds parentheses based on operator precedence. For example, given an existing [BinaryExpr](ast_package_classes.md#class-binaryexpr) node `a * b`, if the user modifies the left expression `a` to `a + 1`, the `toTokens` method will add parentheses to the left expression, resulting in the output `(a + 1) * b`.

Parent Type:

- [Node](#class-node)

## class ExtendDecl

```cangjie
public class ExtendDecl <: Decl {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents an extension declaration node.

The extension definition uses the `extend` keyword, followed by: the `extend` keyword, the type being extended, optional parent interface specification, optional generic constraints, and the extension body definition.

Parent Type:

- [Decl](#class-decl)

### prop body

```cangjie
public mut prop body: Body
```

Function: Gets or sets the class body of the [ExtendDecl](ast_package_classes.md#class-extenddecl) node.

Type: [Body](ast_package_classes.md#class-body)

### prop extendType

```cangjie
public mut prop extendType: TypeNode
```

Function: Gets or sets the type being extended.

Type: [TypeNode](ast_package_classes.md#class-typenode)

### prop identifier

```cangjie
public mut override prop identifier: Token
```

Function: The [ExtendDecl](ast_package_classes.md#class-extenddecl) node inherits from [Decl](ast_package_classes.md#class-decl), but does not support the `identifier` property. An exception will be thrown when attempting to use it.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when attempting to use the `identifier` property.

### prop superTypeBitAnds

```cangjie
public mut prop superTypeBitAnds: Tokens
```

Function: Gets or sets the sequence of `&` operator tokens in the parent interface declaration of the [ExtendDecl](ast_package_classes.md#class-extenddecl) node, which may be empty.

Type: [Tokens](ast_package_classes.md#class-tokens)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Tokens](ast_package_classes.md#class-tokens) is not a sequence of `&` operator tokens.

### prop superTypes

```cangjie
public mut prop superTypes: ArrayList<TypeNode>
```

Function: Gets or sets the parent interfaces of the [ExtendDecl](ast_package_classes.md#class-extenddecl) node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[TypeNode](ast_package_classes.md#class-typenode)>

### prop upperBound

```cangjie
public mut prop upperBound: Token
```

Function: Gets or sets the `<:` operator.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not a `<:` operator.

### init()

```cangjie
public init()
```

Function: Constructs a default [ExtendDecl](ast_package_classes.md#class-extenddecl) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs an [ExtendDecl](ast_package_classes.md#class-extenddecl) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The token collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [ExtendDecl](ast_package_classes.md#class-extenddecl) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into an [ExtendDecl](ast_package_classes.md#class-extenddecl) node.

## class ForInExpr

```cangjie
public class ForInExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a `for-in` expression.

In the [ForInExpr](ast_package_classes.md#class-forinexpr) type, the `for` keyword is followed by a [Pattern](ast_package_classes.md#class-pattern), then an `in` keyword and an expression node, and finally the loop body [Block](ast_package_classes.md#class-block).

Parent Type:

- [Expr](#class-expr)

### prop block

```cangjie
public mut prop block: Block
```

Function: Gets or sets the loop body in [ForInExpr](ast_package_classes.md#class-forinexpr).

Type: [Block](ast_package_classes.md#class-block)

### prop expr

```cangjie
public mut prop expr: Expr
```

Function: Gets or sets the expression in [ForInExpr](ast_package_classes.md#class-forinexpr).

Type: [Expr](ast_package_classes.md#class-expr)

### prop keywordF

```cangjie
public mut prop keywordF: Token
```

Function: Gets or sets the `for` keyword in [ForInExpr](ast_package_classes.md#class-forinexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not a `for` keyword.

### prop keywordI

```cangjie
public mut prop keywordI: Token
```

Function: Gets or sets the `in` keyword in [ForInExpr](ast_package_classes.md#class-forinexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not an `in` keyword.

### prop keywordW

```cangjie
public mut prop keywordW: Token
```

Function: Gets or sets the `where` keyword in [ForInExpr](ast_package_classes.md#class-forinexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not a `where` keyword.

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" following the `for` keyword in [ForInExpr](ast_package_classes.md#class-forinexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not "(".

### prop pattern

```cangjie
public mut prop pattern: Pattern
```

Function: Gets or sets the [Pattern](ast_package_classes.md#class-pattern) node in [ForInExpr](ast_package_classes.md#class-forinexpr).

Type: [Pattern](ast_package_classes.md#class-pattern)

### prop patternGuard

```cangjie
public mut prop patternGuard: Expr
```

Function: Gets or sets the `patternGuard` conditional expression in [ForInExpr](ast_package_classes.md#class-forinexpr).

Type: [Expr](ast_package_classes.md#class-expr)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the [ForInExpr](ast_package_classes.md#class-forinexpr) node does not contain a `patternGuard` expression.

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" in [ForInExpr](ast_package_classes.md#class-forinexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not ")".

### init()

```cangjie
public init()
```

Function: Constructs a default [ForInExpr](ast_package_classes.md#class-forinexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [ForInExpr](ast_package_classes.md#class-forinexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [ForInExpr](ast_package_classes.md#class-forinexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into a [ForInExpr](ast_package_classes.md#class-forinexpr) node.

## class FuncDecl

```cangjie
public class FuncDecl <: Decl {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a function declaration node.

Defined by optional function modifiers, the `func` keyword, function name, optional type parameter list, function parameters, and an optional return type. A function declaration must include a function body, which is a block.

Parent Type:

- [Decl](#class-decl)

### prop block

```cangjie
public mut prop block: Block
```

Function: Gets or sets the function body of the [FuncDecl](ast_package_classes.md#class-funcdecl) node.Type: [Block](ast_package_classes.md#class-block)

### prop colon

```cangjie
public mut prop colon: Token
```

Function: Gets or sets the colon token of the [FuncDecl](ast_package_classes.md#class-funcdecl) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not a colon.

### prop declType

```cangjie
public mut prop declType: TypeNode
```

Function: Gets or sets the return type of the [FuncDecl](ast_package_classes.md#class-funcdecl) node.

Type: [TypeNode](ast_package_classes.md#class-typenode)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the return type of the [FuncDecl](ast_package_classes.md#class-funcdecl) node is a default value.

### prop funcParams

```cangjie
public mut prop funcParams: ArrayList<FuncParam>
```

Function: Gets or sets the function parameters of the [FuncDecl](ast_package_classes.md#class-funcdecl) node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[FuncParam](ast_package_classes.md#class-funcparam)>

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" token of the [FuncDecl](ast_package_classes.md#class-funcdecl) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not "(".

### prop overloadOp

```cangjie
public mut prop overloadOp: Tokens
```

Function: Gets or sets the overload operator of the [FuncDecl](ast_package_classes.md#class-funcdecl) node.

Type: [Tokens](ast_package_classes.md#class-tokens)

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" token of the [FuncDecl](ast_package_classes.md#class-funcdecl) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not ")".

### init()

```cangjie
public init()
```

Function: Constructs a default [FuncDecl](ast_package_classes.md#class-funcdecl) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [FuncDecl](ast_package_classes.md#class-funcdecl) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical token collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [FuncDecl](ast_package_classes.md#class-funcdecl) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into a [FuncDecl](ast_package_classes.md#class-funcdecl) node.

### func isConst()

```cangjie
public func isConst(): Bool
```

Function: Determines whether this is a `Const` type node.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if it is a `Const` type node; otherwise, returns false.

## class FuncParam

```cangjie
public open class FuncParam <: Decl {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a function parameter node, including both unnamed and named parameters.

A [FuncParam](ast_package_classes.md#class-funcparam) node: In `func foo(a: Int64, b: Float64) {...}`, these would be `a: Int64` and `b: Float64`.

Parent Type:

- [Decl](#class-decl)

### prop assign

```cangjie
public mut prop assign: Token
```

Function: Gets or sets the `=` token for function parameters with default values.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not `=`.

### prop colon

```cangjie
public mut prop colon: Token
```

Function: Gets or sets the ":" in the shape parameter.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not ":".

### prop expr

```cangjie
public mut prop expr: Expr
```

Function: Gets or sets the variable initialization node for function parameters with default values.

Type: [Expr](ast_package_classes.md#class-expr)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the function parameter is not initialized.

### prop not

```cangjie
public mut prop not: Token
```

Function: Gets or sets the `!` in named parameters.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not `!`.

### prop paramType

```cangjie
public mut prop paramType: TypeNode
```

Function: Gets or sets the type of the function parameter.

Type: [TypeNode](ast_package_classes.md#class-typenode)

### init()

```cangjie
public init()
```

Function: Constructs a default [FuncParam](ast_package_classes.md#class-funcparam) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [FuncParam](ast_package_classes.md#class-funcparam) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [FuncParam](ast_package_classes.md#class-funcparam) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [FuncParam](ast_package_classes.md#class-funcparam) node.

### func isMemberParam()

```cangjie
public func isMemberParam(): Bool
```

Function: Determines whether the current function parameter is a parameter in the primary constructor.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Boolean type, returns `true` if it is a parameter in the primary constructor.

## class FuncType

```cangjie
public class FuncType <: TypeNode {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a function type node.

Composed of the function's parameter types and return type, separated by `->`, e.g., `(Int32) -> Unit`.

Parent Type:

- [TypeNode](#class-typenode)

### prop arrow

```cangjie
public mut prop arrow: Token
```

Function: Gets or sets the `->` lexical unit between the parameter types and return type in the [FuncType](ast_package_classes.md#class-functype) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not the `->` lexical unit.

### prop commas

```cangjie
public mut prop commas: Tokens
```

Function: Gets or sets the sequence of "," lexical units in the [FuncType](ast_package_classes.md#class-functype) node, which may be empty.

Type: [Tokens](ast_package_classes.md#class-tokens)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Tokens](ast_package_classes.md#class-tokens) is not a sequence of "," lexical units.

### prop keyword

```cangjie
public mut prop keyword: Token
```

Function: Gets or sets the lexical unit of the keyword `CFunc` in the [FuncType](ast_package_classes.md#class-functype) node. If it is not a `CFunc` type, gets an [ILLEGAL](ast_package_enums.md#illegal) lexical unit.

Type: [Token](ast_package_structs.md#struct-token)

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" lexical unit in the [FuncType](ast_package_classes.md#class-functype) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the lexical unit of ")" for the [FuncType](ast_package_classes.md#class-functype) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not ")".

### prop returnType

```cangjie
public mut prop returnType: TypeNode
```

Function: Gets or sets the return type node of [FuncType](ast_package_classes.md#class-functype).

Type: [TypeNode](ast_package_classes.md#class-typenode)

### prop types

```cangjie
public mut prop types: ArrayList<TypeNode>
```

Function: Gets or sets the parameter type list of the function in the [FuncType](ast_package_classes.md#class-functype) node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[TypeNode](ast_package_classes.md#class-typenode)>

### init()

```cangjie
public init()
```

Function: Constructs a default [FuncType](ast_package_classes.md#class-functype) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [FuncType](ast_package_classes.md#class-functype) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [FuncType](ast_package_classes.md#class-functype) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [FuncType](ast_package_classes.md#class-functype) node.

## class GenericConstraint

```cangjie
public class GenericConstraint <: Node {
    public init()
}
```

Function: Represents a generic constraint node.

A [GenericConstraint](ast_package_classes.md#class-genericconstraint) node: `where U <: Bounded` in `interface Enumerable<U> where U <: Bounded {}`.

> **Note:**
>
> Declared via the `<:` operator after `where`, consisting of a lower bound and an upper bound. The left side of `<:` is called the constraint's lower bound, which can only be a type variable. The right side of `<:` is called the constraint's upper bound, which can be a type.

Parent Type:

- [Node](#class-node)

### prop bitAnds

```cangjie
public mut prop bitAnds: Tokens
```

Function: Gets or sets the sequence of `&` operator lexical units in the [GenericConstraint](ast_package_classes.md#class-genericconstraint) node, which may be empty.

Type: [Tokens](ast_package_classes.md#class-tokens)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Tokens](ast_package_classes.md#class-tokens) is not a sequence of `&` lexical units.

### prop keyword

```cangjie
public mut prop keyword: Token
```

Function: Gets or sets the `where` keyword lexical unit in the [GenericConstraint](ast_package_classes.md#class-genericconstraint) node, which may be an [ILLEGAL](ast_package_enums.md#illegal) lexical unit.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not the `where` keyword.

### prop typeArgument

```cangjie
public mut prop typeArgument: TypeNode
```

Function: Gets or sets the constraint's lower bound in the [GenericConstraint](ast_package_classes.md#class-genericconstraint) node.

Type: [TypeNode](ast_package_classes.md#class-typenode)

### prop upperBound

```cangjie
public mut prop upperBound: Token
```

Function: Gets or sets the `<:` operator in the [GenericConstraint](ast_package_classes.md#class-genericconstraint) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not the `<:` operator.

### prop upperBounds

```cangjie
public mut prop upperBounds: ArrayList<TypeNode>
```

Function: Gets or sets the collection of [TypeNode](ast_package_classes.md#class-typenode) type nodes for the constraint's upper bounds in the [GenericConstraint](ast_package_classes.md#class-genericconstraint) node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[TypeNode](ast_package_classes.md#class-typenode)>

### init()

```cangjie
public init()
```

Function: Constructs a default [GenericConstraint](ast_package_classes.md#class-genericconstraint) object.

## class GenericParam

```cangjie
public class GenericParam <: Node {
    public init()
    public init(parameters: Tokens)
}
```

Function: Represents a type parameter node.

A [GenericParam](ast_package_classes.md#class-genericparam) node: `<T1, T2, T3>`.

> **Note:**
>
> Type parameters are enclosed in `<>` and separated by "," for multiple type parameter names.

Parent Type:

- [Node](#class-node)

### prop lAngle

```cangjie
public mut prop lAngle: Token
```

Function: Gets or sets the left angle bracket lexical unit in the [GenericParam](ast_package_classes.md#class-genericparam) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not a left angle bracket.

### prop parameters

```cangjie
public mut prop parameters: Tokens
```

Function: Gets or sets the [Tokens](ast_package_classes.md#class-tokens) type of type parameters in the [GenericParam](ast_package_classes.md#class-genericparam) node, which may be empty, such as `T1`, `T2`, and `T3` in `<T1, T2, T3>`.

Type: [Tokens](ast_package_classes.md#class-tokens)

### prop rAngle

```cangjie
public mut prop rAngle: Token
```

Function: Gets or sets the right angle bracket lexical unit in the [GenericParam](ast_package_classes.md#class-genericparam) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not a right angle bracket.

### init()

```cangjie
public init()
```

Function: Constructs a default [GenericParam](ast_package_classes.md#class-genericparam) object.

### init(Tokens)

```cangjie
public init(parameters: Tokens)
```

Function: Constructs a [GenericParam](ast_package_classes.md#class-genericparam) object.

Parameters:

- parameters: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) of type parameters to construct the [GenericParam](ast_package_classes.md#class-genericparam).

## class IfExpr

```cangjie
public class IfExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a conditional expression.

Determines which code branch to execute based on whether the condition is met. In an [IfExpr](ast_package_classes.md#class-ifexpr) node, `if` is a keyword, followed by parentheses containing either an expression or a destructuring match declared with `let`, then a [Block](ast_package_classes.md#class-block), followed by an optional `else` branch. The `else` branch starts with the `else` keyword, followed by a new `if` expression or a [Block](ast_package_classes.md#class-block).

Parent Type:

- [Expr](#class-expr)

### prop condition

```cangjie
public mut prop condition: Expr
```

Function: Gets or sets the condition expression following `if` in the [IfExpr](ast_package_classes.md#class-ifexpr) node.

Type: [Expr](ast_package_classes.md#class-expr)

### prop elseExpr

```cangjie
public mut prop elseExpr: Expr
```

Function: Gets or sets the `else` branch node in the [IfExpr](ast_package_classes.md#class-ifexpr) node.

Type: [Expr](ast_package_classes.md#class-expr)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the current [IfExpr](ast_package_classes.md#class-ifexpr) node has no else branch node.

### prop ifBlock

```cangjie
public mut prop ifBlock: Block
```

Function: Gets or sets the block node following `if` in the [IfExpr](ast_package_classes.md#class-ifexpr) node.

Type: [Block](ast_package_classes.md#class-block)

### prop keywordE

```cangjie
public mut prop keywordE: Token
```

Function: Gets or sets the `else` keyword in the [IfExpr](ast_package_classes.md#class-ifexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not an `else` keyword.

### prop keywordI

```cangjie
public mut prop keywordI: Token
```

Function: Gets or sets the `if` keyword in an [IfExpr](ast_package_classes.md#class-ifexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not an `if` keyword.

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" after `if` in an [IfExpr](ast_package_classes.md#class-ifexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" after `if` in an [IfExpr](ast_package_classes.md#class-ifexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not ")".

### init()

```cangjie
public init()
```

Function: Constructs a default [IfExpr](ast_package_classes.md#class-ifexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs an [IfExpr](ast_package_classes.md#class-ifexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [IfExpr](ast_package_classes.md#class-ifexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into an [IfExpr](ast_package_classes.md#class-ifexpr) node.

## class ImportContent

```cangjie
public class ImportContent <: Node {
    public init()
}
```

Function: Represents a package import node.

Parent Type:

- [Node](#class-node)

### prop importKind

```cangjie
public mut prop importKind: ImportKind
```

Function: Gets or sets the import type in an [ImportContent](ast_package_classes.md#class-importcontent) node.

Type: [ImportKind](ast_package_enums.md#enum-importkind)

### prop prefixPaths

```cangjie
public mut prop prefixPaths: Tokens
```

Function: Gets or sets the lexical unit sequence of the prefix part of the full package name in an [ImportContent](ast_package_classes.md#class-importcontent) node, which may be empty. For example, `a` and `b` in `import a.b.c`.

Type: [Tokens](ast_package_classes.md#class-tokens)

### prop prefixDots

```cangjie
public mut prop prefixDots: Tokens
```

Function: Gets or sets the lexical unit sequence of the dots separating each subpackage in the full package name in an [ImportContent](ast_package_classes.md#class-importcontent) node, which may be empty. For example, the two "." in `import a.b.c`.

Type: [Tokens](ast_package_classes.md#class-tokens)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Tokens](ast_package_classes.md#class-tokens) is not a sequence of "." lexical units.

### prop identifier

```cangjie
public mut prop identifier: Token
```

Function: Gets or sets the imported item in an [ImportContent](ast_package_classes.md#class-importcontent) node, which may be a top-level definition or declaration in the package or the name of a subpackage.

Type: [Token](ast_package_structs.md#struct-token)

### prop importAlias

```cangjie
public mut prop importAlias: Tokens
```

Function: Gets or sets the alias lexical unit sequence of the imported definition or declaration in an [ImportContent](ast_package_classes.md#class-importcontent) node, which is non-empty only when `importKind` is `ImportKind.Alias`. For example, `as yyy` in `import packageName.xxx as yyy`.

Type: [Tokens](ast_package_classes.md#class-tokens)

### prop lBrace

```cangjie
public mut prop lBrace: Token
```

Function: Gets or sets the "{" operator lexical unit in an [ImportContent](ast_package_classes.md#class-importcontent) node, which is non-empty only when `importKind` is `ImportKind.Multi`.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not a "{" operator.

### prop items

```cangjie
public mut prop items: ArrayList<ImportContent>
```

Function: Gets or sets all imported items in an [ImportContent](ast_package_classes.md#class-importcontent) node, which is non-empty only when `importKind` is `ImportKind.Multi`.Type: ArrayList\<[ImportContent](ast_package_classes.md#class-importcontent)>

### prop commas

```cangjie
public mut prop commas: Tokens
```

Function: Gets or sets the sequence of "," lexical tokens in the [ImportContent](ast_package_classes.md#class-importcontent) node. Only non-empty when `importKind` is `ImportKind.Multi`.

Type: [Tokens](ast_package_classes.md#class-tokens)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Tokens](ast_package_classes.md#class-tokens) is not a sequence of "," lexical tokens.

### prop rBrace

```cangjie
public mut prop rBrace: Token
```

Function: Gets or sets the `}` operator token in the [ImportContent](ast_package_classes.md#class-importcontent) node. Only non-empty when `importKind` is `ImportKind.Multi`.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not a `}` operator.

### init()

```cangjie
public init()
```

Function: Constructs a default [ImportContent](ast_package_classes.md#class-importcontent) object.

### func isImportAlias()

```cangjie
public func isImportAlias(): Bool
```

Function: Determines whether the [ImportContent](ast_package_classes.md#class-importcontent) node has an alias for the imported item.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the [ImportContent](ast_package_classes.md#class-importcontent) node has an alias for the imported item.

### func isImportAll()

```cangjie
public func isImportAll(): Bool
```

Function: Determines whether the [ImportContent](ast_package_classes.md#class-importcontent) node represents a wildcard import.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the [ImportContent](ast_package_classes.md#class-importcontent) node represents a wildcard import.

### func isImportMulti()

```cangjie
public func isImportMulti(): Bool
```

Function: Determines whether the [ImportContent](ast_package_classes.md#class-importcontent) node imports multiple top-level definitions or declarations.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the [ImportContent](ast_package_classes.md#class-importcontent) node imports multiple top-level definitions or declarations.

### func isImportSingle()

```cangjie
public func isImportSingle(): Bool
```

Function: Determines whether the [ImportContent](ast_package_classes.md#class-importcontent) node represents a single import.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the [ImportContent](ast_package_classes.md#class-importcontent) node represents a single import.

## class ImportList

```cangjie
public class ImportList <: Node {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a package import node.

An [ImportList](ast_package_classes.md#class-importlist) node: `import moduleName.packageName.foo as bar`.

> **Note:**
>
> Import nodes begin with an optional accessibility modifier (`public/protected/internal/private`) followed by the `import` keyword. For example, in `import pkga.pkgb.item`, `pkga.pkgb` is the package name containing the top-level definition or declaration being imported, and `item` is the top-level definition or declaration itself.

Parent Type:

- [Node](#class-node)

### prop modifier

```cangjie
public mut prop modifier: Token
```

Function: Gets or sets the modifier in the [ImportList](ast_package_classes.md#class-importlist) node, which may be an [ILLEGAL](ast_package_enums.md#illegal) token.

Type: [Token](ast_package_structs.md#struct-token)

### prop keywordI

```cangjie
public mut prop keywordI: Token
```

Function: Gets or sets the `import` keyword token in the [ImportList](ast_package_classes.md#class-importlist) node, where `I` is the initial letter of the keyword.

Type: [Token](ast_package_structs.md#struct-token)

### prop content

```cangjie
public mut prop content: ImportContent
```

Function: Gets or sets the specific imported item in the [ImportList](ast_package_classes.md#class-importlist) node. For example, the `a.b.c` part in `import a.b.c`.

Type: [ImportContent](ast_package_classes.md#class-importcontent)

### init()

```cangjie
public init()
```

Function: Constructs a default [ImportList](ast_package_classes.md#class-importlist) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a default [ImportList](ast_package_classes.md#class-importlist) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - A sequence of lexical unit collections ([Tokens](ast_package_classes.md#class-tokens)) to construct the [ImportList](ast_package_classes.md#class-importlist) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as an [ImportList](ast_package_classes.md#class-importlist) node.

### func isImportMulti()

```cangjie
public func isImportMulti(): Bool
```

Function: Determines whether the [ImportList](ast_package_classes.md#class-importlist) node imports multiple top-level definitions or declarations.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the [ImportList](ast_package_classes.md#class-importlist) node imports multiple top-level definitions or declarations; otherwise, returns `false`.

## class IncOrDecExpr

```cangjie
public class IncOrDecExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents an expression containing increment (`++`) or decrement (`--`) operators.

Parent Type:

- [Expr](#class-expr)

### prop expr

```cangjie
public mut prop expr: Expr
```

Function: Gets or sets the expression within the [IncOrDecExpr](ast_package_classes.md#class-incordecexpr).

Type: [Expr](ast_package_classes.md#class-expr)

### prop op

```cangjie
public mut prop op: Token
```

Function: Gets or sets the operator within the [IncOrDecExpr](ast_package_classes.md#class-incordecexpr).

Type: [Token](ast_package_structs.md#struct-token)

### init()

```cangjie
public init()
```

Function: Constructs a default [IncOrDecExpr](ast_package_classes.md#class-incordecexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs an [IncOrDecExpr](ast_package_classes.md#class-incordecexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - A lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [IncOrDecExpr](ast_package_classes.md#class-incordecexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as an [IncOrDecExpr](ast_package_classes.md#class-incordecexpr) node.

## class InterfaceDecl

```cangjie
public class InterfaceDecl <: Decl {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents an interface definition node.

Interface definitions use the `interface` keyword and consist of: optional modifiers, the `interface` keyword, the interface name, optional type parameters, optional parent interface specifications, optional generic constraints, and the interface body definition.

Parent Type:

- [Decl](#class-decl)

### prop body

```cangjie
public mut prop body: Body
```

Function: Gets or sets the class body of the [InterfaceDecl](ast_package_classes.md#class-interfacedecl) node.

Type: [Body](ast_package_classes.md#class-body)

### prop superTypeBitAnds

```cangjie
public mut prop superTypeBitAnds: Tokens
```

Function: Gets or sets the sequence of `&` operator lexical units in the parent interface declaration of the [InterfaceDecl](ast_package_classes.md#class-interfacedecl) node, which may be empty.

Type: [Tokens](ast_package_classes.md#class-tokens)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Tokens](ast_package_classes.md#class-tokens) is not a sequence of `&` lexical units.

### prop superTypes

```cangjie
public mut prop superTypes: ArrayList<TypeNode>
```

Function: Gets or sets the parent interfaces of the [InterfaceDecl](ast_package_classes.md#class-interfacedecl) node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[TypeNode](ast_package_classes.md#class-typenode)>

### prop upperBound

```cangjie
public mut prop upperBound: Token
```

Function: Gets or sets the `<:` operator.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not the `<:` operator.

### init()

```cangjie
public init()
```

Function: Constructs a default [InterfaceDecl](ast_package_classes.md#class-interfacedecl) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs an [InterfaceDecl](ast_package_classes.md#class-interfacedecl) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical token collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [InterfaceDecl](ast_package_classes.md#class-interfacedecl) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as an [InterfaceDecl](ast_package_classes.md#class-interfacedecl) node.

## class IsExpr

```cangjie
public class IsExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a type-checking expression.

An [IsExpr](ast_package_classes.md#class-isexpr) expression: `e is T`, with type [Bool](../../core/core_package_api/core_package_intrinsics.md#bool). Here, `e` can be any expression, and `T` can be any type.

Parent Type:

- [Expr](#class-expr)

### prop expr

```cangjie
public mut prop expr: Expr
```

Function: Gets or sets the expression node within the [IsExpr](ast_package_classes.md#class-isexpr) node.

Type: [Expr](ast_package_classes.md#class-expr)

### prop keyword

```cangjie
public mut prop keyword: Token
```

Function: Gets or sets the `is` operator in the [IsExpr](ast_package_classes.md#class-isexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not the `is` operator.

### prop shiftType

```cangjie
public mut prop shiftType: TypeNode
```

Function: Gets or sets the target type in the [IsExpr](ast_package_classes.md#class-isexpr) node.

Type: [TypeNode](ast_package_classes.md#class-typenode)

### init()

```cangjie
public init()
```

Function: Constructs a default [IsExpr](ast_package_classes.md#class-isexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs an [IsExpr](ast_package_classes.md#class-isexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical token collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [IsExpr](ast_package_classes.md#class-isexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as an [IsExpr](ast_package_classes.md#class-isexpr) node.

## class JumpExpr

```cangjie
public class JumpExpr <: Expr {
    public init()
    public init(kind: Tokens)
}
```

Function: Represents `break` and `continue` statements within loop expression bodies.

Parent Type:

- [Expr](#class-expr)

### prop keyword

```cangjie
public mut prop keyword: Token
```

Function: Gets or sets the keyword.

Type: [Token](ast_package_structs.md#struct-token)

### init()

```cangjie
public init()
```

Function: Constructs a default [JumpExpr](ast_package_classes.md#class-jumpexpr) object.

### init(Tokens)

```cangjie
public init(kind: Tokens)
```

Function: Constructs a [JumpExpr](ast_package_classes.md#class-jumpexpr) object.

Parameters:

- kind: [Tokens](ast_package_classes.md#class-tokens) - The lexical token collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [JumpExpr](ast_package_classes.md#class-jumpexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [JumpExpr](ast_package_classes.md#class-jumpexpr) node.

## class LambdaExpr

```cangjie
public class LambdaExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a `Lambda` expression, which is an anonymous function.

A [LambdaExpr](ast_package_classes.md#class-lambdaexpr) node has two forms: one with parameters, such as `{a: Int64 => e1; e2 }`, and another without parameters, such as `{ => e1; e2 }`.

Parent Type:

- [Expr](#class-expr)

### prop doubleArrow

```cangjie
public mut prop doubleArrow: Token
```

Function: Gets or sets the `=>` in [LambdaExpr](ast_package_classes.md#class-lambdaexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not the `=>` operator.

### prop funcParams

```cangjie
public mut prop funcParams:  ArrayList<FuncParam>
```

Function: Gets or sets the parameter list in [LambdaExpr](ast_package_classes.md#class-lambdaexpr).

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[FuncParam](ast_package_classes.md#class-funcparam)>

### prop lBrace

```cangjie
public mut prop lBrace: Token
```

Function: Gets or sets the "{" in [LambdaExpr](ast_package_classes.md#class-lambdaexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "{".

### prop nodes

```cangjie
public mut prop nodes: ArrayList<Node>
```

Function: Gets or sets the expression or declaration nodes in [LambdaExpr](ast_package_classes.md#class-lambdaexpr).

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Node](ast_package_classes.md#class-node)>

### prop rBrace

```cangjie
public mut prop rBrace: Token
```

Function: Gets or sets the "}" in [LambdaExpr](ast_package_classes.md#class-lambdaexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "}".

### init()

```cangjie
public init()
```

Function: Constructs a default [LambdaExpr](ast_package_classes.md#class-lambdaexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [LambdaExpr](ast_package_classes.md#class-lambdaexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [LambdaExpr](ast_package_classes.md#class-lambdaexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [LambdaExpr](ast_package_classes.md#class-lambdaexpr) node.

## class LetPatternExpr

```cangjie
public class LetPatternExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a destructuring pattern matching node in a `let` declaration.

A [LetPatternExpr](ast_package_classes.md#class-letpatternexpr) node: `let Some(v) <- x` in `if (let Some(v) <- x)`.

Parent Type:

- [Expr](#class-expr)

### prop backArrow

```cangjie
public mut prop backArrow: Token
```

Function: Gets or sets the `<-` operator in the [LetPatternExpr](ast_package_classes.md#class-letpatternexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not the `<-` operator.

### prop expr

```cangjie
public mut prop expr: Expr
```

Function: Gets or sets the expression following the `<-` operator in the [LetPatternExpr](ast_package_classes.md#class-letpatternexpr) node.

Type: [Expr](ast_package_classes.md#class-expr)

### prop keyword

```cangjie
public mut prop keyword: Token
```

Function: Gets or sets the `let` keyword in the [LetPatternExpr](ast_package_classes.md#class-letpatternexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not the `let` keyword.

### prop pattern

```cangjie
public mut prop pattern: Pattern
```

Function: Gets or sets the pattern following `let` in the [LetPatternExpr](ast_package_classes.md#class-letpatternexpr) node.

Type: [Pattern](ast_package_classes.md#class-pattern)

### init()

```cangjie
public init()
```

Function: Constructs a default [LetPatternExpr](ast_package_classes.md#class-letpatternexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [LetPatternExpr](ast_package_classes.md#class-letpatternexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to be constructed into a [LetPatternExpr](ast_package_classes.md#class-letpatternexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed into a [LetPatternExpr](ast_package_classes.md#class-letpatternexpr) node.

## class LitConstExpr

```cangjie
public class LitConstExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a constant expression node.

A [LitConstExpr](ast_package_classes.md#class-litconstexpr) expression: `"abc"`, `123`, etc.

Parent Type:

- [Expr](#class-expr)

### prop literal

```cangjie
public mut prop literal: Token
```

Function: Gets or sets the literal in the [LitConstExpr](ast_package_classes.md#class-litconstexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

### init()

```cangjie
public init()
```

Function: Constructs a default [LitConstExpr](ast_package_classes.md#class-litconstexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [LitConstExpr](ast_package_classes.md#class-litconstexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to be constructed into a [LitConstExpr](ast_package_classes.md#class-litconstexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed into a [ParenExpr](ast_package_classes.md#class-parenexpr) node.

## class MacroDecl

```cangjie
public class MacroDecl <: Decl {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a macro definition node.

A [MacroDecl](ast_package_classes.md#class-macrodecl) node: `public macro M(input: Tokens): Tokens {...}`.

Parent Type:

- [Decl](#class-decl)

### prop block

```cangjie
public mut prop block: Block
```

Function: Gets or sets the function body of the [MacroDecl](ast_package_classes.md#class-macrodecl) node.

Type: [Block](ast_package_classes.md#class-block)

### prop colon

```cangjie
public mut prop colon: Token
```

Function: Gets or sets the colon in the [MacroDecl](ast_package_classes.md#class-macrodecl) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not a colon.

### prop declType

```cangjie
public mut prop declType: TypeNode
```

Function: Gets or sets the function return type of the [MacroDecl](ast_package_classes.md#class-macrodecl) node.

Type: [TypeNode](ast_package_classes.md#class-typenode)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the function return type of the [MacroDecl](ast_package_classes.md#class-macrodecl) node is a default value.

### prop funcParams

```cangjie
public mut prop funcParams: ArrayList<FuncParam>
```

Function: Gets or sets the parameters of the [MacroDecl](ast_package_classes.md#class-macrodecl) node.Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[FuncParam](ast_package_classes.md#class-funcparam)>

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" token of the [MacroDecl](ast_package_classes.md#class-macrodecl) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" token of the [MacroDecl](ast_package_classes.md#class-macrodecl) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not ")".

### init()

```cangjie
public init()
```

Function: Constructs a default [MacroDecl](ast_package_classes.md#class-macrodecl) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [MacroDecl](ast_package_classes.md#class-macrodecl) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [MacroDecl](ast_package_classes.md#class-macrodecl) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into a [MacroDecl](ast_package_classes.md#class-macrodecl) node.

## class MacroExpandDecl

```cangjie
public class MacroExpandDecl <: Decl {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a macro invocation node.

A [MacroExpandDecl](ast_package_classes.md#class-macroexpanddecl) node example: `@M class A {}`.

Parent Type:

- [Decl](#class-decl)

### prop fullIdentifier

```cangjie
public mut prop fullIdentifier: Token
```

Function: Gets or sets the full identifier of the macro invocation node.

Type: [Token](ast_package_structs.md#struct-token)

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" token of the [MacroExpandDecl](ast_package_classes.md#class-macroexpanddecl) macro invocation.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop lSquare

```cangjie
public mut prop lSquare: Token
```

Function: Gets or sets the "[" token of the [MacroExpandDecl](ast_package_classes.md#class-macroexpanddecl) attribute macro invocation.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "[".

### prop macroAttrs

```cangjie
public mut prop macroAttrs: Tokens
```

Function: Gets or sets the input of the [MacroExpandDecl](ast_package_classes.md#class-macroexpanddecl) attribute macro invocation.

Type: [Tokens](ast_package_classes.md#class-tokens)

### prop macroInputDecl

```cangjie
public mut prop macroInputDecl: Decl
```

Function: Gets or sets the declaration node within the [MacroExpandDecl](ast_package_classes.md#class-macroexpanddecl).

Type: [Decl](ast_package_classes.md#class-decl)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when there is no declaration node in the [MacroExpandDecl](ast_package_classes.md#class-macrodecl) node.

### prop macroInputs

```cangjie
public mut prop macroInputs: Tokens
```

Function: Gets or sets the input of the [MacroExpandDecl](ast_package_classes.md#class-macroexpanddecl) macro invocation.

Type: [Tokens](ast_package_classes.md#class-tokens)

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" for [MacroExpandDecl](ast_package_classes.md#class-macroexpanddecl) macro invocation.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws when the set [Token](ast_package_structs.md#struct-token) is not ")".

### prop rSquare

```cangjie
public mut prop rSquare: Token
```

Function: Gets or sets the "]" for [MacroExpandDecl](ast_package_classes.md#class-macroexpanddecl) attribute macro invocation.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws when the set [Token](ast_package_structs.md#struct-token) is not "]".

### init()

```cangjie
public init()
```

Function: Constructs a default [MacroExpandDecl](ast_package_classes.md#class-macroexpanddecl) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [MacroExpandDecl](ast_package_classes.md#class-macroexpanddecl) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [MacroExpandDecl](ast_package_classes.md#class-macroexpanddecl) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [MacroExpandDecl](ast_package_classes.md#class-macroexpanddecl) node.

## class MacroExpandExpr

```cangjie
public class MacroExpandExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a macro invocation node.

A [MacroExpandExpr](ast_package_classes.md#class-macroexpandexpr) node: `@M (a is Int64)`.

Parent Type:

- [Expr](#class-expr)

### prop at

```cangjie
public mut prop at: Token
```

Function: Gets or sets the `@` operator in the [MacroExpandExpr](ast_package_classes.md#class-macroexpandexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws when the set [Token](ast_package_structs.md#struct-token) is not the `@` operator.

### prop identifier

```cangjie
public mut prop identifier: Token
```

Function: Gets or sets the identifier of the macro invocation node.

Type: [Token](ast_package_structs.md#struct-token)

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" for [MacroExpandExpr](ast_package_classes.md#class-macroexpandexpr) macro invocation.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop lSquare

```cangjie
public mut prop lSquare: Token
```

Function: Gets or sets the "[" for [MacroExpandExpr](ast_package_classes.md#class-macroexpandexpr) attribute macro invocation.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws when the set [Token](ast_package_structs.md#struct-token) is not "[".

### prop macroAttrs

```cangjie
public mut prop macroAttrs: Tokens
```

Function: Gets or sets the input for [MacroExpandExpr](ast_package_classes.md#class-macroexpandexpr) attribute macro invocation.

Type: [Tokens](ast_package_classes.md#class-tokens)

### prop macroInputs

```cangjie
public mut prop macroInputs: Tokens
```

Function: Gets or sets the input for [MacroExpandExpr](ast_package_classes.md#class-macroexpandexpr) macro invocation.

Type: [Tokens](ast_package_classes.md#class-tokens)

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" for [MacroExpandExpr](ast_package_classes.md#class-macroexpandexpr) macro invocation.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws when the set [Token](ast_package_structs.md#struct-token) is not ")".

### prop rSquare

```cangjie
public mut prop rSquare: Token
```

Function: Gets or sets the "]" for the attribute macro invocation of [MacroExpandExpr](ast_package_classes.md#class-macroexpandexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "]".

### init()

```cangjie
public init()
```

Function: Constructs a default [MacroExpandExpr](ast_package_classes.md#class-macroexpandexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [MacroExpandExpr](ast_package_classes.md#class-macroexpandexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [MacroExpandExpr](ast_package_classes.md#class-macroexpandexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [MacroExpandExpr](ast_package_classes.md#class-macroexpandexpr) node.

## class MacroExpandParam

```cangjie
public class MacroExpandParam <: FuncParam {
    public init()
}
```

Function: Represents a macro invocation node.

A [MacroExpandDecl](ast_package_classes.md#class-macroexpanddecl) node: `@M a: Int64` in `func foo (@M a: Int64)`.

Parent Type:

- [FuncParam](#class-funcparam)

### prop fullIdentifier

```cangjie
public mut prop fullIdentifier: Token
```

Function: Gets or sets the full identifier of the macro invocation node.

Type: [Token](ast_package_structs.md#struct-token)

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" for the [MacroExpandParam](ast_package_classes.md#class-macroexpandparam) macro invocation.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop lSquare

```cangjie
public mut prop lSquare: Token
```

Function: Gets or sets the "[" for the attribute macro invocation of [MacroExpandParam](ast_package_classes.md#class-macroexpandparam).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "[".

### prop macroAttrs

```cangjie
public mut prop macroAttrs: Tokens
```

Function: Gets or sets the input for the attribute macro invocation of [MacroExpandParam](ast_package_classes.md#class-macroexpandparam).

Type: [Tokens](ast_package_classes.md#class-tokens)

### prop macroInputDecl

```cangjie
public mut prop macroInputDecl: Decl
```

Function: Gets or sets the declaration node in [MacroExpandParam](ast_package_classes.md#class-macroexpandparam).

Type: [Decl](ast_package_classes.md#class-decl)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when there is no declaration node in the [MacroExpandParam](ast_package_classes.md#class-macroexpandparam) node.

### prop macroInputs

```cangjie
public mut prop macroInputs: Tokens
```

Function: Gets or sets the input for the [MacroExpandParam](ast_package_classes.md#class-macroexpandparam) macro invocation.

Type: [Tokens](ast_package_classes.md#class-tokens)

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" for the [MacroExpandParam](ast_package_classes.md#class-macroexpandparam) macro invocation.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not ")".

### prop rSquare

```cangjie
public mut prop rSquare: Token
```

Function: Gets or sets the "]" for the attribute macro invocation of [MacroExpandParam](ast_package_classes.md#class-macroexpandparam).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not "]".

### init()

```cangjie
public init()
```

Function: Constructs a default [MacroExpandParam](ast_package_classes.md#class-macroexpandparam) object.

## class MacroMessage

```cangjie
public class MacroMessage
```

Function: Records messages sent by inner macros.

### func getBool(String)

```cangjie
public func getBool(key: String): Bool
```

Function: Retrieves [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) type information corresponding to the given key value.

Parameters:

- key: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The keyword name used for retrieval.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns the [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) type information corresponding to the existing key value.

Exceptions:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - Throws an exception when no [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) type information corresponds to the key value.

### func getInt64(String)

```cangjie
public func getInt64(key: String): Int64
```

Function: Retrieves [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type information corresponding to the given key value.

Parameters:

- key: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The keyword name used for retrieval.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type information corresponding to the existing key value.

Exceptions:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - Throws an exception when no [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type information corresponds to the key value.

### func getString(String)

```cangjie
public func getString(key: String): String
```

Function: Retrieves [String](../../core/core_package_api/core_package_structs.md#struct-string) type information corresponding to the given key value.

Parameters:

- key: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The keyword name used for retrieval.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - Returns the [String](../../core/core_package_api/core_package_structs.md#struct-string) type information corresponding to the existing key value.

Exceptions:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - Throws an exception when no [String](../../core/core_package_api/core_package_structs.md#struct-string) type information corresponds to the key value.

### func getTokens(String)

```cangjie
public func getTokens(key: String): Tokens
```

Function: Retrieves [Tokens](ast_package_classes.md#class-tokens) type information corresponding to the given key value.

Parameters:

- key: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The keyword name used for retrieval.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - Returns the [Tokens](ast_package_classes.md#class-tokens) type information corresponding to the existing key value.

Exceptions:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - Throws an exception when no [Tokens](ast_package_classes.md#class-tokens) type information corresponds to the key value.

### func hasItem(String)

```cangjie
public func hasItem(key: String): Bool
```

Function: Checks whether there is information corresponding to the given key value.

Parameters:

- key: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The keyword name used for retrieval.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if information corresponding to the key value exists; otherwise, returns false.

## class MainDecl

```cangjie
public class MainDecl <: Decl {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a `main` function definition node.

A [MainDecl](ast_package_classes.md#class-maindecl) node: `main() {}`.

Parent Type:

- [Decl](#class-decl)

### prop block

```cangjie
public mut prop block: Block
```

Function: Gets or sets the function body of the [MainDecl](ast_package_classes.md#class-maindecl) node.

Type: [Block](ast_package_classes.md#class-block)

### prop colon

```cangjie
public mut prop colon: Token
```

Function: Gets or sets the colon of the [MainDecl](ast_package_classes.md#class-maindecl) node.Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not a colon.

### prop declType

```cangjie
public mut prop declType: TypeNode
```

Function: Gets or sets the function return type of the [MainDecl](ast_package_classes.md#class-maindecl) node.

Type: [TypeNode](ast_package_classes.md#class-typenode)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the function return type of the [MainDecl](ast_package_classes.md#class-maindecl) node is a default value.

### prop funcParams

```cangjie
public mut prop funcParams: ArrayList<FuncParam>
```

Function: Gets or sets the function parameters of the [MainDecl](ast_package_classes.md#class-maindecl) node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[FuncParam](ast_package_classes.md#class-funcparam)>

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" token of the [MainDecl](ast_package_classes.md#class-maindecl) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" token of the [MainDecl](ast_package_classes.md#class-maindecl) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not ")".

### init()

```cangjie
public init()
```

Function: Constructs a default [MainDecl](ast_package_classes.md#class-maindecl) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [MainDecl](ast_package_classes.md#class-maindecl) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [MainDecl](ast_package_classes.md#class-maindecl) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [MainDecl](ast_package_classes.md#class-maindecl) node.

## class MatchCase

```cangjie
public class MatchCase <: Node {
    public init()
}
```

Function: Represents a `case` node in a `match` expression.

A [MatchCase](ast_package_classes.md#class-matchcase) node example: `case failScore where score > 0 => 0`.

> **Note:**
>
> - [MatchCase](ast_package_classes.md#class-matchcase) starts with the keyword `case`, followed by [Expr](ast_package_classes.md#class-expr) or one or more `pattern`s of the same kind separated by `|`, an optional `patternguard`, a `=>`, and a series of declarations or expressions.
> - This node has a strong binding relationship with [MatchExpr](ast_package_classes.md#class-matchexpr).

Parent Type:

- [Node](#class-node)

### prop arrow

```cangjie
public mut prop arrow: Token
```

Function: Gets or sets the `=>` operator token in [MatchCase](ast_package_classes.md#class-matchcase).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not the `=>` operator.

### prop bitOrs

```cangjie
public mut prop bitOrs: Tokens
```

Function: Gets or sets the sequence of `|` operator tokens in [MatchCase](ast_package_classes.md#class-matchcase), which may be empty.

Type: [Tokens](ast_package_classes.md#class-tokens)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Tokens](ast_package_classes.md#class-tokens) is not a sequence of `|` tokens.

### prop block

```cangjie
public mut prop block: Block
```

Function: Gets or sets the series of declaration or expression nodes in [MatchCase](ast_package_classes.md#class-matchcase).

Type: [Block](ast_package_classes.md#class-block)

### prop expr

```cangjie
public mut prop expr: Expr
```

Function: Gets or sets the expression node following `case` in [MatchCase](ast_package_classes.md#class-matchcase).

Type: [Expr](ast_package_classes.md#class-expr)Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when there is no expression node in the [MatchCase](ast_package_classes.md#class-matchcase) node.

### prop keywordC

```cangjie
public mut prop keywordC: Token
```

Function: Gets or sets the lexical token for the `case` keyword within [MatchCase](ast_package_classes.md#class-matchcase).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not a `case` keyword.

### prop keywordW

```cangjie
public mut prop keywordW: Token
```

Function: Gets or sets the optional `where` keyword token in [MatchCase](ast_package_classes.md#class-matchcase), which may be an [ILLEGAL](ast_package_enums.md#illegal) token.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not a `where` keyword.

### prop patternGuard

```cangjie
public mut prop patternGuard: Expr
```

Function: Gets or sets the optional pattern guard expression node in [MatchCase](ast_package_classes.md#class-matchcase).

Type: [Expr](ast_package_classes.md#class-expr)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when there is no pattern guard expression in the [MatchCase](ast_package_classes.md#class-matchcase) node.

### prop patterns

```cangjie
public mut prop patterns: ArrayList<Pattern>
```

Function: Gets or sets the list of `pattern`s following the `case` keyword in [MatchCase](ast_package_classes.md#class-matchcase).

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Pattern](ast_package_classes.md#class-pattern)>

### init()

```cangjie
public init()
```

Function: Constructs a default [MatchCase](ast_package_classes.md#class-matchcase) object.

## class MatchExpr

```cangjie
public class MatchExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a pattern matching expression that implements pattern matching.

Pattern matching expressions are divided into `match` expressions with selectors and those without selectors.

Parent Type:

- [Expr](#class-expr)

### prop keyword

```cangjie
public mut prop keyword: Token
```

Function: Gets or sets the `match` keyword in the [MatchExpr](ast_package_classes.md#class-matchexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not a `match` keyword.

### prop lBrace

```cangjie
public mut prop lBrace: Token
```

Function: Gets or sets the "{" following the [MatchExpr](ast_package_classes.md#class-matchexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "{".

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" following the [MatchExpr](ast_package_classes.md#class-matchexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop matchCases

```cangjie
public mut prop matchCases: ArrayList<MatchCase>
```

Function: Gets or sets the `matchCase` within [MatchExpr](ast_package_classes.md#class-matchexpr). A `matchCase` starts with the `case` keyword, followed by one or more [Pattern](ast_package_classes.md#class-pattern) or [Expr](ast_package_classes.md#class-expr) nodes. For details, see [MatchCase](ast_package_classes.md#class-matchcase).

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[MatchCase](ast_package_classes.md#class-matchcase)>

### prop rBrace

```cangjie
public mut prop rBrace: Token
```

Function: Gets or sets the "}" following the [MatchExpr](ast_package_classes.md#class-matchexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "}".

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the closing parenthesis ")" following a [MatchExpr](ast_package_classes.md#class-matchexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the assigned [Token](ast_package_structs.md#struct-token) is not a ")".

### prop selector

```cangjie
public mut prop selector: Expr
```

Function: Gets or sets the [Expr](ast_package_classes.md#class-expr) following the `match` keyword.

Type: [Expr](ast_package_classes.md#class-expr)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the expression is a `match` expression without a selector.

### init()

```cangjie
public init()
```

Function: Constructs a default [MatchExpr](ast_package_classes.md#class-matchexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [MatchExpr](ast_package_classes.md#class-matchexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The token collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [MatchExpr](ast_package_classes.md#class-matchexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into a [MatchExpr](ast_package_classes.md#class-matchexpr) node.

## class MemberAccess

```cangjie
public class MemberAccess <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a member access expression.

Can be used to access members of classes, interfaces, structs, etc. A [MemberAccess](ast_package_classes.md#class-memberaccess) node takes the form `T.a`, where `T` is the base expression of the member access, and `a` represents the member name.

Parent Type:

- [Expr](#class-expr)

### prop baseExpr

```cangjie
public mut prop baseExpr: Expr
```

Function: Gets or sets the base expression of the [MemberAccess](ast_package_classes.md#class-memberaccess) node.

Type: [Expr](ast_package_classes.md#class-expr)

### prop commas

```cangjie
public mut prop commas: Tokens
```

Function: Gets or sets the sequence of "," tokens in the [MemberAccess](ast_package_classes.md#class-memberaccess) node, which may be empty.

Type: [Tokens](ast_package_classes.md#class-tokens)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the assigned [Tokens](ast_package_classes.md#class-tokens) is not a sequence of "," tokens.

### prop dot

```cangjie
public mut prop dot: Token
```

Function: Gets or sets the "." token in the [MemberAccess](ast_package_classes.md#class-memberaccess) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the assigned [Token](ast_package_structs.md#struct-token) is not a "." token type.

### prop field

```cangjie
public mut prop field: Token
```

Function: Gets or sets the member name token in the [MemberAccess](ast_package_classes.md#class-memberaccess) node.

Type: [Token](ast_package_structs.md#struct-token)

### prop lAngle

```cangjie
public mut prop lAngle: Token
```

Function: Gets or sets the left angle bracket token in the [MemberAccess](ast_package_classes.md#class-memberaccess) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the assigned [Token](ast_package_structs.md#struct-token) is not a left angle bracket.

### prop rAngle

```cangjie
public mut prop rAngle: Token
```

Function: Gets or sets the right angle bracket token in the [MemberAccess](ast_package_classes.md#class-memberaccess) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the assigned [Token](ast_package_structs.md#struct-token) is not a right angle bracket.

### prop typeArguments

```cangjie
public mut prop typeArguments: ArrayList<TypeNode>
```

Function: Gets or sets the instantiation types in the [MemberAccess](ast_package_classes.md#class-memberaccess) node.Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[TypeNode](ast_package_classes.md#class-typenode)>

### init()

```cangjie
public init()
```

Function: Constructs a default [MemberAccess](ast_package_classes.md#class-memberaccess) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [MemberAccess](ast_package_classes.md#class-memberaccess) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [MemberAccess](ast_package_classes.md#class-memberaccess) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [MemberAccess](ast_package_classes.md#class-memberaccess) node.

## class Modifier

```cangjie
public class Modifier <: Node {
    public init()
    public init(keyword: Token)
}
```

Function: Represents that the definition possesses certain characteristics, typically placed at the forefront of the definition.

A [Modifier](ast_package_classes.md#class-modifier) node: The `public` in `public func foo()`.

Parent Type:

- [Node](#class-node)

### prop keyword(Token)

```cangjie
public mut prop keyword: Token
```

Function: Gets or sets the modifier lexical unit in the [Modifier](ast_package_classes.md#class-modifier) node.

Type: [Token](ast_package_structs.md#struct-token)

### init()

```cangjie
public init()
```

Function: Constructs a default [Modifier](ast_package_classes.md#class-modifier) object.

### init(Token)

```cangjie
public init(keyword: Token)
```

Function: Constructs a [Modifier](ast_package_classes.md#class-modifier) object.

Parameters:

- keyword: [Token](ast_package_structs.md#struct-token) - The lexical unit used to construct the [Modifier](ast_package_classes.md#class-modifier) type.

## class Node

```cangjie
abstract sealed class Node <: ToTokens
```

Function: The parent class of all Cangjie Abstract Syntax Tree (AST) nodes.

This class provides common operation interfaces for all data types.

Parent Type:

- [ToTokens](ast_package_interfaces.md#interface-totokens)

### prop beginPos

```cangjie
public mut prop beginPos: Position
```

Function: Gets or sets the starting position information of the current node.

Type: [Position](ast_package_structs.md#struct-position)

### prop endPos

```cangjie
public mut prop endPos: Position
```

Function: Gets or sets the ending position information of the current node.

Type: [Position](ast_package_structs.md#struct-position)

### func dump()

```cangjie
public func dump(): Unit
```

Function: Converts the current syntax tree node into a tree structure and prints it.

The tree structure of the syntax tree node will be output in the following format:

- `-` string: Represents common attributes of the current node, such as `-keyword`, `-identifier`.
- Node attributes are immediately followed by the specific type of the node, e.g., `-declType: PrimitiveType` indicates the node type is a [PrimitiveType](ast_package_classes.md#class-primitivetype) node.
- Each type uses curly braces to denote its scope.

For detailed syntax tree output format, refer to [Syntax Tree Node Printing](../ast_samples/dump.md).

### func toTokens()

```cangjie
public func toTokens(): Tokens
```

Function: Converts the syntax tree node into a [Tokens](ast_package_classes.md#class-tokens) type.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The converted [Tokens](ast_package_classes.md#class-tokens) type node.

### func traverse(Visitor)

```cangjie
public func traverse(v: Visitor): Unit
```

Function: Traverses the current syntax tree node and its child nodes. To terminate child node traversal early, override the `visit` function and call the `breakTraverse` function to terminate traversal prematurely. Refer to [Custom Visitor Function for Traversing AST Objects Example](../ast_samples/traverse.md).

Parameters:

- v: [Visitor](ast_package_classes.md#class-visitor) - An instance of the [Visitor](ast_package_classes.md#class-visitor) type.

## class OptionalExpr

```cangjie
public class OptionalExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents an expression node with a question mark operator.

An [OptionalExpr](ast_package_classes.md#class-optionalexpr) node: The `a?` in expressions like `a?.b, a?(b), a?[b]`.

Parent Type:

- [Expr](#class-expr)

### prop baseExpr

```cangjie
public mut prop baseExpr: Expr
```

Function: Gets or sets the expression node of the [OptionalExpr](ast_package_classes.md#class-optionalexpr).

Type: [Expr](ast_package_classes.md#class-expr)

### prop quest

```cangjie
public mut prop quest: Token
```

Function: Gets or sets the question mark operator in the [OptionalExpr](ast_package_classes.md#class-optionalexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not a question mark operator.

### init()

```cangjie
public init()
```

Function: Constructs a default [OptionalExpr](ast_package_classes.md#class-optionalexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs an [OptionalExpr](ast_package_classes.md#class-optionalexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The collection of lexical units ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [OptionalExpr](ast_package_classes.md#class-optionalexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into an [OptionalExpr](ast_package_classes.md#class-optionalexpr) node.

## class PackageHeader

```cangjie
public class PackageHeader <: Node {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a package declaration node.

A [PackageHeader](ast_package_classes.md#class-packageheader) node: `package define` or `macro package define`.

> **Note:**
>
> Package declarations must start with the keyword `package` or `macro package`, followed by the package name, and must appear on the first line of the source file.

Parent Type:

- [Node](#class-node)

### prop accessible

```cangjie
public mut prop accessible: Token
```

Function: Gets or sets the accessibility modifier lexical unit in the [PackageHeader](ast_package_classes.md#class-packageheader) node, which may be an [ILLEGAL](ast_package_enums.md#illegal) lexical unit.

Type: [Token](ast_package_structs.md#struct-token)

### prop keywordM

```cangjie
public mut prop keywordM: Token
```

Function: Gets or sets the `macro` keyword lexical unit in the [PackageHeader](ast_package_classes.md#class-packageheader) node (`M` stands for the first letter of the keyword, same below), which may be an [ILLEGAL](ast_package_enums.md#illegal) lexical unit.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not a `macro` keyword.

### prop keywordP

```cangjie
public mut prop keywordP: Token
```

Function: Gets or sets the `package` keyword lexical unit in the [PackageHeader](ast_package_classes.md#class-packageheader) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not a `package` keyword.

### prop prefixPaths

```cangjie
public mut prop prefixPaths: Tokens
```

Function: Gets or sets the sequence of lexical units representing the prefix part of the full package name in the [PackageHeader](ast_package_classes.md#class-packageheader) node, which may be empty. For example, `a` and `b` in `package a.b.c`.

Type: [Tokens](ast_package_classes.md#class-tokens)

### prop prefixDots

```cangjie
public mut prop prefixDots: Tokens
```

Function: Gets or sets the sequence of lexical units representing the separators between sub-package levels in the full package name within the [PackageHeader](ast_package_classes.md#class-packageheader) node, which may be empty. For example, the two "." in `package a.b.c`.

Type: [Tokens](ast_package_classes.md#class-tokens)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Tokens](ast_package_classes.md#class-tokens) are not a sequence of "." lexical units.

### prop packageIdentifier

```cangjie
public mut prop packageIdentifier: Token
```

Function: Gets or sets the name of the current package in the [PackageHeader](ast_package_classes.md#class-packageheader) node. If the current package is the root package, it returns the full package name; if it is a subpackage, it returns the name after the last ".".

Type: [Token](ast_package_structs.md#struct-token)

### init()

```cangjie
public init()
```

Function: Constructs a default [PackageHeader](ast_package_classes.md#class-packageheader) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [PackageHeader](ast_package_classes.md#class-packageheader) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The sequence of lexical unit collections ([Tokens](ast_package_classes.md#class-tokens)) to be constructed into a [PackageHeader](ast_package_classes.md#class-packageheader) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed into a [PackageHeader](ast_package_classes.md#class-packageheader) node.

## class ParenExpr

```cangjie
public class ParenExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a parenthesized expression node, which is an expression enclosed in parentheses.

Example of a [ParenExpr](ast_package_classes.md#class-parenexpr) node: `(1 + 2)`.

Parent Type:

- [Expr](#class-expr)

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" token in the [ParenExpr](ast_package_classes.md#class-parenexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop parenthesizedExpr

```cangjie
public mut prop parenthesizedExpr: Expr
```

Function: Gets or sets the subexpression enclosed in parentheses within the [ParenExpr](ast_package_classes.md#class-parenexpr) node.

Type: [Expr](ast_package_classes.md#class-expr)

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" token in the [ParenExpr](ast_package_classes.md#class-parenexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not ")".

### init()

```cangjie
public init()
```

Function: Constructs a default [ParenExpr](ast_package_classes.md#class-parenexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [ParenExpr](ast_package_classes.md#class-parenexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to be constructed into a [ParenExpr](ast_package_classes.md#class-parenexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed into a [ParenExpr](ast_package_classes.md#class-parenexpr) node.

## class ParenType

```cangjie
public class ParenType <: TypeNode {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a parenthesized type node.

Example: `(Int64)` in `var a: (Int64)`.

Parent Type:

- [TypeNode](#class-typenode)

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" token in the [ParenType](ast_package_classes.md#class-parentype) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop parenthesizedType

```cangjie
public mut prop parenthesizedType: TypeNode
```

Function: Gets or sets the enclosed type in the [ParenType](ast_package_classes.md#class-parentype) node, such as [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) in `(Int64)`.

Type: [TypeNode](ast_package_classes.md#class-typenode)

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" token in a [ParenType](ast_package_classes.md#class-parentype) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not ")".

### init()

```cangjie
public init()
```

Function: Constructs a default [ParenType](ast_package_classes.md#class-parentype) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [ParenType](ast_package_classes.md#class-parentype) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The token collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [ParenType](ast_package_classes.md#class-parentype) node.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into a [ParenType](ast_package_classes.md#class-parentype) node.

## class Pattern

```cangjie
public open class Pattern <: Node
```

Function: The parent class of all pattern matching nodes, inherits from [Node](ast_package_classes.md#class-node).

Parent Type:

- [Node](#class-node)

## class PrefixType

```cangjie
public class PrefixType <: TypeNode {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a prefix type node with a question mark.

Example: `?A` in `var a : ?A`.

Parent Type:

- [TypeNode](#class-typenode)

### prop baseType

```cangjie
public mut prop baseType: TypeNode
```

Function: Gets or sets the type node in a [PrefixType](ast_package_classes.md#class-prefixtype) node, such as `A` in `var a: ?A`.

Type: [TypeNode](ast_package_classes.md#class-typenode)

### prop prefixOps

```cangjie
public mut prop prefixOps: Tokens
```

Function: Gets or sets the collection of prefix operators in a [PrefixType](ast_package_classes.md#class-prefixtype) node.

Type: [Tokens](ast_package_classes.md#class-tokens)

### init()

```cangjie
public init()
```

Function: Constructs a default [PrefixType](ast_package_classes.md#class-prefixtype) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [PrefixType](ast_package_classes.md#class-prefixtype) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The token collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [PrefixType](ast_package_classes.md#class-prefixtype) node.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into a [PrefixType](ast_package_classes.md#class-prefixtype) node.

## class PrimaryCtorDecl

```cangjie
public class PrimaryCtorDecl <: Decl {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a primary constructor node.

A primary constructor node consists of modifiers, primary constructor name, parameter list, and primary constructor body.

Parent Type:

- [Decl](#class-decl)

### prop block

```cangjie
public mut prop block: Block
```

Function: Gets or sets the primary constructor body in a [PrimaryCtorDecl](ast_package_classes.md#class-primaryctordecl) node.

Type: [Block](ast_package_classes.md#class-block)

### prop funcParams

```cangjie
public mut prop funcParams: ArrayList<FuncParam>
```

Function: Gets or sets the parameters in a [PrimaryCtorDecl](ast_package_classes.md#class-primaryctordecl) node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[FuncParam](ast_package_classes.md#class-funcparam)>

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" token for the [PrimaryCtorDecl](ast_package_classes.md#class-primaryctordecl) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" token for the [PrimaryCtorDecl](ast_package_classes.md#class-primaryctordecl) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not ")".

### init()

```cangjie
public init()
```

Function: Constructs a default [PrimaryCtorDecl](ast_package_classes.md#class-primaryctordecl) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [PrimaryCtorDecl](ast_package_classes.md#class-primaryctordecl) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The token collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [PrimaryCtorDecl](ast_package_classes.md#class-primaryctordecl) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into a [PrimaryCtorDecl](ast_package_classes.md#class-primaryctordecl) node.

### func isConst()

```cangjie
public func isConst(): Bool
```

Function: Determines whether the node is of `Const` type.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the current node is of `Const` type; otherwise, returns false.

## class PrimitiveType

```cangjie
public class PrimitiveType <: TypeNode {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a primitive type node.

Examples include numeric types, [Rune](../../core/core_package_api/core_package_intrinsics.md#rune) type, boolean type, etc.

Parent Type:

- [TypeNode](#class-typenode)

### prop keyword

```cangjie
public mut prop keyword: Token
```

Function: Gets or sets the keyword used to construct the [PrimitiveType](ast_package_classes.md#class-primitivetype), such as [Int8](../../core/core_package_api/core_package_intrinsics.md#int8).

Type: [Token](ast_package_structs.md#struct-token)

### init()

```cangjie
public init()
```

Function: Constructs a default [PrimitiveType](ast_package_classes.md#class-primitivetype) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [PrimitiveType](ast_package_classes.md#class-primitivetype) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The token collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [PrimitiveType](ast_package_classes.md#class-primitivetype).

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into a [PrimitiveType](ast_package_classes.md#class-primitivetype) node.

## class PrimitiveTypeExpr

```cangjie
public class PrimitiveTypeExpr <: Expr {
    public init()
    public init(kind: Tokens)
}
```

Function: Represents a primitive type expression node.

[PrimitiveTypeExpr](ast_package_classes.md#class-primitivetypeexpr) node: Compiler-built-in primitive types appear as expressions in nodes. For example, [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) in [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).toSting().

Parent Type:

- [Expr](#class-expr)

### prop keyword

```cangjie
public mut prop keyword: Token
```

Function: Gets or sets the primitive type keyword in [PrimitiveTypeExpr](ast_package_classes.md#class-primitivetypeexpr).

Type: [Token](ast_package_structs.md#struct-token)

### init()

```cangjie
public init()
```

Function: Constructs a default [PrimitiveTypeExpr](ast_package_classes.md#class-primitivetypeexpr) object.

### init(Tokens)

```cangjie
public init(kind: Tokens)
```

Function: Constructs a [PrimitiveTypeExpr](ast_package_classes.md#class-primitivetypeexpr) object.

Parameters:

- kind: [Tokens](ast_package_classes.md#class-tokens) - The lexical token collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [PrimitiveTypeExpr](ast_package_classes.md#class-primitivetypeexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [PrimitiveTypeExpr](ast_package_classes.md#class-primitivetypeexpr) node.

## class Program

```cangjie
public class Program <: Node {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a Cangjie source code file node.

A Cangjie source code file node primarily includes package definition nodes, package import nodes, and all declaration nodes within the TopLevel scope.

> **Note:**
>
> Any Cangjie source code file can be parsed into a [Program](ast_package_classes.md#class-program) type.

Parent Type:

- [Node](#class-node)

### prop decls

```cangjie
public mut prop decls: ArrayList<Decl>
```

Function: Gets or sets the list of declaration nodes defined within the TopLevel scope of the Cangjie source code file.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Decl](ast_package_classes.md#class-decl)>

### prop importLists

```cangjie
public mut prop importLists: ArrayList<ImportList>
```

Function: Gets or sets the list of package import nodes [ImportList](ast_package_classes.md#class-importlist) in the Cangjie source code file.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[ImportList](ast_package_classes.md#class-importlist)>

### prop packageHeader

```cangjie
public mut prop packageHeader: PackageHeader
```

Function: Gets or sets the package declaration node [PackageHeader](ast_package_classes.md#class-packageheader) in the Cangjie source code file.

Type: [PackageHeader](ast_package_classes.md#class-packageheader)

### init()

```cangjie
public init()
```

Function: Constructs a default [Program](ast_package_classes.md#class-program) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [Program](ast_package_classes.md#class-program) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The sequence of lexical token collections ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [Program](ast_package_classes.md#class-program) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a file node.

## class PropDecl

```cangjie
public class PropDecl <: Decl {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a property declaration node.

A [PropDecl](ast_package_classes.md#class-propdecl) node example: `prop X: Int64 { get() { 0 } }`.

Parent Type:

- [Decl](#class-decl)

### prop colon

```cangjie
public mut prop colon: Token
```

Function: Gets or sets the colon token in the [PropDecl](ast_package_classes.md#class-propdecl) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not a colon.

### prop declType

```cangjie
public mut prop declType : TypeNode
```

Function: Gets or sets the return type of the [PropDecl](ast_package_classes.md#class-propdecl) node.

Type: [TypeNode](ast_package_classes.md#class-typenode)

### prop getter

```cangjie
public mut prop getter: FuncDecl
```

Function: Gets or sets the getter function of the [PropDecl](ast_package_classes.md#class-propdecl) node.

Type: [FuncDecl](ast_package_classes.md#class-funcdecl)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the [PropDecl](ast_package_classes.md#class-propdecl) node does not have a getter function.

### prop lBrace

```cangjie
public mut prop lBrace: Token
```

Function: Gets or sets the "{" for a [PropDecl](ast_package_classes.md#class-propdecl) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "{".

### prop rBrace

```cangjie
public mut prop rBrace: Token
```

Function: Gets or sets the "}" for a [PropDecl](ast_package_classes.md#class-propdecl) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "}".

### prop setter

```cangjie
public mut prop setter: FuncDecl
```

Function: Gets or sets the setter function for a [PropDecl](ast_package_classes.md#class-propdecl) node.

Type: [FuncDecl](ast_package_classes.md#class-funcdecl)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the [PropDecl](ast_package_classes.md#class-propdecl) node does not have a setter function.

### init()

```cangjie
public init()
```

Function: Constructs a default [PropDecl](ast_package_classes.md#class-propdecl) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [PropDecl](ast_package_classes.md#class-propdecl) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [PropDecl](ast_package_classes.md#class-propdecl) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into a [PropDecl](ast_package_classes.md#class-propdecl) node.

## class QualifiedType

```cangjie
public class QualifiedType <: TypeNode {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a user-defined member type.

For example, `T.a` in `var a : T.a`, where T is the package name and a is the type imported from package T.

Parent Type:

- [TypeNode](#class-typenode)

### prop baseType

```cangjie
public mut prop baseType: TypeNode
```

Function: Gets or sets the member access type subject of the [QualifiedType](ast_package_classes.md#class-qualifiedtype) node, such as `T` in `var a : T.a`.

Type: [TypeNode](ast_package_classes.md#class-typenode)

### prop commas

```cangjie
public mut prop commas: Tokens
```

Function: Gets or sets the sequence of "," lexical units in the [QualifiedType](ast_package_classes.md#class-qualifiedtype) node, which may be empty.

Type: [Tokens](ast_package_classes.md#class-tokens)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Tokens](ast_package_classes.md#class-tokens) is not a sequence of "," lexical units.

### prop dot

```cangjie
public mut prop dot: Token
```

Function: Gets or sets the "." in the [QualifiedType](ast_package_classes.md#class-qualifiedtype) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Tokens](ast_package_classes.md#class-tokens) is not a "." lexical unit.

### prop identifier

```cangjie
public mut prop identifier: Token
```

Function: Gets or sets the identifier of the member in the [QualifiedType](ast_package_classes.md#class-qualifiedtype) node, such as `a` in `var a : T.a`.

Type: [Token](ast_package_structs.md#struct-token)

### prop lAngle

```cangjie
public mut prop lAngle: Token
```

Function: Gets or sets the left angle bracket lexical unit in the [QualifiedType](ast_package_classes.md#class-qualifiedtype) node, which may be an [ILLEGAL](ast_package_enums.md#illegal) lexical unit.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not a left angle bracket.

### prop rAngle

```cangjie
public mut prop rAngle: Token
```

Function: Gets or sets the right angle bracket lexical unit in the [QualifiedType](ast_package_classes.md#class-qualifiedtype) node, which may be an [ILLEGAL](ast_package_enums.md#illegal) lexical unit.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not a right angle bracket.

### prop typeArguments

```cangjie
public mut prop typeArguments: ArrayList<TypeNode>
```

Function: Gets or sets the list of instantiated types in the [QualifiedType](ast_package_classes.md#class-qualifiedtype) node, such as [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) in `T.a<Int32>`. The list may be empty.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[TypeNode](ast_package_classes.md#class-typenode)>

### init()

```cangjie
public init()
```

Function: Constructs a default [QualifiedType](ast_package_classes.md#class-qualifiedtype) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [QualifiedType](ast_package_classes.md#class-qualifiedtype) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to be constructed as a [QualifiedType](ast_package_classes.md#class-qualifiedtype) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [QualifiedType](ast_package_classes.md#class-qualifiedtype) node.

## class QuoteExpr

```cangjie
public class QuoteExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a `quote` expression node.

A [QuoteExpr](ast_package_classes.md#class-quoteexpr) node: `quote(var ident = 0)`.

Parent Type:

- [Expr](#class-expr)

### prop exprs

```cangjie
public mut prop exprs: ArrayList<Expr>
```

Function: Gets or sets the internal quoted expression nodes enclosed by `()` in the [QuoteExpr](ast_package_classes.md#class-quoteexpr).

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Expr](ast_package_classes.md#class-expr)>

### prop keyword

```cangjie
public mut prop keyword: Token
```

Function: Gets or sets the `quote` keyword in the [QuoteExpr](ast_package_classes.md#class-quoteexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not a `quote` keyword.

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" in the [QuoteExpr](ast_package_classes.md#class-quoteexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" in the [QuoteExpr](ast_package_classes.md#class-quoteexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not ")".

### init()

```cangjie
public init()
```

Function: Constructs a default [QuoteExpr](ast_package_classes.md#class-quoteexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [QuoteExpr](ast_package_classes.md#class-quoteexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to be constructed as a [QuoteExpr](ast_package_classes.md#class-quoteexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [QuoteExpr](ast_package_classes.md#class-quoteexpr) node.

## class QuoteToken

```cangjie
public class QuoteToken <: Expr
```

Function: Represents any legal `token` within a `quote` expression node.

Parent Type:

- [Expr](#class-expr)

### prop tokens

```cangjie
public mut prop tokens: Tokens
```

Function: Gets the [Tokens](ast_package_classes.md#class-tokens) within the [QuoteToken](ast_package_classes.md#class-quotetoken).Type: [Tokens](ast_package_classes.md#class-tokens)

## class RangeExpr

```cangjie
public class RangeExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents an expression containing range operators.

[RangeExpr](ast_package_classes.md#class-rangeexpr) Node: There are two types of [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) operators: `..` and `..=`, used to create left-closed-right-open and left-closed-right-closed [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) instances respectively. Their usage formats are `start..end:step` and `start..=end:step`.

Parent Types:

- [Expr](#class-expr)

### prop colon

```cangjie
public mut prop colon: Token
```

Function: Gets or sets the ":" operator in [RangeExpr](ast_package_classes.md#class-rangeexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not a ":" operator.

### prop end

```cangjie
public mut prop end: Expr
```

Function: Gets or sets the end value in [RangeExpr](ast_package_classes.md#class-rangeexpr).

Type: [Expr](ast_package_classes.md#class-expr)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - End expression omitted. Only occurs when [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> type instances are used in empty subscript operator `[]` scenarios.

### prop op

```cangjie
public mut prop op: Token
```

Function: Gets or sets the [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) operator in [RangeExpr](ast_package_classes.md#class-rangeexpr).

Type: [Token](ast_package_structs.md#struct-token)

### prop start

```cangjie
public mut prop start: Expr
```

Function: Gets or sets the start value in [RangeExpr](ast_package_classes.md#class-rangeexpr).

Type: [Expr](ast_package_classes.md#class-expr)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Start expression omitted. Only occurs when [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> type instances are used in empty subscript operator `[]` scenarios.

### prop step

```cangjie
public mut prop step: Expr
```

Function: Gets or sets the difference between consecutive elements in the sequence within [RangeExpr](ast_package_classes.md#class-rangeexpr).

Type: [Expr](ast_package_classes.md#class-expr)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the difference between consecutive elements in the sequence is not set in [RangeExpr](ast_package_classes.md#class-rangeexpr).

### init()

```cangjie
public init()
```

Function: Constructs a default [RangeExpr](ast_package_classes.md#class-rangeexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [RangeExpr](ast_package_classes.md#class-rangeexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [RangeExpr](ast_package_classes.md#class-rangeexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [RangeExpr](ast_package_classes.md#class-rangeexpr) node.

## class RefExpr

```cangjie
public class RefExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents an expression node that references a declaration.

A [RefExpr](ast_package_classes.md#class-refexpr) node: In `var b = a + 1`, `a` is a [RefExpr](ast_package_classes.md#class-refexpr).

Parent Types:

- [Expr](#class-expr)

### prop commas

```cangjie
public mut prop commas: Tokens
```

Function: Gets or sets the sequence of "," lexical units in [RefExpr](ast_package_classes.md#class-refexpr) node, which may be empty.

Type: [Tokens](ast_package_classes.md#class-tokens)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Tokens](ast_package_classes.md#class-tokens) is not a sequence of "," lexical units.

### prop identifier

```cangjie
public mut prop identifier: Token
```

Function: Gets or sets the identifier of the custom type in [RefExpr](ast_package_classes.md#class-refexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

### prop lAngle

```cangjie
public mut prop lAngle: Token
```

Function: Gets or sets the left angle bracket in a [RefExpr](ast_package_classes.md#class-refexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not a left angle bracket.

### prop rAngle

```cangjie
public mut prop rAngle: Token
```

Function: Gets or sets the right angle bracket in a [RefExpr](ast_package_classes.md#class-refexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not a right angle bracket.

### prop typeArguments

```cangjie
public mut prop typeArguments: ArrayList<TypeNode>
```

Function: Gets or sets the instantiation types in a [RefExpr](ast_package_classes.md#class-refexpr) node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[TypeNode](ast_package_classes.md#class-typenode)>

### init()

```cangjie
public init()
```

Function: Constructs a default [RefExpr](ast_package_classes.md#class-refexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [RefExpr](ast_package_classes.md#class-refexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [RefExpr](ast_package_classes.md#class-refexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into a [RefExpr](ast_package_classes.md#class-refexpr) node.

## class RefType

```cangjie
public class RefType <: TypeNode {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a non-primitive type node.

For example, user-defined types declared via `class`, `struct`, `enum`, etc., as well as built-in types like [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt) and [String](../../core/core_package_api/core_package_structs.md#struct-string), can be represented using [RefType](ast_package_classes.md#class-reftype). For instance, `A` in `var a : A`.

Parent Type:

- [TypeNode](#class-typenode)

### prop commas

```cangjie
public mut prop commas: Tokens
```

Function: Gets or sets the sequence of "," lexical units in a [RefType](ast_package_classes.md#class-reftype) node, which may be empty.

Type: [Tokens](ast_package_classes.md#class-tokens)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Tokens](ast_package_classes.md#class-tokens) is not a sequence of "," lexical units.

### prop identifier

```cangjie
public mut prop identifier: Token
```

Function: Gets or sets the keyword used to construct the [RefType](ast_package_classes.md#class-reftype), such as `A` in `var a : A = A()`.

Type: [Token](ast_package_structs.md#struct-token)

### prop lAngle

```cangjie
public mut prop lAngle: Token
```

Function: Gets or sets the left angle bracket lexical unit in a [RefType](ast_package_classes.md#class-reftype) node, which may be an [ILLEGAL](ast_package_enums.md#illegal) lexical unit.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not a left angle bracket.

### prop rAngle

```cangjie
public mut prop rAngle: Token
```

Function: Gets or sets the right angle bracket lexical unit in a [RefType](ast_package_classes.md#class-reftype) node, which may be an [ILLEGAL](ast_package_enums.md#illegal) lexical unit.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not a right angle bracket.

### prop typeArguments

```cangjie
public mut prop typeArguments: ArrayList<TypeNode>
```

Function: Gets or sets the list of instantiation types in a [RefType](ast_package_classes.md#class-reftype) node, which may be empty. For example, [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) in `var a : Array<Int32>`.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[TypeNode](ast_package_classes.md#class-typenode)>

### init()

```cangjie
public init()
```

Function: Constructs a default [RefType](ast_package_classes.md#class-reftype) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [RefType](ast_package_classes.md#class-reftype) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical token collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [RefType](ast_package_classes.md#class-reftype) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [RefType](ast_package_classes.md#class-reftype) node.

## class ReturnExpr

```cangjie
public class ReturnExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a `return` expression node.

A [ReturnExpr](ast_package_classes.md#class-returnexpr) node example: `return 1`.

Parent Type:

- [Expr](#class-expr)

### prop expr

```cangjie
public mut prop expr: Expr
```

Function: Gets or sets the expression node within the [ReturnExpr](ast_package_classes.md#class-returnexpr) node.

Type: [Expr](ast_package_classes.md#class-expr)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the [ReturnExpr](ast_package_classes.md#class-returnexpr) node lacks an expression.

### prop keyword

```cangjie
public mut prop keyword: Token
```

Function: Gets or sets the keyword within the [ReturnExpr](ast_package_classes.md#class-returnexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not a `return` keyword.

### init()

```cangjie
public init()
```

Function: Constructs a default [ReturnExpr](ast_package_classes.md#class-returnexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [ReturnExpr](ast_package_classes.md#class-returnexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical token collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [ReturnExpr](ast_package_classes.md#class-returnexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [ReturnExpr](ast_package_classes.md#class-returnexpr) node.

## class SpawnExpr

```cangjie
public class SpawnExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a `Spawn` expression.

A [SpawnExpr](ast_package_classes.md#class-spawnexpr) node consists of the `spawn` keyword and a parameterless closure, e.g., `spawn { add(1, 2) }`.

Parent Type:

- [Expr](#class-expr)

### prop keyword

```cangjie
public mut prop keyword: Token
```

Function: Gets or sets the `spawn` keyword within the [SpawnExpr](ast_package_classes.md#class-spawnexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not a `spawn` keyword.

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" within the [SpawnExpr](ast_package_classes.md#class-spawnexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop lambdaExpr

```cangjie
public mut prop lambdaExpr: LambdaExpr
```

Function: Gets or sets the parameterless closure within the [SpawnExpr](ast_package_classes.md#class-spawnexpr).

Type: [LambdaExpr](ast_package_classes.md#class-lambdaexpr)

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" within the [SpawnExpr](ast_package_classes.md#class-spawnexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not ")".

### prop threadContext

```cangjie
public mut prop threadContext: Expr
```

Function: Gets or sets the thread context environment expression in [SpawnExpr](ast_package_classes.md#class-spawnexpr).

Type: [Expr](ast_package_classes.md#class-expr)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when [SpawnExpr](ast_package_classes.md#class-spawnexpr) lacks a context expression.

### init()

```cangjie
public init()
```

Function: Constructs a default [SpawnExpr](ast_package_classes.md#class-spawnexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [SpawnExpr](ast_package_classes.md#class-spawnexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [SpawnExpr](ast_package_classes.md#class-spawnexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [SpawnExpr](ast_package_classes.md#class-spawnexpr) node.

## class StructDecl

```cangjie
public class StructDecl <: Decl {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a `Struct` node.

Struct definitions use the `struct` keyword, with the following components in order: optional modifiers, the struct keyword, struct name, optional type parameters, optional parent interface specification, optional generic constraints, and struct body definition.

Parent Type:

- [Decl](#class-decl)

### prop body

```cangjie
public mut prop body: Body
```

Function: Gets or sets the class body of the [StructDecl](ast_package_classes.md#class-structdecl) node.

Type: [Body](ast_package_classes.md#class-body)

### prop superTypeBitAnds

```cangjie
public mut prop superTypeBitAnds: Tokens
```

Function: Gets or sets the sequence of `&` operator lexical units in the parent interface declaration of the [StructDecl](ast_package_classes.md#class-structdecl) node, which may be empty.

Type: [Tokens](ast_package_classes.md#class-tokens)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Tokens](ast_package_classes.md#class-tokens) is not a sequence of `&` lexical units.

### prop superTypes

```cangjie
public mut prop superTypes: ArrayList<TypeNode>
```

Function: Gets or sets the parent interfaces of the [StructDecl](ast_package_classes.md#class-structdecl) node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[TypeNode](ast_package_classes.md#class-typenode)>

### prop upperBound

```cangjie
public mut prop upperBound: Token
```

Function: Gets or sets the `<:` operator.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not the `<:` operator.

### init()

```cangjie
public init()
```

Function: Constructs a default [StructDecl](ast_package_classes.md#class-structdecl) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [StructDecl](ast_package_classes.md#class-structdecl) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [StructDecl](ast_package_classes.md#class-structdecl) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [StructDecl](ast_package_classes.md#class-structdecl) node.

## class SubscriptExpr

```cangjie
public class SubscriptExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents an index access expression.

[SubscriptExpr](ast_package_classes.md#class-subscriptexpr) node: Used for types that support index access (including [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt) type and `Tuple` type) to access elements at specific positions via subscripts, such as `arr[0]`.

Parent Type:

- [Expr](#class-expr)

### prop baseExpr

```cangjie
public mut prop baseExpr: Expr
```

Function: Gets or sets the expression within the [SubscriptExpr](ast_package_classes.md#class-subscriptexpr).

Type: [Expr](ast_package_classes.md#class-expr)

### prop indexList

```cangjie
public mut prop indexList: ArrayList<Expr>
```

Function: Gets or sets the sequence of index expressions within the [SubscriptExpr](ast_package_classes.md#class-subscriptexpr).

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Expr](ast_package_classes.md#class-expr)>

### prop lSquare

```cangjie
public mut prop lSquare: Token
```

Function: Gets or sets the "[" token within the [SubscriptExpr](ast_package_classes.md#class-subscriptexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not "[".

### prop rSquare

```cangjie
public mut prop rSquare: Token
```

Function: Gets or sets the "]" token within the [SubscriptExpr](ast_package_classes.md#class-subscriptexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not "]".

### init()

```cangjie
public init()
```

Function: Constructs a default [SubscriptExpr](ast_package_classes.md#class-subscriptexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [SubscriptExpr](ast_package_classes.md#class-subscriptexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical token collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [SubscriptExpr](ast_package_classes.md#class-subscriptexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed as a [SubscriptExpr](ast_package_classes.md#class-subscriptexpr) node.

## class SynchronizedExpr

```cangjie
public class SynchronizedExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a `synchronized` expression.

A [SynchronizedExpr](ast_package_classes.md#class-synchronizedexpr) node consists of the `synchronized` keyword, a `StructuredMutex` pair, and a following code block, e.g., `synchronized(m) { foo() }`.

Parent Type:

- [Expr](#class-expr)

### prop block

```cangjie
public mut prop block: Block
```

Function: Gets or sets the code block modified by the [SynchronizedExpr](ast_package_classes.md#class-synchronizedexpr).

Type: [Block](ast_package_classes.md#class-block)

### prop keyword

```cangjie
public mut prop keyword: Token
```

Function: Gets or sets the `synchronized` keyword within the [SynchronizedExpr](ast_package_classes.md#class-synchronizedexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not the `synchronized` keyword.

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" token within the [SynchronizedExpr](ast_package_classes.md#class-synchronizedexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not "(".

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" token within the [SynchronizedExpr](ast_package_classes.md#class-synchronizedexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not ")".

### prop structuredMutex

```cangjie
public mut prop structuredMutex: Expr
```

Function: Gets or sets the `StructuredMutex` object within the [SynchronizedExpr](ast_package_classes.md#class-synchronizedexpr).

Type: [Expr](ast_package_classes.md#class-expr)

### init()

```cangjie
public init()
```

Function: Constructs a default [SynchronizedExpr](ast_package_classes.md#class-synchronizedexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [SynchronizedExpr](ast_package_classes.md#class-synchronizedexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [SynchronizedExpr](ast_package_classes.md#class-synchronizedexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [SynchronizedExpr](ast_package_classes.md#class-synchronizedexpr) node.

## class ThisType

```cangjie
public class ThisType <: TypeNode {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a `This` type node.

Parent Type:

- [TypeNode](#class-typenode)

### prop keyword

```cangjie
public mut prop keyword: Token
```

Function: Gets or sets the lexical unit for the `This` keyword in the [ThisType](ast_package_classes.md#class-thistype) node.

Type: [Token](ast_package_structs.md#struct-token)

### init()

```cangjie
public init()
```

Function: Constructs a default [ThisType](ast_package_classes.md#class-thistype) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [ThisType](ast_package_classes.md#class-thistype) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [ThisType](ast_package_classes.md#class-thistype) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [ThisType](ast_package_classes.md#class-thistype) node.

## class ThrowExpr

```cangjie
public class ThrowExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a `throw` expression node.

A [ThrowExpr](ast_package_classes.md#class-throwexpr) node example: `throw Exception()`.

Parent Type:

- [Expr](#class-expr)

### prop expr

```cangjie
public mut prop expr: Expr
```

Function: Gets or sets the expression node within the [ThrowExpr](ast_package_classes.md#class-throwexpr) node.

Type: [Expr](ast_package_classes.md#class-expr)

### prop keyword

```cangjie
public mut prop keyword: Token
```

Function: Gets or sets the keyword in the [ThrowExpr](ast_package_classes.md#class-throwexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not a `throw` keyword.

### init()

```cangjie
public init()
```

Function: Constructs a default [ThrowExpr](ast_package_classes.md#class-throwexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [ThrowExpr](ast_package_classes.md#class-throwexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [ThrowExpr](ast_package_classes.md#class-throwexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [ThrowExpr](ast_package_classes.md#class-throwexpr) node.

## class Tokens

```cangjie
public open class Tokens <: ToString & Iterable<Token> & ToBytes {
    public init()
    public init(tokArray: Array<Token>)
    public init(tokArrayList: ArrayList<Token>)
}
```

Function: A wrapper type for sequences of [Token](ast_package_structs.md#struct-token).

Parent Types:- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<[Token](ast_package_structs.md#struct-token)>
- [ToBytes](ast_package_interfaces.md#interface-tobytes)

### prop size

```cangjie
public open prop size: Int64
```

Function: Gets the count of [Token](ast_package_structs.md#struct-token) objects within the [Tokens](ast_package_classes.md#class-tokens) object.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### init()

```cangjie
public init()
```

Function: Constructs a default [Tokens](ast_package_classes.md#class-tokens) object.

### init(Array\<Token>)

```cangjie
public init(tokArray: Array<Token>)
```

Function: Constructs a [Tokens](ast_package_classes.md#class-tokens) object.

Parameters:

- tokArray: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Token](ast_package_structs.md#struct-token)> - An array containing [Token](ast_package_structs.md#struct-token) objects of type [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt).

### init(ArrayList\<Token>)

```cangjie
public init(tokArrayList: ArrayList<Token>)
```

Function: Constructs a [Tokens](ast_package_classes.md#class-tokens) object.

Parameters:

- tokArrayList: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Token](ast_package_structs.md#struct-token)> - A collection containing [Token](ast_package_structs.md#struct-token) objects of type [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt).

### func append(Node)

```cangjie
public func append(node: Node): Tokens
```

Function: Concatenates the current [Tokens](ast_package_classes.md#class-tokens) with the [Tokens](ast_package_classes.md#class-tokens) converted from the input node.

Parameters:

- node: [Node](ast_package_classes.md#class-node) - The [Node](ast_package_classes.md#class-node) object to be concatenated.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The concatenated [Tokens](ast_package_classes.md#class-tokens) object.

### func append(Token)

```cangjie
public open func append(token: Token): Tokens
```

Function: Concatenates the current [Tokens](ast_package_classes.md#class-tokens) with the input [Token](ast_package_structs.md#struct-token).

Parameters:

- token: [Token](ast_package_structs.md#struct-token) - The [Token](ast_package_structs.md#struct-token) object to be concatenated.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The concatenated [Tokens](ast_package_classes.md#class-tokens) object.

### func append(Tokens)

```cangjie
public open func append(tokens: Tokens): Tokens
```

Function: Appends the input [Tokens](ast_package_classes.md#class-tokens) to the current [Tokens](ast_package_classes.md#class-tokens) (this interface performs better than other concatenation functions).

Parameters:

- tokens: [Tokens](ast_package_classes.md#class-tokens) - The [Tokens](ast_package_classes.md#class-tokens) object to be concatenated.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The concatenated [Tokens](ast_package_classes.md#class-tokens) object.

### func concat(Tokens)

```cangjie
public func concat(tokens: Tokens): Tokens
```

Function: Concatenates the current [Tokens](ast_package_classes.md#class-tokens) with the input [Tokens](ast_package_classes.md#class-tokens).

Parameters:

- tokens: [Tokens](ast_package_classes.md#class-tokens) - The [Tokens](ast_package_classes.md#class-tokens) object to be concatenated.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The concatenated [Tokens](ast_package_classes.md#class-tokens) object.

### func dump()

```cangjie
public func dump(): Unit
```

Function: Prints all [Token](ast_package_structs.md#struct-token) information within the [Tokens](ast_package_classes.md#class-tokens) object.

### func get(Int64)

```cangjie
public open func get(index: Int64): Token
```

Function: Retrieves a [Token](ast_package_structs.md#struct-token) element by index.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index value to query.

Return Value:

- [Token](ast_package_structs.md#struct-token) - The [Token](ast_package_structs.md#struct-token) at the specified index.

Exceptions:

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Thrown when `index` is invalid.

### func iterator()

```cangjie
public func iterator(): TokensIterator
```

Function: Gets an iterator object for the [Tokens](ast_package_classes.md#class-tokens) object.

Return Value:

- [TokensIterator](ast_package_classes.md#class-tokensiterator) - The iterator object for the [Tokens](ast_package_classes.md#class-tokens) object.

### func remove(Int64)

```cangjie
public func remove(index: Int64): Tokens
```

Function: Removes the [Token](ast_package_structs.md#struct-token) object at the specified position.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index of the [Token](ast_package_structs.md#struct-token) to be removed.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The [Tokens](ast_package_classes.md#class-tokens) object after removing the specified [Token](ast_package_structs.md#struct-token).

### func toBytes()

```cangjie
public func toBytes(): Array<UInt8>
```

Function: Serializes the Tokens type.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - The serialized byte sequence.

### func toString()

```cangjie
public func toString(): String
```

Function: Converts [Tokens](ast_package_classes.md#class-tokens) to [String](../../core/core_package_api/core_package_structs.md#struct-string) type.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The converted string.

### operator func +(Token)

```cangjie
public operator func +(r: Token): Tokens
```

Function: Concatenates the current [Tokens](ast_package_classes.md#class-tokens) with another [Token](ast_package_structs.md#struct-token) to obtain a new [Tokens](ast_package_classes.md#class-tokens).

Parameters:

- r: [Token](ast_package_structs.md#struct-token) - Another [Token](ast_package_structs.md#struct-token) object to be operated on.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The new lexical unit collection after concatenation.

### operator func +(Tokens)

```cangjie
public operator func +(r: Tokens): Tokens
```

Function: Concatenates the current [Tokens](ast_package_classes.md#class-tokens) with another [Tokens](ast_package_classes.md#class-tokens) to obtain a new [Tokens](ast_package_classes.md#class-tokens) type.

Parameters:

- r: [Tokens](ast_package_classes.md#class-tokens) - Another set of [Tokens](ast_package_classes.md#class-tokens) objects to be operated on.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The new lexical unit collection after concatenation.

### operator func [](Int64)

```cangjie
public operator func [](index: Int64): Token
```

Function: Operator overload to retrieve the corresponding [Token](ast_package_structs.md#struct-token) by index value.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index value to be queried.

Return Value:

- [Token](ast_package_structs.md#struct-token) - The [Token](ast_package_structs.md#struct-token) corresponding to the index.

Exceptions:

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Thrown when `index` is invalid.

### operator func [](Range<Int64>)

```cangjie
public open operator func [](range: Range<Int64>): Tokens
```

Function: Operator overload to retrieve the corresponding [Tokens](ast_package_classes.md#class-tokens) slice by `range`.

Parameters:

- range: [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> - The slice range to be indexed.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The [Tokens](ast_package_classes.md#class-tokens) corresponding to the slice index.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when `range.step` is not equal to 1.
- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Thrown when the range is invalid.

## class TokensIterator

```cangjie
public class TokensIterator <: Iterator<Token> {
    public init(tokens: Tokens)
}
```

Function: Implements iterator functionality for [Tokens](ast_package_classes.md#class-tokens).

Parent Type:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<[Token](ast_package_structs.md#struct-token)>

### init(Tokens)

```cangjie
public init(tokens: Tokens)
```

Function: Constructs a [TokensIterator](ast_package_classes.md#class-tokensiterator) object.

Parameters:

- tokens: [Tokens](ast_package_classes.md#class-tokens) - The input [Tokens](ast_package_classes.md#class-tokens).

### func next()

```cangjie
public func next(): Option<Token>
```

Function: Retrieves the next value in the iterator.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Token](ast_package_structs.md#struct-token)> - Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Token](ast_package_structs.md#struct-token)>. Returns None when traversal is complete.

### func peek()

```cangjie
public func peek(): Option<Token>
```

Function: Retrieves the current value in the iterator.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Token](ast_package_structs.md#struct-token)> - Returns the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Token](ast_package_structs.md#struct-token)> type. Returns None when iteration is complete.

### func seeing(TokenKind)

```cangjie
public func seeing(kind: TokenKind): Bool
```

Function: Determines whether the current node's [Token](ast_package_structs.md#struct-token) type matches the input type.

Parameters:

- kind: [TokenKind](ast_package_enums.md#enum-tokenkind) - The [TokenKind](ast_package_enums.md#enum-tokenkind) type to be checked.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the current node's [TokenKind](ast_package_enums.md#enum-tokenkind) matches the input type; otherwise, returns false.

## class TrailingClosureExpr

```cangjie
public class TrailingClosureExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a trailing `Lambda` node.

A [TrailingClosureExpr](ast_package_classes.md#class-trailingclosureexpr) node places the lambda expression at the tail of a function call, outside the parentheses, e.g., `f(a){ i => i * i }`.

Parent Type:

- [Expr](#class-expr)

### prop expr

```cangjie
public mut prop expr: Expr
```

Function: Gets or sets the expression within the [TrailingClosureExpr](ast_package_classes.md#class-trailingclosureexpr).

Type: [Expr](ast_package_classes.md#class-expr)

### prop lambdaExpr

```cangjie
public mut prop lambdaExpr: LambdaExpr
```

Function: Gets or sets the trailing lambda within the [TrailingClosureExpr](ast_package_classes.md#class-trailingclosureexpr).

Type: [LambdaExpr](ast_package_classes.md#class-lambdaexpr)

### init()

```cangjie
public init()
```

Function: Constructs a default [TrailingClosureExpr](ast_package_classes.md#class-trailingclosureexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [TrailingClosureExpr](ast_package_classes.md#class-trailingclosureexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [TrailingClosureExpr](ast_package_classes.md#class-trailingclosureexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed into a [TrailingClosureExpr](ast_package_classes.md#class-trailingclosureexpr) node.

## class TryExpr

```cangjie
public class TryExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a `try` expression node.

A `try` expression consists of three parts: the `try` block, `catch` block(s), and `finally` block.

Parent Type:

- [Expr](#class-expr)

### prop catchBlocks

```cangjie
public mut prop catchBlocks: ArrayList<Block>
```

Function: Gets or sets the Catch block(s) within the [TryExpr](ast_package_classes.md#class-tryexpr).

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Block](ast_package_classes.md#class-block)>

### prop catchPatterns

```cangjie
public mut prop catchPatterns: ArrayList<Pattern>
```

Function: Gets or sets the sequence of exceptions to be caught via pattern matching in the [TryExpr](ast_package_classes.md#class-tryexpr).

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Pattern](ast_package_classes.md#class-pattern)>

### prop finallyBlock

```cangjie
public mut prop finallyBlock: Block
```

Function: Gets or sets the `Finally` keyword block within the [TryExpr](ast_package_classes.md#class-tryexpr).

Type: [Block](ast_package_classes.md#class-block)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the [TryExpr](ast_package_classes.md#class-tryexpr) node lacks a `Finally` block node.

### prop keywordF

```cangjie
public mut prop keywordF: Token
```

Function: Gets or sets the `finally` keyword within the [TryExpr](ast_package_classes.md#class-tryexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not the `finally` keyword.

### prop keywordT

```cangjie
public mut prop keywordT: Token
```

Function: Gets or sets the `try` keyword in [TryExpr](ast_package_classes.md#class-tryexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not the `try` keyword.

### prop keywordsC

```cangjie
public mut prop keywordsC: Tokens
```

Function: Gets or sets the `catch` keyword in [TryExpr](ast_package_classes.md#class-tryexpr).

Type: [Tokens](ast_package_classes.md#class-tokens)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not the `catch` keyword.

### prop resourceSpec

```cangjie
public mut prop resourceSpec: ArrayList<VarDecl>
```

Function: Gets or sets the sequence of instantiated objects for Try-with-resources type expressions in [TryExpr](ast_package_classes.md#class-tryexpr).

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[VarDecl](ast_package_classes.md#class-vardecl)>

### prop tryBlock

```cangjie
public mut prop tryBlock: Block
```

Function: Gets or sets the block composed of expressions and declarations in [TryExpr](ast_package_classes.md#class-tryexpr).

Type: [Block](ast_package_classes.md#class-block)

### init()

```cangjie
public init()
```

Function: Constructs a default [TryExpr](ast_package_classes.md#class-tryexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [TryExpr](ast_package_classes.md#class-tryexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [TryExpr](ast_package_classes.md#class-tryexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [TryExpr](ast_package_classes.md#class-tryexpr) node.

## class TupleLiteral

```cangjie
public class TupleLiteral <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a tuple literal node.

[TupleLiteral](ast_package_classes.md#class-tupleliteral) node: Uses the format `(expr1, expr2, ... , exprN)` where each `expr` is an expression.

Parent Type:

- [Expr](#class-expr)

### prop elements

```cangjie
public mut prop elements: ArrayList<Expr>
```

Function: Gets or sets the list of expressions in [TupleLiteral](ast_package_classes.md#class-tupleliteral).

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Expr](ast_package_classes.md#class-expr)>

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" in [TupleLiteral](ast_package_classes.md#class-tupleliteral).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" in [TupleLiteral](ast_package_classes.md#class-tupleliteral).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not ")".

### init()

```cangjie
public init()
```

Function: Constructs a default [TupleLiteral](ast_package_classes.md#class-tupleliteral) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [TupleLiteral](ast_package_classes.md#class-tupleliteral) object.

Parameters:- inputs: [Tokens](ast_package_classes.md#class-tokens) - The collection of lexical units ([Tokens](ast_package_classes.md#class-tokens)) to be constructed into a [TupleLiteral](ast_package_classes.md#class-tupleliteral) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into a [TupleLiteral](ast_package_classes.md#class-tupleliteral) node.

## class TuplePattern

```cangjie
public class TuplePattern <: Pattern {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a Tuple pattern node.

Used for matching `tuple` values, such as `("Bob", age)` in `case ("Bob", age) => 1`.

Parent Type:

- [Pattern](#class-pattern)

### prop commas

```cangjie
public mut prop commas: Tokens
```

Function: Gets or sets the sequence of "," lexical units in the [TuplePattern](ast_package_classes.md#class-tuplepattern) node, which may be empty.

Type: [Tokens](ast_package_classes.md#class-tokens)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Tokens](ast_package_classes.md#class-tokens) is not a sequence of "," lexical units.

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" lexical unit in the [TuplePattern](ast_package_classes.md#class-tuplepattern) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop patterns

```cangjie
public mut prop patterns: ArrayList<Pattern>
```

Function: Gets or sets a group of [Pattern](ast_package_classes.md#class-pattern) nodes in the [TuplePattern](ast_package_classes.md#class-tuplepattern) node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Pattern](ast_package_classes.md#class-pattern)>

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" lexical unit in the [TuplePattern](ast_package_classes.md#class-tuplepattern) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not ")".

### init()

```cangjie
public init()
```

Function: Constructs a default [TuplePattern](ast_package_classes.md#class-tuplepattern) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [TuplePattern](ast_package_classes.md#class-tuplepattern) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The collection of lexical units ([Tokens](ast_package_classes.md#class-tokens)) to be constructed into a [TuplePattern](ast_package_classes.md#class-tuplepattern) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into a [TuplePattern](ast_package_classes.md#class-tuplepattern) node.

## class TupleType

```cangjie
public class TupleType <: TypeNode {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a tuple type node.

For example, `(Int64, Int32)` in `var a : (Int64, Int32)`.

Parent Type:

- [TypeNode](#class-typenode)

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" lexical unit in the [TupleType](ast_package_classes.md#class-tupletype) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" lexical unit in the [TupleType](ast_package_classes.md#class-tupletype) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not ")".

### prop types

```cangjie
public mut prop types: ArrayList<TypeNode>
```

Function: Gets or sets the list of type nodes in a [TupleType](ast_package_classes.md#class-tupletype) node.

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[TypeNode](ast_package_classes.md#class-typenode)>

### init()

```cangjie
public init()
```

Function: Constructs a default [TupleType](ast_package_classes.md#class-tupletype) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [TupleType](ast_package_classes.md#class-tupletype) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical token collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [TupleType](ast_package_classes.md#class-tupletype).

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into a [TupleType](ast_package_classes.md#class-tupletype) node.

## class TypeAliasDecl

```cangjie
public class TypeAliasDecl <: Decl {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a type alias node.

A [TypeAliasDecl](ast_package_classes.md#class-typealiasdecl) node example: `type Point2D = Float64`.

> **Note:**
>
> In this node, `type` serves as a keyword followed by any valid identifier. The subsequent `type` can be any top-level visible type, with the identifier and `type` connected by `=`.

Parent Type:

- [Decl](#class-decl)

### prop aliasType

```cangjie
public mut prop aliasType: TypeNode
```

Function: Gets or sets the type to be aliased.

Type: [TypeNode](ast_package_classes.md#class-typenode)

### prop assign

```cangjie
public mut prop assign: Token
```

Function: Gets or sets the `=` between the identifier and `type`.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not `=`.

### init()

```cangjie
public init()
```

Function: Constructs a default [TypeAliasDecl](ast_package_classes.md#class-typealiasdecl) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [TypeAliasDecl](ast_package_classes.md#class-typealiasdecl) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical token collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [TypeAliasDecl](ast_package_classes.md#class-typealiasdecl).

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into a [TypeAliasDecl](ast_package_classes.md#class-typealiasdecl) node.

## class TypeConvExpr

```cangjie
public class TypeConvExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a type conversion expression.

Used to implement conversions between various numeric types. A [TypeConvExpr](ast_package_classes.md#class-typeconvexpr) node example: `Int8(32)`.

Parent Type:

- [Expr](#class-expr)

### prop expr

```cangjie
public mut prop expr: Expr
```

Function: Gets or sets the original expression to be type-converted in [TypeConvExpr](ast_package_classes.md#class-typeconvexpr).

Type: [Expr](ast_package_classes.md#class-expr)

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" in [TypeConvExpr](ast_package_classes.md#class-typeconvexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" in [TypeConvExpr](ast_package_classes.md#class-typeconvexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not ")".

### prop targetType

```cangjie
public mut prop targetType: PrimitiveType
```

Function: Gets or sets the target type to be converted to in [TypeConvExpr](ast_package_classes.md#class-typeconvexpr).

Type: [PrimitiveType](ast_package_classes.md#class-primitivetype)

### init()

```cangjie
public init()
```

Function: Constructs a default [TypeConvExpr](ast_package_classes.md#class-typeconvexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [TypeConvExpr](ast_package_classes.md#class-typeconvexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [TypeConvExpr](ast_package_classes.md#class-typeconvexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [TypeConvExpr](ast_package_classes.md#class-typeconvexpr) node.

## class TypeNode

```cangjie
public open class TypeNode <: Node
```

Function: The parent class of all type nodes, inherits from [Node](ast_package_classes.md#class-node).

Parent Type:

- [Node](#class-node)

### prop typeParameterName

```cangjie
public mut prop typeParameterName: Token
```

Function: Gets or sets the parameters of the type node, such as `p1` and `p2` in `(p1:Int64, p2:Int64)`, which may be [ILLEGAL](ast_package_enums.md#illegal) lexical units.

Type: [Token](ast_package_structs.md#struct-token)

### prop colon

```cangjie
public mut prop colon: Token
```

Function: Gets or sets the operator ":" in the [TypeNode](ast_package_classes.md#class-typenode) node, which may be an [ILLEGAL](ast_package_enums.md#illegal) lexical unit.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not the ":" operator.

## class TypePattern

```cangjie
public class TypePattern <: Pattern {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a type pattern node.

Used to determine whether the runtime type of a value is a subtype of a certain type, such as `b: Base` in `case b: Base => 0`.

Parent Type:

- [Pattern](#class-pattern)

### prop colon

```cangjie
public mut prop colon: Token
```

Function: Gets or sets the lexical unit node of the ":" operator in the [TypePattern](ast_package_classes.md#class-typepattern) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not the ":" operator.

### prop pattern

```cangjie
public mut prop pattern: Pattern
```

Function: Gets or sets the pattern node in the [TypePattern](ast_package_classes.md#class-typepattern) node.

Type: [Pattern](ast_package_classes.md#class-pattern)

### prop patternType

```cangjie
public mut prop patternType: TypeNode
```

Function: Gets or sets the pattern type node to be matched in the [TypePattern](ast_package_classes.md#class-typepattern) node.

Type: [TypeNode](ast_package_classes.md#class-typenode)

### init()

```cangjie
public init()
```

Function: Constructs a default [TypePattern](ast_package_classes.md#class-typepattern) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [TypePattern](ast_package_classes.md#class-typepattern) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [TypePattern](ast_package_classes.md#class-typepattern) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [TypePattern](ast_package_classes.md#class-typepattern) node.

## class UnaryExpr

```cangjie
public class UnaryExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a unary operation expression node.

Parent Types:

- [Expr](#class-expr)

### prop expr

```cangjie
public mut prop expr: Expr
```

Function: Gets or sets the operand in the [UnaryExpr](ast_package_classes.md#class-unaryexpr) node.

Type: [Expr](ast_package_classes.md#class-expr)

### prop op

```cangjie
public mut prop op: Token
```

Function: Gets or sets the unary operator in the [UnaryExpr](ast_package_classes.md#class-unaryexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

### init()

```cangjie
public init()
```

Function: Constructs a default [UnaryExpr](ast_package_classes.md#class-unaryexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [UnaryExpr](ast_package_classes.md#class-unaryexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [UnaryExpr](ast_package_classes.md#class-unaryexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [UnaryExpr](ast_package_classes.md#class-unaryexpr) node.

## class VArrayExpr

```cangjie
public class VArrayExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a `VArray` instance node.

A [VArrayExpr](ast_package_classes.md#class-varrayexpr) node: The `VArray<Int64, $5>({ i => i })` in `let arr: VArray<Int64, $5> = VArray<Int64, $5>({ i => i })`.

Parent Types:

- [Expr](#class-expr)

### prop arguments

```cangjie
public mut prop arguments: ArrayList<Argument>
```

Function: Gets or sets the initialization parameter sequence in the [VArrayExpr](ast_package_classes.md#class-varrayexpr).

Type: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<[Argument](ast_package_classes.md#class-argument)>

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" in the [VArrayExpr](ast_package_classes.md#class-varrayexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" in the [VArrayExpr](ast_package_classes.md#class-varrayexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not ")".

### prop vArrayType

```cangjie
public mut prop vArrayType: VArrayType
```

Function: Gets or sets the VArray type node in the [VArrayExpr](ast_package_classes.md#class-varrayexpr).

Type: [VArrayType](ast_package_classes.md#class-varraytype)

### init()

```cangjie
public init()
```

Function: Constructs a default [VArrayExpr](ast_package_classes.md#class-varrayexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [VArrayExpr](ast_package_classes.md#class-varrayexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [VArrayExpr](ast_package_classes.md#class-varrayexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [VArrayExpr](ast_package_classes.md#class-varrayexpr) node.

## class VArrayType

```cangjie
public class VArrayType <: TypeNode {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a `VArray` type node.

Uses generics `VArray<T, size: Int64>` to denote the `VArray` type.

Parent Type:

- [TypeNode](#class-typenode)

### prop dollar

```cangjie
public mut prop dollar: Token
```

Function: Gets or sets the lexical token for the operator `$` in the [VArrayType](ast_package_classes.md#class-varraytype) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not a `$` lexical token.

### prop elementTy

```cangjie
public mut prop elementTy: TypeNode
```

Function: Gets or sets the type argument node in the [VArrayType](ast_package_classes.md#class-varraytype) node, such as [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) in `VArray<Int16, $0>`.

Type: [TypeNode](ast_package_classes.md#class-typenode)

### prop keyword

```cangjie
public mut prop keyword: Token
```

Function: Gets or sets the lexical token for the keyword `VArray` in the [VArrayType](ast_package_classes.md#class-varraytype) node.

Type: [Token](ast_package_structs.md#struct-token)

### prop lAngle

```cangjie
public mut prop lAngle: Token
```

Function: Gets or sets the lexical token for the left angle bracket in the [VArrayType](ast_package_classes.md#class-varraytype) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not a left angle bracket.

### prop rAngle

```cangjie
public mut prop rAngle: Token
```

Function: Gets or sets the lexical token for the right angle bracket in the [VArrayType](ast_package_classes.md#class-varraytype) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not a right angle bracket.

### prop size

```cangjie
public mut prop size: Token
```

Function: Gets or sets the lexical token for the type length in the [VArrayType](ast_package_classes.md#class-varraytype) node.

Type: [Token](ast_package_structs.md#struct-token)

### init()

```cangjie
public init()
```

Function: Constructs a default [VArrayType](ast_package_classes.md#class-varraytype) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [VArrayType](ast_package_classes.md#class-varraytype) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The collection of lexical tokens ([Tokens](ast_package_classes.md#class-tokens)) used to construct the [VArrayType](ast_package_classes.md#class-varraytype) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the input [Tokens](ast_package_classes.md#class-tokens) cannot be constructed into a [VArrayType](ast_package_classes.md#class-varraytype) node.

## class VarDecl

```cangjie
public class VarDecl <: Decl {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a variable declaration node.

A [VarDecl](ast_package_classes.md#class-vardecl) node: `var a: String`, `var b: Int64 = 1`.

> **Note:**
>
> Variable declarations mainly include the following components: modifiers, keywords, patternsMaybeIrrefutable, variable types, and variable initial values.

Parent Type:

- [Decl](#class-decl)

### prop assign

```cangjie
public mut prop assign: Token
```

Function: Gets or sets the position information for the assignment operator in the [VarDecl](ast_package_classes.md#class-vardecl) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Throws an exception when the set [Token](ast_package_structs.md#struct-token) is not an assignment operator.

### prop colon

```cangjie
public mut prop colon: Token
```

Function: Gets or sets the position information for the colon in the [VarDecl](ast_package_classes.md#class-vardecl) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the provided [Token](ast_package_structs.md#struct-token) is not a colon.

### prop declType

```cangjie
public mut prop declType: TypeNode
```

Function: Gets or sets the variable type of the [VarDecl](ast_package_classes.md#class-vardecl) node.

Type: [TypeNode](ast_package_classes.md#class-typenode)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the [VarDecl](ast_package_classes.md#class-vardecl) node has no declared variable type.

### prop expr

```cangjie
public mut prop expr: Expr
```

Function: Gets or sets the variable initialization node of the [VarDecl](ast_package_classes.md#class-vardecl) node.

Type: [Expr](ast_package_classes.md#class-expr)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the [VarDecl](ast_package_classes.md#class-vardecl) node has no variable initialization.

### prop pattern

```cangjie
public mut prop pattern: Pattern
```

Function: Gets or sets the pattern node of the [VarDecl](ast_package_classes.md#class-vardecl) node.

Type: [Pattern](ast_package_classes.md#class-pattern)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the [VarDecl](ast_package_classes.md#class-vardecl) node has no declared pattern node.

### init()

```cangjie
public init()
```

Function: Constructs a default [VarDecl](ast_package_classes.md#class-vardecl) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [VarDecl](ast_package_classes.md#class-vardecl) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to construct the [VarDecl](ast_package_classes.md#class-vardecl) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [VarDecl](ast_package_classes.md#class-vardecl) node.

### func isConst()

```cangjie
public func isConst(): Bool
```

Function: Determines whether this is a `Const` type node.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if it is a `Const` type node; otherwise, returns false.

## class VarOrEnumPattern

```cangjie
public class VarOrEnumPattern <: Pattern {
    public init()
    public init(identifier: Token)
}
```

Function: Represents the node when the pattern identifier is an `Enum` constructor.

For example, `RED` in `case RED` is an `Enum` constructor.

Parent Type:

- [Pattern](#class-pattern)

### prop identifier

```cangjie
public mut prop identifier: Token
```

Function: Gets or sets the lexical unit of the identifier in the [VarOrEnumPattern](ast_package_classes.md#class-varorenumpattern) node.

Type: [Token](ast_package_structs.md#struct-token)

### init()

```cangjie
public init()
```

Function: Constructs a default [VarOrEnumPattern](ast_package_classes.md#class-varorenumpattern) object.

### init(Tokens)

```cangjie
public init(identifier: Token)
```

Function: Constructs a [VarOrEnumPattern](ast_package_classes.md#class-varorenumpattern) object.

Parameters:

- identifier: [Token](ast_package_structs.md#struct-token) - The lexical unit to construct the [VarOrEnumPattern](ast_package_classes.md#class-varorenumpattern) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [VarOrEnumPattern](ast_package_classes.md#class-varorenumpattern) node.

## class VarPattern

```cangjie
public class VarPattern <: Pattern {
    public init()
    public init(identifier: Token)
}
```

Function: Represents a binding pattern node.

Expressed using a valid identifier, such as `i` in `for (i in 1..10)`.

Parent Type:- [Pattern](#class-pattern)

### prop identifier

```cangjie
public mut prop identifier: Token
```

Function: Gets or sets the lexical token for the identifier in a [VarPattern](ast_package_classes.md#class-varpattern) node.

Type: [Token](ast_package_structs.md#struct-token)

### init()

```cangjie
public init()
```

Function: Constructs a default [VarPattern](ast_package_classes.md#class-varpattern) object.

### init(Tokens)

```cangjie
public init(identifier: Token)
```

Function: Constructs a [VarPattern](ast_package_classes.md#class-varpattern) object.

Parameters:

- identifier: [Token](ast_package_structs.md#struct-token) - The lexical token to construct the [VarPattern](ast_package_classes.md#class-varpattern) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [VarPattern](ast_package_classes.md#class-varpattern) node.

## class Visitor

```cangjie
public abstract class Visitor
```

Function: An abstract class that internally defines default `visit` functions for accessing different types of AST nodes.

> **Note:**
>
> - The `visit` functions are used in conjunction with `traverse` to enable node access and modification. All `visit` functions have empty implementations by default, allowing selective implementation as needed.
> - This class must be inherited and allows subclasses to redefine the visit functions.

### func breakTraverse()

```cangjie
public func breakTraverse(): Unit
```

Function: Used within overridden `visit` functions to terminate further traversal of child nodes by calling this function.

## class WhileExpr

```cangjie
public class WhileExpr <: Expr {
    public init()
    public init(inputs: Tokens)
}
```

Function: Represents a `while` expression.

`while` is a keyword, followed by parentheses containing either an expression or a destructuring `let` declaration, then a [Block](ast_package_classes.md#class-block) node.

Parent Type:

- [Expr](#class-expr)

### prop block

```cangjie
public mut prop block: Block
```

Function: Gets or sets the block node in [WhileExpr](ast_package_classes.md#class-whileexpr).

Type: [Block](ast_package_classes.md#class-block)

### prop condition

```cangjie
public mut prop condition: Expr
```

Function: Gets or sets the conditional expression in the [WhileExpr](ast_package_classes.md#class-whileexpr) keyword.

Type: [Expr](ast_package_classes.md#class-expr)

### prop keyword

```cangjie
public mut prop keyword: Token
```

Function: Gets or sets the `while` keyword in the [WhileExpr](ast_package_classes.md#class-whileexpr) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not the `while` keyword.

### prop lParen

```cangjie
public mut prop lParen: Token
```

Function: Gets or sets the "(" following the `while` keyword in [WhileExpr](ast_package_classes.md#class-whileexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not "(".

### prop rParen

```cangjie
public mut prop rParen: Token
```

Function: Gets or sets the ")" following the `while` keyword in [WhileExpr](ast_package_classes.md#class-whileexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not ")".

### init()

```cangjie
public init()
```

Function: Constructs a default [WhileExpr](ast_package_classes.md#class-whileexpr) object.

### init(Tokens)

```cangjie
public init(inputs: Tokens)
```

Function: Constructs a [WhileExpr](ast_package_classes.md#class-whileexpr) object.

Parameters:

- inputs: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to be constructed as a [WhileExpr](ast_package_classes.md#class-whileexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [WhileExpr](ast_package_classes.md#class-whileexpr) node.

## class WildcardExpr

```cangjie
public class WildcardExpr <: Expr {
    public init()
    public init(keyword: Tokens)
}
```

Function: Represents a wildcard expression node.

Parent Type:

- [Expr](#class-expr)

### prop keyword

```cangjie
public mut prop keyword: Token
```

Function: Gets the "_" keyword of [WildcardExpr](ast_package_classes.md#class-wildcardexpr).

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not the "_" keyword.

### init()

```cangjie
public init()
```

Function: Constructs a default [WildcardExpr](ast_package_classes.md#class-wildcardexpr) object.

### init(Tokens)

```cangjie
public init(keyword: Tokens)
```

Function: Constructs a [WildcardExpr](ast_package_classes.md#class-wildcardexpr) object.

Parameters:

- keyword: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to be constructed as a [WildcardExpr](ast_package_classes.md#class-wildcardexpr) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [WildcardExpr](ast_package_classes.md#class-wildcardexpr) node.

## class WildcardPattern

```cangjie
public class WildcardPattern <: Pattern {
    public init()
    public init(keyword: Tokens)
}
```

Function: Represents a wildcard pattern node.

Denoted by the underscore "_", which can match any value.

Parent Type:

- [Pattern](#class-pattern)

### prop wildcard

```cangjie
public mut prop wildcard: Token
```

Function: Gets or sets the lexical unit of the "_" operator in the [WildcardPattern](ast_package_classes.md#class-wildcardpattern) node.

Type: [Token](ast_package_structs.md#struct-token)

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the set [Token](ast_package_structs.md#struct-token) is not the "_" operator.

### init()

```cangjie
public init()
```

Function: Constructs a default [WildcardPattern](ast_package_classes.md#class-wildcardpattern) object.

### init(Tokens)

```cangjie
public init(keyword: Tokens)
```

Function: Constructs a [WildcardPattern](ast_package_classes.md#class-wildcardpattern) object.

Parameters:

- keyword: [Tokens](ast_package_classes.md#class-tokens) - The lexical unit collection ([Tokens](ast_package_classes.md#class-tokens)) to be constructed as a [WildcardPattern](ast_package_classes.md#class-wildcardpattern) type.

Exceptions:

- [ASTException](ast_package_exceptions.md#class-astexception) - Thrown when the input [Tokens](ast_package_classes.md#class-tokens) type cannot be constructed as a [WildcardPattern](ast_package_classes.md#class-wildcardpattern) node.
