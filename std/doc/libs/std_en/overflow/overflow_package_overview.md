# std.overflow

## Functionality

The overflow package provides handling capabilities for integer arithmetic overflow.

In integer arithmetic, overflow occurs when the result of an operation exceeds the maximum value or falls below the minimum value of its type. By default, an exception is thrown when overflow occurs.

The overflow package offers four overflow handling strategies and defines corresponding interfaces, as listed below:

| Strategy               | Interface                          | Description                                           |
| ---------------------- | --------------------------------- | ---------------------------------------------------- |
| Return Option         | [CheckedOp](./overflow_package_api/overflow_package_interfaces.md#interface-checkedopt)    | Returns `None` when integer arithmetic overflow occurs. |
| Saturation            | [SaturatingOp](./overflow_package_api/overflow_package_interfaces.md#interface-saturatingopt) | Returns MAX value when result exceeds target type's MAX; returns MIN value when result is below target type's MIN. |
| Throw Exception       | [ThrowingOp](./overflow_package_api/overflow_package_interfaces.md#interface-throwingopt)   | Throws an exception when integer arithmetic overflow occurs. |
| Wrapping              | [WrappingOp](./overflow_package_api/overflow_package_interfaces.md#interface-wrappingopt)   | Truncates higher bits beyond target type's bit width when overflow occurs. |

The overflow package provides implementations of these interfaces for all integer types through extensions. Users can implement overflow interfaces for other types in the same manner.

## API List

### Interfaces

| Interface Name | Functionality |
| -------------- | ------------- |
| [CarryingOp](./overflow_package_api/overflow_package_interfaces.md#interface-carryingopt) | Provides interface for returning whether truncation occurred in integer operations along with the result. |
| [CarryingPow](./overflow_package_api/overflow_package_interfaces.md#interface-carryingpow) | Provides power operation interface using [wrapping](./overflow_package_api//overflow_package_interfaces.md#interface-wrappingopt) strategy. |
| [CheckedOp](./overflow_package_api/overflow_package_interfaces.md#interface-checkedopt) | Returns `None` when integer arithmetic overflow occurs. |
| [CheckedPow](./overflow_package_api/overflow_package_interfaces.md#interface-checkedpow) | Provides power operation interface returning [Option](../core/core_package_api/core_package_enums.md#enum-optiont) strategy. |
| [SaturatingOp](./overflow_package_api/overflow_package_interfaces.md#interface-saturatingopt) | Performs saturation when integer arithmetic overflow occurs. |
| [SaturatingPow](./overflow_package_api/overflow_package_interfaces.md#interface-saturatingpow) | Provides power operation interface with saturation strategy. |
| [ThrowingOp](./overflow_package_api/overflow_package_interfaces.md#interface-throwingopt) | Throws an exception when integer arithmetic overflow occurs. |
| [ThrowingPow](./overflow_package_api/overflow_package_interfaces.md#interface-throwingpow) | Provides power operation interface using exception-throwing strategy. |
| [WrappingOp](./overflow_package_api/overflow_package_interfaces.md#interface-wrappingopt) | Truncates higher bits beyond target type's bit width when overflow occurs. |
| [WrappingPow](./overflow_package_api/overflow_package_interfaces.md#interface-wrappingpow) | Provides power operation interface using wrapping strategy. |

### Exception Classes

| Class Name | Functionality |
| --------- | ------------ |
| [OvershiftException](./overflow_package_api/overflow_package_exceptions.md#class-overshiftexception) | Exception thrown when shift count exceeds operand bit width in shift operations. |
| [UndershiftException](./overflow_package_api/overflow_package_exceptions.md#class-undershiftexception) | Exception thrown when shift count is less than 0 in shift operations. |