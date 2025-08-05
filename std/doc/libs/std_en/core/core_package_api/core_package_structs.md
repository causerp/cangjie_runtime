# Struct

## struct Array\<T>

```cangjie
public struct Array<T> {
    public const init()
    public init(size: Int64, repeat!: T)
    public init(size: Int64, initElement: (Int64) -> T)
}
```

Function: The Cangjie array type, used to represent an ordered sequence of elements of a single type.

T represents the element type of the array, which can be any type.

### prop first

```cangjie
public prop first: Option<T>
```

Function: Gets the first element of the current array. Returns None if the array is empty.

Type: [Option](core_package_enums.md#enum-optiont)\<T>

### prop last

```cangjie
public prop last: Option<T>
```

Function: Gets the last element of the current array. Returns None if the array is empty.

Type: [Option](core_package_enums.md#enum-optiont)\<T>

### init()

```cangjie
public const init()
```

Function: Constructs an empty array.

### init(Int64, (Int64) -> T)

```cangjie
public init(size: Int64, initElement: (Int64) -> T)
```

Function: Creates an array of specified length, where elements are obtained by computing through the initialization function.

Specifically: Passes values in the range [0, size) to the initialization function initElement in sequence, and executes to obtain the element at the corresponding index of the array.

Parameters:

- size: [Int64](core_package_intrinsics.md#int64) - Array size.
- initElement: ([Int64](core_package_intrinsics.md#int64)) ->T - Initialization function.

Exceptions:

- [NegativeArraySizeException](core_package_exceptions.md#class-negativearraysizeexception) - Throws an exception when size is less than 0.

### init(Int64, T)

```cangjie
public init(size: Int64, repeat!: T)
```

Function: Constructs an array of specified length, where all elements are initialized with the specified initial value.

> **Note:**
>
> This constructor does not copy `repeat`. If `repeat` is a reference type, every element of the constructed array will point to the same reference.

Parameters:

- size: [Int64](core_package_intrinsics.md#int64) - Array size, with valid range [0, [Int64](core_package_intrinsics.md#int64).Max].
- repeat!: T - Initial value for array elements.

Exceptions:

- [NegativeArraySizeException](core_package_exceptions.md#class-negativearraysizeexception) - Throws an exception when size is less than 0.

### func clone()

```cangjie
public func clone(): Array<T>
```

Function: Clones the array, performing a deep copy of the array data.

Return value:

- [Array](core_package_structs.md#struct-arrayt)\<T> - The newly cloned array.

### func clone(Range\<Int64>)

```cangjie
public func clone(range: Range<Int64>) : Array<T>
```

Function: Clones a specified range of the array.

> **Note:**
>
> 1. If the parameter `range` is a [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) instance constructed using the [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) constructor, the behavior is as follows:
>    - The value of `start` is exactly the value passed to the constructor, unaffected by the `hasStart` parameter during construction.
>    - When `hasEnd` is false, the `end` value is ineffective and unaffected by the `isClosed` parameter during construction. The array slice will include elements up to the last element of the original array.
> 2. The step size of `range` can only be 1.

Parameters:

- range: [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<[Int64](core_package_intrinsics.md#int64)> - The range to clone.

Return value:

- [Array](core_package_structs.md#struct-arrayt)\<T> - The newly cloned array.

Exceptions:

- [IndexOutOfBoundsException](core_package_exceptions.md#class-indexoutofboundsexception) - Throws an exception when `range` exceeds the array bounds.

Example:

<!-- verify -->
```cangjie
main() {
    let arr = [0, 1, 2, 3, 4, 5]
    let new = arr.clone(1..4)
    println(new)
}
```

Execution result:

```text
[1, 2, 3]
```

### func concat(Array\<T>)

```cangjie
public func concat(other: Array<T>): Array<T>
```

Function: Creates a new array by concatenating the current array with the array pointed to by `other`.

Parameters:

- other: [Array](core_package_structs.md#struct-arrayt)\<T> - The array to concatenate to the end of the current array.

Return value:

- [Array](core_package_structs.md#struct-arrayt)\<T> - The newly concatenated array.

Example:

<!-- verify -->
```cangjie
main() {
    let arr = [0, 1, 2, 3, 4, 5]
    let new = arr.concat([6, 7, 8, 9, 10])
    println(new)
}
```

Execution result:

```text
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```

### func copyTo(Array\<T>)

```cangjie
public func copyTo(dst: Array<T>): Unit
```

Function: Copies all elements of the current array to the destination array `dst`.

The copy length equals the length of the current array, starting from the beginning of the destination array. The current array's length must not exceed that of the destination array.

Parameters:

- dst: [Array](core_package_structs.md#struct-arrayt)\<T> - The destination array.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the current array's length exceeds that of the destination array.

### func copyTo(Array\<T>, Int64, Int64, Int64)

```cangjie
public func copyTo(dst: Array<T>, srcStart: Int64, dstStart: Int64, copyLen: Int64): Unit
```

Function: Copies a segment of data from the current array to the destination array.

Parameters:

- dst: [Array](core_package_structs.md#struct-arrayt)\<T> - The destination array.
- srcStart: [Int64](core_package_intrinsics.md#int64) - The starting index in the current array for copying, with valid range [0, this.size).
- dstStart: [Int64](core_package_intrinsics.md#int64) - The starting index in the destination array for writing, with valid range [0, dst.size).
- copyLen: [Int64](core_package_intrinsics.md#int64) - The length of data to copy. Requirements: copyLen + srcStart < this.size, copyLen + dstStart < dst.size.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when copyLen is less than 0.
- [IndexOutOfBoundsException](core_package_exceptions.md#class-indexoutofboundsexception) - Throws an exception when parameters do not meet the specified ranges.

Example:

<!-- verify -->
```cangjie
main() {
    let arr = [0, 1, 2, 3, 4, 5]
    let new = [0, 0, 0, 0, 0, 0]
    arr.copyTo(new, 2, 2, 4)
    println(new)
}
```

Execution result:

```text
[0, 0, 2, 3, 4, 5]
```

### func fill(T)

```cangjie
public func fill(value: T): Unit
```

Function: Replaces all elements in the current array with the specified `value`.

Parameters:

- value: T - The target value for replacement.

Example:

<!-- verify -->
```cangjie
main() {
    let arr = [0, 1, 2]
    arr[1..3].fill(-1)
    println(arr)
}
```

Execution result:

```text
[0, -1, -1]
```

### func get(Int64)

```cangjie
public func get(index: Int64): Option<T>
```

Function: Gets the element at the specified `index` in the array.

The result is wrapped in [Option](core_package_enums.md#enum-optiont). Returns None if `index` is out of bounds.

Alternatively, the [] operator can be used to access elements, which throws an exception when `index` is out of bounds.

Parameters:

- index: [Int64](core_package_intrinsics.md#int64) - The index of the element to retrieve.

Return value:

- [Option](core_package_enums.md#enum-optiont)\<T> - The value at the specified `index` in the current array.

Example:

<!-- verify -->
```cangjie
main() {
    let arr = [0, 1, 2]
    let num = arr.get(0)
    println(num)
}
```

Execution result:

```text
Some(0)
```

### func map\<R>((T)->R)

```cangjie
public func map<R>(transform: (T)->R): Array<R>
```

Function: Maps all elements of type T in the current array to elements of type R using the transform function, forming a new array.

Parameters:

- transform: (T)->R - The mapping function.

Return Value:

- [Array](./core_package_structs.md#struct-arrayt)\<R> - A new array composed of the mapped elements from the original array.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    let arr = [0, 1, 2]
    let arr1 = arr.map({value => value + 1})
    println(arr1)
    return 0
}
```

Execution Result:

```text
[1, 2, 3]
```

### func repeat(Int64)

```cangjie
public func repeat(n: Int64): Array<T>
```

Function: Repeats the current array a specified number of times to form a new array.

Parameters:

- n: [Int64](core_package_intrinsics.md#int64) - The number of repetitions.

Return Value:

- [Array](./core_package_structs.md#struct-arrayt)\<T> - A new array formed by repeating the current array n times.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown if parameter n is less than or equal to 0.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    let arr = [0, 1, 2]
    var arr1 = arr.repeat(2)
    println(arr1)
    return 0
}
```

Execution Result:

```text
[0, 1, 2, 0, 1, 2]
```

### func reverse()

```cangjie
public func reverse(): Unit
```

Function: Reverses the order of elements in the array.

Example:

<!-- verify -->
```cangjie
main() {
    let arr = [0, 1, 2, 3, 4, 5]
    arr.reverse()
    println(arr)
}
```

Execution Result:

```text
[5, 4, 3, 2, 1, 0]
```

### func slice(Int64, Int64)

```cangjie
public func slice(start: Int64, len: Int64): Array<T>
```

Function: Obtains a slice of the array.

> **Note:**
>
> The slice does not copy the array data; it is a reference to a specific interval of the original data.

Parameters:

- start: [Int64](core_package_intrinsics.md#int64) - The starting position of the slice. Must be greater than 0, and start + len must be less than or equal to the length of the current [Array](core_package_structs.md#struct-arrayt) instance.
- len: [Int64](core_package_intrinsics.md#int64) - The length of the slice. Must be greater than 0.

Return Value:

- [Array](core_package_structs.md#struct-arrayt)\<T> - The sliced array.

Exceptions:

- [IndexOutOfBoundsException](core_package_exceptions.md#class-indexoutofboundsexception) - Thrown if the parameters do not meet the specified value ranges.

Example:

<!-- verify -->
```cangjie
class Rectangle <: ToString {
    var width: Int64
    var height: Int64

    public init(width: Int64, height: Int64) {
        this.width = width
        this.height = height
    }

    public func toString(): String {
        return "width: ${this.width}, height: ${this.height}"
    }
}

main(): Int64 {
    let arr = [Rectangle(1, 2), Rectangle(3, 4), Rectangle(5, 6)]
    let arr1 = arr.slice(1, 2)
    println(arr1)
    /* Since slice() is a reference to the original array, modifying the new array will also affect the reference-type elements in the original array */
    arr1[0].width = 5
    println(arr)
    return 0
}
```

Execution Result:

```text
[width: 3, height: 4, width: 5, height: 6]
[width: 1, height: 2, width: 5, height: 4, width: 5, height: 6]
```

### func splitAt(Int64)

```cangjie
public func splitAt(mid: Int64): (Array<T>, Array<T>)
```

Function: Splits the array at the specified position mid.

The resulting two arrays are slices of the original array, with value ranges [0, mid) and [mid, this.size).

Parameters:

- mid: [Int64](core_package_intrinsics.md#int64) - The split position. Must be in the range [0, this.size].

Return Value:

- ([Array](./core_package_structs.md#struct-arrayt)\<T>, [Array](./core_package_structs.md#struct-arrayt)\<T>) - The two slices obtained by splitting the original array.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown if mid is less than 0 or greater than this.size.

### func swap(Int64, Int64)

```cangjie
public func swap(index1: Int64, index2: Int64): Unit
```

Function: Swaps the elements at the specified positions.

If index1 and index2 point to the same position, no swap occurs.

Parameters:

- index1: [Int64](core_package_intrinsics.md#int64) - One of the indices of the elements to swap. Must be in the range [0, this.size).
- index2: [Int64](core_package_intrinsics.md#int64) - The other index of the elements to swap. Must be in the range [0, this.size).

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown if index1 or index2 is less than 0 or greater than or equal to this.size.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    let arr = [1, 2, 3, 4]
    arr.swap(1, 2)
    println(arr)
    return 0
}
```

Execution Result:

```text
[1, 3, 2, 4]
```

### operator func [](Int64)

```cangjie
public operator func [](index: Int64): T
```

Function: Retrieves the value at the specified index in the array.

If the index is out of bounds, this function throws an exception.

Alternatively, the get function can be used to retrieve an element at a specified index, which returns None if the index is out of bounds.

Parameters:

- index: [Int64](core_package_intrinsics.md#int64) - The index of the value to retrieve. Must be in the range [0, [Int64](core_package_intrinsics.md#int64).Max].

Return Value:

- T - The value at the specified index in the array.

Exceptions:

- [IndexOutOfBoundsException](core_package_exceptions.md#class-indexoutofboundsexception) - Thrown if index is less than 0 or greater than or equal to the array length.

### operator func [](Int64, T)

```cangjie
public operator func [](index: Int64, value!: T): Unit
```

Function: Modifies the value at the specified index in the array.

Parameters:

- index: [Int64](core_package_intrinsics.md#int64) - The index of the value to modify. Must be in the range [0, [Int64](core_package_intrinsics.md#int64).Max].
- value!: T - The new value to set.

Exceptions:

- [IndexOutOfBoundsException](core_package_exceptions.md#class-indexoutofboundsexception) - Thrown if index is less than 0 or greater than or equal to the array length.

### operator func [](Range\<Int64>)

```cangjie
public operator func [](range: Range<Int64>): Array<T>
```

Function: Obtains a slice of the array based on the specified range.

> **Note:**
>
> 1. If the parameter range is a [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) instance constructed using the [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) constructor, the behavior is as follows:
>    - The start value is exactly the value passed to the constructor, unaffected by the hasStart value during construction.
>    - If hasEnd is false, the end value is ignored (regardless of the isClosed value during construction), and the slice includes all elements up to the last element of the original array.
> 2. The step size of the range must be 1.

Parameters:

- range: [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<[Int64](core_package_intrinsics.md#int64)> - The range of the slice. The range must not exceed the bounds of the array.

Return Value:

- [Array](core_package_structs.md#struct-arrayt)\<T> - The array slice.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown if the step size of the range is not equal to 1.
- [IndexOutOfBoundsException](core_package_exceptions.md#class-indexoutofboundsexception) - Thrown if the range specifies an invalid array interval.

Example:

<!-- verify -->
```cangjie
main() {
    let arr = [0, 1, 2, 3, 4, 5]
    let slice = arr[1..4]
    arr[3] = 10
    println(slice)
}
```

Execution Result:

```text
[1, 2, 10]
```

### operator func [](Range\<Int64>, Array\<T>)

```cangjie
public operator func [](range: Range<Int64>, value!: Array<T>): Unit
```

Function: Assigns values from the specified array to a contiguous range of elements in this array.

The length of the range and the size of the target array value must be equal.

> **Note:**
>
> 1. If the parameter range is a [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) instance constructed using the [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) constructor, the following behaviors apply:
>    - The value of start is exactly the value passed to the constructor, unaffected by the hasStart parameter during construction.
>    - When hasEnd is false, the end value is ineffective and unaffected by the isClosed parameter during construction. The array slice will extend to the last element of the original array.
> 2. The step size of the range must be 1.

Parameters:

- range: [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<[Int64](core_package_intrinsics.md#int64)> - The array range to be modified. The range must not exceed the bounds of the array.
- value!: [Array](core_package_structs.md#struct-arrayt)\<T> - The target values for modification.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown if the step size of range is not equal to 1, or if the length of range does not match the length of value.
- [IndexOutOfBoundsException](core_package_exceptions.md#class-indexoutofboundsexception) - Thrown if the array range specified by range is invalid.

Example:

<!-- verify -->
```cangjie
main() {
    let arr = [0, 1, 2, 3, 4, 5]
    arr[1..3] = [10, 11]
    println(arr)
}
```

Output:

```text
[0, 10, 11, 3, 4, 5]
```

### extend\<T> Array\<T> <: Collection\<T>

```cangjie
extend<T> Array<T> <: Collection<T>
```

Function: Implements the [Collection](core_package_interfaces.md#interface-collectiont) interface for the [Array](core_package_structs.md#struct-arrayt)\<T> type.

Parent Type:

- [Collection](core_package_interfaces.md#interface-collectiont)\<T>

#### prop size

```cangjie
public prop size: Int64
```

Function: Gets the number of elements.

Type: [Int64](core_package_intrinsics.md#int64)

#### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Checks if the array is empty.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the array is empty, otherwise returns false.

#### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

Function: Gets an iterator for the current array, used for traversing the array.

Return Value:

- [Iterator](core_package_classes.md#class-iteratort)\<T> - The iterator for the current array.

#### func toArray()

```cangjie
public func toArray(): Array<T>
```

Function: Creates a new [Array](core_package_structs.md#struct-arrayt) instance by copying the current [Array](core_package_structs.md#struct-arrayt) instance.

Return Value:

- [Array](core_package_structs.md#struct-arrayt)\<T> - A new [Array](core_package_structs.md#struct-arrayt) instance copied from the current one.

### extend\<T> Array\<T> <: Equatable\<Array\<T>> where T <: Equatable\<T>

```cangjie
extend<T> Array<T> <: Equatable<Array<T>> where T <: Equatable<T>
```

Function: Extends the [Array](core_package_structs.md#struct-arrayt)\<T> type to implement the [Equatable](core_package_interfaces.md#interface-equatablet)\<[Array](core_package_structs.md#struct-arrayt)\<T>> interface, supporting equality comparison operations.

Parent Type:

- [Equatable](core_package_interfaces.md#interface-equatablet)\<[Array](#struct-arrayt)\<T>>

#### func contains(T)

```cangjie
public func contains(element: T): Bool
```

Function: Checks if the current array contains the specified element.

Parameter:

- element: T - The target element to search for.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the element is found, otherwise returns false.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    let arr = [1, 2, 3, 4]
    println(arr.contains(1))
    return 0
}
```

Output:

```text
true
```

#### func indexOf(Array\<T>)

```cangjie
public func indexOf(elements: Array<T>): Option<Int64>
```

Function: Returns the first occurrence position of the subarray `elements` in the array. Returns None if the array does not contain this subarray.

> **Note:**
>
> When T is of type [Int64](core_package_intrinsics.md#int64), the variadic parameter syntax sugar version of this function may conflict with `public func indexOf(element: T, fromIndex: Int64): Option<Int64>`. According to priority, when the number of parameters is 2, `public func indexOf(element: T, fromIndex: Int64): Option<Int64>` will be called first.

Parameter:

- elements: [Array](core_package_structs.md#struct-arrayt)\<T> - The target subarray to locate.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<[Int64](core_package_intrinsics.md#int64)> - The first occurrence position of the subarray `elements` in the array. Returns None if the array does not contain this subarray.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    let arr = [1, 2, 3, 4]
    let subArr = [2, 3]
    println(arr.indexOf(subArr))
    return 0
}
```

Output:

```text
Some(1)
```

#### func indexOf(Array\<T>, Int64)

```cangjie
public func indexOf(elements: Array<T>, fromIndex: Int64): Option<Int64>
```

Function: Returns the first occurrence position of the subarray `elements` in the array starting from `fromIndex`. Returns None if not found.

The function checks the range of `fromIndex`. If `fromIndex` is less than 0, the search starts from position 0. If `fromIndex` is greater than or equal to the size of the array, the result is None.

Parameters:

- elements: [Array](core_package_structs.md#struct-arrayt)\<T> - The target subarray to locate.
- fromIndex: [Int64](core_package_intrinsics.md#int64) - The starting position for the search.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<[Int64](core_package_intrinsics.md#int64)> - The first occurrence position of the subarray `elements` starting from `fromIndex`. Returns None if not found.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    let arr = [1, 2, 3, 4, 2, 3]
    let subArr = [2, 3]
    println(arr.indexOf(subArr, 3))
    return 0
}
```

Output:

```text
Some(4)
```

#### func indexOf(T)

```cangjie
public func indexOf(element: T): Option<Int64>
```

Function: Gets the first occurrence position of `element` in the array. Returns None if the array does not contain this element.

Parameter:

- element: T - The target element to locate.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<[Int64](core_package_intrinsics.md#int64)> - The first occurrence position of `element` in the array. Returns None if the array does not contain this element.

#### func indexOf(T, Int64)

```cangjie
public func indexOf(element: T, fromIndex: Int64): Option<Int64>
```

Function: Returns the first occurrence position of `element` in the array starting from `fromIndex`. Returns None if not found.

The function starts searching from index `fromIndex`. If `fromIndex` is less than 0, the search starts from position 0. If `fromIndex` is greater than or equal to the size of the array, the result is None.

Parameters:

- element: T - The target element to locate.
- fromIndex: [Int64](core_package_intrinsics.md#int64) - The starting position for the search.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<[Int64](core_package_intrinsics.md#int64)> - The first occurrence position of `element` starting from `fromIndex`. Returns None if not found.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    let arr = [1, 2, 3, 4, 2, 3]
    let subArr = [2, 3]
    println(arr.lastIndexOf(subArr, 3))
    return 0
}
```

Output:

```text
Some(4)
```

#### func lastIndexOf(Array\<T>)

```cangjie
public func lastIndexOf(elements: Array<T>): Option<Int64>
```

Function: Returns the last occurrence position of the subarray `elements` in the array. Returns None if the array does not contain this subarray.

Parameter:

- elements: [Array](core_package_structs.md#struct-arrayt)\<T> - The target subarray to locate.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<[Int64](core_package_intrinsics.md#int64)> - The last occurrence position of `elements` in the array. Returns None if the array does not contain this subarray.

#### func lastIndexOf(Array\<T>, Int64)

```cangjie
public func lastIndexOf(elements: Array<T>, fromIndex: Int64): Option<Int64>
```

Function: Searches backward starting from `fromIndex` and returns the last occurrence position of the subarray `elements` in the array. Returns None if the array does not contain this subarray.

The function checks the range of `fromIndex`. If `fromIndex` is less than 0, the search starts from position 0. If `fromIndex` is greater than or equal to the size of the array, the result is None.

Parameters:

- elements: [Array](core_package_structs.md#struct-arrayt)\<T> - The target subarray to locate.
- fromIndex: [Int64](core_package_intrinsics.md#int64) - The starting position for the backward search.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<[Int64](core_package_intrinsics.md#int64)> - The last occurrence position of `elements` starting from `fromIndex`. Returns None if the array does not contain this subarray.Parameters:

- `elements`: [Array](core_package_structs.md#struct-arrayt)\<T> - The target array to locate.
- `fromIndex`: [Int64](core_package_intrinsics.md#int64) - The starting position for the search.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<[Int64](core_package_intrinsics.md#int64)> - The last occurrence position of the subarray `elements` in the array when searching backward from `fromIndex`. Returns None if the subarray does not exist in the array.

#### func lastIndexOf(T)

```cangjie
public func lastIndexOf(element: T): Option<Int64>
```

Function: Returns the last occurrence position of `element` in the array. Returns None if the element does not exist in the array.

Parameters:

- `element`: T - The target element to locate.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<[Int64](core_package_intrinsics.md#int64)> - The last occurrence position of `element` in the array. Returns None if the element does not exist in the array.

#### func lastIndexOf(T, Int64)

```cangjie
public func lastIndexOf(element: T, fromIndex: Int64): Option<Int64>
```

Function: Searches backward from `fromIndex` and returns the last occurrence position of `element` in the array. Returns None if the element does not exist in the array.

The function checks the range of `fromIndex`. If `fromIndex` is less than 0, the search starts from position 0. If `fromIndex` is greater than or equal to the size of the array, the result is None.

Parameters:

- `element`: T - The target element to locate.
- `fromIndex`: [Int64](core_package_intrinsics.md#int64) - The starting position for the search.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<[Int64](core_package_intrinsics.md#int64)> - The last occurrence position of `element` when searching backward from `fromIndex`. Returns None if the element does not exist in the array.

#### func removePrefix(Array\<T>)

```cangjie
public func removePrefix(prefix: Array<T>): Array<T>
```

Function: Removes the prefix.

If the beginning of the current array exactly matches `prefix`, the prefix is removed. The return value is a slice of the current array after removing the prefix.

Parameters:

- `prefix`: [Array](./core_package_structs.md#struct-arrayt)\<T> - The prefix to remove.

Return Value:

- [Array](./core_package_structs.md#struct-arrayt)\<T> - The slice of the original array after removing the prefix.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    let arr = [1, 2, 1, 2, 3].removePrefix([1, 2])
    println(arr)
    return 0
}
```

Output:

```text
[1, 2, 3]
```

#### func removeSuffix(Array\<T>)

```cangjie
public func removeSuffix(suffix: Array<T>): Array<T>
```

Function: Removes the suffix.

If the end of the current array exactly matches `suffix`, the suffix is removed. The return value is a slice of the current array after removing the suffix.

Parameters:

- `suffix`: [Array](./core_package_structs.md#struct-arrayt)\<T> - The suffix to remove.

Return Value:

- [Array](./core_package_structs.md#struct-arrayt)\<T> - The slice of the original array after removing the suffix.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    let arr = [1, 2, 3, 2, 3].removeSuffix([2, 3])
    println(arr)
    return 0
}
```

Output:

```text
[1, 2, 3]
```

#### func trimEnd(Array\<T>)

```cangjie
public func trimEnd(set: Array<T>): Array<T>
```

Function: Trims the current array by removing elements from the end that are in the specified set `set` until the first element not in `set` is encountered, and returns the slice of the current array.

Parameters:

- `set`: [Array](core_package_structs.md#struct-arrayt)\<T> - The set of elements to remove.

Return Value:

- [Array](core_package_structs.md#struct-arrayt)\<T> - The trimmed array slice.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    let arr = [2, 1, 2, 2, 3].trimEnd([2, 3])
    println(arr)
    return 0
}
```

Output:

```text
[2, 1]
```

#### func trimEnd((T)->Bool)

```cangjie
public func trimEnd(predicate: (T)->Bool): Array<T>
```

Function: Trims the current array by removing elements from the end that satisfy the filter condition until the first element that does not satisfy the condition is encountered, and returns the slice of the current array.

Parameters:

- `predicate`: (T)->[Bool](./core_package_intrinsics.md#bool) - The filter condition.

Return Value:

- [Array](core_package_structs.md#struct-arrayt)\<T> - The trimmed array slice.

#### func trimStart(Array\<T>)

```cangjie
public func trimStart(set: Array<T>): Array<T>
```

Function: Trims the current array by removing elements from the beginning that are in the specified set `set` until the first element not in `set` is encountered, and returns the slice of the current array.

Parameters:

- `set`: [Array](core_package_structs.md#struct-arrayt)\<T> - The set of elements to remove.

Return Value:

- [Array](core_package_structs.md#struct-arrayt)\<T> - The trimmed array slice.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    let arr = [1, 2, 1, 3, 1].trimStart([1, 2])
    println(arr)
    return 0
}
```

Output:

```text
[3, 1]
```

#### func trimStart((T)->Bool)

```cangjie
public func trimStart(predicate: (T)->Bool): Array<T>
```

Function: Trims the current array by removing elements from the beginning that satisfy the filter condition until the first element that does not satisfy the condition is encountered, and returns the slice of the current array.

Parameters:

- `predicate`: (T)->[Bool](./core_package_intrinsics.md#bool) - The filter condition.

Return Value:

- [Array](core_package_structs.md#struct-arrayt)\<T> - The trimmed array slice.

#### operator func !=(Array\<T>)

```cangjie
public operator const func !=(that: Array<T>): Bool
```

Function: Determines whether the current instance is not equal to the specified [Array](core_package_structs.md#struct-arrayt)\<T> instance.

Parameters:

- `that`: [Array](core_package_structs.md#struct-arrayt)\<T> - Another [Array](core_package_structs.md#struct-arrayt)\<T> instance to compare with the current instance.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if not equal; otherwise, returns false.

#### operator func ==(Array\<T>)

```cangjie
public operator const func ==(that: Array<T>): Bool
```

Function: Determines whether the current instance is equal to the specified [Array](core_package_structs.md#struct-arrayt)\<T> instance.

Two [Array](core_package_structs.md#struct-arrayt)\<T> instances are considered equal if all their elements are equal.

Parameters:

- `that`: [Array](core_package_structs.md#struct-arrayt)\<T> - Another [Array](core_package_structs.md#struct-arrayt)\<T> instance to compare with the current instance.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if equal; otherwise, returns false.

### extend\<T> Array\<T> where T <: ToString

```cangjie
extend<T> Array<T> <: ToString where T <: ToString
```

Function: Extends the [Array](core_package_structs.md#struct-arrayt)\<T> type with the [ToString](core_package_interfaces.md#interface-tostring) interface, supporting string conversion operations.

Parent Type:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the array to an output-ready string.

The string format is like "[1, 2, 3, 4, 5]".

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

### extend\<T> Array\<Array\<T>>

```cangjie
extend<T> Array<Array<T>>
```

Function: Extends the two-dimensional array with methods to flatten it into a one-dimensional array.

#### func flatten()

```cangjie
public func flatten(): Array<T>
```

Function: Flattens the current two-dimensional array into a one-dimensional array.

For example, [[1, 2], [3, 4]] is flattened into [1, 2, 3, 4].

Return Value:

- [Array](./core_package_structs.md#struct-arrayt)\<T> - The flattened one-dimensional array.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    let arr = [[1, 2], [3, 4]].flatten()
    println(arr)
    return 0
}
```

Execution Result:

```text
[1, 2, 3, 4]
```

## struct CPointerHandle\<T> where T <: CType

```cangjie
public struct CPointerHandle<T> where T <: CType {
    public let array: Array<T>
    public let pointer: CPointer<T>
    public init()
    public init(ptr: CPointer<T>, arr: Array<T>)
}
```

Function: Represents the raw pointer of an [Array](core_package_structs.md#struct-arrayt), where the generic parameter should satisfy the [CType](core_package_interfaces.md#interface-ctype) constraint.

### let array

```cangjie
public let array: Array<T>
```

Function: The corresponding [Array](core_package_structs.md#struct-arrayt) instance of the raw pointer.

Type: [Array](core_package_structs.md#struct-arrayt)\<T>

### let pointer

```cangjie
public let pointer: CPointer<T>
```

Function: Retrieves the raw pointer corresponding to the specified [Array](core_package_structs.md#struct-arrayt).

Type: [CPointer](core_package_intrinsics.md#cpointert)\<T>

### init() <sup>(deprecated)</sup>

```cangjie
public init()
```

Function: Constructs a default [CPointerHandle](core_package_structs.md#struct-cpointerhandlet-where-t--ctype) instance, where the raw pointer is a null pointer and the Cangjie array is an empty array.

> **Note:**
>
> This will be deprecated in future versions. Use the [acquireArrayRawData](./core_package_funcs.md#func-acquirearrayrawdatatarrayt-where-t--ctype) function to construct a CPointerHandle instance instead.

### init(CPointer\<T>, Array\<T>) <sup>(deprecated)</sup>

```cangjie
public init(ptr: CPointer<T>, arr: Array<T>)
```

Function: Initializes a [CPointerHandle](core_package_structs.md#struct-cpointerhandlet-where-t--ctype) with the provided [CPointer](core_package_intrinsics.md#cpointert) and [Array](core_package_structs.md#struct-arrayt).

Parameters:

- ptr: [CPointer](core_package_intrinsics.md#cpointert)\<T> - The raw pointer of the array.
- arr: [Array](core_package_structs.md#struct-arrayt)\<T> - The corresponding Cangjie array.

> **Note:**
>
> This will be deprecated in future versions. Use the [acquireArrayRawData](./core_package_funcs.md#func-acquirearrayrawdatatarrayt-where-t--ctype) function to construct a CPointerHandle instance instead.

## struct CPointerResource\<T> where T <: CType

```cangjie
public struct CPointerResource<T> <: Resource where T <: CType {
    public let value: CPointer<T>
}
```

Function: This struct represents the resource management type for [CPointer](core_package_intrinsics.md#cpointert). Its instances can be obtained via the `asResource` member function of [CPointer](core_package_intrinsics.md#cpointert).

Parent Types:

- [Resource](core_package_interfaces.md#interface-resource)

### let value

```cangjie
public let value: CPointer<T>
```

Function: Represents the [CPointer](core_package_intrinsics.md#cpointert)\<T> instance managed by this resource.

Type: [CPointer](core_package_intrinsics.md#cpointert)\<T>

### func close()

```cangjie
public func close(): Unit
```

Function: Releases the content pointed to by the managed [CPointer](core_package_intrinsics.md#cpointert)\<T> instance.

### func isClosed()

```cangjie
public func isClosed(): Bool
```

Function: Checks whether the pointer content has been released.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if released.

## struct CStringResource

```cangjie
public struct CStringResource <: Resource {
    public let value: CString
}
```

Function: This struct represents the resource management type for [CString](core_package_intrinsics.md#cstring). Its instances can be obtained via the `asResource` member function of [CString](core_package_intrinsics.md#cstring).

Parent Types:

- [Resource](core_package_interfaces.md#interface-resource)

### let value

```cangjie
public let value: CString
```

Function: Represents the [CString](core_package_intrinsics.md#cstring) resource managed by this instance.

Type: [CString](core_package_intrinsics.md#cstring)

### func close()

```cangjie
public func close(): Unit
```

Function: Releases the content pointed to by the managed [CString](core_package_intrinsics.md#cstring) instance.

### func isClosed()

```cangjie
public func isClosed(): Bool
```

Function: Checks whether the string has been released.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if released.

## struct DefaultHasher

```cangjie
public struct DefaultHasher <: Hasher {
 public init(res!: Int64 = 0)
}
```

Function: This struct provides a default hash algorithm implementation.

A series of `write` functions can be used to input different data type instances and compute their combined hash value.

Parent Types:

- [Hasher](core_package_interfaces.md#interface-hasher)

### init(Int64)

```cangjie
public init(res!: Int64 = 0)
```

Function: Constructor, creates a [DefaultHasher](core_package_structs.md#struct-defaulthasher).

Parameters:

- res!: [Int64](core_package_intrinsics.md#int64) - Initial hash value, default is 0.

### func finish()

```cangjie
public func finish(): Int64
```

Function: Retrieves the result of the hash operation.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The result of the hash operation.

### func reset()

```cangjie
public mut func reset(): Unit
```

Function: Resets the hash value to 0.

### func write(Bool)

```cangjie
public mut func write(value: Bool): Unit
```

Function: Inputs a [Bool](core_package_intrinsics.md#bool) value for hash computation and performs combined hash operations.

Parameters:

- value: [Bool](core_package_intrinsics.md#bool) - The value to be hashed.

### func write(Float16)

```cangjie
public mut func write(value: Float16): Unit
```

Function: Inputs a [Float16](core_package_intrinsics.md#float16) value for hash computation and performs combined hash operations.

Parameters:

- value: [Float16](core_package_intrinsics.md#float16) - The value to be hashed.

### func write(Float32)

```cangjie
public mut func write(value: Float32): Unit
```

Function: Inputs a [Float32](core_package_intrinsics.md#float32) value for hash computation and performs combined hash operations.

Parameters:

- value: [Float32](core_package_intrinsics.md#float32) - The value to be hashed.

### func write(Float64)

```cangjie
public mut func write(value: Float64): Unit
```

Function: Inputs a [Float64](core_package_intrinsics.md#float64) value for hash computation and performs combined hash operations.

Parameters:

- value: [Float64](core_package_intrinsics.md#float64) - The value to be hashed.

### func write(Int16)

```cangjie
public mut func write(value: Int16): Unit
```

Function: Inputs an [Int16](core_package_intrinsics.md#int16) value for hash computation and performs combined hash operations.

Parameters:

- value: [Int16](core_package_intrinsics.md#int16) - The value to be hashed.

### func write(Int32)

```cangjie
public mut func write(value: Int32): Unit
```

Function: Inputs an [Int32](core_package_intrinsics.md#int32) value for hash computation and performs combined hash operations.

Parameters:

- value: [Int32](core_package_intrinsics.md#int32) - The value to be hashed.

### func write(Int64)

```cangjie
public mut func write(value: Int64): Unit
```

Function: Inputs an [Int64](core_package_intrinsics.md#int64) value for hash computation and performs combined hash operations.

Parameters:

- value: [Int64](core_package_intrinsics.md#int64) - The value to be hashed.

### func write(Int8)

```cangjie
public mut func write(value: Int8): Unit
```

Function: Inputs an [Int8](core_package_intrinsics.md#int8) value for hash computation and performs combined hash operations.

Parameters:

- value: [Int8](core_package_intrinsics.md#int8) - The value to be processed.

### func write(Rune)

```cangjie
public mut func write(value: Rune): Unit
```

Function: Passes the [Rune](core_package_intrinsics.md#rune) value to be hashed through this function for combined hash computation.

Parameters:

- value: [Rune](core_package_intrinsics.md#rune) - The value to be processed.

### func write(String)

```cangjie
public mut func write(value: String): Unit
```

Function: Passes the [String](core_package_structs.md#struct-string) value to be hashed through this function for combined hash computation.

Parameters:

- value: [String](core_package_structs.md#struct-string) - The value to be processed.

### func write(UInt16)

```cangjie
public mut func write(value: UInt16): Unit
```

Function: Passes the [UInt16](core_package_intrinsics.md#uint16) value to be hashed through this function for combined hash computation.

Parameters:

- value: [UInt16](core_package_intrinsics.md#uint16) - The value to be processed.

### func write(UInt32)

```cangjie
public mut func write(value: UInt32): Unit
```

Function: Passes the [UInt32](core_package_intrinsics.md#uint32) value to be hashed through this function for combined hash computation.

Parameters:

- value: [UInt32](core_package_intrinsics.md#uint32) - The value to be processed.

### func write(UInt64)

```cangjie
public mut func write(value: UInt64): Unit
```

Function: Passes the [UInt64](core_package_intrinsics.md#uint64) value to be hashed through this function for combined hash computation.

Parameters:

- value: [UInt64](core_package_intrinsics.md#uint64) - The value to be processed.

### func write(UInt8)

```cangjie
public mut func write(value: UInt8): Unit
```

Function: Passes the [UInt8](core_package_intrinsics.md#uint8) value to be hashed through this function for combined hash computation.

Parameters:

- value: [UInt8](core_package_intrinsics.md#uint8) - The value to be processed.

## struct Duration

```cangjie
public struct Duration <: ToString & Hashable & Comparable<Duration> {
    public static const Max: Duration = Duration(0x7FFF_FFFF_FFFF_FFFF, 999999999)
    public static const Min: Duration = Duration(-0x8000_0000_0000_0000, 0)
    public static const Zero: Duration = Duration(0, 0)
    public static const day: Duration = Duration(24 * 60 * 60, 0)
    public static const hour: Duration = Duration(60 * 60, 0)
    public static const microsecond: Duration = Duration(0, 1000u32)
    public static const millisecond: Duration = Duration(0, 1000000u32)
    public static const minute: Duration = Duration(60, 0)
    public static const nanosecond: Duration = Duration(0, 1)
    public static const second: Duration = Duration(1, 0)
}
```

Function: [Duration](core_package_structs.md#struct-duration) represents a time interval, describing a period of time with common static instances and providing computation and comparison functionalities.

> **Note:**
>
> - [Duration](core_package_structs.md#struct-duration) ranges from [Duration](core_package_structs.md#struct-duration).Min to [Duration](core_package_structs.md#struct-duration).Max, represented numerically as \[-2<sup>63</sup>, 2<sup>63</sup>\) (in seconds) with nanosecond precision.
> - Each time unit in [Duration](core_package_structs.md#struct-duration) is represented as an integer. If the actual value is not an integer, it is rounded toward zero. For example, calling the `toHours` method on a [Duration](core_package_structs.md#struct-duration) instance representing `1 hour 30 minutes 46 seconds` will return 1 instead of 1.5 or 2.

Parent Types:

- [ToString](core_package_interfaces.md#interface-tostring)
- [Hashable](core_package_interfaces.md#interface-hashable)
- [Comparable](core_package_interfaces.md#interface-comparablet)\<[Duration](#struct-duration)>

### static const Max

```cangjie
public static const Max: Duration = Duration(0x7FFF_FFFF_FFFF_FFFF, 999999999)
```

Function: Represents the maximum time interval as a [Duration](core_package_structs.md#struct-duration) instance.

Type: [Duration](core_package_structs.md#struct-duration)

### static const Min

```cangjie
public static const Min: Duration = Duration(-0x8000_0000_0000_0000, 0)
```

Function: Represents the minimum time interval as a [Duration](core_package_structs.md#struct-duration) instance.

Type: [Duration](core_package_structs.md#struct-duration)

### static const Zero

```cangjie
public static const Zero: Duration = Duration(0, 0)
```

Function: Represents a zero-nanosecond time interval as a [Duration](core_package_structs.md#struct-duration) instance.

Type: [Duration](core_package_structs.md#struct-duration)

### static const day

```cangjie
public static const day: Duration = Duration(24 * 60 * 60, 0)
```

Function: Represents a one-day time interval as a [Duration](core_package_structs.md#struct-duration) instance.

Type: [Duration](core_package_structs.md#struct-duration)

### static const hour

```cangjie
public static const hour: Duration = Duration(60 * 60, 0)
```

Function: Represents a one-hour time interval as a [Duration](core_package_structs.md#struct-duration) instance.

Type: [Duration](core_package_structs.md#struct-duration)

### static const microsecond

```cangjie
public static const microsecond: Duration = Duration(0, 1000u32)
```

Function: Represents a one-microsecond time interval as a [Duration](core_package_structs.md#struct-duration) instance.

Type: [Duration](core_package_structs.md#struct-duration)

### static const millisecond

```cangjie
public static const millisecond: Duration = Duration(0, 1000000u32)
```

Function: Represents a one-millisecond time interval as a [Duration](core_package_structs.md#struct-duration) instance.

Type: [Duration](core_package_structs.md#struct-duration)

### static const minute

```cangjie
public static const minute: Duration = Duration(60, 0)
```

Function: Represents a one-minute time interval as a [Duration](core_package_structs.md#struct-duration) instance.

Type: [Duration](core_package_structs.md#struct-duration)

### static const nanosecond

```cangjie
public static const nanosecond: Duration = Duration(0, 1)
```

Function: Represents a one-nanosecond time interval as a [Duration](core_package_structs.md#struct-duration) instance.

Type: [Duration](core_package_structs.md#struct-duration)

### static const second

```cangjie
public static const second: Duration = Duration(1, 0)
```

Function: Represents a one-second time interval as a [Duration](core_package_structs.md#struct-duration) instance.

Type: [Duration](core_package_structs.md#struct-duration)

### func abs()

```cangjie
public func abs(): Duration
```

Function: Returns a new [Duration](core_package_structs.md#struct-duration) instance with the absolute value of the current [Duration](core_package_structs.md#struct-duration) instance.

Return Value:

- [Duration](core_package_structs.md#struct-duration) - The absolute value of the current [Duration](core_package_structs.md#struct-duration) instance.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown if the current [Duration](core_package_structs.md#struct-duration) instance equals [Duration](core_package_structs.md#struct-duration).Min, as taking the absolute value would exceed the representable range of [Duration](core_package_structs.md#struct-duration).

### func compare(Duration)

```cangjie
public func compare(rhs: Duration): Ordering
```

Function: Compares the current [Duration](core_package_structs.md#struct-duration) instance with another [Duration](core_package_structs.md#struct-duration) instance. Returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).GT if greater, [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ if equal, or [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).LT if less.

Parameters:

- rhs: [Duration](core_package_structs.md#struct-duration) - The [Duration](core_package_structs.md#struct-duration) instance to compare with.

Return Value:

- [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) - The comparison result between the current [Duration](core_package_structs.md#struct-duration) instance and `rhs`.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Obtains the hash value of the current [Duration](core_package_structs.md#struct-duration) instance.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value of the current [Duration](core_package_structs.md#struct-duration) instance.

### func toDays()

```cangjie
public func toDays(): Int64
```

Function: Obtains the integer value of the current [Duration](core_package_structs.md#struct-duration) instance in days.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value of the current [Duration](core_package_structs.md#struct-duration) instance in days.

### func toHours()

```cangjie
public func toHours(): Int64
```

Function: Obtains the integer value of the current [Duration](core_package_structs.md#struct-duration) instance in hours.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value of the current [Duration](core_package_structs.md#struct-duration) instance in hours.

### func toMicroseconds()

```cangjie
public func toMicroseconds(): Int64
```

Function: Obtains the integer value of the current [Duration](core_package_structs.md#struct-duration) instance in microseconds.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value of the current [Duration](core_package_structs.md#struct-duration) instance in microseconds.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown if the value of the [Duration](core_package_structs.md#struct-duration) instance in microseconds exceeds the representable range of [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

### func toMilliseconds()

```cangjie
public func toMilliseconds(): Int64
```

Function: Obtains the integer value of the current [Duration](core_package_structs.md#struct-duration) instance in milliseconds.

Return Value:- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The size of the current [Duration](core_package_structs.md#struct-duration) instance in milliseconds.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the size of the [Duration](core_package_structs.md#struct-duration) instance in milliseconds exceeds the representation range of [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

### func toMinutes()

```cangjie
public func toMinutes(): Int64
```

Function: Gets the integer size of the current [Duration](core_package_structs.md#struct-duration) instance in minutes.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The size of the current [Duration](core_package_structs.md#struct-duration) instance in minutes.

### func toNanoseconds()

```cangjie
public func toNanoseconds(): Int64
```

Function: Gets the integer size of the current [Duration](core_package_structs.md#struct-duration) instance in nanoseconds, rounded towards zero.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The size of the current [Duration](core_package_structs.md#struct-duration) instance in nanoseconds.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the size of the [Duration](core_package_structs.md#struct-duration) instance in nanoseconds exceeds the representation range of [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

### func toSeconds()

```cangjie
public func toSeconds(): Int64
```

Function: Gets the integer size of the current [Duration](core_package_structs.md#struct-duration) instance in seconds.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The size of the current [Duration](core_package_structs.md#struct-duration) instance in seconds.

### func toString()

```cangjie
public func toString(): String
```

Function: Gets the string representation of the current [Duration](core_package_structs.md#struct-duration) instance, formatted as "1d2h3m4s5ms6us7ns", representing "1 day 2 hours 3 minutes 4 seconds 5 milliseconds 6 microseconds 7 nanoseconds". Units with a value of 0 are omitted. Specifically, when all units are 0, returns "0s".

Return value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of the current [Duration](core_package_structs.md#struct-duration) instance.

### operator func !=(Duration)

```cangjie
public operator func !=(r: Duration): Bool
```

Function: Determines whether the current [Duration](core_package_structs.md#struct-duration) instance is not equal to `r`.

Parameters:

- r: [Duration](core_package_structs.md#struct-duration) - A [Duration](core_package_structs.md#struct-duration) instance.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the current [Duration](core_package_structs.md#struct-duration) instance is not equal to `r`; otherwise, returns `false`.

### operator func *(Float64)

```cangjie
public operator func *(r: Float64): Duration
```

Function: Implements multiplication between [Duration](core_package_structs.md#struct-duration) and [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) types, i.e., [Duration](core_package_structs.md#struct-duration) * [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) operation.

Parameters:

- r: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The right operand of the multiplication.

Return value:

- [Duration](core_package_structs.md#struct-duration) - The product of the [Duration](core_package_structs.md#struct-duration) instance and `r`.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the result of the multiplication exceeds the representation range of [Duration](core_package_structs.md#struct-duration).

### operator func *(Int64)

```cangjie
public operator func *(r: Int64): Duration
```

Function: Implements multiplication between [Duration](core_package_structs.md#struct-duration) and [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) types, i.e., [Duration](core_package_structs.md#struct-duration) * [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) operation.

Parameters:

- r: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The right operand of the multiplication.

Return value:

- [Duration](core_package_structs.md#struct-duration) - The product of the [Duration](core_package_structs.md#struct-duration) instance and `r`.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the result of the multiplication exceeds the representation range of [Duration](core_package_structs.md#struct-duration).

### operator func +(Duration)

```cangjie
public operator func +(r: Duration): Duration
```

Function: Implements addition between [Duration](core_package_structs.md#struct-duration) types, i.e., [Duration](core_package_structs.md#struct-duration) + [Duration](core_package_structs.md#struct-duration) operation.

Parameters:

- r: [Duration](core_package_structs.md#struct-duration) - The right operand of the addition.

Return value:

- [Duration](core_package_structs.md#struct-duration) - The sum of the [Duration](core_package_structs.md#struct-duration) instance and `r`.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the result of the addition exceeds the representation range of [Duration](core_package_structs.md#struct-duration).

### operator func -(Duration)

```cangjie
public operator func -(r: Duration): Duration
```

Function: Implements subtraction between [Duration](core_package_structs.md#struct-duration) types, i.e., [Duration](core_package_structs.md#struct-duration) - [Duration](core_package_structs.md#struct-duration) operation.

Parameters:

- r: [Duration](core_package_structs.md#struct-duration) - The right operand of the subtraction.

Return value:

- [Duration](core_package_structs.md#struct-duration) - The difference between the [Duration](core_package_structs.md#struct-duration) instance and `r`.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the result of the subtraction exceeds the representation range of [Duration](core_package_structs.md#struct-duration).

### operator func /(Duration)

```cangjie
public operator func /(r: Duration): Float64
```

Function: Implements division between [Duration](core_package_structs.md#struct-duration) types, i.e., [Duration](core_package_structs.md#struct-duration) / [Duration](core_package_structs.md#struct-duration) operation.

Parameters:

- r: [Duration](core_package_structs.md#struct-duration) - The divisor.

Return value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The quotient of the [Duration](core_package_structs.md#struct-duration) instance and `r`.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when `r` equals [Duration](core_package_structs.md#struct-duration).Zero.

### operator func /(Float64)

```cangjie
public operator func /(r: Float64): Duration
```

Function: Implements division between [Duration](core_package_structs.md#struct-duration) and [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) types, i.e., [Duration](core_package_structs.md#struct-duration) / [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) operation.

Parameters:

- r: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The divisor.

Return value:

- [Duration](core_package_structs.md#struct-duration) - The quotient of the [Duration](core_package_structs.md#struct-duration) instance and `r`.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when `r` equals 0.
- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the result of the division exceeds the representation range of [Duration](core_package_structs.md#struct-duration).

### operator func /(Int64)

```cangjie
public operator func /(r: Int64): Duration
```

Function: Implements division between [Duration](core_package_structs.md#struct-duration) and [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) types, i.e., [Duration](core_package_structs.md#struct-duration) / [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) operation.

Parameters:

- r: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The divisor.

Return value:

- [Duration](core_package_structs.md#struct-duration) - The quotient of the [Duration](core_package_structs.md#struct-duration) instance and `r`.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when `r` equals 0.
- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the result of the division exceeds the representation range of [Duration](core_package_structs.md#struct-duration).

### operator func <(Duration)

```cangjie
public operator func <(r: Duration): Bool
```

Function: Determines whether the current [Duration](core_package_structs.md#struct-duration) instance is less than `r`.

Parameters:

- r: [Duration](core_package_structs.md#struct-duration) - A [Duration](core_package_structs.md#struct-duration) instance.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the current [Duration](core_package_structs.md#struct-duration) instance is less than `r`; otherwise, returns `false`.

### operator func <=(Duration)

```cangjie
public operator func <=(r: Duration): Bool
```

Function: Determines whether the current [Duration](core_package_structs.md#struct-duration) instance is less than or equal to `r`.

Parameters:

- r: [Duration](core_package_structs.md#struct-duration) - A [Duration](core_package_structs.md#struct-duration) instance.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the current [Duration](core_package_structs.md#struct-duration) instance is less than or equal to `r`; otherwise, returns `false`.

### operator func ==(Duration)

```cangjie
public operator func ==(r: Duration): Bool
```

Function: Determines whether the current [Duration](core_package_structs.md#struct-duration) instance is equal to `r`.

Parameters:

- r: [Duration](core_package_structs.md#struct-duration) - A [Duration](core_package_structs.md#struct-duration) instance.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the current [Duration](core_package_structs.md#struct-duration) instance is equal to `r`; otherwise, returns `false`.

### operator func >(Duration)

```cangjie
public operator func >(r: Duration): Bool
```

Function: Determines whether the current [Duration](core_package_structs.md#struct-duration) instance is greater than `r`.

Parameters:

- r: [Duration](core_package_structs.md#struct-duration) - A [Duration](core_package_structs.md#struct-duration) instance.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the current [Duration](core_package_structs.md#struct-duration) instance is greater than `r`; otherwise, returns `false`.

### operator func >=(Duration)

```cangjie
public operator func >=(r: Duration): Bool
```

Function: Determines whether the current [Duration](core_package_structs.md#struct-duration) instance is greater than or equal to `r`.

Parameters:

- r: [Duration](core_package_structs.md#struct-duration) - A [Duration](core_package_structs.md#struct-duration) instance.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the current [Duration](core_package_structs.md#struct-duration) instance is greater than or equal to `r`; otherwise, returns `false`.

## struct LibC

```cangjie
public struct LibC
```

Function: Provides commonly used C interfaces in Cangjie, such as allocating and freeing heap-allocated [CType](core_package_interfaces.md#interface-ctype) instances.

### static func free\<T>(CPointer\<T>) where T <: CType

```cangjie
public unsafe static func free<T>(p: CPointer<T>): Unit where T <: CType
```

Function: Frees the heap memory pointed to by pointer p.

Parameters:

- p: [CPointer](core_package_intrinsics.md#cpointert)\<T> - Represents the memory address to be freed.

### static func free(CString)

```cangjie
public unsafe static func free(cstr: CString): Unit
```

Function: Frees a C-style string.

Parameters:

- cstr: [CString](core_package_intrinsics.md#cstring) - The C-style string to be freed.

### static func mallocCString(String)

```cangjie
public unsafe static func mallocCString(str: String): CString
```

Function: Allocates a C-style string with identical character content from a [String](core_package_structs.md#struct-string).

The constructed C-style string will be null-terminated ('\0'). In exceptional scenarios such as insufficient system memory, the returned string pointer may be null, so null pointer checks are required before use.

Parameters:

- str: [String](core_package_structs.md#struct-string) - Constructs a C string based on this Cangjie string.

Return Value:

- [CString](core_package_intrinsics.md#cstring) - The newly constructed C-style string.

Exceptions:

- [IllegalMemoryException](core_package_exceptions.md#class-illegalmemoryexception) - Thrown when memory is insufficient.

Example:

<!-- verify -->
```cangjie
main() {
    var str = unsafe { LibC.mallocCString("I like Cangjie") }
    println(str)
    unsafe { LibC.free(str) }
}
```

Execution Result:

```text
I like Cangjie
```

### static func malloc\<T>(Int64) where T <: CType

```cangjie
public static func malloc<T>(count!: Int64 = 1): CPointer<T> where T <: CType
```

Function: Allocates a specified number of `T` instances on the heap and returns their starting pointer.

The allocated memory length is [sizeOf](core_package_funcs.md#func-sizeoft-where-t--ctype)\<T>() * [count](../../collection/collection_package_api/collection_package_function.md#func-counttiterablet).

Parameters:

- [count](../../collection/collection_package_api/collection_package_function.md#func-counttiterablet)!: [Int64](core_package_intrinsics.md#int64) - An optional parameter, defaulting to 1, representing the number of T-type instances to allocate.

Return Value:

- [CPointer](core_package_intrinsics.md#cpointert)\<T> - The allocated T-type pointer.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown when the input parameter is negative.

Example:

<!-- verify -->
```cangjie
main() {
    var p = unsafe { LibC.malloc<Int64>(count: 1) }
    unsafe { p.write(8) }
    let value: Int64 = unsafe { p.read() }
    println(value)
    unsafe { LibC.free<Int64>(p) }
}
```

Execution Result:

```text
8
```

## struct Range\<T> where T <: Countable\<T> & Comparable\<T> & Equatable\<T>

```cangjie
public struct Range<T> <: Iterable<T> where T <: Countable<T> & Comparable<T> & Equatable<T> {
    public let end: T
    public let hasEnd: Bool
    public let hasStart: Bool
    public let isClosed: Bool
    public let start: T
    public let step: Int64
    public const init(start: T, end: T, step: Int64, hasStart: Bool, hasEnd: Bool, isClosed: Bool)
}
```

Function: This class represents a range type, used to denote a sequence of `T` with a fixed range and step size, requiring `T` to be countable, ordered, and equatable.

Range types have corresponding literal representations with the following formats:

- Left-closed right-open interval: `start..end : step`, representing a range from start to end (excluding end) with step size [step](#let-step).
- Left-closed right-closed interval: `start..=end : step`, representing a range from start to end (including end) with step size [step](#let-step).

> **Note:**
>
> - When [step](#let-step) > 0 and start >= end, or [step](#let-step) < 0 and start <= end, this [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) instance will be an empty range.
> - When [step](#let-step) > 0 and start > end, or [step](#let-step) < 0 and start < end, this [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) instance will be an empty range.

Parent Types:

- [Iterable](core_package_interfaces.md#interface-iterablee)\<T>

### let end

```cangjie
public let end: T
```

Function: Represents the end value.

Type: T

### let hasEnd

```cangjie
public let hasEnd: Bool
```

Function: Indicates whether the end value is included.

Type: [Bool](core_package_intrinsics.md#bool)

### let hasStart

```cangjie
public let hasStart: Bool
```

Function: Indicates whether the start value is included.

Type: [Bool](core_package_intrinsics.md#bool)

### let isClosed

```cangjie
public let isClosed: Bool
```

Function: Indicates the interval's closure status. true represents left-closed right-closed, false represents left-closed right-open.

Type: [Bool](core_package_intrinsics.md#bool)

### let start

```cangjie
public let start: T
```

Function: Represents the start value.

Type: T

### let step

```cangjie
public let step: Int64
```

Function: Represents the step size.

Type: [Int64](core_package_intrinsics.md#int64)

### init(T, T, Int64, Bool, Bool, Bool)

```cangjie
public const init(start: T, end: T, step: Int64, hasStart: Bool, hasEnd: Bool, isClosed: Bool)
```

Function: Creates a [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) sequence using this constructor.

Parameters:

- start: T - The start value.
- end: T - The end value.
- [step](#let-step): [Int64](core_package_intrinsics.md#int64) - The step size, which cannot be 0.
- hasStart: [Bool](core_package_intrinsics.md#bool) - Whether there is a start value.
- hasEnd: [Bool](core_package_intrinsics.md#bool) - Whether there is an end value.
- isClosed: [Bool](core_package_intrinsics.md#bool) - true represents left-closed right-closed, false represents left-closed right-open.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown when [step](#let-step) equals 0.

### func isEmpty()

```cangjie
public const func isEmpty(): Bool
```

Function: Determines whether this range is empty.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if empty, otherwise false.

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

Function: Gets the iterator for the current range.

Return Value:

- [Iterator](core_package_classes.md#class-iteratort)\<T> - The iterator for the current range.

### extend\<T> Range\<T> <: Equatable\<Range\<T>> where T <: Countable\<T> & Comparable\<T> & Equatable\<T>

```cangjie
extend<T> Range<T> <: Equatable<Range<T>> where T <: Countable<T> & Comparable<T> & Equatable<T>
```

Function: Extends the [Equatable](core_package_interfaces.md#interface-equatablet)\<[Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<T>> interface for the [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<T> type.

Parent Types:

- [Equatable](core_package_interfaces.md#interface-equatablet)\<[Range](#struct-ranget-where-t--countablet--comparablet--equatablet)\<T>>

#### operator func ==(Range\<T>)

```cangjie
public operator func ==(that: Range<T>): Bool
```

Function: Determines whether two [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) instances are equal.

Two [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) instances are equal if they represent the same interval, i.e., their `start`, `end`, [step](#let-step), and `isClosed` values are equal.

Parameters:

- that: [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<T> - The [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) instance to compare.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - true if equal, false otherwise.

### extend\<T> Range\<T> <: Hashable where T <: Hashable & Countable\<T> & Comparable\<T> & Equatable\<T>

```cangjie
extend<T> Range<T> <: Hashable where T <: Hashable & Countable<T> & Comparable<T> & Equatable<T>
```

Function: Extends the [Hashable](core_package_interfaces.md#interface-hashable) interface for the [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) type, supporting hash value computation.

Parent Types:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Gets the hash value, which is the combined hash operation result of `start`, `end`, [step](#let-step), and `isClosed`.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash value.

## struct String

```cangjie
public struct String <: Collection<Byte> & Comparable<String> & Hashable & ToString {
    public static const empty: String = String()
    public const init()
    public init(value: Array<Rune>)
    public init(value: Collection<Rune>)
}
```

Functionality: This struct represents a Cangjie string, providing a series of string operations including construction, searching, concatenation, etc.

> **Note:**
>
> - The `String` type only supports UTF-8 encoding.
> - For memory optimization of `String` objects, the length of `String` is limited to `4GB`, meaning the maximum length of `String` does not exceed [the maximum value of UInt32](./core_package_intrinsics.md#uint32).

Parent Types:

- [Collection](core_package_interfaces.md#interface-collectiont)\<Byte>
- [Comparable](core_package_interfaces.md#interface-comparablet)\<[String](#struct-string)>
- [Hashable](core_package_interfaces.md#interface-hashable)
- [ToString](core_package_interfaces.md#interface-tostring)

### static const empty

```cangjie
public static const empty: String = String()
```

Functionality: Creates and returns an empty string.

Type: [String](core_package_structs.md#struct-string)

### prop size

```cangjie
public prop size: Int64
```

Functionality: Gets the byte length of the string after UTF-8 encoding.

Type: [Int64](core_package_intrinsics.md#int64)

### init()

```cangjie
public const init()
```

Functionality: Constructs an empty string.

### init(Array\<Rune>)

```cangjie
public init(value: Array<Rune>)
```

Functionality: Constructs a string from an array of characters, where the string content consists of all characters in the array.

Parameters:

- value: [Array](core_package_structs.md#struct-arrayt)\<Rune> - The character array used to construct the string.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown when attempting to construct a string whose length exceeds [the maximum value of UInt32](./core_package_intrinsics.md#uint32).

### init(Collection\<Rune>)

```cangjie
public init(value: Collection<Rune>)
```

Functionality: Constructs a string from a collection of characters, where the string content consists of all characters in the collection.

Parameters:

- value: [Collection](core_package_interfaces.md#interface-collectiont)\<Rune> - The character collection used to construct the string.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown when attempting to construct a string whose length exceeds [the maximum value of UInt32](./core_package_intrinsics.md#uint32).

### static func fromUtf8(Array\<UInt8>)

```cangjie
public static func fromUtf8(utf8Data: Array<UInt8>): String
```

Functionality: Constructs a string from a UTF-8 encoded byte array.

Parameters:

- utf8Data: [Array](core_package_structs.md#struct-arrayt)\<[UInt8](core_package_intrinsics.md#uint8)> - The byte array used to construct the string.

Return Value:

- [String](core_package_structs.md#struct-string) - The constructed string.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown if the input does not conform to UTF-8 sequence rules or when attempting to construct a string whose length exceeds [the maximum value of UInt32](./core_package_intrinsics.md#uint32).

### static func fromUtf8Unchecked(Array\<UInt8>)

```cangjie
public unsafe static func fromUtf8Unchecked(utf8Data: Array<UInt8>): String
```

Functionality: Constructs a string from a byte array.

Unlike the `fromUtf8` function, this does not perform UTF-8 rule checks on the byte array, so the constructed string is not guaranteed to be valid and may result in unexpected exceptions. Unless performance is a critical concern, prefer using the safer `fromUtf8` function.

Parameters:

- utf8Data: [Array](core_package_structs.md#struct-arrayt)\<[UInt8](core_package_intrinsics.md#uint8)> - The byte array used to construct the string.

Return Value:

- [String](core_package_structs.md#struct-string) - The constructed string.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown when attempting to construct a string whose length exceeds [the maximum value of UInt32](./core_package_intrinsics.md#uint32).

### static func join(Array\<String>, String)

```cangjie
public static func join(strArray: Array<String>, delimiter!: String = String.empty): String
```

Functionality: Concatenates all strings in the string array, separated by the specified delimiter.

Parameters:

- strArray: [Array](core_package_structs.md#struct-arrayt)\<[String](core_package_structs.md#struct-string)> - The string array to be concatenated. Returns an empty string if the array is empty.
- delimiter!: [String](core_package_structs.md#struct-string) - The intermediate string used for concatenation, with a default value of [String](core_package_structs.md#struct-string).empty.

Return Value:

- [String](core_package_structs.md#struct-string) - The newly concatenated string.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown when attempting to construct a string whose length exceeds [the maximum value of UInt32](./core_package_intrinsics.md#uint32).

Example:

<!-- verify -->
```cangjie
main() {
    var arr = ["I", "like", "Cangjie"]
    var str = String.join(arr, delimiter: " ")
    println(str)
}
```

Output:

```text
I like Cangjie
```

### func clone()

```cangjie
public func clone(): String
```

Functionality: Returns a copy of the original string.

Return Value:

- [String](core_package_structs.md#struct-string) - The newly copied string.

### func compare(String)

```cangjie
public func compare(str: String): Ordering
```

Functionality: Compares the current string with the specified string lexicographically.

Parameters:

- str: [String](core_package_structs.md#struct-string) - The string to be compared.

Return Value:

- [Ordering](core_package_enums.md#enum-ordering) - Returns an enum value [Ordering](core_package_enums.md#enum-ordering) indicating the result. [Ordering](core_package_enums.md#enum-ordering).GT means the current string is lexicographically greater than `str`, [Ordering](core_package_enums.md#enum-ordering).LT means the current string is lexicographically less than `str`, and [Ordering](core_package_enums.md#enum-ordering).EQ means the two strings are lexicographically equal.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown if invalid UTF-8 encoding exists in the raw data of either string.

### func contains(String)

```cangjie
public func contains(str: String): Bool
```

Functionality: Determines whether the original string contains the string `str`.

Parameters:

- str: [String](core_package_structs.md#struct-string) - The string to search for.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns `true` if `str` is found in the original string, otherwise `false`. Specifically, returns `true` if `str` is an empty string.

### func count(String)

```cangjie
public func count(str: String): Int64
```

Functionality: Returns the number of occurrences of the substring `str` in the original string.

Parameters:

- str: [String](core_package_structs.md#struct-string) - The substring to search for.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The number of occurrences. Returns the number of Runes in the original string plus one if `str` is an empty string.

### func endsWith(String)

```cangjie
public func endsWith(suffix: String): Bool
```

Functionality: Determines whether the original string ends with the suffix `suffix`.

Parameters:

- suffix: [String](core_package_structs.md#struct-string) - The suffix string to check.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns `true` if `suffix` is a suffix of the original string, otherwise `false`. Specifically, returns `true` if `suffix` is an empty string.

### func equalsIgnoreAsciiCase(String): Bool

```cangjie
public func equalsIgnoreAsciiCase(that: String): Bool
```

Functionality: Determines whether the current string is equal to the specified string, ignoring case.

Parameters:

- that: [String](./core_package_structs.md#struct-string) - The string to compare.

Return Value:

- [Bool](./core_package_intrinsics.md#bool) - Returns `true` if the current string is equal to the specified string, otherwise `false`.

### func get(Int64)

```cangjie
public func get(index: Int64): Option<Byte>
```

Functionality: Returns the UTF-8 encoded byte value at the specified index in the string.

Parameters:

- index: [Int64](core_package_intrinsics.md#int64) - The index of the byte value to retrieve.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<[Byte](core_package_types.md#type-byte)> - The UTF-8 encoded byte value at the specified index. Returns [Option](core_package_enums.md#enum-optiont)\<[Byte](core_package_types.md#type-byte)>.None if `index` is less than 0 or greater than or equal to the string length.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Functionality: Gets the hash code of the string.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash code of the string.

### func indexOf(Byte)

```cangjie
public func indexOf(b: Byte): Option<Int64>
```

Functionality: Gets the index of the first occurrence of the specified byte `b` in the original string.

Parameters:

- b: [Byte](core_package_types.md#type-byte) - The byte to search for.

Return Value:- [Option](core_package_enums.md#enum-optiont)\<[Int64](core_package_intrinsics.md#int64)> - If the original string contains the specified byte, returns the index of its first occurrence; if the original string does not contain this byte, returns [Option](core_package_enums.md#enum-optiont)\<[Int64](core_package_intrinsics.md#int64)>.None.

### func indexOf(Byte, Int64)

```cangjie
public func indexOf(b: Byte, fromIndex: Int64): Option<Int64>
```

Function: Searches from the specified index of the original string to get the index of the first occurrence of the specified byte within the original string.

Parameters:

- b: [Byte](core_package_types.md#type-byte) - The byte to search for.
- fromIndex: [Int64](core_package_intrinsics.md#int64) - The index from which to start the search.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<[Int64](core_package_intrinsics.md#int64)> - If the search is successful, returns the index of the first occurrence of the specified byte; otherwise, returns `None`. Specifically, if fromIndex is less than zero, it is treated as 0; if fromIndex is greater than or equal to the length of the original string, returns [Option](core_package_enums.md#enum-optiont)\<[Int64](core_package_intrinsics.md#int64)>.None.

### func indexOf(String)

```cangjie
public func indexOf(str: String): Option<Int64>
```

Function: Returns the starting index of the first occurrence of the specified string str within the original string.

Parameters:

- str: [String](core_package_structs.md#struct-string) - The string to search for.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<[Int64](core_package_intrinsics.md#int64)> - If the original string contains the str string, returns the index of its first occurrence; if the original string does not contain the str string, returns None.

### func indexOf(String, Int64)

```cangjie
public func indexOf(str: String, fromIndex: Int64): Option<Int64>
```

Function: Searches from the specified index fromIndex of the original string to get the starting index of the first occurrence of the specified string str within the original string.

Parameters:

- str: [String](core_package_structs.md#struct-string) - The string to search for.
- fromIndex: [Int64](core_package_intrinsics.md#int64) - The index from which to start the search.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<[Int64](core_package_intrinsics.md#int64)> - If the search is successful, returns the index of the first occurrence of str; otherwise, returns None. Specifically, if str is an empty string and fromIndex is greater than 0, returns None; otherwise, returns Some(0). If fromIndex is less than zero, it is treated as 0; if fromIndex is greater than or equal to the length of the original string, returns None.

### func isAscii()

```cangjie
public func isAscii(): Bool
```

Function: Determines whether the string is an ASCII string. Returns true if the string is empty or contains no characters outside the ASCII range.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if it is an ASCII string; otherwise, returns false.

### func isAsciiBlank()

```cangjie
public func isAsciiBlank(): Bool
```

Function: Determines whether the string is empty or all Runes in the string are ASCII whitespace characters (including: 0x09, 0x10, 0x11, 0x12, 0x13, 0x20).

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if it meets the condition; otherwise, returns false.

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Determines whether the original string is an empty string.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if it is empty; otherwise, returns false.

### func iterator()

```cangjie
public func iterator(): Iterator<Byte>
```

Function: Gets a UTF-8 encoded byte iterator for the string, which can be used to support for-in loops.

Return Value:

- [Iterator](core_package_classes.md#class-iteratort)\<[Byte](core_package_types.md#type-byte)> - A UTF-8 encoded byte iterator for the string.

Example:

<!-- verify -->
```cangjie
main() {
    var str = "abc"

    /* The iterator elements are the UTF-8 encodings of each character */
    for (i in str) {
        println(i)
    }
}
```

Execution Result:

```text
97
98
99
```

### func lastIndexOf(Byte)

```cangjie
public func lastIndexOf(b: Byte): Option<Int64>
```

Function: Returns the index of the last occurrence of the specified byte b within the original string.

Parameters:

- b: [Byte](core_package_types.md#type-byte) - The byte to search for.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<[Int64](core_package_intrinsics.md#int64)> - If the original string contains this byte, returns the index of its last occurrence; otherwise, returns `None`.

### func lastIndexOf(Byte, Int64)

```cangjie
public func lastIndexOf(b: Byte, fromIndex: Int64): Option<Int64>
```

Function: Searches from the specified index fromIndex of the original string to get the index of the last occurrence of the specified UTF-8 encoded byte b within the original string.

Parameters:

- b: [Byte](core_package_types.md#type-byte) - The byte to search for.
- fromIndex: [Int64](core_package_intrinsics.md#int64) - The index from which to start the search.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<[Int64](core_package_intrinsics.md#int64)> - If the search is successful, returns the index of the last occurrence of the specified byte; otherwise, returns `None`. Specifically, if fromIndex is less than zero, it is treated as 0; if fromIndex is greater than or equal to the length of the original string, returns `None`.

### func lastIndexOf(String)

```cangjie
public func lastIndexOf(str: String): Option<Int64>
```

Function: Returns the starting index of the last occurrence of the specified string str within the original string.

Parameters:

- str: [String](core_package_structs.md#struct-string) - The string to search for.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<[Int64](core_package_intrinsics.md#int64)> - If the original string contains the str string, returns the index of its last occurrence; otherwise, returns `None`.

### func lastIndexOf(String, Int64)

```cangjie
public func lastIndexOf(str: String, fromIndex: Int64): Option<Int64>
```

Function: Searches from the specified index fromIndex of the original string to get the starting index of the last occurrence of the specified string str within the original string.

Parameters:

- str: [String](core_package_structs.md#struct-string) - The string to search for.
- fromIndex: [Int64](core_package_intrinsics.md#int64) - The index from which to start the search.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<[Int64](core_package_intrinsics.md#int64)> - If the string does not appear at or after the position fromIndex, returns `None`. Specifically, if str is an empty string and fromIndex is greater than 0, returns `None`; otherwise, returns `Some(0)`. If fromIndex is less than zero, it is treated as 0; if fromIndex is greater than or equal to the length of the original string, returns `None`.

### func lazySplit(String, Bool)

```cangjie
public func lazySplit(str: String, removeEmpty!: Bool = false): Iterator<String>
```

Function: Splits the original string using the string str as a delimiter. This function does not immediately split the string but returns an iterator that performs the split operation during traversal.

If str does not appear in the original string, returns a string iterator of size 1, with the only element being the original string.

Parameters:

- str: [String](core_package_structs.md#struct-string) - The string delimiter.
- removeEmpty!: [Bool](core_package_intrinsics.md#bool) - Removes empty strings from the split result. Default value is false.

Return Value:

- [Iterator](core_package_classes.md#class-iteratort)\<[String](core_package_structs.md#struct-string)> - An iterator of the split strings.

Example:

<!-- verify -->
```cangjie
main() {
    var str = "I like Cangjie"
    var iter = str.lazySplit(" ")
    while (true) {
        match (iter.next()) {
            case Some(i) => println(i)
            case None => break
        }
    }
}
```

Execution Result:

```text
I
like
Cangjie
```

### func lazySplit(String, Int64, Bool)

```cangjie
public func lazySplit(str: String, maxSplits: Int64, removeEmpty!: Bool = false): Iterator<String>
```

Function: Splits the original string using the string str as a delimiter. This function does not immediately split the string but returns an iterator that performs the split operation during traversal.

- If maxSplit is 0, returns an empty string iterator.
- If maxSplit is 1, returns a string iterator of size 1, with the only element being the original string.
- If maxSplit is negative, directly returns the iterator of the split strings.
- If maxSplit is greater than the number of substrings resulting from a complete split, returns the iterator of the complete split.
- If str does not appear in the original string, returns a string iterator of size 1, with the only element being the original string.
- If str is empty, splits the string by each character. If both the original string and the delimiter are empty, returns an empty string iterator.

Parameters:

- str: [String](core_package_structs.md#struct-string) - The string delimiter.
- maxSplits: [Int64](core_package_intrinsics.md#int64) - The maximum number of substrings to split into.
- removeEmpty!: [Bool](core_package_intrinsics.md#bool) - Removes empty strings from the split result. Default value is false.

Return Value:

- [Iterator](core_package_classes.md#class-iteratort)\<[String](core_package_structs.md#struct-string)> - An iterator of the split strings.

### func lines()

```cangjie
public func lines(): Iterator<String>
```

Function: Gets a line iterator for the string, where each line is separated by a line break character (one of `\n`, `\r`, or `\r\n`). The result does not include the line break characters.

Return Value:

- [Iterator](core_package_classes.md#class-iteratort)\<[String](core_package_structs.md#struct-string)> - A line iterator for the string.

Example:

<!-- verify -->
```cangjie
main() {
    var str = "I\rlike\nCangjie\r"
    var iter = str.lines()
    while (true) {
        match (iter.next()) {
            case Some(i) => println(i)
            case None => break
        }
    }
}
```

Execution Result:

```text
I
like
Cangjie
```

### func padEnd(Int64, String)

```cangjie
public func padEnd(totalWidth: Int64, padding!: String = " "): String
```

Function: Left-aligns the original string to the specified length. If the original string's length is less than the specified length, appends the specified string to its right.When the specified length is less than the string length, the string itself is returned without truncation; when the specified length is greater than the string length, the padding string is added to the right. If the padding length is greater than 1, the returned string length may exceed the specified length.

Parameters:

- totalWidth: [Int64](core_package_intrinsics.md#int64) - The specified aligned string length, must be greater than or equal to 0.
- padding!: [String](core_package_structs.md#struct-string) - When the length is insufficient, the specified padding string is added to the right.

Return Value:

- [String](core_package_structs.md#struct-string) - The padded string.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown if totalWidth is less than 0.

### func padStart(Int64, String)

```cangjie
public func padStart(totalWidth: Int64, padding!: String = " "): String
```

Function: Right-aligns the original string to the specified length. If the original string length is less than the specified length, the specified string is added to the left.

When the specified length is less than the string length, the string itself is returned without truncation; when the specified length is greater than the string length, the padding string is added to the left. If the padding length is greater than 1, the returned string length may exceed the specified length.

Parameters:

- totalWidth: [Int64](core_package_intrinsics.md#int64) - The specified aligned string length, must be greater than or equal to 0.
- padding!: [String](core_package_structs.md#struct-string) - When the length is insufficient, the specified padding string is added to the left.

Return Value:

- [String](core_package_structs.md#struct-string) - The padded string.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown if totalWidth is less than 0.

### func rawData()

```cangjie
public unsafe func rawData(): Array<Byte>
```

Function: Retrieves the raw byte array of the string encoded in UTF-8.

> **Note:**
>
> Users should not modify the obtained array, as this would violate the string's immutability.

Return Value:

- [Array](core_package_structs.md#struct-arrayt)\<[Byte](core_package_types.md#type-byte)> - The raw byte array corresponding to the current string.

### func removePrefix(String)

```cangjie
public func removePrefix(prefix: String): String
```

Function: Removes the specified prefix from the string.

Parameters:

- prefix: [String](core_package_structs.md#struct-string) - The prefix to be removed.

Return Value:

- [String](core_package_structs.md#struct-string) - The new string after removing the prefix.

### func removeSuffix(String)

```cangjie
public func removeSuffix(suffix: String): String
```

Function: Removes the specified suffix from the string.

Parameters:

- suffix: [String](core_package_structs.md#struct-string) - The suffix to be removed.

Return Value:

- [String](core_package_structs.md#struct-string) - The new string after removing the suffix.

### func replace(String, String)

```cangjie
public func replace(old: String, new: String): String
```

Function: Replaces occurrences of the old string with the new string in the original string.

Parameters:

- old: [String](core_package_structs.md#struct-string) - The old string.
- new: [String](core_package_structs.md#struct-string) - The new string.

Return Value:

- [String](core_package_structs.md#struct-string) - The new string after replacement.

Exceptions:

- [OutOfMemoryError](core_package_exceptions.md#class-outofmemoryerror) - Thrown if memory allocation fails during execution.

### func runes()

```cangjie
public func runes(): Iterator<Rune>
```

Function: Retrieves an iterator for the string's Runes.

Return Value:

- [Iterator](core_package_classes.md#class-iteratort)\<Rune> - The Rune iterator for the string.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown if an illegal character is encountered during iteration using `for-in` or `next()`.

### func split(String, Bool)

```cangjie
public func split(str: String, removeEmpty!: Bool = false): Array<String>
```

Function: Splits the original string using the specified delimiter string, with an option to remove empty strings.

If the delimiter string does not appear in the original string, a single-element array containing the original string is returned.

Parameters:

- str: [String](core_package_structs.md#struct-string) - The delimiter string.
- removeEmpty!: [Bool](core_package_intrinsics.md#bool) - Whether to remove empty strings from the result, default is false.

Return Value:

- [Array](core_package_structs.md#struct-arrayt)\<[String](core_package_structs.md#struct-string)> - The array of split strings.

### func split(String, Int64, Bool)

```cangjie
public func split(str: String, maxSplits: Int64, removeEmpty!: Bool = false): Array<String>
```

Function: Splits the original string using the specified delimiter string, with a maximum number of splits and an option to remove empty strings.

- If maxSplits is 0, returns an empty string array.
- If maxSplits is 1, returns a single-element array containing the original string.
- If maxSplits is negative, returns the fully split string array.
- If maxSplits exceeds the number of possible splits, returns the fully split string array.
- If the delimiter string does not appear in the original string, returns a single-element array containing the original string.
- If the delimiter string is empty, splits the string into individual characters. If both the original string and delimiter are empty, returns an empty string array.

Parameters:

- str: [String](core_package_structs.md#struct-string) - The delimiter string.
- maxSplits: [Int64](core_package_intrinsics.md#int64) - The maximum number of splits.
- removeEmpty!: [Bool](core_package_intrinsics.md#bool) - Whether to remove empty strings from the result, default is false.

Return Value:

- [Array](core_package_structs.md#struct-arrayt)\<[String](core_package_structs.md#struct-string)> - The array of split strings.

### func startsWith(String)

```cangjie
public func startsWith(prefix: String): Bool
```

Function: Determines whether the original string starts with the specified prefix.

Parameters:

- prefix: [String](core_package_structs.md#struct-string) - The prefix string to check.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the string starts with the prefix, otherwise false. If the prefix string length is 0, returns true.

### func toArray()

```cangjie
public func toArray(): Array<Byte>
```

Function: Retrieves the byte array of the string encoded in UTF-8.

Return Value:

- [Array](core_package_structs.md#struct-arrayt)\<[Byte](core_package_types.md#type-byte)> - The UTF-8 encoded byte array of the string.

### func toAsciiLower()

```cangjie
public func toAsciiLower(): String
```

Function: Converts all ASCII uppercase letters in the string to lowercase.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted new string.

### func toAsciiTitle()

```cangjie
public func toAsciiTitle(): String
```

Function: Converts the string to title case.

This function only converts ASCII English characters. If an English character is the first character of the string or the preceding character is not an English character, it is converted to uppercase; other English characters are converted to lowercase.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted new string.

### func toAsciiUpper()

```cangjie
public func toAsciiUpper(): String
```

Function: Converts all ASCII lowercase letters in the string to uppercase.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted new string.

### func toRuneArray()

```cangjie
public func toRuneArray(): Array<Rune>
```

Function: Retrieves the Rune array of the string. If the original string is empty, returns an empty array.

Return Value:

- [Array](core_package_structs.md#struct-arrayt)\<Rune> - The Rune array of the string.

### func toString()

```cangjie
public func toString(): String
```

Function: Returns the string itself.

Return Value:

- [String](core_package_structs.md#struct-string) - The string itself.

### func trimAscii()

```cangjie
public func trimAscii(): String
```

Function: Removes leading and trailing substrings composed of ASCII whitespace characters from the original string.

ASCII whitespace characters include characters with ASCII codes in the range [0x09, 0x0D] and the character with ASCII code 0x20. Specific characters are listed below.

| Character Description | ASCII Code |
| --- | --- |
| Horizontal Tab (\t, HT) | 0x09 |
| Line Feed (\n, LF) | 0x0A |
| Vertical Tab (\v, VT) | 0x0B |
| Form Feed (\f, FF) | 0x0C |
| Carriage Return (\r, CR) | 0x0D |
| Space (Space) | 0x20 |

Return Value:

- [String](core_package_structs.md#struct-string) - The converted new string.

### func trimAsciiEnd()

```cangjie
public func trimAsciiEnd(): String
```

Function: Removes trailing substrings composed of ASCII whitespace characters from the original string.

ASCII whitespace characters include characters with ASCII codes in the range [0x09, 0x0D] and the character with ASCII code 0x20. Specific characters are listed in [trimAscii()](#func-trimascii).

Return Value:

- [String](core_package_structs.md#struct-string) - The converted new string.

### func trimAsciiStart()

```cangjie
public func trimAsciiStart(): String
```

Function: Removes the leading substring composed of ASCII whitespace characters from the original string.

ASCII whitespace characters include those with ASCII codes in the range [0x09, 0x0D] and the character with ASCII code 0x20. For specific characters, see [trimAscii()](#func-trimascii).

Return Value:

- [String](core_package_structs.md#struct-string) - The new string after conversion.

### func trimEnd((Rune)->Bool)

```cangjie
public func trimEnd(predicate: (Rune)->Bool): String
```

Function: Trims the current string by removing [Rune](./core_package_intrinsics.md#rune) characters from the end that meet the filter condition until the first [Rune](./core_package_intrinsics.md#rune) character that does not meet the condition is encountered.

Parameters:

- predicate: ([Rune](./core_package_intrinsics.md#rune))->[Bool](./core_package_intrinsics.md#bool) - The filter condition.

Return Value:

- [String](./core_package_structs.md#struct-string) - The new string after trimming.

Example:

<!-- verify -->
```cangjie
main() {
    var str = "14122"
    var subStr = str.trimEnd({c => c == r'2'})
    println(subStr)
}
```

Execution Result:

```text
141
```

### func trimEnd(Array\<Rune>)

```cangjie
public func trimEnd(set: Array<Rune>): String
```

Function: Trims the current string by removing [Rune](./core_package_intrinsics.md#rune) characters from the end that are in the set until the first [Rune](./core_package_intrinsics.md#rune) character not in the set is encountered.

Parameters:

- set: [Array](./core_package_structs.md#struct-arrayt)\<[Rune](./core_package_intrinsics.md#rune)> - The set of characters to be removed.

Return Value:

- [String](./core_package_structs.md#struct-string) - The new string after trimming.

Example:

<!-- verify -->
```cangjie
main() {
    var str = "14122"
    var subStr = str.trimEnd([r'1', r'2'])
    println(subStr)
}
```

Execution Result:

```text
14
```

### func trimEnd(String)

```cangjie
public func trimEnd(set: String): String
```

Function: Trims the current string by removing [Rune](./core_package_intrinsics.md#rune) characters from the end that are in the set until the first [Rune](./core_package_intrinsics.md#rune) character not in the set is encountered.

Parameters:

- set: [String](./core_package_structs.md#struct-string) - The set of characters to be removed.

Return Value:

- [String](./core_package_structs.md#struct-string) - The new string after trimming.

Example:

<!-- verify -->
```cangjie
main() {
    var str = "14122"
    var subStr = str.trimEnd("12")
    println(subStr)
}
```

Execution Result:

```text
14
```

### func trimStart((Rune)->Bool)

```cangjie
public func trimStart(predicate: (Rune)->Bool): String
```

Function: Trims the current string by removing [Rune](./core_package_intrinsics.md#rune) characters from the start that meet the filter condition until the first [Rune](./core_package_intrinsics.md#rune) character that does not meet the condition is encountered.

Parameters:

- predicate: ([Rune](./core_package_intrinsics.md#rune))->[Bool](./core_package_intrinsics.md#bool) - The filter condition.

Return Value:

- [String](./core_package_structs.md#struct-string) - The new string after trimming.

### func trimStart(Array\<Rune>)

```cangjie
public func trimStart(set: Array<Rune>): String
```

Function: Trims the current string by removing [Rune](./core_package_intrinsics.md#rune) characters from the start that are in the set until the first [Rune](./core_package_intrinsics.md#rune) character not in the set is encountered.

For example, "12241".trimStart([r'1', r'2']) = "41".

Parameters:

- set: [Array](./core_package_structs.md#struct-arrayt)\<[Rune](./core_package_intrinsics.md#rune)> - The set of characters to be removed.

Return Value:

- [String](./core_package_structs.md#struct-string) - The new string after trimming.

### func trimStart(String)

```cangjie
public func trimStart(set: String): String
```

Function: Trims the current string by removing [Rune](./core_package_intrinsics.md#rune) characters from the start that are in the set until the first [Rune](./core_package_intrinsics.md#rune) character not in the set is encountered.

For example, "12241".trimStart("12") = "41".

Parameters:

- set: [String](./core_package_structs.md#struct-string) - The set of characters to be removed.

Return Value:

- [String](./core_package_structs.md#struct-string) - The new string after trimming.

### operator func !=(String)

```cangjie
public operator const func !=(right: String): Bool
```

Function: Determines whether two strings are not equal.

Parameters:

- right: [String](core_package_structs.md#struct-string) - The [String](core_package_structs.md#struct-string) instance to compare.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if not equal, false otherwise.

### operator func *(Int64)

```cangjie
public operator const func *(count: Int64): String
```

Function: Repeats the original string [count](../../collection/collection_package_api/collection_package_function.md#func-counttiterablet) times.

Parameters:

- count: [Int64](core_package_intrinsics.md#int64) - The number of times to repeat the original string.

Return Value:

- [String](core_package_structs.md#struct-string) - The new string after repeating [count](../../collection/collection_package_api/collection_package_function.md#func-counttiterablet) times.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when attempting to construct a string whose length exceeds the [maximum value of UInt32](./core_package_intrinsics.md#uint32).

### operator func +(String)

```cangjie
public operator const func +(right: String): String
```

Function: Concatenates two strings by appending the right string to the end of the original string.

Parameters:

- right: [String](core_package_structs.md#struct-string) - The string to append.

Return Value:

- [String](core_package_structs.md#struct-string) - The concatenated string.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when attempting to construct a string whose length exceeds the [maximum value of UInt32](./core_package_intrinsics.md#uint32).

### operator func <(String)

```cangjie
public operator const func <(right: String): Bool
```

Function: Compares the sizes of two strings.

Parameters:

- right: [String](core_package_structs.md#struct-string) - The string to compare.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the original string is lexicographically smaller than the right string, false otherwise.

### operator func <=(String)

```cangjie
public operator const func <=(right: String): Bool
```

Function: Compares the sizes of two strings.

Parameters:

- right: [String](core_package_structs.md#struct-string) - The string to compare.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the original string is lexicographically smaller than or equal to the right string, false otherwise.

### operator func ==(String)

```cangjie
public operator const func ==(right: String): Bool
```

Function: Determines whether two strings are equal.

Parameters:

- right: [String](core_package_structs.md#struct-string) - The string to compare.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if equal, false otherwise.

### operator func >(String)

```cangjie
public operator const func >(right: String): Bool
```

Function: Compares the sizes of two strings.

Parameters:

- right: [String](core_package_structs.md#struct-string) - The string to compare.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the original string is lexicographically larger than the right string, false otherwise.

### operator func >=(String)

```cangjie
public operator const func >=(right: String): Bool
```

Function: Compares the sizes of two strings.

Parameters:

- right: [String](core_package_structs.md#struct-string) - The string to compare.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the original string is lexicographically larger than or equal to the right string, false otherwise.

### operator func \[](Int64)

```cangjie
public operator const func [](index: Int64): Byte
```

Function: Returns the UTF-8 encoded byte at the specified index.

Parameters:

- index: [Int64](core_package_intrinsics.md#int64) - The index to retrieve the UTF-8 encoded byte.

Return Value:

- [Byte](core_package_types.md#type-byte) - The UTF-8 encoded byte corresponding to the specified index.

Exceptions:

- [IndexOutOfBoundsException](core_package_exceptions.md#class-indexoutofboundsexception) - Thrown if the index is less than 0 or greater than or equal to the string length.

### operator func \[](Range\<Int64>)

```cangjie
public operator const func [](range: Range<Int64>): String
```

Function: Retrieves a slice of the current string based on the given range.

> **Note:**
>
> 1. If the parameter `range` is constructed using the [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) constructor, the behavior is as follows:
>    - The value of `start` is exactly the value passed to the constructor, unaffected by the `hasStart` parameter during construction.
>    - When `hasEnd` is false, the `end` value is ignored (unaffected by the `isClosed` parameter during construction), and the string slice extends to the last element of the original string.
> 2. The step size of `range` must be 1.

Parameters:

- range: [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<[Int64](core_package_intrinsics.md#int64)> - The range for slicing.

Return Value:

- [String](core_package_structs.md#struct-string) - The string slice.

Exceptions:

- [IndexOutOfBoundsException](core_package_exceptions.md#class-indexoutofboundsexception) - Thrown if the slice range exceeds the boundaries of the original string.
- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown if `range.[step](#let-step)` is not equal to 1 or if the range endpoints are not character boundaries.
