# Decimal Basic Properties Example

The following demonstrates initializing a `Decimal` object and querying its basic properties:
<!-- verify -->

```cangjie
import std.math.*
import std.math.numeric.*

main() {
    let decimalProperties = Decimal.parse("-123456.7890123456789")
    println("decimal: ${decimalProperties}")
    println("decimal sign: ${decimalProperties.sign}")
    println("decimal scale: ${decimalProperties.scale}")
    println("decimal value: ${decimalProperties.value}")
    println("decimal precision: ${decimalProperties.precision}")

    // To initialize a Decimal object with specified precision and rounding mode, use the following approach
    let decimalProperties2 = Decimal.parse("-123456.7890123456789").roundWithPrecision(10, roundingMode: HalfEven)
    println("decimal2: ${decimalProperties2}")
    println("decimal2 sign: ${decimalProperties2.sign}")
    println("decimal2 scale: ${decimalProperties2.scale}")
    println("decimal2 value: ${decimalProperties2.value}")
    println("decimal2 precision: ${decimalProperties2.precision}")

    return 0
}
```

Execution results:

```text
decimal: -123456.7890123456789
decimal sign: -1
decimal scale: 13
decimal value: -1234567890123456789
decimal precision: 19
decimal2: -123456.7890
decimal2 sign: -1
decimal2 scale: 4
decimal2 value: -1234567890
decimal2 precision: 10
```