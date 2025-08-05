# Enumeration

## enum RoundingMode

```cangjie
public enum RoundingMode <: Equatable<RoundingMode> & ToString {
    | Ceiling
    | Down
    | Floor
    | HalfEven
    | HalfUp
    | Up
}
```

Function: An enumeration class for rounding modes, containing 6 rounding rules. In addition to the 5 rounding rules specified by IEEE 754 floating-point standard, it includes the commonly used "round half up" rule.

|Decimal|Up|Down|Ceiling|Floor|HalfUp|HalfEven|
|:----|:----:|:----:|:----:|:----:|:----:|:----:|
|7.5|8|7|8|7|8|8|
|4.5|5|4|5|4|5|4|
|-1.1|-2|-1|-1|-2|-1|-1|
|-4.5|-5|-4|-4|-5|-5|-4|
|-7.5|-8|-7|-7|-8|-8|-8|

Parent Types:

- [Equatable](../../../std_en/core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[RoundingMode](#enum-roundingmode)>
- [ToString](../../../std_en/core/core_package_api/core_package_interfaces.md#interface-tostring)

### Ceiling

```cangjie
Ceiling
```

Function: Round towards positive infinity.

### Down

```cangjie
Down
```

Function: Round towards zero.

### Floor

```cangjie
Floor
```

Function: Round towards negative infinity.

### HalfEven

```cangjie
HalfEven
```

Function: Round half to even (also known as "banker's rounding").

### HalfUp

```cangjie
HalfUp
```

Function: Round half up (common "rounding" method).

### Up

```cangjie
Up
```

Function: Round away from zero.

### func toString()

```cangjie
public func toString(): String
```

Function: Generate a string representation of the rounding mode.

Return Value:

- [String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string) - The name string of the rounding mode.

### operator func ==(RoundingMode)

```cangjie
public operator func ==(that: RoundingMode): Bool
```

Function: Equality comparison.

Parameters:

- that: [RoundingMode](#enum-roundingmode) - The rounding mode to compare with.

Return Value:

- [Bool](../../../std_en/core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the rounding modes are identical, otherwise returns false.