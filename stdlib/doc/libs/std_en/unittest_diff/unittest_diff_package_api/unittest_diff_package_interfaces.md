# Interface

## interface AssertPrintable

```cangjie
public interface AssertPrintable<T> {
    prop hasNestedDiff: Bool
    func pprintForAssertion(
        pp: PrettyPrinter, that: T, thisPrefix: String, thatPrefix: String, level: Int64
    ): PrettyPrinter
}
```

Function: Provides methods for printing the check results of [@Assert](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#assert-宏)/[@Expect](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#expect-宏).

### prop hasNestedDiff

```cangjie
prop hasNestedDiff: Bool
```

Function: Gets whether there are nested diff levels.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

### func pprintForAssertion(PrettyPrinter, T, String, String, Int64)

```cangjie
func pprintForAssertion(
    pp: PrettyPrinter, that: T, thisPrefix: String, thatPrefix: String, level: Int64
): PrettyPrinter
```

Function: Method for printing the check results of [@Assert](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#assert-宏)/[@Expect](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#expect-宏).

Parameters:

- pp: [PrettyPrinter](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-prettyprinter) - Printer.
- that: T - Information to be printed.
- thisPrefix: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Prefix for expected content.
- thatPrefix: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Prefix for actual content.
- level: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Nesting level.

Return value:

- PrettyPrinter - Printer.

### extend Float16 <: AssertPrintable\<Float16>

```cangjie
extend Float16 <: AssertPrintable<Float16>
```

Function: Extension for [Float16](../../core/core_package_api/core_package_intrinsics.md#float16).

#### prop hasNestedDiff

```cangjie
public prop hasNestedDiff: Bool
```

Function: Gets whether there are nested diff levels.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

#### func pprintForAssertion(PrettyPrinter, Float16, String, String, Int64)

```cangjie
public func pprintForAssertion(
    pp: PrettyPrinter, that: Float16, thisPrefix: String, thatPrefix: String, level: Int64
): PrettyPrinter
```

Function: Method for printing the check results of [@Assert](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#assert-宏)/[@Expect](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#expect-宏).

Parameters:

- pp: [PrettyPrinter](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-prettyprinter) - Printer.
- that: [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - Information to be printed.
- thisPrefix: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Prefix for expected content.
- thatPrefix: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Prefix for actual content.
- level: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Nesting level.

Return value:

- PrettyPrinter - Printer.

### extend Float32 <: AssertPrintable\<Float32>

```cangjie
extend Float32  <: AssertPrintable<Float32>
```

Function: Extension for [Float32](../../core/core_package_api/core_package_intrinsics.md#float32).

#### prop hasNestedDiff

```cangjie
public prop hasNestedDiff: Bool
```

Function: Gets whether there are nested diff levels.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

#### func pprintForAssertion(PrettyPrinter, Float32, String, String, Int64)

```cangjie
public func pprintForAssertion(
    pp: PrettyPriner, that: Float32, thisPrefix: String, thatPrefix: String, level: Int64
): PrettyPrinter
```

Function: Method for printing the check results of [@Assert](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#assert-宏)/[@Expect](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#expect-宏).

Parameters:

- pp: [PrettyPrinter](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-prettyprinter) - Printer.
- that: [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - Information to be printed.
- thisPrefix: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Prefix for expected content.
- thatPrefix: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Prefix for actual content.
- level: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Nesting level.

Return value:

- PrettyPrinter - Printer.

### extend Float64 <: AssertPrintable\<Float64>

```cangjie
extend Float64 <: AssertPrintable<Float64>
```

Function: Extension for [Float64](../../core/core_package_api/core_package_intrinsics.md#float64).

#### prop hasNestedDiff

```cangjie
public prop hasNestedDiff: Bool
```

Function: Gets whether there are nested diff levels.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

#### func pprintForAssertion(PrettyPrinter, Float64, String, String, Int64)

```cangjie
public func pprintForAssertion(
    pp: PrettyPrinter, that: Float64, thisPrefix: String, thatPrefix: String, level: Int64
): PrettyPrinter
```

Function: Method for printing the check results of [@Assert](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#assert-宏)/[@Expect](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#expect-宏).

Parameters:

- pp: [PrettyPrinter](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-prettyprinter) - Printer.
- that: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - Information to be printed.
- thisPrefix: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Prefix for expected content.
- thatPrefix: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Prefix for actual content.
- level: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Nesting level.

Return value:

- PrettyPrinter - Printer.

### extend\<T> Option\<T> <: AssertPrintable\<Option\<T>> where T <: Equatable\<T>

```cangjie
extend<T> Option<T> <: AssertPrintable<Option<T>> where T <: Equatable<T> 
```

Function: Extension for [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>.

#### prop hasNestedDiff

```cangjie
public prop hasNestedDiff: Bool
```

Function: Gets whether there are nested diff levels.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

#### func pprintForAssertion(PrettyPrinter,  Option\<T>, String, String, Int64)

```cangjie
public func pprintForAssertion(
    pp: PrettyPrinter, that:  Option<T>, thisPrefix: String, thatPrefix: String, level: Int64
): PrettyPrinter
```

Function: Method for printing the check results of [@Assert](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#assert-宏)/[@Expect](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#expect-宏).

Parameters:

- pp: [PrettyPrinter](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-prettyprinter) - Printer.
- that:  [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Information to be printed.
- thisPrefix: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Prefix for expected content.
- thatPrefix: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Prefix for actual content.
- level: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Nesting level.

Return value:

- PrettyPrinter - Printer.

### extend String <: AssertPrintable\<String>

```cangjie
extend String <: AssertPrintable<String>
```

Function: Extension for [String](../../core/core_package_api/core_package_structs.md#struct-string).

#### prop hasNestedDiff

```cangjie
public prop hasNestedDiff: Bool
```

Function: Gets whether there are nested diff levels.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

#### func pprintForAssertion(PrettyPrinter, String, String, String, Int64)

```cangjie
public func pprintForAssertion(
    pp: PrettyPrinter, that: String, thisPrefix: String, thatPrefix: String, level: Int64
): PrettyPrinter
```

Function: Method for printing the check results of [@Assert](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#assert-宏)/[@Expect](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#expect-宏).

Parameters:

- pp: [PrettyPrinter](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-prettyprinter) - Printer.
- that: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Information to be printed.
- thisPrefix: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Prefix for expected content.
- thatPrefix: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Prefix for actual content.
- level: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Nesting level.

Return value:

- PrettyPrinter - Printer.