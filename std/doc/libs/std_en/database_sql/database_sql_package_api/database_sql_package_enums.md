# Enums

## enum ConnectionState

```cangjie
public enum ConnectionState <: Equatable<ConnectionState> {
    | Broken
    | Closed
    | Connecting
    | Connected
}
```

Function: Describes the current state of the connection to a data source.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[ConnectionState](#enum-connectionstate)>

### Broken

```cangjie
Broken
```

Function: Indicates that the connection to the data source has been broken. This can only occur after being in the Connected state.

### Closed

```cangjie
Closed
```

Function: Indicates that the connection object has been closed.

### Connected

```cangjie
Connected
```

Function: Indicates that the connection object has successfully connected to the data source.

### Connecting

```cangjie
Connecting
```

Function: Indicates that the connection object is in the process of connecting to the data source.

### operator func !=(ConnectionState)

```cangjie
public operator func !=(rhs: ConnectionState): Bool
```

Function: Determines whether the data source connection states are different.

Parameters:

- rhs: [ConnectionState](database_sql_package_enums.md#enum-connectionstate) - The data source connection state to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `false` if the input connection state matches the current state, otherwise returns `true`.

### operator func ==(ConnectionState)

```cangjie
public operator func ==(rhs: ConnectionState): Bool
```

Function: Determines whether the data source connection states are identical.

Parameters:

- rhs: [ConnectionState](database_sql_package_enums.md#enum-connectionstate) - The data source connection state to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the input connection state matches the current state, otherwise returns `false`.

## enum TransactionAccessMode

```cangjie
public enum TransactionAccessMode <: ToString & Hashable & Equatable<TransactionAccessMode> {
    | ReadOnly
    | ReadWrite
    | Unspecified
}
```

Function: Specifies the read/write mode for transactions.

Parent Types:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TransactionAccessMode](#enum-transactionaccessmode)>

### ReadOnly

```cangjie
ReadOnly
```

Function: Indicates read-only mode.

### ReadWrite

```cangjie
ReadWrite
```

Function: Indicates read-write mode.

### Unspecified

```cangjie
Unspecified
```

Function: Indicates an unspecified transaction access mode. The actual behavior depends on the specific database server.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value of the transaction access mode.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value of the transaction access mode.

### func toString()

```cangjie
public func toString(): String
```

Function: Returns the string representation of the transaction access mode. The mapping between enum values and strings is as follows:

| Enum Value   | String        |
| ------------ | ------------- |
| ReadOnly     | "Read Only"   |
| ReadWrite    | "Read Write"  |
| Unspecified  | "Unspecified" |

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of the transaction access mode.

### operator func !=(TransactionAccessMode)

```cangjie
public operator func != (rhs: TransactionAccessMode): Bool
```

Function: Determines whether two [TransactionAccessMode](database_sql_package_enums.md#enum-transactionaccessmode) values are unequal.

Parameters:

- rhs: [TransactionAccessMode](database_sql_package_enums.md#enum-transactionaccessmode) - The input enum value to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if unequal, otherwise returns `false`.

### operator func ==(TransactionAccessMode)

```cangjie
public operator func == (rhs: TransactionAccessMode): Bool
```

Function: Determines whether two [TransactionAccessMode](database_sql_package_enums.md#enum-transactionaccessmode) values are equal.

Parameters:

- rhs: [TransactionAccessMode](database_sql_package_enums.md#enum-transactionaccessmode) - The input enum value to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if equal, otherwise returns `false`.

## enum TransactionDeferrableMode

```cangjie
public enum TransactionDeferrableMode <: ToString & Hashable & Equatable<TransactionDeferrableMode> {
    | Deferrable
    | NotDeferrable
    | Unspecified
}
```

Function: Specifies the deferrable mode for transactions.

Parent Types:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TransactionDeferrableMode](#enum-transactiondeferrablemode)>

### Deferrable

```cangjie
Deferrable
```

Function: Indicates that the transaction is deferrable.

> **Note:**
>
> A deferred transaction is one that hasn't been committed by the end of the forward phase and encounters an error preventing rollback. Because the transaction cannot be rolled back, it becomes deferred.

### NotDeferrable

```cangjie
NotDeferrable
```

Function: Indicates that the transaction is not deferrable.

### Unspecified

```cangjie
Unspecified
```

Function: Indicates an unspecified transaction deferrable mode. The actual behavior depends on the specific database server.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value of the transaction deferrable mode.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value of the transaction deferrable mode.

### func toString()

```cangjie
public func toString(): String
```

Function: Returns the string representation of the transaction deferrable mode. The mapping between enum values and strings is as follows:

| Enum Value     | String           |
| -------------- | ---------------- |
| Deferrable     | "Deferrable"     |
| NotDeferrable  | "Not Deferrable" |
| Unspecified    | "Unspecified"    |

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of the transaction deferrable mode.

### operator func !=(TransactionDeferrableMode)

```cangjie
public operator func != (rhs: TransactionDeferrableMode): Bool
```

Function: Determines whether two [TransactionDeferrableMode](database_sql_package_enums.md#enum-transactiondeferrablemode) values are unequal.

Parameters:

- rhs: [TransactionDeferrableMode](database_sql_package_enums.md#enum-transactiondeferrablemode) - The input enum value to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if unequal, otherwise returns `false`.

### operator func ==(TransactionDeferrableMode)

```cangjie
public operator func == (rhs: TransactionDeferrableMode): Bool
```

Function: Determines whether two [TransactionDeferrableMode](database_sql_package_enums.md#enum-transactiondeferrablemode) values are equal.

Parameters:

- rhs: [TransactionDeferrableMode](database_sql_package_enums.md#enum-transactiondeferrablemode) - The input enum value to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if equal, otherwise returns `false`.

## enum TransactionIsoLevel

```cangjie
public enum TransactionIsoLevel <: ToString & Hashable & Equatable<TransactionIsoLevel> {
    | Chaos
    | Linearizable
    | ReadCommitted
    | ReadUncommitted
    | RepeatableRead
    | Serializable
    | Snapshot
    | Unspecified
}
```

Function: Transaction isolation level.

> **Note:**
>
> Transaction isolation defines when and how the results of operations within one transaction become visible to concurrent operations in other transactions in a database system.

Parent Types:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TransactionIsoLevel](#enum-transactionisolevel)>

### Chaos

```cangjie
Chaos
```

Function: Indicates that pending changes from transactions with higher isolation levels cannot be overwritten.

### Linearizable

```cangjie
Linearizable
```

Function: Represents transaction linearizability.

> **Note:**
>
> Distinct from serializability ([Serializable]()), linearizability primarily emphasizes a set of individual operations (such as a series of read-write operations) on a single object (i.e., a database row or NoSQL record). Linearizability guarantees these operations are executed strictly in real-time order. For example, when examining a subset of operations on a single object, linearizability becomes relevant.

### ReadCommitted

```cangjie
ReadCommitted
```

Function: Indicates that a transaction waits until rows locked by other transactions' writes are unlocked; this prevents it from reading any "dirty" data.

### ReadUncommitted

```cangjie
ReadUncommitted
```

Function: Indicates no isolation between transactions.

### RepeatableRead

```cangjie
RepeatableRead
```

Function: Indicates repeatable read isolation. Multiple reads of the same field yield consistent results unless the data is modified by the transaction itself.

### Serializable

```cangjie
Serializable
```

Function: Indicates serializable isolation. At this isolation level, all transactions execute sequentially, thus preventing dirty reads, non-repeatable reads, and phantom reads.

### Snapshot

```cangjie
Snapshot
```

Function: Indicates that snapshot isolation avoids most locking and blocking by using row versioning.

### Unspecified

```cangjie
Unspecified
```

Function: An unspecified transaction isolation level whose behavior depends on the specific database server.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Gets the hash value of the transaction isolation level.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value of the transaction isolation level.

### func toString()

```cangjie
public func toString(): String
```

Function: Returns the string representation of the transaction isolation level. The correspondence between enum values and strings is shown in the following table:

| Enum Value       | String              |
| ---------------- | ------------------- |
| Chaos            | "Chaos"             |
| Linearizable     | "Linearizable"      |
| ReadCommitted    | "Read Committed"    |
| ReadUncommitted  | "Read Uncommitted"  |
| RepeatableRead   | "Repeatable Read"   |
| Serializable     | "Serializable"      |
| Snapshot         | "Snapshot"          |
| Unspecified      | "Unspecified"       |

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of the transaction isolation level.

### operator func !=(TransactionIsoLevel)

```cangjie
public operator func != (rhs: TransactionIsoLevel): Bool
```

Function: Determines whether two [TransactionIsoLevel](database_sql_package_enums.md#enum-transactionisolevel) values are not equal.

Parameters:

- rhs: [TransactionIsoLevel](database_sql_package_enums.md#enum-transactionisolevel) - The input [TransactionIsoLevel](database_sql_package_enums.md#enum-transactionisolevel).

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if not equal, otherwise returns `false`.

### operator func ==(TransactionIsoLevel)

```cangjie
public operator func == (rhs: TransactionIsoLevel): Bool
```

Function: Determines whether two [TransactionIsoLevel](database_sql_package_enums.md#enum-transactionisolevel) values are equal.

Parameters:

- rhs: [TransactionIsoLevel](database_sql_package_enums.md#enum-transactionisolevel) - The input [TransactionIsoLevel](database_sql_package_enums.md#enum-transactionisolevel).

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if equal, otherwise returns `false`.