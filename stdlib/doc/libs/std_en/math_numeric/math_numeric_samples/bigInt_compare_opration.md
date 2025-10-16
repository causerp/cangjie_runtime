# BigInt Comparison Examples

The following demonstrates size comparisons between multiple initialized `BigInt` objects:
<!-- verify -->

```cangjie
import std.math.numeric.*

main() {
    let int1 = BigInt.parse("123456789")
    let int2 = BigInt.parse("987654321")
    println("${int1} > ${int2} = ${int1 > int2}")
    println("${int1} < ${int2} = ${int1 < int2}")
    println("${int1} == ${int2} = ${int1 == int2}")
    println("${int1} != ${int2} = ${int1 != int2}")
    println("${int1} <= ${int2} = ${int1 <= int2}")
    println("${int1} >= ${int2} = ${int1 >= int2}")
    println("${int1}.compare(${int2}) = ${int1.compare(int2)}")
    return 0
}
```

Execution results:

```text
123456789 > 987654321 = false
123456789 < 987654321 = true
123456789 == 987654321 = false
123456789 != 987654321 = true
123456789 <= 987654321 = true
123456789 >= 987654321 = false
123456789.compare(987654321) = Ordering.LT
```