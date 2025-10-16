# Interfaces

## interface Formattable

```cangjie
public interface Formattable {
    func format(fmt: String): String
}
```

Function: This interface defines the formatting function, which converts an instance of the specified type into a string in the corresponding format based on formatting parameters.

For details about formatting parameters, please refer to the [Function Description](./../convert_package_overview.md#function-description) in the convert package.

Other types can provide formatting functionality by implementing this interface.

### func format(String)

```cangjie
func format(fmt: String): String
```

Function: Formats the current instance into a string in the corresponding format based on formatting parameters.

Parameters:

- fmt: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Formatting parameters.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The formatted string obtained from the current instance.

### extend Float16 <: Formattable

```cangjie
extend Float16 <: Formattable
```

Function: Extends the [Formattable](convert_package_interfaces.md#interface-formattable) interface for [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) to enable converting [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) instances into formatted strings.

Parent Type:

- [Formattable](#interface-formattable)

#### func format(String)

```cangjie
public func format(fmt: String): String
```

Function: Formats the current [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type instance into a string in the corresponding format based on formatting parameters.

Parameters:

- fmt: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Formatting parameters.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The formatted string obtained from the current [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type instance.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when fmt is invalid.

### extend Float32 <: Formattable

```cangjie
extend Float32 <: Formattable
```

Function: Extends the [Formattable](convert_package_interfaces.md#interface-formattable) interface for [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) to enable converting [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) instances into formatted strings.

Parent Type:

- [Formattable](#interface-formattable)

#### func format(String)

```cangjie
public func format(fmt: String): String
```

Function: Formats the current [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type instance into a string in the corresponding format based on formatting parameters.

Parameters:

- fmt: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Formatting parameters.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The formatted string obtained from the current [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type instance.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when fmt is invalid.

### extend Float64 <: Formattable

```cangjie
extend Float64 <: Formattable
```

Function: Extends the [Formattable](convert_package_interfaces.md#interface-formattable) interface for [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) to enable converting [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) instances into formatted strings.

Parent Type:

- [Formattable](#interface-formattable)

#### func format(String)

```cangjie
public func format(fmt: String): String
```

Function: Formats the current [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type instance into a string in the corresponding format based on formatting parameters.

Parameters:

- fmt: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Formatting parameters.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The formatted string obtained from the current [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type instance.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when fmt is invalid.

### extend Int16 <: Formattable

```cangjie
extend Int16 <: Formattable
```

Function: Extends the [Formattable](convert_package_interfaces.md#interface-formattable) interface for [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) to enable converting [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) instances into formatted strings.

Parent Type:

- [Formattable](#interface-formattable)

#### func format(String)

```cangjie
public func format(fmt: String): String
```

Function: Formats the current [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) type instance into a string in the corresponding format based on formatting parameters.

Parameters:- fmt: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Formatting parameter.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The formatted string representation of the current [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) instance.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the fmt parameter is invalid.

### extend Int32 <: Formattable

```cangjie
extend Int32 <: Formattable
```

Function: Extends the [Formattable](convert_package_interfaces.md#interface-formattable) interface to [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) for converting [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) instances into formatted strings.

Parent Type:

- [Formattable](#interface-formattable)

#### func format(String)

```cangjie
public func format(fmt: String): String
```

Function: Formats the current [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) instance into a string according to the specified format parameter.

Parameters:

- fmt: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Formatting parameter.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The formatted string representation of the current [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) instance.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the fmt parameter is invalid.

### extend Int64 <: Formattable

```cangjie
extend Int64 <: Formattable
```

Function: Extends the [Formattable](convert_package_interfaces.md#interface-formattable) interface to [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) for converting [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) instances into formatted strings.

Parent Type:

- [Formattable](#interface-formattable)

#### func format(String)

```cangjie
public func format(fmt: String): String
```

Function: Formats the current [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) instance into a string according to the specified format parameter.

Parameters:

- fmt: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Formatting parameter.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The formatted string representation of the current [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) instance.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the fmt parameter is invalid.

### extend Int8 <: Formattable

```cangjie
extend Int8 <: Formattable
```

Function: Extends the [Formattable](convert_package_interfaces.md#interface-formattable) interface to [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) for converting [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) instances into formatted strings.

Parent Type:

- [Formattable](#interface-formattable)

#### func format(String)

```cangjie
public func format(fmt: String): String
```

Function: Formats the current [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) instance into a string according to the specified format parameter.

Parameters:

- fmt: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Formatting parameter.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The formatted string representation of the current [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) instance.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the fmt parameter is invalid.

### extend Rune <: Formattable

```cangjie
extend Rune <: Formattable
```

Function: Extends the [Formattable](convert_package_interfaces.md#interface-formattable) interface to [Rune](../../core/core_package_api/core_package_intrinsics.md#rune) for converting [Rune](../../core/core_package_api/core_package_intrinsics.md#rune) instances into formatted strings.

Parent Type:

- [Formattable](#interface-formattable)

#### func format(String)

```cangjie
public func format(fmt: String): String
```

Function: Formats the current [Rune](../../core/core_package_api/core_package_intrinsics.md#rune) instance into a string according to the specified format parameter.

Parameters:

- fmt: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Formatting parameter.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The formatted string representation of the current [Rune](../../core/core_package_api/core_package_intrinsics.md#rune) instance.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the fmt parameter is invalid.

### extend UInt16 <: Formattable

```cangjie
extend UInt16 <: Formattable
```

Function: Extends the [Formattable](convert_package_interfaces.md#interface-formattable) interface to [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) for converting [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) instances into formatted strings.

Parent Type:

- [Formattable](#interface-formattable)

#### func format(String)

```cangjie
public func format(fmt: String): String
```

Function: Formats the current [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type instance into a corresponding formatted string based on the formatting parameters.

Parameters:

- fmt: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Formatting parameters.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The formatted string obtained from the current [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type instance.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the fmt parameter is invalid.

### extend UInt32 <: Formattable

```cangjie
extend UInt32 <: Formattable
```

Function: Extends the [Formattable](convert_package_interfaces.md#interface-formattable) interface for [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) to enable formatting [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) instances into formatted strings.

Parent Types:

- [Formattable](#interface-formattable)

#### func format(String)

```cangjie
public func format(fmt: String): String
```

Function: Formats the current [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type instance into a corresponding formatted string based on the formatting parameters.

Parameters:

- fmt: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Formatting parameters.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The formatted string obtained from the current [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type instance.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the fmt parameter is invalid.

### extend UInt64 <: Formattable

```cangjie
extend UInt64 <: Formattable
```

Function: Extends the [Formattable](convert_package_interfaces.md#interface-formattable) interface for [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) to enable formatting [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) instances into formatted strings.

Parent Types:

- [Formattable](#interface-formattable)

#### func format(String)

```cangjie
public func format(fmt: String): String
```

Function: Formats the current [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) type instance into a corresponding formatted string based on the formatting parameters.

Parameters:

- fmt: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Formatting parameters.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The formatted string obtained from the current [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) type instance.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the fmt parameter is invalid.

### extend UInt8 <: Formattable

```cangjie
extend UInt8 <: Formattable
```

Function: Extends the [Formattable](convert_package_interfaces.md#interface-formattable) interface for [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) to enable formatting [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) instances into formatted strings.

Parent Types:

- [Formattable](#interface-formattable)

#### func format(String)

```cangjie
public func format(fmt: String): String
```

Function: Formats the current [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) type instance into a corresponding formatted string based on the formatting parameters.

Parameters:

- fmt: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Formatting parameters.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The formatted string obtained from the current [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) type instance.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the fmt parameter is invalid.

## interface Parsable\<T>

```cangjie
public interface Parsable<T> {
    static func parse(value: String): T
    static func tryParse(value: String): Option<T>
}
```

Function: This interface provides unified methods to support parsing strings into specific types.

This interface offers two sets of methods: parse and tryParse. The parse method throws an exception upon parsing failure, while the tryParse method wraps the return value in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont), returning None if parsing fails.
This package has already implemented this interface for basic types such as [Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Rune](../../core/core_package_api/core_package_intrinsics.md#rune), [Float16](../../core/core_package_api/core_package_intrinsics.md#float16), and [Int64](../../core/core_package_api/core_package_intrinsics.md#int64), enabling string conversion to these types.

### static func parse(String)

```cangjie
static func parse(value: String): T
```

Function: Parses a specific type from a string.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be parsed.

Return Value:

- T - The converted value.

### static func tryParse(String)

```cangjie
static func tryParse(value: String): Option<T>
```

Function: Parses a specific type from a string.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be parsed.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - The converted value, returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>.None if conversion fails.

### extend Bool <: Parsable\<Bool>

```cangjie
extend Bool <: Parsable<Bool>
```

Function: This extension primarily implements operations to convert string literals of [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) type to [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) values.

Parent Type:

- [Parsable](#interface-parsablet)\<[Bool](../../core/core_package_api/core_package_intrinsics.md#bool)>

#### static func parse(String)

```cangjie
public static func parse(data: String): Bool
```

Function: Converts a string literal of [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) type to a [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns the converted [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string is empty or conversion fails.

#### static func tryParse(String)

```cangjie
public static func tryParse(data: String): Option<Bool>
```

Function: Converts a string literal of [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) type to an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Bool](../../core/core_package_api/core_package_intrinsics.md#bool)> value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Bool](../../core/core_package_api/core_package_intrinsics.md#bool)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Bool](../../core/core_package_api/core_package_intrinsics.md#bool)> value, returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Bool](../../core/core_package_api/core_package_intrinsics.md#bool)>.None if conversion fails.

### extend Float16 <: Parsable\<Float16>

```cangjie
extend Float16 <: Parsable<Float16>
```

Function: This extension primarily implements operations to convert string literals of [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type to [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) values.

> **Note:**
>
> Currently, binary and octal floating-point conversions are not supported.

Parent Type:

- [Parsable](#interface-parsablet)\<[Float16](../../core/core_package_api/core_package_intrinsics.md#float16)>

#### static func parse(String)

```cangjie
public static func parse(data: String): Float16
```

Function: Converts a string literal of [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type to a [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return Value:

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - Returns the converted [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string does not conform to floating-point syntax.

#### static func tryParse(String)

```cangjie
public static func tryParse(data: String): Option<Float16>
```

Function: Converts a string literal of [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type to an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Float16](../../core/core_package_api/core_package_intrinsics.md#float16)> value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Float16](../../core/core_package_api/core_package_intrinsics.md#float16)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Float16](../../core/core_package_api/core_package_intrinsics.md#float16)> value, returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Float16](../../core/core_package_api/core_package_intrinsics.md#float16)>.None if conversion fails.

### extend Float32 <: Parsable\<Float32>

```cangjie
extend Float32 <: Parsable<Float32>
```

Function: This extension primarily implements operations to convert string literals of [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type to [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) values.

> **Note:**
>
> Currently, binary and octal floating-point conversions are not supported.

Parent Type:

- [Parsable](#interface-parsablet)\<[Float32](../../core/core_package_api/core_package_intrinsics.md#float32)>

#### static func parse(String)

```cangjie
public static func parse(data: String): Float32
```

Function: Converts a string literal of [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type to a [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return Value:

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - Returns the converted [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string does not conform to floating-point syntax.

#### static func tryParse(String)

```cangjie
public static func tryParse(data: String): Option<Float32>
```

Function: Converts a string literal of type [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) into an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Float32](../../core/core_package_api/core_package_intrinsics.md#float32)> value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Float32](../../core/core_package_api/core_package_intrinsics.md#float32)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Float32](../../core/core_package_api/core_package_intrinsics.md#float32)> value. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Float32](../../core/core_package_api/core_package_intrinsics.md#float32)>.None if conversion fails.

### extend Float64 <: Parsable\<Float64>

```cangjie
extend Float64 <: Parsable<Float64>
```

Function: This extension primarily implements operations for converting string literals of type [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) into [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) values.

> **Note:**
>
> Binary and octal floating-point number conversions are currently not supported.

Parent Type:

- [Parsable](#interface-parsablet)\<[Float64](../../core/core_package_api/core_package_intrinsics.md#float64)>

#### static func parse(String)

```cangjie
public static func parse(data: String): Float64
```

Function: Converts a string literal of type [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) into a [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - Returns the converted [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string does not conform to floating-point syntax.

#### static func tryParse(String)

```cangjie
public static func tryParse(data: String): Option<Float64>
```

Function: Converts a string literal of type [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) into an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Float64](../../core/core_package_api/core_package_intrinsics.md#float64)> value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Float64](../../core/core_package_api/core_package_intrinsics.md#float64)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Float64](../../core/core_package_api/core_package_intrinsics.md#float64)> value. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Float64](../../core/core_package_api/core_package_intrinsics.md#float64)>.None if conversion fails.

### extend Int16 <: Parsable\<Int16>

```cangjie
extend Int16 <: Parsable<Int16>
```

Function: This extension primarily implements operations for converting string literals of type [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) into [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) values.

Parent Type:

- [Parsable](#interface-parsablet)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

#### static func parse(String)

```cangjie
public static func parse(data: String): Int16
```

Function: Converts a string literal of type [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) into an [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Returns the converted [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string is empty, starts with `+`, fails to convert, exceeds the [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) range, or contains invalid UTF-8 characters.

#### static func tryParse(String)

```cangjie
public static func tryParse(data: String): Option<Int16>
```

Function: Converts a string literal of type [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) into an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)> value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)> value. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>.None if conversion fails.

### extend Int32 <: Parsable\<Int32>

```cangjie
extend Int32 <: Parsable<Int32>
```

Function: This extension primarily implements operations for converting string literals of type [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) into [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) values.

Parent Type:

- [Parsable](#interface-parsablet)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

#### static func parse(String)

```cangjie
public static func parse(data: String): Int32
```

Function: Converts a string literal of type [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) into an [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns the converted [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string is empty, starts with `+`, fails to convert, exceeds the [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) range, or contains invalid UTF-8 characters.

#### static func tryParse(String)

```cangjie
public static func tryParse(data: String): Option<Int32>
```

Function: Converts a string literal of type [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) into an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)> value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)> value. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>.None if conversion fails.

### extend Int64 <: Parsable\<Int64>

```cangjie
extend Int64 <: Parsable<Int64>
```

Function: This extension primarily implements operations to convert string literals of type [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) into [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) values.

Parent Type:

- [Parsable](#interface-parsablet)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>

#### static func parse(String)

```cangjie
public static func parse(data: String): Int64
```

Function: Converts a string literal of type [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) into an [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the converted [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string is empty, starts with `+`, conversion fails, the converted value exceeds the [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) range, or the string contains invalid UTF-8 characters.

#### static func tryParse(String)

```cangjie
public static func tryParse(data: String): Option<Int64>
```

Function: Converts a string literal of type [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) into an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> value. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>.None if conversion fails.

### extend Int8 <: Parsable\<Int8>

```cangjie
extend Int8 <: Parsable<Int8>
```

Function: This extension primarily implements operations to convert string literals of type [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) into [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) values.

Parent Type:

- [Parsable](#interface-parsablet)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

#### static func parse(String)

```cangjie
public static func parse(data: String): Int8
```

Function: Converts a string literal of type [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) into an [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Returns the converted [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string is empty, starts with `+`, conversion fails, the converted value exceeds the [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) range, or the string contains invalid UTF-8 characters.

#### static func tryParse(String)

```cangjie
public static func tryParse(data: String): Option<Int8>
```

Function: Converts a string literal of type [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) into an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)> value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)> value. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>.None if conversion fails.

### extend Rune <: Parsable\<Rune>

```cangjie
extend Rune <: Parsable<Rune>
```

Function: This extension primarily implements operations to convert string literals of type [Rune](../../core/core_package_api/core_package_intrinsics.md#rune) into [Rune](../../core/core_package_api/core_package_intrinsics.md#rune) values.

Parent Type:

- [Parsable](#interface-parsablet)\<[Rune](../../core/core_package_api/core_package_intrinsics.md#rune)>

#### static func parse(String)

```cangjie
public static func parse(data: String): Rune
```

Function: Converts a string literal of type [Rune](../../core/core_package_api/core_package_intrinsics.md#rune) into a [Rune](../../core/core_package_api/core_package_intrinsics.md#rune) value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return Value:

- [Rune](../../core/core_package_api/core_package_intrinsics.md#rune) - Returns the converted [Rune](../../core/core_package_api/core_package_intrinsics.md#rune) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string is empty, conversion fails, or the string contains invalid UTF-8 characters.

#### static func tryParse(String)

```cangjie
public static func tryParse(data: String): Option<Rune>
```

Function: Converts a string literal of type [Rune](../../core/core_package_api/core_package_intrinsics.md#rune) into an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Rune](../../core/core_package_api/core_package_intrinsics.md#rune)> value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Rune](../../core/core_package_api/core_package_intrinsics.md#rune)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Rune](../../core/core_package_api/core_package_intrinsics.md#rune)> value. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Rune](../../core/core_package_api/core_package_intrinsics.md#rune)>.None if conversion fails.

### extend UInt16 <: Parsable\<UInt16>

```cangjie
extend UInt16 <: Parsable<UInt16>
```

Functionality: This extension primarily implements operations for converting string literals of [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type to [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) values.

Parent type:

- [Parsable](#interface-parsablet)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

#### static func parse(String)

```cangjie
public static func parse(data: String): UInt16
```

Functionality: Converts a string literal of [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type to a [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Returns the converted [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string is empty, starts with `+` or `-`, conversion fails, the converted value exceeds [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) range, or the string contains invalid UTF-8 characters.

#### static func tryParse(String)

```cangjie
public static func tryParse(data: String): Option<UInt16>
```

Functionality: Converts a string literal of [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type to an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)> value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)> value. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>.None if conversion fails.

### extend UInt32 <: Parsable\<UInt32>

```cangjie
extend UInt32 <: Parsable<UInt32>
```

Functionality: This extension primarily implements operations for converting string literals of [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type to [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) values.

Parent type:

- [Parsable](#interface-parsablet)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

#### static func parse(String)

```cangjie
public static func parse(data: String): UInt32
```

Functionality: Converts a string literal of [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type to a [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Returns the converted [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string is empty, starts with `+` or `-`, conversion fails, the converted value exceeds [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) range, or the string contains invalid UTF-8 characters.

#### static func tryParse(String)

```cangjie
public static func tryParse(data: String): Option<UInt32>
```

Functionality: Converts a string literal of [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type to an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)> value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)> value. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>.None if conversion fails.

### extend UInt64 <: Parsable\<UInt64>

```cangjie
extend UInt64 <: Parsable<UInt64>
```

Functionality: This extension primarily implements operations for converting string literals of [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) type to [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) values.

Parent type:

- [Parsable](#interface-parsablet)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>

#### static func parse(String)

```cangjie
public static func parse(data: String): UInt64
```

Functionality: Converts a string literal of [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) type to a [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Returns the converted [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string is empty, starts with `+` or `-`, conversion fails, the converted value exceeds [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) range, or the string contains invalid UTF-8 characters.

#### static func tryParse(String)

```cangjie
public static func tryParse(data: String): Option<UInt64>
```

Functionality: Converts a string literal of [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) type to an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)> value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)> value. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>.None if conversion fails.

### extend UInt8 <: Parsable\<UInt8>

```cangjie
extend UInt8 <: Parsable<UInt8>
```

Functionality: This extension primarily implements operations for converting string literals of type [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) into [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) values.

Parent Type:

- [Parsable](#interface-parsablet)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

#### static func parse(String)

```cangjie
public static func parse(data: String): UInt8
```

Functionality: Converts a string literal of type [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) into a [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Returns the converted [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string is empty, starts with `+` or `-`, conversion fails, the converted value exceeds the [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) range, or the string contains invalid UTF-8 characters.

#### static func tryParse(String)

```cangjie
public static func tryParse(data: String): Option<UInt8>
```

Functionality: Converts a string literal of type [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) into an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> value.

Parameters:

- data: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> value. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>.None if conversion fails.

## interface RadixConvertible\<T>

```cangjie
public interface RadixConvertible<T> {
    
    static func parse(value: String, radix!: Int64): T

    static func tryParse(value: String, radix!: Int64): Option<T>

    func toString(radix!: Int64): String
}
```

Functionality: This interface provides unified methods to support parsing strings of specified radixes into specific types.

The radix is specified via parameters, not via string prefixes. The radix must be within the range of 2-36; otherwise, an exception will be thrown. For radixes exceeding decimal, representations follow the alphabetical order (uppercase or lowercase), i.e., 10 digits + 26 English letters = 36 radix. Strings for Int series can start with `+` or `-`; if neither is present, they are treated as `+`. Strings for UInt series can start with `+`; if they start with `-`, an exception will be thrown. The returned string is in the specified radix format, with representations exceeding decimal using lowercase English letters (i.e., 10 digits + 26 lowercase English letters = 36 radix).

This interface provides two sets of methods: `parse` and `tryParse`. The `parse` method throws an exception upon parsing failure, while the `tryParse` method wraps the return value in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont), returning None if parsing fails.
This package already implements this interface for basic types such as [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) and [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64), enabling string conversion to these types.

### static func parse(String, Int64)

```cangjie
static func parse(value: String, radix!: Int64): T
```

Functionality: Parses a specific type from a string of specified radix.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be parsed.
- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- T - The converted value.

### static func tryParse(String, Int64)

```cangjie
static func tryParse(value: String, radix!: Int64): Option<T>
```

Functionality: Parses a specific type from a string of specified radix.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be parsed.
- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - The converted value. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>.None if conversion fails.

### func toString(Int64)

```cangjie
func toString(radix!: Int64): String
```

Functionality: Returns a string in the specified radix format.

Parameters:

- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string in the specified radix format.

### extend Int8 <: RadixConvertible\<Int8>

```cangjie
extend Int8 <: RadixConvertible<Int8>
```

Functionality: This extension primarily implements operations for converting string literals of type [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) into [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) values.

Parent Type:

- [RadixConvertible](#interface-radixconvertiblet)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

#### static func parse(String, Int64)

```cangjie
public static func parse(value: String, radix!: Int64): Int8
```

Functionality: Converts a string literal of type [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) into an [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) value.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.
- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Returns the converted [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string is empty, the radix is out of range, the converted value exceeds the [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) range, the string contains invalid UTF-8 characters, or conversion fails.

#### static func tryParse(String, Int64)

```cangjie
public static func tryParse(value: String, radix!: Int64): Option<Int8>
```

Function: Converts a string literal of type [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) to an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)> value.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.
- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)> value. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>.None if conversion fails.

#### func toString(Int64)

```cangjie
public func toString(radix!: Int64): String
```

Function: Returns a string representation in the specified radix.

Parameters:

- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation in the specified radix.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the radix is invalid.

### extend Int16 <: RadixConvertible\<Int16>

```cangjie
extend Int16 <: RadixConvertible<Int16>
```

Function: This extension primarily implements operations for converting string literals of type [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) to [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) values.

Parent Type:

- [RadixConvertible](#interface-radixconvertiblet)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

#### static func parse(String, Int64)

```cangjie
public static func parse(value: String, radix!: Int64): Int16
```

Function: Converts a string literal of type [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) to an [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) value.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.
- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Returns the converted [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string is empty, the radix is out of range, the converted value exceeds the [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) range, the string contains invalid UTF-8 characters, or the conversion fails.

#### static func tryParse(String, Int64)

```cangjie
public static func tryParse(value: String, radix!: Int64): Option<Int16>
```

Function: Converts a string literal of type [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) to an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)> value.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.
- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)> value. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>.None if conversion fails.

#### func toString(Int64)

```cangjie
public func toString(radix!: Int64): String
```

Function: Returns a string representation in the specified radix.

Parameters:

- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation in the specified radix.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the radix is invalid.

### extend Int32 <: RadixConvertible\<Int32>

```cangjie
extend Int32 <: RadixConvertible<Int32>
```

Function: This extension primarily implements operations for converting string literals of type [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) to [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) values.

Parent Type:

- [RadixConvertible](#interface-radixconvertiblet)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

#### static func parse(String, Int64)

```cangjie
public static func parse(value: String, radix!: Int64): Int32
```

Function: Converts a string literal of type [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) to an [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) value.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.
- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns the converted [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string is empty, the radix is out of range, the converted value exceeds the [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) range, the string contains invalid UTF-8 characters, or the conversion fails.

#### static func tryParse(String, Int64)

```cangjie
public static func tryParse(value: String, radix!: Int64): Option<Int32>
```

Function: Converts a string literal of type [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) to an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)> value.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.

- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)> value. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>.None if conversion fails.

#### func toString(Int64)

```cangjie
public func toString(radix!: Int64): String
```

Function: Returns a string representation in the specified radix.

Parameters:

- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation in the specified radix.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the radix is invalid.

### extend Int64 <: RadixConvertible\<Int64>

```cangjie
extend Int64 <: RadixConvertible<Int64>
```

Function: This extension primarily implements operations for converting string literals of [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type to [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) values.

Parent Type:

- [RadixConvertible](#interface-radixconvertiblet)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>

#### static func parse(String, Int64)

```cangjie
public static func parse(value: String, radix!: Int64): Int64
```

Function: Converts a string literal of [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type to an [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) value.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.
- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the converted [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string is empty, the radix is out of range, the converted value exceeds [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) range, the string contains invalid UTF-8 characters, or the conversion fails.

#### static func tryParse(String, Int64)

```cangjie
public static func tryParse(value: String, radix!: Int64): Option<Int64>
```

Function: Converts a string literal of [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type to an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> value.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.
- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> value. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>.None if conversion fails.

#### func toString(Int64)

```cangjie
public func toString(radix!: Int64): String
```

Function: Returns a string representation in the specified radix.

Parameters:

- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation in the specified radix.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the radix is invalid.

### extend UInt8 <: RadixConvertible\<UInt8>

```cangjie
extend UInt8 <: RadixConvertible<UInt8>
```

Function: This extension primarily implements operations for converting string literals of [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) type to [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) values.

Parent Type:

- [RadixConvertible](#interface-radixconvertiblet)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

#### static func parse(String, Int64)

```cangjie
public static func parse(value: String, radix!: Int64): UInt8
```

Function: Converts a string literal of [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) type to a [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) value.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.
- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Returns the converted [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string is empty, the radix is out of range, the first character is `-`, the converted value exceeds [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) range, or the string contains invalid UTF-8 characters.

#### static func tryParse(String, Int64)

```cangjie
public static func tryParse(value: String, radix!: Int64): Option<UInt8>
```

Function: Converts a string literal of [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) type to an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> value.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.
- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> value. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>.None if conversion fails.

#### func toString(Int64)

```cangjie
public func toString(radix!: Int64): String
```

Function: Returns a string representation in the specified radix.

Parameters:

- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - String representation in the specified radix.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the radix is invalid.

### extend UInt16 <: RadixConvertible\<UInt16>

```cangjie
extend UInt16 <: RadixConvertible<UInt16>
```

Function: This extension primarily implements operations for converting string literals of [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type to [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) values.

Parent Type:

- [RadixConvertible](#interface-radixconvertiblet)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

#### static func parse(String, Int64)

```cangjie
public static func parse(value: String, radix!: Int64): UInt16
```

Function: Converts a string literal of [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type to a [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) value.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.
- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Returns the converted [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string is empty, radix is out of range, first character is `-`, converted value exceeds [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) range, or the string contains invalid UTF-8 characters.

#### static func tryParse(String, Int64)

```cangjie
public static func tryParse(value: String, radix!: Int64): Option<UInt16>
```

Function: Converts a string literal of [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type to an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)> value.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.
- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)> value. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>.None if conversion fails.

#### func toString(Int64)

```cangjie
public func toString(radix!: Int64): String
```

Function: Returns a string representation in the specified radix.

Parameters:

- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - String representation in the specified radix.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the radix is invalid.

### extend UInt32 <: RadixConvertible\<UInt32>

```cangjie
extend UInt32 <: RadixConvertible<UInt32>
```

Function: This extension primarily implements operations for converting string literals of [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type to [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) values.

Parent Type:

- [RadixConvertible](#interface-radixconvertiblet)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

#### static func parse(String, Int64)

```cangjie
public static func parse(value: String, radix!: Int64): UInt32
```

Function: Converts a string literal of [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type to a [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) value.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.
- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Returns the converted [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string is empty, radix is out of range, first character is `-`, converted value exceeds [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) range, or the string contains invalid UTF-8 characters.

#### static func tryParse(String, Int64)

```cangjie
public static func tryParse(value: String, radix!: Int64): Option<UInt32>
```

Function: Converts a string literal of [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type to an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)> value.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.
- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)> value. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>.None if conversion fails.

#### func toString(Int64)

```cangjie
public func toString(radix!: Int64): String
```

Function: Returns a string representation in the specified radix.

Parameters:

- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - String representation in the specified radix.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the radix is invalid.Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation in the specified radix.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the radix is invalid.

### extend UInt64 <: RadixConvertible\<UInt64>

```cangjie
extend UInt64 <: RadixConvertible<UInt64>
```

Functionality: This extension primarily implements operations for converting string literals of type [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) to [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) values.

Parent Type:

- [RadixConvertible](#interface-radixconvertiblet)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>

#### static func parse(String, Int64)

```cangjie
public static func parse(value: String, radix!: Int64): UInt64
```

Functionality: Converts a string literal of type [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) to a [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) value.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.
- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The converted [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the string is empty, the radix is out of range, the first character is `-`, the converted value exceeds the [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) range, or the string contains invalid UTF-8 characters.

#### static func tryParse(String, Int64)

```cangjie
public static func tryParse(value: String, radix!: Int64): Option<UInt64>
```

Functionality: Converts a string literal of type [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) to an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)> value.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be converted.
- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)> - Returns the converted [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)> value. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>.None if conversion fails.

#### func toString(Int64)

```cangjie
public func toString(radix!: Int64): String
```

Functionality: Returns the string representation in the specified radix.

Parameters:

- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified radix.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation in the specified radix.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the radix is invalid.
