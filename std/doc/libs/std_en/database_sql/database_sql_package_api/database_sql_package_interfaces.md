# Interface

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

Function: Column information for the result returned by executing Select/Query statements.

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

Function: Indicates whether column values can be database `Null`.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

### prop scale

```cangjie
prop scale: Int64
```

Function: Gets the scale length of column values. Returns 0 if no decimal part exists.

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

Classes, interfaces, or structs inheriting this interface must also comply with the parameter and return value definitions of its functions.

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

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Throws exception when already in a transaction state and parallel transactions are not supported.

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

Function: Returns a pre-executed [Statement](database_sql_package_interfaces.md#interface-statement) object instance based on the provided SQL statement.

Parameters:

- sql: [String](../../core/core_package_api/core_package_structs.md#struct-string) - SQL statement to pre-execute, where parameters only support `?` symbol placeholders.

Return value:

- [Statement](database_sql_package_interfaces.md#interface-statement) - An instance object capable of executing SQL statements.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Throws exception when the SQL statement contains unrecognized characters.

## interface Datasource

```cangjie
public interface Datasource <: Resource {
    func connect(): Connection
    func setOption(key: String, value: String): Unit
}
```

Function: Data source interface.

Classes, interfaces, or structs inheriting this interface must also comply with the parameter and return value definitions of its functions.

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

Classes, interfaces, or structs inheriting this interface must also comply with the parameter and return value definitions of its functions.

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

Function: Indicates whether the driver is affinity with connection pooling.

When this property is `false`, it's not recommended to use connection pooling for management. For example, for certain database drivers (like SQLite), the benefits of connection pooling are not significant, hence not recommended.

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
- opts: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<([String](../../core/core_package_api/core_package_structs.md#struct-string), [String](../../core/core_package_api/core_package_structs.md#struct-string))> - Array of key-value tuples, options for opening the data source.

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

Function: Interface for results produced by executing Select statements.

Classes, interfaces, or structs inheriting this interface must also comply with the parameter and return value definitions of its functions.

Parent type:

- [Resource](../../core/core_package_api/core_package_interfaces.md#interface-resource)

### prop columnInfos

```cangjie
prop columnInfos: Array<ColumnInfo>
```

Function: Returns column information of the result set, such as column names, column types, column lengths, whether database Null values are allowed, etc.

Type: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[ColumnInfo](database_sql_package_interfaces.md#interface-columninfo)>

### func get\<T>(Int64)

```cangjie
func get<T>(index: Int64): T
```

Function: Retrieves the value of the specified column from the current row of the result set.

Return Value:

- T - An instance of type `T`.

### func getOrNull\<T>(Int64)

```cangjie
func getOrNull<T>(index: Int64): ?T
```

Function: Retrieves the value of the specified column from the current row of the result set, allowing SQL NULL for database columns.

Return Value:

- ?T - An instance of type `T`, or None if the value is NULL.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Throws an exception if the index is out of column range or row data is not ready.

### func next()

```cangjie
func next(): Bool
```

Function: Moves to the next row. Must call `next()` once to move to the first row, call again to move to the second row, and so on. When `true` is returned, the driver populates the current row of the result set with data. When `false` is returned, it indicates the end, and the current row content of the result set remains unchanged.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the next row contains data, otherwise returns `false`.

### func next(Array\<SqlDbType>) <sup>(deprecated)</sup>

```cangjie
func next(values: Array<SqlDbType>): Bool
```

Function: Moves to the next row. Must call `next` once to move to the first row, call again to move to the second row, and so on. When `true` is returned, the driver populates the `values` array with row data. When `false` is returned, it indicates the end, and the `values` content remains unchanged.

> **Note:**
>
> This method will be deprecated in future versions. Use [next()](database_sql_package_interfaces.md#func-next) instead.

Parameters:

- values: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)> - A list of SQL data type values.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the next row contains data, otherwise returns `false`.

## interface SqlDbType <sup>(deprecated)</sup>

```cangjie
public interface SqlDbType {
    prop name: String
}
```

Function: The parent interface for all SQL data types.

> **Note:**
>
> This interface will be deprecated in future versions.

To extend user-defined types, inherit from [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated) or [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated).

> **Description:**
>
> All implementations of the [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated) interface must have a public `value` property. Each SQL data type implementation class must meet the following conditions:
>
> - A constructor with a single parameter of type `T` (where `T` is a type supported by the Cangjie language).
> - A `public` `value` property whose type matches the parameter type used above, holding the corresponding Cangjie type value.
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

Function: The parent interface for SQL data types that allow `null` values.

> **Note:**
>
> This interface will be deprecated in future versions.

For `null` values, the `value` property is set to [Option](../../core/core_package_api/core_package_enums.md#enum-optiont).None.

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

Function: The interface for SQL statement pre-execution.

[Statement](database_sql_package_interfaces.md#interface-statement) is bound to a [Connection](database_sql_package_interfaces.md#interface-connection). Classes, interfaces, or structs inheriting this interface must adhere to the function parameter and return value definitions specified herein.

Parent Type:

- [Resource](../../core/core_package_api/core_package_interfaces.md#interface-resource)

### prop parameterColumnInfos

```cangjie
prop parameterColumnInfos: Array<ColumnInfo>
```

Function: Column information for placeholder parameters in the pre-executed SQL statement, such as column name, column type, column length, and whether database `Null` values are allowed.

Type: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[ColumnInfo](database_sql_package_interfaces.md#interface-columninfo)>

### func query()

```cangjie
func query(): QueryResult
```

Function: Executes the SQL statement and retrieves the query result.

Return Value:

- [QueryResult](database_sql_package_interfaces.md#interface-queryresult) - The query result.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Throws an exception if an error occurs during execution, such as network interruption, server timeout, or incorrect parameter count.

### func query(Array\<SqlDbType>) <sup>(deprecated)</sup>

```cangjie
func query(params: Array<SqlDbType>): QueryResult
```

Function: Executes the SQL statement and retrieves the query result.

> **Note:**
>
> This method will be deprecated in future versions. Use query() instead.

Parameters:

- params: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)> - A list of SQL data type values used to replace `?` placeholders in the SQL statement.

Return Value:

- [QueryResult](database_sql_package_interfaces.md#interface-queryresult) - The query result.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Throws an exception if an error occurs during execution, such as network interruption, server timeout, or incorrect parameter count.

### func set\<T>(Int64, T)

```cangjie
func set<T>(index: Int64, value: T): Unit
```

Function: Sets an SQL parameter, converting a Cangjie data type to a database data type.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The parameter sequence position.
- value: T - The parameter value.

### func setNull(Int64)

```cangjie
func setNull(index: Int64): Unit
```

Function: Sets the specified statement parameter to SQL NULL.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The parameter sequence position.

### func setOption(String, String)

```cangjie
func setOption(key: String, value: String): Unit
```

Function: Sets options for the pre-executed SQL statement.

Parameters:

- key: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The connection option name.
- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The connection option value.

### func update(Array\<SqlDbType>) <sup>(deprecated)</sup>

```cangjie
func update(params: Array<SqlDbType>): UpdateResult
```

Function: Executes the SQL statement and retrieves the update result.

> **Note:**
>
> This method will be deprecated in future versions. Use update() instead.

Parameters:

- params: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)> - A list of SQL data type values used to replace `?` placeholders in the SQL statement.

Return Value:

- [UpdateResult](database_sql_package_interfaces.md#interface-updateresult) - The update result.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Throws an exception if an error occurs during execution, such as network interruption, server timeout, or incorrect parameter count.

### func update()

```cangjie
func update(): UpdateResult
```

Function: Executes the SQL statement and retrieves the update result.

Return Value:

- [UpdateResult](database_sql_package_interfaces.md#interface-updateresult) - The update result.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Throws an exception if an error occurs during execution, such as network interruption, server timeout, or incorrect parameter count.

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

Function: Defines the core behavior of database transactions.

Classes, interfaces, or structs inheriting this interface must adhere to the function parameter and return value definitions specified herein.

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

Function: Gets the database transaction deferrable mode.Type: [TransactionDeferrableMode](database_sql_package_enums.md#enum-transactiondeferrablemode)

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

Function: Begins a database transaction.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Thrown when a server-side error occurs during transaction commit, or when the transaction has already been committed/rolled back or the connection is disconnected.

### func commit()

```cangjie
func commit(): Unit
```

Function: Commits the database transaction.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Thrown when a server-side error occurs during transaction commit, or when the transaction has already been committed/rolled back or the connection is disconnected.

### func release(String)

```cangjie
func release(savePointName: String): Unit
```

Function: Destroys a savepoint previously defined in the current transaction. This allows the system to reclaim some resources before the transaction ends.

Parameters:

- savePointName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the savepoint.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Thrown when a server-side error occurs during transaction commit, or when the transaction has already been committed/rolled back or the connection is disconnected.

### func rollback()

```cangjie
func rollback(): Unit
```

Function: Rolls back the transaction from a pending state.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Thrown when a server-side error occurs during transaction commit, or when the transaction has already been committed/rolled back or the connection is disconnected.

### func rollback(String)

```cangjie
func rollback(savePointName: String): Unit
```

Function: Rolls back the transaction to the specified savepoint name.

Parameters:

- savePointName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the savepoint.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Thrown when a server-side error occurs during transaction commit, or when the transaction has already been committed/rolled back or the connection is disconnected.

### func save(String)

```cangjie
func save(savePointName: String): Unit
```

Function: Creates a savepoint with the specified name in the transaction, which can be used to roll back the transaction after this savepoint.

Parameters:

- savePointName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the savepoint.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Thrown when a server-side error occurs during transaction commit, or when the transaction has already been committed/rolled back or the connection is disconnected.

## interface UpdateResult

```cangjie
public interface UpdateResult {
    prop lastInsertId: Int64
    prop rowCount: Int64
}
```

Function: Result interface generated by executing Insert, Update, and Delete statements.

Classes, interfaces, or structs that inherit this interface must also comply with the parameter and return value definitions of the functions in this interface.

### prop lastInsertId

```cangjie
prop lastInsertId: Int64
```

Function: The last automatically generated row ID from executing an Insert statement. Returns 0 if not supported.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop rowCount

```cangjie
prop rowCount: Int64
```

Function: The number of rows affected by executing Insert, Update, or Delete statements.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)