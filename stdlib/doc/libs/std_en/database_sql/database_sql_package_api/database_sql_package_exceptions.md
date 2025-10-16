# Exception Classes

## class SqlException

```cangjie
public open class SqlException <: Exception {
    public init()
    public init(message: String)
    public init(message: String, sqlState: String, errorCode: Int64)
}
```

Function: Used to handle SQL-related exceptions.

Parent Type:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### prop errorCode

```cangjie
public prop errorCode: Int64
```

Function: The integer error code returned by the database vendor.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop message

```cangjie
public override prop message: String
```

Function: Gets the exception message string.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop sqlState

```cangjie
public prop sqlState: String
```

Function: A five-character string representing the state of the last executed SQL statement returned by the database system.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### init()

```cangjie
public init()
```

Function: Parameterless constructor.

### init(String)

```cangjie
public init(message: String)
```

Function: Creates an [SqlException](database_sql_package_exceptions.md#class-sqlexception) instance with the specified error message.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The error message.

### init(String, String, Int64)

```cangjie
public init(message: String, sqlState: String, errorCode: Int64)
```

Function: Creates an [SqlException](database_sql_package_exceptions.md#class-sqlexception) instance with the specified error message, SQL state, and error code.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The error message.
- sqlState: [String](../../core/core_package_api/core_package_structs.md#struct-string) - A five-character string representing the state of the last executed SQL statement returned by the database system.
- errorCode: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The integer error code returned by the database vendor.

### func getClassName()

```cangjie
protected override open func getClassName(): String
```

Function: Gets the class name.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The class name.