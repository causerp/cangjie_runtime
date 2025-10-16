# Decimal Comparison Example

The following demonstrates size comparisons between multiple initialized `Decimal` objects:
<!-- verify -->

```cangjie
import std.math.*
import std.math.numeric.*

main() {
    let decimal1 = Decimal.parse("12345.6789")
    let decimal2 = Decimal.parse("987.654321")
    println("${decimal1} > ${decimal2} = ${decimal1 > decimal2}")
    println("${decimal1} < ${decimal2} = ${decimal1 < decimal2}")
    println("${decimal1} == ${decimal2} = ${decimal1 == decimal2}")
    println("${decimal1} != ${decimal2} = ${decimal1 != decimal2}")
    println("${decimal1} <= ${decimal2} = ${decimal1 <= decimal2}")
    println("${decimal1} >= ${decimal2} = ${decimal1 >= decimal2}")
    println("${decimal1}.compare(${decimal2}) = ${decimal1.compare(decimal2)}")
    return 0
}
```

Execution results:

```text
12345.6789 > 987.654321 = true
12345.6789 < 987.654321 = false
12345.6789 == 987.654321 = false
12345.6789 != 987.654321 = true
12345.6789 <= 987.654321 = false
12345.6789 >= 987.654321 = true
12345.6789.compare(987.654321) = Ordering.GT
```