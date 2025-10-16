# Enumeration

## enum OverflowStrategy

```cangjie
public enum OverflowStrategy <: Equatable<OverflowStrategy> & ToString {
    | Saturating
    | Throwing
    | Wrapping
}
```

Function: An enumeration class for overflow strategies, containing 3 overflow strategies. When converting [BigInt](math_numeric_package_structs.md#struct-bigint) type or [Decimal](math_numeric_package_structs.md#struct-decimal) type to integer types, different overflow handling strategies can be specified.

Parent Types:

- [Equatable](../../../std_en/core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[OverflowStrategy](#enum-overflowstrategy)>
- [ToString](../../../std_en/core/core_package_api/core_package_interfaces.md#interface-tostring)

### Saturating

```cangjie
Saturating
```

Function: When overflow occurs, if the current value is greater than the MAX value of the target type, returns the MAX value of the target type; if the current value is less than the MIN value of the target type, returns the MIN value of the target type.

### Throwing

```cangjie
Throwing
```

Function: When overflow occurs, throws an exception.

### Wrapping

```cangjie
Wrapping
```

Function: When overflow occurs, truncates the high-order bits.

### func toString()

```cangjie
public func toString(): String
```

Function: Generates a string representation of the overflow strategy name.

Return Value:

- [String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string) - The string representation of the overflow strategy name.

### operator func ==(OverflowStrategy)

```cangjie
public operator func ==(that: OverflowStrategy): Bool
```

Function: Equality comparison.

Parameters:

- that: [OverflowStrategy](#enum-overflowstrategy) - The overflow strategy to be compared.

Return Value:

- [Bool](../../../std_en/core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the overflow strategies are identical; otherwise, returns false.