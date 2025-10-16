# Classes

## class DriverManager

```cangjie
public class DriverManager
```

Function: Provides runtime capability to retrieve database driver instances by name.

### static func deregister(String)

```cangjie
public static func deregister(driverName: String): Unit
```

Function: Deregisters a database driver by name (if exists). This function is thread-safe.

Parameters:

- driverName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Driver name.

### static func drivers()

```cangjie
public static func drivers(): Array<String>
```

Function: Returns a list of registered database driver names (sorted lexicographically). This method is thread-safe.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - List of database driver names.

### static func getDriver(String)

```cangjie
public static func getDriver(driverName: String): Option<Driver>
```

Function: Retrieves a registered database driver by name, returns `None` if not found. This function is thread-safe.

Parameters:

- driverName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Driver name.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Driver](database_sql_package_interfaces.md#interface-driver)> - Returns driver instance wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) if exists, otherwise returns `None`.

### static func register(String, Driver)

```cangjie
public static func register(driverName: String, driver: Driver): Unit
```

Function: Registers a database driver with name and instance (one-to-one mapping). This method is thread-safe.

Parameters:

- driverName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Driver name.
- driver: [Driver](database_sql_package_interfaces.md#interface-driver) - Driver instance.

Exceptions:

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Thrown when the specified driver name already exists.

## class PooledDatasource

```cangjie
public class PooledDatasource <: Datasource {
    public init(datasource: Datasource)
}
```

Function: Database connection pool class providing connection pooling capabilities.

Parent Type:

- [Datasource](database_sql_package_interfaces.md#interface-datasource)

### prop connectionTimeout

```cangjie
public mut prop connectionTimeout: Duration
```

Function: Timeout duration for acquiring a connection from the pool.

Type: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when this property is set to [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).Max or [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).Min.
- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - Thrown when connection acquisition times out.

### prop idleTimeout

```cangjie
public mut prop idleTimeout: Duration
```

Function: Maximum duration a connection can remain idle in the pool before being potentially reclaimed.

Type: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

### prop keepaliveTime

```cangjie
public mut prop keepaliveTime: Duration
```

Function: Interval for checking health of idle connections to prevent timeout by database or network infrastructure.

Type: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

### prop maxIdleSize

```cangjie
public mut prop maxIdleSize: Int32
```

Function: Maximum number of idle connections. Excess idle connections will be closed. Negative or zero values indicate no limit.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### prop maxLifeTime

```cangjie
public mut prop maxLifeTime: Duration
```

Function: Maximum duration since connection creation, after which the connection will be automatically closed.

Type: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

### prop maxSize

```cangjie
public mut prop maxSize: Int32
```

Function: Maximum number of connections in the pool. Negative or zero values indicate no limit.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### init(Datasource)

```cangjie
public init(datasource: Datasource)
```

Function: Constructs a [PooledDatasource](database_sql_package_classes.md#class-pooleddatasource) instance using the provided datasource parameter, which must be a [Datasource](database_sql_package_interfaces.md#interface-datasource) object.

Parameters:

- datasource: [Datasource](database_sql_package_interfaces.md#interface-datasource) - Data source.

### func close()

```cangjie
public func close(): Unit
```

Function: Closes all connections in the pool and blocks further connection requests. This method blocks until all connections are closed and returned to the pool.

### func connect()

```cangjie
public func connect(): Connection
```

Function: Acquires a connection.

Return Value:

- [Connection](./database_sql_package_interfaces.md#interface-connection) - The acquired connection.

### func isClosed()

```cangjie
public func isClosed(): Bool
```

Function: Determines whether the connection is closed.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the connection is closed.

### func setOption(String, String)

```cangjie
public func setOption(key: String, value: String): Unit
```

Function: Sets database driver connection options (public keys are predefined in [SqlOption](database_sql_package_classes.md#class-sqloption)).

Parameters:

- key: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Connection option name.
- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Connection option value.

## class SqlBigInt <sup>(deprecated)</sup>

```cangjie
public class SqlBigInt <: SqlDbType {
    public init(v: Int64)
}
```

Function: Big integer type, corresponding to Cangjie's [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type.

> **Note:**
>
> Will be deprecated in future versions. Use native Cangjie types instead.

Parent Type:

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlBigInt <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlbigInt-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: Int64
```

Function: The value of this data.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### init(Int64)

```cangjie
public init(v: Int64)
```

Function: Constructs a [SqlBigInt <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlbigInt-deprecated) instance using the provided parameter v.

Parameters:

- v: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Input data.

## class SqlBinary <sup>(deprecated)</sup>

```cangjie
public class SqlBinary <: SqlDbType {
    public init(v: Array<Byte>)
}
```

Function: Fixed-length binary string, corresponding to Cangjie's [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> type.

> **Note:**
>
> Will be deprecated in future versions. Use native Cangjie types instead.

Parent Type:

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlBinary <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlbinary-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: Array<Byte>
```

Function: The value of this data.

Type: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>

### init(Array\<Byte>)

```cangjie
public init(v: Array<Byte>)
```

Function: Constructs a [SqlBinary <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlbinary-deprecated) instance using the provided parameter v.

Parameters:- v: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - Input data.

## class SqlBlob <sup>(deprecated)</sup>

```cangjie
public class SqlBlob <: SqlDbType {
    public init(v: InputStream)
}
```

Function: Variable-length large binary string (BINARY LARGE OBJECT), corresponding to the Cangjie [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream) type.

> **Note:**
>
> Will be deprecated in future versions, replaced by native Cangjie types.

Parent type:

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlBlob <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlblob-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: InputStream
```

Function: The value of this data.

Type: [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream)

### init(InputStream)

```cangjie
public init(v: InputStream)
```

Function: Constructs a [SqlBlob <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlblob-deprecated) instance from the input parameter v.

Parameters:

- v: [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream) - Input data.

## class SqlBool <sup>(deprecated)</sup>

```cangjie
public class SqlBool <: SqlDbType {
    public init(v: Bool)
}
```

Function: Boolean type, corresponding to the Cangjie [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) type.

> **Note:**
>
> Will be deprecated in future versions, replaced by native Cangjie types.

Parent type:

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlBool<sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlbool-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: Bool
```

Function: The value of this data.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

### init(Bool)

```cangjie
public init(v: Bool)
```

Function: Constructs a [SqlBool<sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlbool-deprecated) instance from the input parameter v.

Parameters:

- v: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Input data.

## class SqlByte <sup>(deprecated)</sup>

```cangjie
public class SqlByte <: SqlDbType {
    public init(v: Int8)
}
```

Function: Byte, corresponding to the Cangjie [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) type.

> **Note:**
>
> Will be deprecated in future versions, replaced by native Cangjie types.

Parent type:

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlByte <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlbyte-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: Int8
```

Function: The value of this data.

Type: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)

### init(Int8)

```cangjie
public init(v: Int8)
```

Function: Constructs a [SqlByte <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlbyte-deprecated) instance from the input parameter v.

Parameters:

- v: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Input data.

## class SqlChar <sup>(deprecated)</sup>

```cangjie
public class SqlChar <: SqlDbType {
    public init(v: String)
}
```

Function: Fixed-length string, corresponding to the Cangjie [String](../../core/core_package_api/core_package_structs.md#struct-string) type.

> **Note:**
>
> Will be deprecated in future versions, replaced by native Cangjie types.

Parent type:

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlChar <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlchar-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: String
```

Function: The value of this data.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### init(String)

```cangjie
public init(v: String)
```

Function: Constructs a [SqlChar <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlchar-deprecated) instance from the input parameter v.

Parameters:

- v: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Input data.

## class SqlClob <sup>(deprecated)</sup>

```cangjie
public class SqlClob <: SqlDbType {
    public init(v: InputStream)
}
```

Function: Variable-length large string (RUNE LARGE OBJECT), corresponding to the Cangjie [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream) type.

> **Note:**
>
> Will be deprecated in future versions, replaced by native Cangjie types.

Parent type:

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlClob](database_sql_package_classes.md#class-sqlclob-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: InputStream
```

Function: The value of this data.

Type: [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream)

### init(InputStream)

```cangjie
public init(v: InputStream)
```

Function: Constructs a [SqlClob](database_sql_package_classes.md#class-sqlclob-deprecated) instance from the input parameter v.

Parameters:

- v: [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream) - Input data.

## class SqlDate <sup>(deprecated)</sup>

```cangjie
public class SqlDate <: SqlDbType {
    public init(v: DateTime)
}
```

Function: Date (only year, month, and day are valid), corresponding to the Cangjie [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) type.

> **Note:**
>
> Will be deprecated in future versions, replaced by native Cangjie types.

Parent type:

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlDate <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqldate-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: DateTime
```

Function: The value of this data.

Type: [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

### init(DateTime)

```cangjie
public init(v: DateTime)
```

Function: Constructs a [SqlDate <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqldate-deprecated) instance from the input parameter v.

Parameters:- v: [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) - Input data.

## class SqlDecimal <sup>(deprecated)</sup>

```cangjie
public class SqlDecimal <: SqlDbType {
    public init(v: Decimal)
}
```

Function: High-precision number, corresponding to the Cangjie [Decimal](../../math_numeric/math_numeric_package_api/math_numeric_package_structs.md#struct-decimal) type.

> **Note:**
>
> Will be deprecated in future versions, replaced by native Cangjie types.

Parent type:

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlDecimal <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqldecimal-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: Decimal
```

Function: The value of this data.

Type: [Decimal](../../math_numeric/math_numeric_package_api/math_numeric_package_structs.md#struct-decimal)

### init(Decimal)

```cangjie
public init(v: Decimal)
```

Function: Constructs a [SqlDecimal <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqldecimal-deprecated) instance with input parameter v.

Parameters:

- v: [Decimal](../../math_numeric/math_numeric_package_api/math_numeric_package_structs.md#struct-decimal) - Input data.

## class SqlDouble <sup>(deprecated)</sup>

```cangjie
public class SqlDouble <: SqlDbType {
    public init(v: Float64)
}
```

Function: Double-precision number, corresponding to the Cangjie [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type.

> **Note:**
>
> Will be deprecated in future versions, replaced by native Cangjie types.

Parent type:

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlDouble <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqldouble-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: Float64
```

Function: The value of this data.

Type: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64)

### init(Float64)

```cangjie
public init(v: Float64)
```

Function: Constructs a [SqlDouble <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqldouble-deprecated) instance with input parameter v.

Parameters:

- v: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - Input data.

## class SqlInteger <sup>(deprecated)</sup>

```cangjie
public class SqlInteger <: SqlDbType {
    public init(v: Int32)
}
```

Function: Medium integer, corresponding to the Cangjie [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) type.

> **Note:**
>
> Will be deprecated in future versions, replaced by native Cangjie types.

Parent type:

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlInteger <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlinteger-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: Int32
```

Function: The value of this data.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### init(Int32)

```cangjie
public init(v: Int32)
```

Function: Constructs a [SqlInteger <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlinteger-deprecated) instance with input parameter v.

Parameters:

- v: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Input data.

## class SqlInterval <sup>(deprecated)</sup>

```cangjie
public class SqlInterval <: SqlDbType {
    public init(v: Duration)
}
```

Function: Time interval, corresponding to the Cangjie [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) type.

> **Note:**
>
> Will be deprecated in future versions, replaced by native Cangjie types.

Parent type:

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlInterval <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlinterval-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: Duration
```

Function: The value of this data.

Type: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

### init(Duration)

```cangjie
public init(v: Duration)
```

Function: Constructs a [SqlInterval <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlinterval-deprecated) instance with input parameter v.

Parameters:

- v: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - Input data.

## class SqlNullableBigInt <sup>(deprecated)</sup>

```cangjie
public class SqlNullableBigInt <: SqlNullableDbType {
    public init(v: ?Int64)
}
```

Function: Large integer, corresponding to the Cangjie [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type, can be database `Null` value.

> **Note:**
>
> Will be deprecated in future versions, replaced by native Cangjie types.

Parent type:

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlNullableBigInt <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablebigInt-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: ?Int64
```

Function: The value of this data.

Type: ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### init(?Int64)

```cangjie
public init(v: ?Int64)
```

Function: Constructs a [SqlNullableBigInt <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablebigInt-deprecated) instance with input parameter v.

Parameters:

- v: ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Input data.

## class SqlNullableBinary <sup>(deprecated)</sup>

```cangjie
public class SqlNullableBinary <: SqlNullableDbType {
    public init(v: ?Array<Byte>)
}
```

Function: Fixed-length binary string, corresponding to the Cangjie [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> type, can be database `Null` value.

> **Note:**
>
> Will be deprecated in future versions, replaced by native Cangjie types.

Parent type:

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlNullableBinary <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablebinary-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: ?Array<Byte>
```

Function: The value of this data.

Type: ?[Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>

### init(?Array\<Byte>)

```cangjie
public init(v: ?Array<Byte>)
```

Function: Constructs a [SqlNullableBinary <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablebinary-deprecated) instance with input parameter v.

Parameters:- v: ?[Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - Input data.

## class SqlNullableBlob <sup>(deprecated)</sup>

```cangjie
public class SqlNullableBlob <: SqlNullableDbType {
    public init(v: ?InputStream)
}
```

Function: Variable-length large binary string (BINARY LARGE OBJECT), corresponding to the Cangjie [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream) type, can be database `Null` value.

> **Note:**
>
> Will be deprecated in future versions, use native Cangjie types instead.

Parent type:

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlNullableBlob <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullableblob-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: ?InputStream
```

Function: The value of this data.

Type: ?[InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream)

### init(?InputStream)

```cangjie
public init(v: ?InputStream)
```

Function: Constructs a [SqlNullableBlob <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullableblob-deprecated) instance with the input parameter v.

Parameters:

- v: ?[InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream) - Input data.

## class SqlNullableBool <sup>(deprecated)</sup>

```cangjie
public class SqlNullableBool <: SqlNullableDbType {
    public init(v: ?Bool)
}
```

Function: Boolean type, corresponding to the Cangjie [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) type, can be database `Null` value.

> **Note:**
>
> Will be deprecated in future versions, use native Cangjie types instead.

Parent type:

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlNullableBool <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablebool-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: ?Bool
```

Function: The value of this data.

Type: ?[Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

### init(?Bool)

```cangjie
public init(v: ?Bool)
```

Function: Constructs a [SqlNullableBool <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablebool-deprecated) instance with the input parameter v.

Parameters:

- v: ?[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Input data.

## class SqlNullableByte <sup>(deprecated)</sup>

```cangjie
public class SqlNullableByte <: SqlNullableDbType {
    public init(v: ?Int8)
}
```

Function: Byte, corresponding to the Cangjie [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) type, can be database `Null` value.

> **Note:**
>
> Will be deprecated in future versions, use native Cangjie types instead.

Parent type:

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlNullableByte <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablebyte-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: ?Int8
```

Function: The value of this data.

Type: ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)

### init(?Int8)

```cangjie
public init(v: ?Int8)
```

Function: Constructs a [SqlNullableByte <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablebyte-deprecated) instance with the input parameter v.

Parameters:

- v: ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Input data.

## class SqlNullableChar <sup>(deprecated)</sup>

```cangjie
public class SqlNullableChar <: SqlNullableDbType {
    public init(v: ?String)
}
```

Function: Fixed-length string, corresponding to the Cangjie [String](../../core/core_package_api/core_package_structs.md#struct-string) type, can be database `Null` value.

> **Note:**
>
> Will be deprecated in future versions, use native Cangjie types instead.

Parent type:

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlNullableChar <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablechar-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: ?String
```

Function: The value of this data.

Type: ?[String](../../core/core_package_api/core_package_structs.md#struct-string)

### init(?String)

```cangjie
public init(v: ?String)
```

Function: Constructs a [SqlNullableChar <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablechar-deprecated) instance with the input parameter v.

Parameters:

- v: ?[String](../../core/core_package_api/core_package_structs.md#struct-string) - Input data.

## class SqlNullableClob <sup>(deprecated)</sup>

```cangjie
public class SqlNullableClob <: SqlNullableDbType {
    public init(v: ?InputStream)
}
```

Function: Variable-length large string (RUNE LARGE OBJECT), corresponding to the Cangjie [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream) type, can be database `Null` value.

> **Note:**
>
> Will be deprecated in future versions, use native Cangjie types instead.

Parent type:

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlNullableClob <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullableclob-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: ?InputStream
```

Function: The value of this data.

Type: ?[InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream)

### init(?InputStream)

```cangjie
public init(v: ?InputStream)
```

Function: Constructs a [SqlNullableClob <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullableclob-deprecated) instance with the input parameter v.

Parameters:

- v: ?[InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream) - Input data.

## class SqlNullableDate <sup>(deprecated)</sup>

```cangjie
public class SqlNullableDate <: SqlNullableDbType {
    public init(v: ?DateTime)
}
```

Function: Date (only year, month, and day are valid), corresponding to the Cangjie [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) type, can be database `Null` value.

> **Note:**
>
> Will be deprecated in future versions, use native Cangjie types instead.

Parent type:

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlNullableDate <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabledate-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: ?DateTime
```

Function: The value of this data.

Type: ?[DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

### init(?DateTime)

```cangjie
public init(v: ?DateTime)
```

Function: Constructs a [SqlNullableDate <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabledate-deprecated) instance with the input parameter v.

Parameters:- v: ?[DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) - Input data.

## class SqlNullableDecimal <sup>(deprecated)</sup>

```cangjie
public class SqlNullableDecimal <: SqlNullableDbType {
    public init(v: ?Decimal)
}
```

Function: High-precision number, corresponding to the Cangjie [Decimal](../../math_numeric/math_numeric_package_api/math_numeric_package_structs.md#struct-decimal) type, can be database `Null` value.

> **Note:**
>
> Will be deprecated in future versions, use native Cangjie types instead.

Parent Type:

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlNullableDecimal <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabledecimal-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: ?Decimal
```

Function: The value of this data.

Type: ?[Decimal](../../math_numeric/math_numeric_package_api/math_numeric_package_structs.md#struct-decimal)

### init(?Decimal)

```cangjie
public init(v: ?Decimal)
```

Function: Constructs a [SqlNullableDecimal <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabledecimal-deprecated) instance based on input parameter v.

Parameters:

- v: ?[Decimal](../../math_numeric/math_numeric_package_api/math_numeric_package_structs.md#struct-decimal) - Input data.

## class SqlNullableDouble <sup>(deprecated)</sup>

```cangjie
public class SqlNullableDouble <: SqlNullableDbType {
    public init(v: ?Float64)
}
```

Function: Double-precision number, corresponding to the Cangjie [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type, can be database `Null` value.

> **Note:**
>
> Will be deprecated in future versions, use native Cangjie types instead.

Parent Type:

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlNullableDouble <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabledouble-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: ?Float64
```

Function: The value of this data.

Type: ?[Float64](../../core/core_package_api/core_package_intrinsics.md#float64)

### init(?Float64)

```cangjie
public init(v: ?Float64)
```

Function: Constructs a [SqlNullableDouble <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabledouble-deprecated) instance based on input parameter v.

Parameters:

- v: ?[Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - Input data.

## class SqlNullableInteger <sup>(deprecated)</sup>

```cangjie
public class SqlNullableInteger <: SqlNullableDbType {
    public init(v: ?Int32)
}
```

Function: Medium integer, corresponding to the Cangjie [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) type, can be database `Null` value.

> **Note:**
>
> Will be deprecated in future versions, use native Cangjie types instead.

Parent Type:

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlNullableInteger <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullableinteger-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: ?Int32
```

Function: The value of this data.

Type: ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### init(?Int32)

```cangjie
public init(v: ?Int32)
```

Function: Constructs a [SqlNullableInteger <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullableinteger-deprecated) instance based on input parameter v.

Parameters:

- v: ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Input data.

## class SqlNullableInterval <sup>(deprecated)</sup>

```cangjie
public class SqlNullableInterval <: SqlNullableDbType {
    public init(v: ?Duration)
}
```

Function: Time interval, corresponding to the Cangjie [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) type, can be database `Null` value.

> **Note:**
>
> Will be deprecated in future versions, use native Cangjie types instead.

Parent Type:

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlNullableInterval <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullableinterval-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: ?Duration
```

Function: The value of this data.

Type: ?[Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

### init(?Duration)

```cangjie
public init(v: ?Duration)
```

Function: Constructs a [SqlNullableInterval <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullableinterval-deprecated) instance based on input parameter v.

Parameters:

- v: ?[Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - Input data.

## class SqlNullableReal <sup>(deprecated)</sup>

```cangjie
public class SqlNullableReal <: SqlNullableDbType {
    public init(v: ?Float32)
}
```

Function: Floating-point number, corresponding to the Cangjie [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type, can be database `Null` value.

> **Note:**
>
> Will be deprecated in future versions, use native Cangjie types instead.

Parent Type:

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlNullableReal <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablereal-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: ?Float32
```

Function: The value of this data.

Type: ?[Float32](../../core/core_package_api/core_package_intrinsics.md#float32)

### init(?Float32)

```cangjie
public init(v: ?Float32)
```

Function: Constructs a [SqlNullableReal <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablereal-deprecated) instance based on input parameter v.

Parameters:

- v: ?[Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - Input data.

## class SqlNullableSmallInt <sup>(deprecated)</sup>

```cangjie
public class SqlNullableSmallInt <: SqlNullableDbType {
    public init(v: ?Int16)
}
```

Function: Small integer, corresponding to the Cangjie [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) type, can be database `Null` value.

> **Note:**
>
> Will be deprecated in future versions, use native Cangjie types instead.

Parent Type:

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, which is [SqlNullableSmallInt <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablesmallint-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: ?Int16
```

Function: The value of this data.

Type: ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)

### init(?Int16)

```cangjie
public init(v: ?Int16)
```

Function: Constructs a [SqlNullableSmallInt <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablesmallint-deprecated) instance based on input parameter v.

Parameters:- v: ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Input data.

## class SqlNullableTime <sup>(deprecated)</sup>

```cangjie
public class SqlNullableTime <: SqlNullableDbType {
    public init(v: ?DateTime)
}
```

Function: Time (only hours, minutes, seconds, and milliseconds are valid), corresponding to the Cangjie [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) type, can be database `Null` value.

> **Note:**
>
> Will be deprecated in future versions, replaced by native Cangjie types.

Parent Type:

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, i.e., [SqlNullableTime <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabletime-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: ?DateTime
```

Function: The value of this data.

Type: ?[DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

### init(?DateTime)

```cangjie
public init(v: ?DateTime)
```

Function: Constructs a [SqlNullableTime <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabletime-deprecated) instance based on input parameter v.

Parameters:

- v: ?[DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) - Input data.

## class SqlNullableTimeTz <sup>(deprecated)</sup>

```cangjie
public class SqlNullableTimeTz <: SqlNullableDbType {
    public init(v: ?DateTime)
}
```

Function: Time with timezone (only hours, minutes, seconds, milliseconds, and timezone are valid), corresponding to the Cangjie [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) type, can be database `Null` value.

> **Note:**
>
> Will be deprecated in future versions, replaced by native Cangjie types.

Parent Type:

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, i.e., [SqlNullableTimeTz <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabletimeTz-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: ?DateTime
```

Function: The value of this data.

Type: ?[DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

### init(?DateTime)

```cangjie
public init(v: ?DateTime)
```

Function: Constructs a [SqlNullableTimeTz <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabletimeTz-deprecated) instance based on input parameter v.

Parameters:

- v: ?[DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) - Input data.

## class SqlNullableTimestamp <sup>(deprecated)</sup>

```cangjie
public class SqlNullableTimestamp <: SqlNullableDbType {
    public init(v: ?DateTime)
}
```

Function: Timestamp, corresponding to the Cangjie [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) type, can be database `Null` value.

> **Note:**
>
> Will be deprecated in future versions, replaced by native Cangjie types.

Parent Type:

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, i.e., [SqlNullableTimestamp <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabletimestamp-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: ?DateTime
```

Function: The value of this data.

Type: ?[DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

### init(?DateTime)

```cangjie
public init(v: ?DateTime)
```

Function: Constructs a [SqlNullableTimestamp <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabletimestamp-deprecated) instance based on input parameter v.

Parameters:

- v: ?[DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) - Input data.

## class SqlNullableVarBinary <sup>(deprecated)</sup>

```cangjie
public class SqlNullableVarBinary <: SqlNullableDbType {
    public init(v: ?Array<Byte>)
}
```

Function: Variable-length binary string, corresponding to the Cangjie [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> type, can be database `Null` value.

> **Note:**
>
> Will be deprecated in future versions, replaced by native Cangjie types.

Parent Type:

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, i.e., [SqlNullableVarBinary <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablevarbinary-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: ?Array<Byte>
```

Function: The value of this data.

Type: ?[Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>

### init(?Array\<Byte>)

```cangjie
public init(v: ?Array<Byte>)
```

Function: Constructs a [SqlNullableVarBinary <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablevarbinary-deprecated) instance based on input parameter v.

Parameters:

- v: ?[Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - Input data.

## class SqlNullableVarchar <sup>(deprecated)</sup>

```cangjie
public class SqlNullableVarchar <: SqlNullableDbType {
    public init(v: ?String)
}
```

Function: Variable-length string, corresponding to the Cangjie [String](../../core/core_package_api/core_package_structs.md#struct-string) type, can be database `Null` value.

> **Note:**
>
> Will be deprecated in future versions, replaced by native Cangjie types.

Parent Type:

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: Type name, i.e., [SqlNullableVarchar <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablevarchar-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: ?String
```

Function: The value of this data.
Type: ?[String](../../core/core_package_api/core_package_structs.md#struct-string)

### init(?String)

```cangjie
public init(v: ?String)
```

Function: Constructs a [SqlNullableVarchar <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablevarchar-deprecated) instance based on input parameter v.

Parameters:

- v: ?[String](../../core/core_package_api/core_package_structs.md#struct-string) - Input data.

## class SqlOption

```cangjie
public class SqlOption {
    public static const URL = "url"
    public static const Host = "host"
    public static const Username = "username"
    public static const Password = "password"
    public static const Driver = "driver"
    public static const Database = "database"
    public static const Encoding = "encoding"
    public static const ConnectionTimeout = "connection_timeout"
    public static const UpdateTimeout = "update_timeout"
    public static const QueryTimeout = "query_timeout"
    public static const FetchRows = "fetch_rows"
    public static const SSLMode = "ssl.mode"
    public static const SSLModePreferred = "ssl.mode.preferred"
    public static const SSLModeDisabled = "ssl.mode.disabled"
    public static const SSLModeRequired = "ssl.mode.required"
    public static const SSLModeVerifyCA = "ssl.mode.verify_ca"
    public static const SSLModeVerifyFull = "ssl.mode.verify_full"
    public static const SSLCA = "ssl.ca"
    public static const SSLCert = "ssl.cert"
    public static const SSLKey = "ssl.key"
    public static const SSLKeyPassword = "ssl.key.password"
    public static const SSLSni = "ssl.sni"
    public static const Tls12Ciphersuites = "tls1.2.ciphersuites"
    public static const Tls13Ciphersuites = "tls1.3.ciphersuites"
    public static const TlsVersion = "tls.version"
}
```

Function: Predefined SQL option names and values. If extending, avoid conflicts with these names and values.

### static const ConnectionTimeout

```cangjie
public static const ConnectionTimeout = "connection_timeout"
```

Function: Gets the timeout duration for connect operations, in milliseconds.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const Database

```cangjie
public static const Database = "database"
```

Function: Get the database name.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const Driver

```cangjie
public static const Driver = "driver"
```

Function: Gets the database driver name, such as postgres, opengauss.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const Encoding

```cangjie
public static const Encoding = "encoding"
```

Function: Gets the database character set encoding type.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const FetchRows

```cangjie
public static const FetchRows = "fetch_rows"
```

Function: Gets the number of rows fetched from the database each time additional data is retrieved.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const Host

```cangjie
public static const Host = "host"
```

Function: Gets the database server hostname or [IP]() address.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const Password

```cangjie
public static const Password = "password"
```

Function: Gets the password for connecting to the database.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const QueryTimeout

```cangjie
public static const QueryTimeout = "query_timeout"
```

Function: Gets the timeout duration for query operations, in milliseconds.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const SSLCA

```cangjie
public static const SSLCA = "ssl.ca"
```

Function: The pathname of the Certificate Authority (CA) certificate file.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const SSLCert

```cangjie
public static const SSLCert = "ssl.cert"
```

Function: The pathname of the client SSL public key certificate file.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const SSLKey

```cangjie
public static const SSLKey = "ssl.key"
```

Function: The pathname of the client SSL private key file.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const SSLKeyPassword

```cangjie
public static const SSLKeyPassword = "ssl.key.password"
```

Function: The password for the client SSL private key file.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const SSLMode

```cangjie
public static const SSLMode = "ssl.mode"
```

Function: Gets the SSLMode transport layer encryption mode.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const SSLModeDisabled

```cangjie
public static const SSLModeDisabled = "ssl.mode.disabled"
```

Function: Establishes an unencrypted connection.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const SSLModePreferred

```cangjie
public static const SSLModePreferred = "ssl.mode.preferred"
```

Function: Establishes an encrypted connection if the server supports it; falls back to an unencrypted connection if an encrypted connection cannot be established. This is the default value for SSLMode.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const SSLModeRequired

```cangjie
public static const SSLModeRequired = "ssl.mode.required"
```

Function: Establishes an encrypted connection if the server supports it. If an encrypted connection cannot be established, the connection fails.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const SSLModeVerifyCA

```cangjie
public static const SSLModeVerifyCA = "ssl.mode.verify_ca"
```

Function: Similar to SSLModeRequired, but additionally verifies the server certificate. If verification fails, the connection fails.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const SSLModeVerifyFull

```cangjie
public static const SSLModeVerifyFull = "ssl.mode.verify_full"
```

Function: Similar to SSLModeVerifyCA, but performs hostname verification by checking if the identifier in the server certificate matches the hostname the client is connecting to.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const SSLSni

```cangjie
public static const SSLSni = "ssl.sni"
```

Function: The hostname the client attempts to connect to at the start of the handshake process.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const Tls12Ciphersuites

```cangjie
public static const Tls12Ciphersuites = "tls1.2.ciphersuites"
```

Function: This option specifies which cipher suites the client allows for encrypted connections using TLSv1.2 and below.
The value is a colon-separated string, e.g., "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_[SHA256]():TLS_DHE_RSA_WITH_AES_128_CBC_SHA".

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const Tls13Ciphersuites

```cangjie
public static const Tls13Ciphersuites = "tls1.3.ciphersuites"
```

Function: This option specifies which cipher suites the client allows for encrypted connections using TLSv1.3.
The value is a colon-separated string, e.g., "TLS_AES_256_GCM_[SHA384]():TLS_CHACHA20_POLY1305_[SHA256]()".

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const TlsVersion

```cangjie
public static const TlsVersion = "tls.version"
```

Function: Supported TLS version numbers, as a comma-separated string, e.g., "TLSv1.2,TLSv1.3".

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const URL

```cangjie
public static const URL = "url"
```

Function: Gets the database connection [URL]() string.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const UpdateTimeout

```cangjie
public static const UpdateTimeout = "update_timeout"
```

Function: Gets the timeout duration for update operations, in milliseconds.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const Username

```cangjie
public static const Username = "username"
```

Function: Gets the username for connecting to the database.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

## class SqlReal <sup>(deprecated)</sup>

```cangjie
public class SqlReal <: SqlDbType {
    public init(v: Float32)
}
```

Function: Floating-point number, corresponding to the Cangjie [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type.

> **Note:**
>
> This will be deprecated in future versions and replaced with native Cangjie types.

Parent Types:

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: The type name, i.e., [SqlReal <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlreal-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: Float32
```

Function: The value of this data.

Type: [Float32](../../core/core_package_api/core_package_intrinsics.md#float32)

### init(Float32)

```cangjie
public init(v: Float32)
```

Function: Constructs a [SqlReal <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlreal-deprecated) instance based on the input parameter v.

Parameters:

- v: [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The input data.

## class SqlSmallInt <sup>(deprecated)</sup>

```cangjie
public class SqlSmallInt <: SqlDbType {
    public init(v: Int16)
}
```

Function: Small integer, corresponding to the Cangjie [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) type.

> **Note:**
>> This will be deprecated in future versions and replaced with native Cangjie types.

Parent Type:

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: The type name, which is [SqlSmallInt <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlsmallInt-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: Int16
```

Function: The value of this data.

Type: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)

### init(Int16)

```cangjie
public init(v: Int16)
```

Function: Constructs a [SqlSmallInt <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlsmallInt-deprecated) instance with the input parameter v.

Parameters:

- v: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The input data.

## class SqlTime <sup>(deprecated)</sup>

```cangjie
public class SqlTime <: SqlDbType {
    public init(v: DateTime)
}
```

Function: Time (only hours, minutes, seconds, and milliseconds are valid), corresponding to the Cangjie [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) type.

> **Note:**
>
> This will be deprecated in future versions and replaced with native Cangjie types.

Parent Type:

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: The type name, which is [SqlTime <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqltime-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: DateTime
```

Function: The value of this data.

Type: [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

### init(DateTime)

```cangjie
public init(v: DateTime)
```

Function: Constructs a [SqlTime <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqltime-deprecated) instance with the input parameter v.

Parameters:

- v: [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) - The input data.

## class SqlTimeTz <sup>(deprecated)</sup>

```cangjie
public class SqlTimeTz <: SqlDbType {
    public init(v: DateTime)
}
```

Function: Time with timezone (only hours, minutes, seconds, milliseconds, and timezone are valid), corresponding to the Cangjie [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) type.

> **Note:**
>
> This will be deprecated in future versions and replaced with native Cangjie types.

Parent Type:

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: The type name, which is [SqlTimeTz <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqltimetz-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: DateTime
```

Function: The value of this data.

Type: [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

### init(DateTime)

```cangjie
public init(v: DateTime)
```

Function: Constructs a [SqlTimeTz <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqltimetz-deprecated) instance with the input parameter v.

Parameters:

- v: [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) - The input data.

## class SqlTimestamp <sup>(deprecated)</sup>

```cangjie
public class SqlTimestamp <: SqlDbType {
    public init(v: DateTime)
}
```

Function: Timestamp, corresponding to the Cangjie [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) type.

> **Note:**
>
> This will be deprecated in future versions and replaced with native Cangjie types.

Parent Type:

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: The type name, which is [SqlTimestamp <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqltimestamp-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: DateTime
```

Function: The value of this data.

Type: [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

### init(DateTime)

```cangjie
public init(v: DateTime)
```

Function: Constructs a [SqlTimestamp <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqltimestamp-deprecated) instance with the input parameter v.

Parameters:

- v: [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) - The input data.

## class SqlVarBinary <sup>(deprecated)</sup>

```cangjie
public class SqlVarBinary <: SqlDbType {
    public init(v: Array<Byte>)
}
```

Function: Variable-length binary string, corresponding to the Cangjie [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> type.

> **Note:**
>
> This will be deprecated in future versions and replaced with native Cangjie types.

Parent Type:

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: The type name, which is [SqlVarBinary <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlvarbinary-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: Array<Byte>
```

Function: The value of this data.

Type: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>

### init(Array\<Byte>)

```cangjie
public init(v: Array<Byte>)
```

Function: Constructs a [SqlVarBinary <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlvarbinary-deprecated) instance with the input parameter v.

Parameters:

- v: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - The input data.

## class SqlVarchar <sup>(deprecated)</sup>

```cangjie
public class SqlVarchar <: SqlDbType {
    public init(v: String)
}
```

Function: Variable-length string, corresponding to the Cangjie [String](../../core/core_package_api/core_package_structs.md#struct-string) type.

> **Note:**
>
> This will be deprecated in future versions and replaced with native Cangjie types.

Parent Type:

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

Function: The type name, which is [SqlVarchar  <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlvarchar-deprecated).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop value

```cangjie
public mut prop value: String
```

Function: The value of this data.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### init(String)

```cangjie
public init(v: String)
```

Function: Constructs a [SqlVarchar  <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlvarchar-deprecated) instance with the input parameter v.

Parameters:

- v: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The input data.