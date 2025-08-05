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

Function: Provides methods for printing the check results of [@Assert](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#assert-macro)/[@Expect](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#expect-macro).

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

Function: Prints the check results of [@Assert](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#assert-macro)/[@Expect](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#expect-macro).

Parameters:

- pp: [PrettyPrinter](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-prettyprinter) - The printer.
- that: T - The information to be printed.
- thisPrefix: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Prefix for expected content.
- thatPrefix: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Prefix for actual content.
- level: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Nesting level.

Return Value:

- PrettyPrinter - The printer.