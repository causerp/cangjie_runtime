# std.database.sql

## Function Overview

The database.sql package provides interfaces for Cangjie to access databases.

This package offers a generic SQL/CLI interface that works in conjunction with database drivers (Driver) to perform various database operations.

> **Note:**
>
> Currently, only SQL/CLI interface is supported.

The following table shows the correspondence between SQL data types and Cangjie data types:

| SQL         | CDBC/Cangjie     | SqlDataType    | Description                                              |
| ----------- | ---------------- | -------------- | ------------------------------------------------------- |
| `RUNE`      | `String`         | `SqlChar`      | -                                                       |
| `VARCHAR`   | `String`         | `SqlVarchar`   | -                                                       |
| `CLOB`      | `io.InputStream` | `SqlClob`      | -                                                       |
| `BINARY`    | `Array<Byte>`    | `SqlBinary`    | -                                                       |
| `VARBINARY` | `Array<Byte>`    | `SqlVarBinary` | -                                                       |
| `BLOB`      | `io.InputStream` | `SqlBlob`      | -                                                       |
| `NUMERIC`   | `Decimal`        | `SqlDecimal`   | -                                                       |
| `DECIMAL`   | `Decimal`        | `SqlDecimal`   | -                                                       |
| `BOOLEAN`   | `Bool`           | `SqlBool`      | -                                                       |
| `TINYINT`   | `Int8`           | `SqlByte`      | -                                                       |
| `SMALLINT`  | `Int16`          | `SqlSmallInt`  | -                                                       |
| `INTEGER`   | `Int32`          | `SqlInteger`   | -                                                       |
| `BIGINT`    | `Int64`          | `SqlBigInt`    | -                                                       |
| `REAL`      | `Float32`        | `SqlReal`      | -                                                       |
| `DOUBLE`    | `Float64`        | `SqlDouble`    | -                                                       |
| `DATE`      | `time.DateTime`  | `SqlDate`      | Values support `YEAR`, `MONTH`, `DAY`.                  |
| `TIME`      | `time.DateTime`  | `SqlTime`      | Values support `HOUR`, `MINUTE`, `SECOND` (excluding `TIME ZONE`). |
| `TIMETZ`    | `time.DateTime`  | `SqlTimeTz`    | Values support `HOUR`, `MINUTE`, `SECOND` (including `TIME ZONE`). |
| `TIMESTAMP` | `time.DateTime`  | `SqlTimestamp` | Values support `YEAR`, `MONTH`, `DAY`, `HOUR`, `MINUTE`, `SECOND`, `TIME ZONE`. |
| `INTERVAL`  | `time.Duration`  | `SqlInterval`  | Year-month or day-time intervals.                       |

## API List

### Interfaces

| Interface Name                                               | Functionality                                                |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [ColumnInfo](./database_sql_package_api/database_sql_package_interfaces.md#interface-columninfo) | Column information for results returned by Select/Query statements. |
| [Connection](./database_sql_package_api/database_sql_package_interfaces.md#interface-connection) | Database connection interface.                               |
| [Datasource](./database_sql_package_api/database_sql_package_interfaces.md#interface-datasource) | Data source interface.                                       |
| [Driver](./database_sql_package_api/database_sql_package_interfaces.md#interface-driver) | Database driver interface.                                   |
| [QueryResult](./database_sql_package_api/database_sql_package_interfaces.md#interface-queryresult) | Result interface for Select statements.                      |
| [SqlDbType <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_interfaces.md#interface-sqldbType-deprecated) | Parent class for all SQL data types.                         |
| [SqlNullableDbType <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_interfaces.md#interface-sqlnullabledbType-deprecated) | Parent class for SQL data types that allow `null` values.    |
| [Statement](./database_sql_package_api/database_sql_package_interfaces.md#interface-statement) | SQL statement pre-execution interface.                       |
| [Transaction](./database_sql_package_api/database_sql_package_interfaces.md#interface-transaction) | Defines core behaviors for database transactions.            |
| [UpdateResult](./database_sql_package_api/database_sql_package_interfaces.md#interface-updateresult) | Result interface for Insert, Update, and Delete statements.  |

### Classes

| Class Name                                                   | Functionality                                                |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [DriverManager](./database_sql_package_api/database_sql_package_classes.md#class-drivermanager) | Supports runtime retrieval of database driver instances by driver name. |
| [PooledDatasource](./database_sql_package_api/database_sql_package_classes.md#class-pooleddatasource) | Database connection pool class providing connection pooling capabilities. |
| [SqlOption](./database_sql_package_api/database_sql_package_classes.md#class-sqloption) | Predefined SQL option names and values.                      |
| [SqlBigInt <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlbigInt-deprecated) | Large integer, corresponding to Cangjie `Int64` type.        |
| [SqlBinary <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlbinary-deprecated) | Fixed-length binary string, corresponding to Cangjie `Array<Byte>` type. |
| [SqlBlob <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlblob-deprecated) | Variable-length large binary string (BINARY LARGE OBJECT), corresponding to Cangjie `InputStream` type. |
| [SqlBool <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlbool-deprecated) | Boolean type, corresponding to Cangjie `Bool` type.          |
| [SqlByte <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlbyte-deprecated) | Byte, corresponding to Cangjie `Int8` type.                  |
| [SqlChar <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlchar-deprecated) | Fixed-length string, corresponding to Cangjie `String` type. |
| [SqlClob <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlclob-deprecated) | Variable-length large string (RUNE LARGE OBJECT), corresponding to Cangjie `InputStream` type. |
| [SqlDate <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqldate-deprecated) | Date (only year, month, day valid), corresponding to Cangjie `DateTime` type. |
| [SqlDecimal <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqldecimal-deprecated) | High-precision number, corresponding to Cangjie `Decimal` type. |
| [SqlDouble <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqldouble-deprecated) | Double-precision number, corresponding to Cangjie `Float64` type. |
| [SqlInteger <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlinteger-deprecated) | Medium integer, corresponding to Cangjie `Int32` type.       |
| [SqlInterval <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlinterval-deprecated) | Time interval, corresponding to Cangjie `Duration` type.    |
| [SqlReal <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlreal-deprecated) | Floating-point number, corresponding to Cangjie `Float32` type. |
| [SqlSmallInt <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlsmallInt-deprecated) | Small integer, corresponding to Cangjie `Int16` type.       |
| [SqlTime <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqltime-deprecated) | Time (only hour, minute, second valid), corresponding to Cangjie `DateTime` type. |
| [SqlTimestamp <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqltimestamp-deprecated) | Timestamp, corresponding to Cangjie `DateTime` type.         |
| [SqlTimeTz <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqltimetz-deprecated) | Time with timezone (only hour, minute, second, timezone valid), corresponding to Cangjie `DateTime` type. |
| [SqlVarBinary <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlvarbinary-deprecated) | Variable-length binary string, corresponding to Cangjie `Array<Byte>` type. |
| [SqlVarchar <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlvarchar-deprecated) | Variable-length string, corresponding to Cangjie `String` type. |
| [SqlNullableBigInt <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlnullablebigInt-deprecated) | Large integer, corresponding to Cangjie `Int64` type, allowing database `Null` values. |
| [SqlNullableBinary <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlnullablebinary-deprecated) | Fixed-length binary string, corresponding to Cangjie `Array<Byte>` type, allowing database `Null` values. |
| [SqlNullableBlob <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlnullableblob-deprecated) | Variable-length large binary string (BINARY LARGE OBJECT), corresponding to Cangjie `InputStream` type, allowing database `Null` values. |
| [SqlNullableBool <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlnullablebool-deprecated) | Boolean type, corresponding to Cangjie `Bool` type, allowing database `Null` values. |
| [SqlNullableByte <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlnullablebyte-deprecated) | Byte, corresponding to Cangjie `Int8` type, allowing database `Null` values. |
| [SqlNullableChar <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlnullablechar-deprecated) | Fixed-length binary string, corresponding to Cangjie `String` type, allowing database `Null` values. |
| [SqlNullableClob <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlnullableclob-deprecated) | Variable-length large string (RUNE LARGE OBJECT), corresponding to Cangjie `InputStream` type, allowing database `Null` values. |
| [SqlNullableDate <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlnullabledate-deprecated) | Date (only year, month, day valid), corresponding to Cangjie `DateTime` type, allowing database `Null` values. |
| [SqlNullableDecimal <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlnullabledecimal-deprecated) | High-precision number, corresponding to Cangjie `Decimal` type, allowing database `Null` values. |
| [SqlNullableDouble <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlnullabledouble-deprecated) | Double-precision number, corresponding to Cangjie `Float64` type, allowing database `Null` values. |
| [SqlNullableInteger <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlnullableinteger-deprecated) | Medium integer, corresponding to Cangjie `Int32` type, allowing database `Null` values. |
| [SqlNullableInterval <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlnullableinterval-deprecated) | Time interval, corresponding to Cangjie `Duration` type, allowing database `Null` values. |
| [SqlNullableReal <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlnullablereal-deprecated) | Floating-point number, corresponding to Cangjie `Float32` type, allowing database `Null` values. |
| [SqlNullableSmallInt <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlnullablesmallint-deprecated) | Small integer, corresponding to Cangjie `Int16` type, allowing database `Null` values. |
| [SqlNullableTime <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlnullabletime-deprecated) | Time (only hour, minute, second valid), corresponding to Cangjie `DateTime` type, allowing database `Null` values. |
| [SqlNullableTimestamp <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlnullabletimestamp-deprecated) | Timestamp, corresponding to Cangjie `DateTime` type, allowing database `Null` values. |
| [SqlNullableTimeTz <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlnullabletimeTz-deprecated) | Time with timezone (only hour, minute, second, timezone valid), corresponding to Cangjie `DateTime` type, allowing database `Null` values. |
| [SqlNullableVarBinary <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlnullablevarbinary-deprecated) | Variable-length binary string, corresponding to Cangjie `Array<Byte>` type, allowing database `Null` values. |
| [SqlNullableVarchar <sup>(deprecated)</sup>](./database_sql_package_api/database_sql_package_classes.md#class-sqlnullablevarchar-deprecated) | Variable-length string, corresponding to Cangjie `String` type, allowing database `Null` values. |

### Enums

| Enum Name                                                    | Functionality                                                |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [ConnectionState](./database_sql_package_api/database_sql_package_enums.md#enum-connectionstate) | Describes the current state of connection with a data source. |
| [TransactionAccessMode](./database_sql_package_api/database_sql_package_enums.md#enum-transactionaccessmode) | Read/write mode for transactions.                           |
| [TransactionDeferrableMode](./database_sql_package_api/database_sql_package_enums.md#enum-transactiondeferrablemode) | Deferrable mode for transactions.                           |
| [TransactionIsoLevel](./database_sql_package_api/database_sql_package_enums.md#enum-transactionisolevel) | Defines when and how the results of operations in one transaction become visible to concurrent transactions in a database system. |

### Exception Classes

| Exception Class Name                                         | Functionality                |
| ------------------------------------------------------------ | ---------------------------- |
| [SqlException](./database_sql_package_api/database_sql_package_exceptions.md#class-sqlexception) | Handles SQL-related exceptions. |