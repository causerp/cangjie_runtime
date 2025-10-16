# Exception Classes

## class ASTException

```cangjie
public class ASTException <: Exception {
    public init()
    public init(message: String)
}
```

Function: The exception class for the AST library, used when exceptions occur during AST library calls.

Parent Types:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

Function: Constructs a default [ASTException](ast_package_exceptions.md#class-astexception) object.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs an [ASTException](ast_package_exceptions.md#class-astexception) object with exception information.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The exception message.

## class MacroContextException

```cangjie
public class MacroContextException <: Exception {
    public init()
    public init(message: String)
}
```

Function: The macro context exception class for the AST library, used when exceptions occur in context macro related interfaces.

Parent Types:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

Function: Constructs a default [MacroContextException](ast_package_exceptions.md#class-macrocontextexception) object.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs a [MacroContextException](ast_package_exceptions.md#class-macrocontextexception) object with exception information.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The exception message.

## class ParseASTException

```cangjie
public class ParseASTException <: Exception {
    public init()
    public init(message: String)
}
```

Function: The parsing exception class for the AST library, used when exceptions occur during node parsing.

Parent Types:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

Function: Constructs a default [ParseASTException](ast_package_exceptions.md#class-parseastexception) object.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs a [ParseASTException](ast_package_exceptions.md#class-parseastexception) object with exception information.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The exception message.