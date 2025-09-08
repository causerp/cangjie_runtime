# Interfaces

## interface ColumnInfo

```cangjie
public interface ColumnInfo {
    prop displaySize: Int64
    prop length: Int64
    prop name: String
    prop nullable: Bool
    prop scale: Int64
    prop typeName: String
}
```

Function: Column information for the result set returned by executing Select/Query statements.

### prop displaySize

```cangjie
prop displaySize: Int64
```

Function: Gets the maximum display length of column values. If unlimited, should return [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).Max (still subject to database limitations).

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop length

```cangjie
prop length: Int64
```

Function: Gets the size of column values.

> **Note:**
>
> - For numeric data, represents maximum precision.
> - For character data, represents length in characters.
> - For datetime data types, represents maximum character length of string representation.
> - For binary data, represents length in bytes.
> - For RowID data type, represents length in bytes.
> - Returns 0 for data types where column size is not applicable.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop name

```cangjie
prop name: String
```

Function: Column name or alias.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop nullable

```cangjie
prop nullable: Bool
```

Function: Indicates whether the column value allows database `Null` values.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

### prop scale

```cangjie
prop scale: Int64
```

Function: Gets the decimal length of column values. Returns 0 if no decimal part exists.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop typeName

```cangjie
prop typeName: String
```

Function: Gets the column type name. If there's a corresponding data type definition in Cangjie, returns the return value of that type's `toString` function; otherwise defined by the database driver.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

## interface Connection

```cangjie
public interface Connection <: Resource {
    prop state: ConnectionState
    func createTransaction(): Transaction
    func getMetaData(): Map<String, String>
    func prepareStatement(sql: String): Statement
}
```

Function: Database connection interface.

Classes, interfaces, or structs inheriting this interface must comply with the parameter and return value definitions of its functions.

Parent type:

- [Resource](../../core/core_package_api/core_package_interfaces.md#interface-resource)

### prop state

```cangjie
prop state: ConnectionState
```

Function: Describes the current state of connection to the data source.

Type: [ConnectionState](database_sql_package_enums.md#enum-connectionstate)

### func createTransaction()

```cangjie
func createTransaction(): Transaction
```

Function: Creates a transaction object.

Return value:

- [Transaction](database_sql_package_interfaces.md#interface-transaction) - Transaction object.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Throws when already in a transaction state and parallel transactions are not supported.

### func getMetaData()

```cangjie
func getMetaData(): Map<String, String>
```

Function: Returns metadata of the connected data source.

Return value:

- [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v)\<[String](../../core/core_package_api/core_package_structs.md#struct-string), [String](../../core/core_package_api/core_package_structs.md#struct-string)> - Data source metadata.

### func prepareStatement(String)

```cangjie
func prepareStatement(sql: String): Statement
```

Function: Returns a pre-executed [Statement](database_sql_package_interfaces.md#interface-statement) object instance using the provided SQL statement.

Parameters:

- sql: [String](../../core/core_package_api/core_package_structs.md#struct-string) - SQL statement to pre-execute, where parameters only support `?` placeholder symbols.

Return value:

- [Statement](database_sql_package_interfaces.md#interface-statement) - An instance object capable of executing SQL statements.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Throws when the SQL statement contains unrecognized characters.

## interface Datasource

```cangjie
public interface Datasource <: Resource {
    func connect(): Connection
    func setOption(key: String, value: String): Unit
}
```

Function: Data source interface.

Classes, interfaces, or structs inheriting this interface must comply with the parameter and return value definitions of its functions.

Parent type:

- [Resource](../../core/core_package_api/core_package_interfaces.md#interface-resource)

### func connect()

```cangjie
func connect(): Connection
```

Function: Returns an available connection.

Return value:

- [Connection](database_sql_package_interfaces.md#interface-connection) - Database connection instance.

### func setOption(String, String)

```cangjie
func setOption(key: String, value: String): Unit
```

Function: Sets connection options.

Parameters:

- key: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Connection option name.
- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Connection option value.

## interface Driver

```cangjie
public interface Driver {
    prop name: String
    prop preferredPooling: Bool
    prop version: String
    func open(connectionString: String, opts: Array<(String, String)>): Datasource
}
```

Function: Database driver interface.

Classes, interfaces, or structs inheriting this interface must comply with the parameter and return value definitions of its functions.

### prop name

```cangjie
prop name: String
```

Function: Driver name.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop preferredPooling

```cangjie
prop preferredPooling: Bool
```

Function: Indicates whether the driver is connection pool-friendly.

When this property is `false`, connection pooling is not recommended. For example, some database drivers (like SQLite) show insignificant benefits from connection pooling.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

### prop version

```cangjie
prop version: String
```

Function: Driver version.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### func open(String, Array\<(String, String)>)

```cangjie
func open(connectionString: String, opts: Array<(String, String)>): Datasource
```

Function: Opens a data source using `connectionString` and options.

Parameters:

- connectionString: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Database connection string.
- opts: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<([String](../../core/core_package_api/core_package_structs.md#struct-string), [String](../../core/core_package_api/core_package_structs.md#struct-string))> - Array of key-value tuples for data source opening options.

Return value:

- [Datasource](database_sql_package_interfaces.md#interface-datasource) - Data source instance.

## interface QueryResult

```cangjie
public interface QueryResult <: Resource {
    prop columnInfos: Array<ColumnInfo>
    func next(values: Array<SqlDbType>): Bool
    func next(): Bool
    func get<T>(index: Int64): T
    func getOrNull<T>(index: Int64): ?T
}
```

Function: Result interface for executing Select statements.

Classes, interfaces, or structs inheriting this interface must comply with the parameter and return value definitions of its functions.

Parent type:

- [Resource](../../core/core_package_api/core_package_interfaces.md#interface-resource)

### prop columnInfos

```cangjie
prop columnInfos: Array<ColumnInfo
```

Function: Returns column information of the result set, such as column names, column types, column lengths, whether database Null values are allowed, etc.

Type: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[ColumnInfo](database_sql_package_interfaces.md#interface-columninfo)>

### func get\<T>(Int64)

```cangjie
func get<T>(index: Int64): T
```

Function: Retrieves the value of the specified column from the current row of the result set.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Specified column.

Return value:

- T - Instance of type `T`.

### func getOrNull\<T>(Int64)

```cangjie
func getOrNull<T>(index: Int64): ?T
```

Function: Retrieves the value of the specified column from the current row of the result set, allowing SQL NULL for database columns.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Specified column.

Return value:

- ?T - Instance of type `T`, returns None if null.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Throws when index exceeds column range or row data is not ready.

### func next()

```cangjie
func next(): Bool
```

Function: Moves to the next row. Must call `next()` once to move to the first row, second call moves to the second row, and so on. When returning `true`, the driver fills the current row of the result set with data; when returning `false`, it ends without modifying the current row's content.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if next row has data, otherwise `false`.

### func next(Array\<SqlDbType>) <sup>(deprecated)</sup>

```cangjie
func next(values: Array<SqlDbType>): Bool
```

Function: Moves to the next row. Must call `next` once to move to the first row, second call moves to the second row, and so on. When returning `true`, the driver fills `values` with row data; when returning `false`, it ends without modifying `values` content.

> **Note:**
>
> Will be deprecated in future versions. Use [next()](database_sql_package_interfaces.md#func-next) instead.

Parameters:

- values: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)> - List of SQL data type values.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if next row has data, otherwise `false`.

## interface SqlDbType <sup>(deprecated)</sup>

```cangjie
public interface SqlDbType {
    prop name: String
}
```

Function: Parent class of all SQL data types.

> **Note:**
>
> Will be deprecated in future versions.

To extend user-defined types, inherit from [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated) or [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated).

> **Explanation:**
>
> All implementation types of [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated) interface must have a public `value` property. Each SQL data type implementation class must satisfy:
>
> - A constructor with single parameter of type `T` (`T` being a type supported by Cangjie language).
> - A `public` `value` property whose type must match the parameter type used above, with its value being the corresponding Cangjie type value.
> - If the data type allows `null` values, inherit [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated). For `null` values, the `value` field should be [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>.None.

### prop name

```cangjie
prop name: String
```

Function: Gets the type name.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

## interface SqlNullableDbType <sup>(deprecated)</sup>

```cangjie
public interface SqlNullableDbType <: SqlDbType
```

Function: Parent class for SQL data types that allow `null` values.

> **Note:**
>
> This will be deprecated in future versions.

If the value is `null`, the `value` property will be [Option](../../core/core_package_api/core_package_enums.md#enum-optiont).None.

Parent Type:

- [SqlDbType <sup>(deprecated)</sup>](#interface-sqldbtype-deprecated)

## interface Statement

```cangjie
public interface Statement <: Resource {
    prop parameterColumnInfos: Array<ColumnInfo>
    func query(params: Array<SqlDbType>): QueryResult
    func setOption(key: String, value: String): Unit
    func update(params: Array<SqlDbType>): UpdateResult
    func set<T>(index: Int64, value: T): Unit
    func setNull(index: Int64): Unit
    func update(): UpdateResult
    func query(): QueryResult
}
```

Function: Pre-execution interface for SQL statements.

[Statement](database_sql_package_interfaces.md#interface-statement) is bound to a [Connection](database_sql_package_interfaces.md#interface-connection). Classes, interfaces, and structs inheriting this interface must comply with its function parameter and return value definitions.

Parent Type:

- [Resource](../../core/core_package_api/core_package_interfaces.md#interface-resource)

### prop parameterColumnInfos

```cangjie
prop parameterColumnInfos: Array<ColumnInfo>
```

Function: Column information for placeholder parameters in pre-executed SQL statements, such as column name, column type, column length, and whether database `Null` values are allowed.

Type: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[ColumnInfo](database_sql_package_interfaces.md#interface-columninfo)>

### func query()

```cangjie
func query(): QueryResult
```

Function: Executes the SQL statement and returns the query result.

Return Value:

- [QueryResult](database_sql_package_interfaces.md#interface-queryresult) - The query result.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Thrown when exceptions occur during execution, such as network interruption, server timeout, or incorrect parameter count.

### func query(Array\<SqlDbType>) <sup>(deprecated)</sup>

```cangjie
func query(params: Array<SqlDbType>): QueryResult
```

Function: Executes the SQL statement and returns the query result.

> **Note:**
>
> This will be deprecated in future versions. Use query() instead.

Parameters:

- params: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)> - A list of SQL data type values used to replace `?` placeholders in the SQL statement.

Return Value:

- [QueryResult](database_sql_package_interfaces.md#interface-queryresult) - The query result.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Thrown when exceptions occur during execution, such as network interruption, server timeout, or incorrect parameter count.

### func set\<T>(Int64, T)

```cangjie
func set<T>(index: Int64, value: T): Unit
```

Function: Sets SQL parameters by converting Cangjie data types to database data types.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The parameter sequence position.
- value: T - The parameter value.

### func setNull(Int64)

```cangjie
func setNull(index: Int64): Unit
```

Function: Sets the statement parameter at the specified position to SQL NULL.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The parameter sequence position.

### func setOption(String, String)

```cangjie
func setOption(key: String, value: String): Unit
```

Function: Sets options for pre-executed SQL statements.

Parameters:

- key: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The connection option name.
- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The connection option value.

### func update(Array\<SqlDbType>) <sup>(deprecated)</sup>

```cangjie
func update(params: Array<SqlDbType>): UpdateResult
```

Function: Executes the SQL statement and returns the update result.

> **Note:**
>
> This will be deprecated in future versions. Use update() instead.

Parameters:

- params: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)> - A list of SQL data type values used to replace `?` placeholders in the SQL statement.

Return Value:

- [UpdateResult](database_sql_package_interfaces.md#interface-updateresult) - The update result.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Thrown when exceptions occur during execution, such as network interruption, server timeout, or incorrect parameter count.

### func update()

```cangjie
func update(): UpdateResult
```

Function: Executes the SQL statement and returns the update result.

Return Value:

- [UpdateResult](database_sql_package_interfaces.md#interface-updateresult) - The update result.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Thrown when exceptions occur during execution, such as network interruption, server timeout, or incorrect parameter count.

## interface Transaction

```cangjie
public interface Transaction {
    mut prop accessMode: TransactionAccessMode
    mut prop deferrableMode: TransactionDeferrableMode
    mut prop isoLevel: TransactionIsoLevel
    func begin(): Unit
    func commit(): Unit
    func release(savePointName: String): Unit
    func rollback(): Unit
    func rollback(savePointName: String): Unit
    func save(savePointName: String): Unit
}
```

Function: Defines core behaviors for database transactions.

Classes, interfaces, and structs inheriting this interface must comply with its function parameter and return value definitions.

### prop accessMode

```cangjie
mut prop accessMode: TransactionAccessMode
```

Function: Gets the database transaction access mode.

Type: [TransactionAccessMode](database_sql_package_enums.md#enum-transactionaccessmode)

### prop deferrableMode

```cangjie
mut prop deferrableMode: TransactionDeferrableMode
```

Function: Gets the database transaction deferrable mode.

Type: [TransactionDeferrableMode](database_sql_package_enums.md#enum-transactiondeferrablemode)

### prop isoLevel

```cangjie
mut prop isoLevel: TransactionIsoLevel
```

Function: Gets the database transaction isolation level.

Type: [TransactionIsoLevel](database_sql_package_enums.md#enum-transactionisolevel)

### func begin()

```cangjie
func begin(): Unit
```

Function: Starts a database transaction.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Thrown when server-side errors occur during transaction commit, or when the transaction has already been committed/rolled back or the connection is disconnected.

### func commit()

```cangjie
func commit(): Unit
```

Function: Commits the database transaction.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Thrown when server-side errors occur during transaction commit, or when the transaction has already been committed/rolled back or the connection is disconnected.

### func release(String)

```cangjie
func release(savePointName: String): Unit
```

Function: Destroys a previously defined savepoint in the current transaction, allowing the system to reclaim some resources before the transaction ends.

Parameters:

- savePointName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The savepoint name.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Thrown when server-side errors occur during transaction commit, or when the transaction has already been committed/rolled back or the connection is disconnected.

### func rollback()

```cangjie
func rollback(): Unit
```

Function: Rolls back the transaction from a pending state.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Thrown when server-side errors occur during transaction commit, or when the transaction has already been committed/rolled back or the connection is disconnected.

### func rollback(String)

```cangjie
func rollback(savePointName: String): Unit
```

Function: Rolls back the transaction to the specified savepoint.

Parameters:

- savePointName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The savepoint name.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Thrown when server-side errors occur during transaction commit, or when the transaction has already been committed/rolled back or the connection is disconnected.

### func save(String)

```cangjie
func save(savePointName: String): Unit
```

Function: Creates a named savepoint in the transaction, which can be used to roll back transactions after this savepoint.

Parameters:

- savePointName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The savepoint name.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Thrown when server-side errors occur during transaction commit, or when the transaction has already been committed/rolled back or the connection is disconnected.

## interface UpdateResult

```cangjie
public interface UpdateResult {
    prop lastInsertId: Int64
    prop rowCount: Int64
}
```

Function: Interface for results generated by executing Insert, Update, or Delete statements.

Classes, interfaces, and structs inheriting this interface must comply with its function parameter and return value definitions.

### prop lastInsertId

```cangjie
prop lastInsertId: Int64
```

Function: The last automatically generated row ID from an Insert statement. Returns 0 if unsupported.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop rowCount

```cangjie
prop rowCount: Int64
```

Function: The number of rows affected by executing Insert, Update, or Delete statements.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)
```