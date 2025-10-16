/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.database.sql

import std.io.InputStream
import std.math.numeric.Decimal
import std.time.DateTime

/**
 * SqlDbType is the base class of all Sql data types. To extend user-defined types, inherit SqlDbType or SqlNullableDbType.
 * All implementation types must have a public value property.
 *
 * @since 0.40.1
 */
@Deprecated
public interface SqlDbType {
    prop name: String
}

/**
 * Base class of the type that allows null values. If the value is null, the value field value is Option.None.
 *
 * @since 0.40.1
 */
@Deprecated
public interface SqlNullableDbType <: SqlDbType {}

/**
 * Fixed-length character string, corresponding to the Cangjie String type.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `String` instead."]
public class SqlChar <: SqlDbType {
    var _value: String
    public init(v: String) {
        _value = v
    }
    public mut prop value: String {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlChar"
        }
    }
}
/**
 * Fixed-length character string, corresponding to the Cangjie String type. The value can be null.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `?String` instead."]
public class SqlNullableChar <: SqlNullableDbType {
    var _value: ?String
    public init(v: ?String) {
        _value = v
    }
    public mut prop value: ?String {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlNullableChar"
        }
    }
}
/**
 * Variable-length character string, corresponding to the Cangjie String type.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `String` instead."]
public class SqlVarchar <: SqlDbType {
    var _value: String
    public init(v: String) {
        _value = v
    }
    public mut prop value: String {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlVarchar"
        }
    }
}
/**
 * Variable-length character string, corresponding to the Cangjie String type. The value can be null.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `?String` instead."]
public class SqlNullableVarchar <: SqlNullableDbType {
    var _value: ?String
    public init(v: ?String) {
        _value = v
    }
    public mut prop value: ?String {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlNullableVarchar"
        }
    }
}
/**
 * Fixed-length binary string, corresponding to the Cangjie Array<Byte> type.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `Array<Byte>` instead."]
public class SqlBinary <: SqlDbType {
    var _value: Array<Byte>
    public init(v: Array<Byte>) {
        _value = v
    }
    public mut prop value: Array<Byte> {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlBinary"
        }
    }
}
/**
 * Fixed-length binary character string corresponding to the Array<Byte> type. The value can be null.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `?Array<Byte>` instead."]
public class SqlNullableBinary <: SqlNullableDbType {
    var _value: ?Array<Byte>
    public init(v: ?Array<Byte>) {
        _value = v
    }
    public mut prop value: ?Array<Byte> {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlNullableBinary"
        }
    }
}
/**
 * Variable-length binary character string, corresponding to the Cangjie Array<Byte> type.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `Array<Byte>` instead."]
public class SqlVarBinary <: SqlDbType {
    var _value: Array<Byte>
    public init(v: Array<Byte>) {
        _value = v
    }
    public mut prop value: Array<Byte> {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlVarBinary"
        }
    }
}
/**
 * Variable-length binary character string, corresponding to the Array<Byte> type. The value can be null.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `?Array<Byte>` instead."]
public class SqlNullableVarBinary <: SqlNullableDbType {
    var _value: ?Array<Byte>
    public init(v: ?Array<Byte>) {
        _value = v
    }
    public mut prop value: ?Array<Byte> {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlNullableVarBinary"
        }
    }
}
/**
 * Variable-length character data (character large object), corresponding to the Cangjie InputStream type.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `InputStream` instead."]
public class SqlClob <: SqlDbType {
    var _value: InputStream
    public init(v: InputStream) {
        _value = v
    }
    public mut prop value: InputStream {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlClob"
        }
    }
}
/**
 * Variable-length character data (character large object), corresponding to the Cangjie InputStream type, which can be null.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `?InputStream` instead."]
public class SqlNullableClob <: SqlNullableDbType {
    var _value: ?InputStream
    public init(v: ?InputStream) {
        _value = v
    }
    public mut prop value: ?InputStream {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlNullableClob"
        }
    }
}
/**
 * Variable-length binary character data (Binary Large Object), corresponding to the Cangjie InputStream type.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `InputStream` instead."]
public class SqlBlob <: SqlDbType {
    var _value: InputStream
    public init(v: InputStream) {
        _value = v
    }
    public mut prop value: InputStream {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlBlob"
        }
    }
}
/**
 * Variable-length binary character data (Binary Large Object), corresponding to the Cangjie InputStream type, which can be null.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `?InputStream` instead."]
public class SqlNullableBlob <: SqlNullableDbType {
    var _value: ?InputStream
    public init(v: ?InputStream) {
        _value = v
    }
    public mut prop value: ?InputStream {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlNullableBlob"
        }
    }
}
/**
 * Boolean type, corresponding to the Cangjie Bool type
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `Bool` instead."]
public class SqlBool <: SqlDbType {
    var _value: Bool
    public init(v: Bool) {
        _value = v
    }
    public mut prop value: Bool {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlBool"
        }
    }
}
/**
 * Boolean type, corresponding to the warehouse Bool type. The value can be null.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `?Bool` instead."]
public class SqlNullableBool <: SqlNullableDbType {
    var _value: ?Bool
    public init(v: ?Bool) {
        _value = v
    }
    public mut prop value: ?Bool {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlNullableBool"
        }
    }
}
/**
 * Byte, corresponding to the Cangjie Int8 type.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `Int8` instead."]
public class SqlByte <: SqlDbType {
    var _value: Int8
    public init(v: Int8) {
        _value = v
    }
    public mut prop value: Int8 {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlByte"
        }
    }
}
/**
 * Byte, corresponding to the warehouse Int8 type. The value can be null.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `?Int8` instead."]
public class SqlNullableByte <: SqlNullableDbType {
    var _value: ?Int8
    public init(v: ?Int8) {
        _value = v
    }
    public mut prop value: ?Int8 {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlNullableByte"
        }
    }
}
/**
 * Small integer, corresponding to the Cangjie Int16 type.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `Int16` instead."]
public class SqlSmallInt <: SqlDbType {
    var _value: Int16
    public init(v: Int16) {
        _value = v
    }
    public mut prop value: Int16 {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlSmallInt"
        }
    }
}
/**
 * Small integer, corresponding to the Cangjie Int16 type. The value can be null.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `?Int16` instead."]
public class SqlNullableSmallInt <: SqlNullableDbType {
    var _value: ?Int16
    public init(v: ?Int16) {
        _value = v
    }
    public mut prop value: ?Int16 {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlNullableSmallInt"
        }
    }
}
/**
 * Medium integer, corresponding to Cangjie Int32 type.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `Int32` instead."]
public class SqlInteger <: SqlDbType {
    var _value: Int32
    public init(v: Int32) {
        _value = v
    }
    public mut prop value: Int32 {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlInteger"
        }
    }
}
/**
 * Medium integer, corresponding to Cangjie Int32 type. The value can be null.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `?Int32` instead."]
public class SqlNullableInteger <: SqlNullableDbType {
    var _value: ?Int32
    public init(v: ?Int32) {
        _value = v
    }
    public mut prop value: ?Int32 {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlNullableInteger"
        }
    }
}
/**
 * Large integer, corresponding to the Cangjie Int64 type.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `Int64` instead."]
public class SqlBigInt <: SqlDbType {
    var _value: Int64
    public init(v: Int64) {
        _value = v
    }
    public mut prop value: Int64 {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlBigInt"
        }
    }
}
/**
 * Large integer, corresponding to the Cangjie Int64 type. The value can be null.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `?Int64` instead."]
public class SqlNullableBigInt <: SqlNullableDbType {
    var _value: ?Int64
    public init(v: ?Int64) {
        _value = v
    }
    public mut prop value: ?Int64 {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlNullableBigInt"
        }
    }
}
/**
 * Floating point number, corresponding to the Cangjie Float32 type.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `Float32` instead."]
public class SqlReal <: SqlDbType {
    var _value: Float32
    public init(v: Float32) {
        _value = v
    }
    public mut prop value: Float32 {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlReal"
        }
    }
}
/**
 * Floating point number, corresponding to the Cangjie Float32 type. The value can be null.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `?Float32` instead."]
public class SqlNullableReal <: SqlNullableDbType {
    var _value: ?Float32
    public init(v: ?Float32) {
        _value = v
    }
    public mut prop value: ?Float32 {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlNullableReal"
        }
    }
}
/**
 * Double-precision number, corresponding to the Cangjie Float64 type.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `Float64` instead."]
public class SqlDouble <: SqlDbType {
    var _value: Float64
    public init(v: Float64) {
        _value = v
    }
    public mut prop value: Float64 {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlDouble"
        }
    }
}
/**
 * Double-precision number, corresponding to the Cangjie Float64 type. The value can be null.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `?Float64` instead."]
public class SqlNullableDouble <: SqlNullableDbType {
    var _value: ?Float64
    public init(v: ?Float64) {
        _value = v
    }
    public mut prop value: ?Float64 {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlNullableDouble"
        }
    }
}
/**
 * Date, which is valid only for the year, month, and day. It corresponds to the Cangjie DateTime type.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `DateTime` instead."]
public class SqlDate <: SqlDbType {
    var _value: DateTime
    public init(v: DateTime) {
        _value = v
    }
    public mut prop value: DateTime {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlDate"
        }
    }
}
/**
 * Date, which is valid only for the year, month, and day. It corresponds to the Cangjie DateTime type. The value can be null.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `?DateTime` instead."]
public class SqlNullableDate <: SqlNullableDbType {
    var _value: ?DateTime
    public init(v: ?DateTime) {
        _value = v
    }
    public mut prop value: ?DateTime {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlNullableDate"
        }
    }
}
/**
 * Time, which is valid only for hour, minute, second, and millisecond. It corresponds to the Cangjie DateTime type.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `DateTime` instead."]
public class SqlTime <: SqlDbType {
    var _value: DateTime
    public init(v: DateTime) {
        _value = v
    }
    public mut prop value: DateTime {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlTime"
        }
    }
}
/**
 * Time, which is valid only for hour, minute, second, and millisecond. It corresponds to the Cangjie DateTime type. The value can be null.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `?DateTime` instead."]
public class SqlNullableTime <: SqlNullableDbType {
    var _value: ?DateTime
    public init(v: ?DateTime) {
        _value = v
    }
    public mut prop value: ?DateTime {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlNullableTime"
        }
    }
}
/**
 * Time with a time zone, which is valid only for the hour, minute, second, and millisecond and timezone. It corresponds to the Cangjie DateTime type.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `DateTime` instead."]
public class SqlTimeTz <: SqlDbType {
    var _value: DateTime
    public init(v: DateTime) {
        _value = v
    }
    public mut prop value: DateTime {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlTimeTz"
        }
    }
}
/**
 * Time with a time zone, which is valid only for the hour, minute, second, and millisecond and timezone. It corresponds to the Cangjie DateTime type. The value can be null.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `?DateTime` instead."]
public class SqlNullableTimeTz <: SqlNullableDbType {
    var _value: ?DateTime
    public init(v: ?DateTime) {
        _value = v
    }
    public mut prop value: ?DateTime {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlNullableTimeTz"
        }
    }
}
/**
 * Timestamp, corresponding to the Cangjie DateTime type.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `DateTime` instead."]
public class SqlTimestamp <: SqlDbType {
    var _value: DateTime
    public init(v: DateTime) {
        _value = v
    }
    public mut prop value: DateTime {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlTimestamp"
        }
    }
}
/**
 * Timestamp, corresponding to the Cangjie DateTime type. The value can be null.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `?DateTime` instead."]
public class SqlNullableTimestamp <: SqlNullableDbType {
    var _value: ?DateTime
    public init(v: ?DateTime) {
        _value = v
    }
    public mut prop value: ?DateTime {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlNullableTimestamp"
        }
    }
}
/**
 * Interval, corresponding to the Cangjie Duration type.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `Duration` instead."]
public class SqlInterval <: SqlDbType {
    var _value: Duration
    public init(v: Duration) {
        _value = v
    }
    public mut prop value: Duration {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlInterval"
        }
    }
}
/**
 * Interval, corresponding to the Cangjie Duration type. The value can be null.
 *
 * @since 0.40.1
 */
@Deprecated[message: "Use `?Duration` instead."]
public class SqlNullableInterval <: SqlNullableDbType {
    var _value: ?Duration
    public init(v: ?Duration) {
        _value = v
    }
    public mut prop value: ?Duration {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlNullableInterval"
        }
    }
}

/**
 * SqlDecimal, corresponding to the Cangjie Decimal type.
 *
 * @since 0.50.2
 */
@Deprecated[message: "Use `Decimal` instead."]
public class SqlDecimal <: SqlDbType {
    var _value: Decimal
    public init(v: Decimal) {
        _value = v
    }
    public mut prop value: Decimal {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlDecimal"
        }
    }
}

/**
 * SqlNullableDecimal, corresponding to the Cangjie Decimal type. The value can be null.
 *
 * @since 0.50.2
 */
@Deprecated[message: "Use `?Decimal` instead."]
public class SqlNullableDecimal <: SqlNullableDbType {
    var _value: ?Decimal
    public init(v: ?Decimal) {
        _value = v
    }
    public mut prop value: ?Decimal {
        get() {
            return _value
        }
        set(value) {
            _value = value
        }
    }
    public prop name: String {
        get() {
            "SqlNullableDecimal"
        }
    }
}
