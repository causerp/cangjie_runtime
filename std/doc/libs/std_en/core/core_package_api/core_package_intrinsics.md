# Built-in Types

## Bool

Function: Represents the boolean type, with two possible values: `true` and `false`.

### extend Bool <: Equatable\<Bool>

```cangjie
extend Bool <: Equatable<Bool>
```

Function: Extends the [Bool](core_package_intrinsics.md#bool) type with the [Equatable](core_package_interfaces.md#interface-equatablet)\<[Bool](core_package_intrinsics.md#bool)> interface to support equality comparison.

Parent Types:

- [Equatable](core_package_interfaces.md#interface-equatablet)\<[Bool](#bool)>

### extend Bool <: Hashable

```cangjie
extend Bool <: Hashable
```

Function: Extends the [Bool](core_package_intrinsics.md#bool) type with the [Hashable](core_package_interfaces.md#interface-hashable) interface to support hash value computation.

Parent Types:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash value.

Example:

<!-- verify -->
```cangjie
main() {
    var flag: Bool = false
    println(flag.hashCode())
    flag = true
    println(flag.hashCode())
}
```

Execution Result:

```text
0
1
```

### extend Bool <: ToString

```cangjie
extend Bool <: ToString
```

Function: Extends the [Bool](core_package_intrinsics.md#bool) type with the [ToString](core_package_interfaces.md#interface-tostring) interface to enable conversion to [String](core_package_structs.md#struct-string) type.

Parent Types:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts a [Bool](core_package_intrinsics.md#bool) value to an output-ready string.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

Example:

<!-- verify -->
```cangjie
main() {
    var flag: Bool = false
    let str1: String = flag.toString()
    println(str1)
    flag = true
    let str2: String = flag.toString()
    println(str2)
}
```

Execution Result:

```text
false
true
```

## CPointer\<T>

Function: Represents a pointer to an instance of type `T`, used in scenarios involving interoperability with C, corresponding to `T*` in C.

Here, `T` must satisfy the [CType](core_package_interfaces.md#interface-ctype) constraint.

The [CPointer](core_package_intrinsics.md#cpointert)\<T> type must satisfy:

- Size and alignment are platform-dependent.
- Arithmetic operations (addition/subtraction) and memory read/write operations require an `unsafe` context.
- [CPointer](core_package_intrinsics.md#cpointert)\<T1> can be type-cast to [CPointer](core_package_intrinsics.md#cpointert)\<T2> in an `unsafe` context.

### extend\<T> CPointer\<T>

```cangjie
extend<T> CPointer<T>
```

Function: Extends the [CPointer](core_package_intrinsics.md#cpointert)\<T> type with essential pointer-related interfaces, including null checks and data read/write operations.

Here, the generic type `T` is the pointer type, which must satisfy the [CType](core_package_interfaces.md#interface-ctype) constraint. Operations on [CPointer](core_package_intrinsics.md#cpointert) require an `unsafe` context.

#### func asResource()

```cangjie
public func asResource(): CPointerResource<T>
```

Function: Retrieves the [CPointerResource](core_package_structs.md#struct-cpointerresourcet-where-t--ctype) instance for this pointer, which enables automatic resource release in a `try-with-resource` syntax context.

Return Value:

- [CPointerResource](core_package_structs.md#struct-cpointerresourcet-where-t--ctype)\<T> - The corresponding [CPointerResource](core_package_structs.md#struct-cpointerresourcet-where-t--ctype) instance for the current pointer.

Example:

<!-- verify -->
```cangjie
foreign func malloc(size: UIntNative): CPointer<Unit>

main() {
    let sizeofInt64: UIntNative = 8
    var p1 = unsafe { malloc(sizeofInt64) }
    var ptr = unsafe { CPointer<Int64>(p1) }
    unsafe { ptr.write(10) }
    var ptrResource: CPointerResource<Int64> = ptr.asResource()
    try (r = ptrResource) {
        var p = r.value
        let num: Int64 = unsafe { p.read() }
        println(num)
    }
    println(ptrResource.isClosed())
}
```

Execution Result:

```text
10
true
```

#### func isNotNull()

```cangjie
public func isNotNull(): Bool
```

Function: Checks whether the pointer is not null.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns `true` if not null, otherwise `false`.

Example:

<!-- verify -->
```cangjie
foreign func malloc(size: UIntNative): CPointer<Unit>

foreign func free(ptr: CPointer<Unit>): Unit

main() {
    let p1 = CPointer<Int64>()
    println(p1.isNotNull())
    let sizeofInt64: UIntNative = 8
    var p2 = unsafe { malloc(sizeofInt64) }
    println(p2.isNotNull())
    unsafe { free(p2) }
}
```

Execution Result:

```text
false
true
```

#### func isNull()

```cangjie
public func isNull(): Bool
```

Function: Checks whether the pointer is null.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns `true` if null, otherwise `false`.

Example:

<!-- verify -->
```cangjie
foreign func malloc(size: UIntNative): CPointer<Unit>

foreign func free(ptr: CPointer<Unit>): Unit

main() {
    let sizeofInt64: UIntNative = 8
    var p1 = unsafe { malloc(sizeofInt64) }
    var ptr = unsafe { CPointer<Int64>(p1) }
    unsafe { ptr.write(10) }
    let num: Int64 = unsafe { ptr.read() }
    println(num)
    unsafe { free(p1) }
}
```

Execution Result:

```text
10
```

#### func read()

```cangjie
public unsafe func read(): T
```

Function: Reads the first data element. The caller must ensure pointer validity; otherwise, undefined behavior occurs.

Return Value:

- T - The first data element of the object type.

Example:

<!-- verify -->
```cangjie
foreign func malloc(size: UIntNative): CPointer<Unit>

foreign func free(ptr: CPointer<Unit>): Unit

main() {
    let p1 = CPointer<Int64>()
    println(p1.isNull())
    let sizeofInt64: UIntNative = 8
    var p2 = unsafe { malloc(sizeofInt64) }
    println(p2.isNull())
    unsafe { free(p2) }
}
```

Execution Result:

```text
true
false
```

#### func read(Int64)

```cangjie
public unsafe func read(idx: Int64): T
```

Function: Reads data at the specified index. The caller must ensure pointer validity; otherwise, undefined behavior occurs.

Parameters:

- idx: [Int64](core_package_intrinsics.md#int64) - The index of the data to retrieve.

Return Value:

- T - The data corresponding to the input index.

Example:

<!-- verify -->
```cangjie
main() {
    var arr: Array<Int64> = [1, 2, 3, 4]
    var cptrHandle: CPointerHandle<Int64> = unsafe { acquireArrayRawData(arr) }
    var cptr: CPointer<Int64> = cptrHandle.pointer

    let num: Int64 = unsafe { cptr.read(2) }
    println("The third element of the array is ${num} ")

    unsafe { releaseArrayRawData<Int64>(cptrHandle) }
}
```

Execution result:

```text
The third element of the array is 3
```

#### func toUIntNative()

```cangjie
public func toUIntNative(): UIntNative
```

Function: Gets the integer form of this pointer.

Return value:

- [UIntNative](core_package_intrinsics.md#uintnative) - The integer form of this pointer.

Example:

<!-- run -->
```cangjie
foreign func malloc(size: UIntNative): CPointer<Unit>

foreign func free(ptr: CPointer<Unit>): Unit

main() {
    let sizeofInt64: UIntNative = 8
    var p = unsafe { malloc(sizeofInt64) }
    var p1 = unsafe { CPointer<Int64>(p) }
    unsafe { p1.write(8) }
    println(p1.toUIntNative())
    unsafe { free(p) }
}
```

Execution result:

```text
93954490863648
```

#### func write(Int64, T)

```cangjie
public unsafe func write(idx: Int64, value: T): Unit
```

Function: Writes data at the specified index position. This interface requires the user to ensure pointer validity; otherwise, undefined behavior occurs.

Parameters:

- idx: [Int64](core_package_intrinsics.md#int64) - The specified index position.
- value: T - The data to be written.

Example:

<!-- verify -->
```cangjie
main() {
    var arr: Array<Int64> = [1, 2, 3, 4]
    var cptrHandle: CPointerHandle<Int64> = unsafe { acquireArrayRawData(arr) }

    var cptr: CPointer<Int64> = cptrHandle.pointer

    unsafe { cptr.write(2, 6) }

    println("The third element of the array is ${arr[2]} ")
    // The first element of the array is 1
    unsafe { releaseArrayRawData<Int64>(cptrHandle) }
}
```

Execution result:

```text
The third element of the array is 6
```

#### func write(T)

```cangjie
public unsafe func write(value: T): Unit
```

Function: Writes data, always at the first position. This interface requires the user to ensure pointer validity; otherwise, undefined behavior occurs.

Parameters:

- value: T - The data to be written.

Example:

<!-- verify -->
```cangjie
foreign func malloc(size: UIntNative): CPointer<Unit>

foreign func free(ptr: CPointer<Unit>): Unit

main() {
    let sizeofInt64: UIntNative = 8
    var p = unsafe { malloc(sizeofInt64) }
    var p1 = unsafe { CPointer<Int64>(p) }
    unsafe { p1.write(8) }
    let value: Int64 = unsafe { p1.read() }
    println(value)
    unsafe { free(p) }
}
```

Execution result:

```text
8
```

#### operator func +(Int64)

```cangjie
public unsafe operator func +(offset: Int64): CPointer<T>
```

Function: Moves the [CPointer](core_package_intrinsics.md#cpointert) object pointer backward, equivalent to pointer addition in C language.

Parameters:

- offset: [Int64](core_package_intrinsics.md#int64) - The offset value.

Return value:

- [CPointer](core_package_intrinsics.md#cpointert)\<T> - The pointer after offset.

Example:

<!-- verify -->
```cangjie
main() {
    var arr: Array<Int64> = [1, 2, 3, 4]
    var cptrHandle: CPointerHandle<Int64> = unsafe { acquireArrayRawData(arr) }
    var cptr: CPointer<Int64> = cptrHandle.pointer

    let num1: Int64 = unsafe { cptr.read() }
    println(num1)
    cptr = unsafe { cptr + 1 }
    let num2: Int64 = unsafe { cptr.read() }
    println(num2)
    unsafe { releaseArrayRawData<Int64>(cptrHandle) }
}
```

Execution result:

```text
1
2
```

#### operator func -(Int64)

```cangjie
public unsafe operator func -(offset: Int64): CPointer<T>
```

Function: Moves the [CPointer](core_package_intrinsics.md#cpointert) object pointer forward, equivalent to pointer subtraction in C language.

Parameters:

- offset: [Int64](core_package_intrinsics.md#int64) - The offset value.

Return value:

- [CPointer](core_package_intrinsics.md#cpointert)\<T> - The pointer after offset.

Example:

<!-- verify -->
```cangjie
main() {
    var arr: Array<Int64> = [1, 2, 3, 4]
    var cptrHandle: CPointerHandle<Int64> = unsafe { acquireArrayRawData(arr) }
    var cptr: CPointer<Int64> = cptrHandle.pointer

    let num1: Int64 = unsafe { cptr.read() }
    println(num1)
    cptr = unsafe { cptr + 1 }
    let num2: Int64 = unsafe { cptr.read() }
    println(num2)
    cptr = unsafe { cptr - 1 }
    let num3: Int64 = unsafe { cptr.read() }
    println(num3)
    unsafe { releaseArrayRawData<Int64>(cptrHandle) }
}
```

Execution result:

```text
1
2
1
```

## CString

Function: Represents C-style strings, used in scenarios requiring interoperability with C language.

[CString](core_package_intrinsics.md#cstring) can be created via its constructor or [LibC](core_package_structs.md#struct-libc)'s `mallocCString`. To release it on the Cangjie side, call [LibC](core_package_structs.md#struct-libc)'s free method.

### extend CString <: ToString

```cangjie
extend CString <: ToString
```

Function: Extends common methods for string pointers to the [CString](core_package_intrinsics.md#cstring) type, including null checks, length retrieval, equality checks, substring extraction, etc.

Parent type:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func asResource()

```cangjie
public func asResource(): CStringResource
```

Function: Gets the [CStringResource](core_package_structs.md#struct-cstringresource) instance corresponding to the current [CString](core_package_intrinsics.md#cstring) instance.

[CStringResource](core_package_structs.md#struct-cstringresource) implements the [Resource](core_package_interfaces.md#interface-resource) interface, enabling automatic resource release in `try-with-resource` syntax contexts.

Return value:

- [CStringResource](core_package_structs.md#struct-cstringresource) - The corresponding [CStringResource](core_package_structs.md#struct-cstringresource) C-string resource type instance.

Example:

<!-- verify -->
```cangjie
foreign func malloc(size: UIntNative): CPointer<Unit>

main() {
    var str: CString = unsafe { LibC.mallocCString("hello") }
    var ptrResource: CStringResource = str.asResource()
    try (r = ptrResource) {
        var p = r.value
        println(p.size())
    }
    println(ptrResource.isClosed())
}
```

Execution result:

```text
5
true
```

#### func compare(CString)

```cangjie
public func compare(str: CString): Int32
```

Function: Compares two strings lexicographically, equivalent to `strcmp` in C language.

Parameters:

- str: [CString](core_package_intrinsics.md#cstring) - The target string to compare.

Return value:

- [Int32](core_package_intrinsics.md#int32) - Returns 0 if equal, -1 if the current string is smaller than parameter str, otherwise returns 1.

Exceptions:

- [IllegalMemoryException](core_package_exceptions.md#class-illegalmemoryexception) - Throws an exception if either of the compared [CString](core_package_intrinsics.md#cstring) pointers is null.

Example:

<!-- verify -->
```cangjie
main() {
    var str1: CString = unsafe { LibC.mallocCString("hello") }
    var str2: CString = unsafe { LibC.mallocCString("hello") }
    println(str1.compare(str2))

    var str3: CString = unsafe { LibC.mallocCString("hello") }
    var str4: CString = unsafe { LibC.mallocCString("hellow") }
    println(str3.compare(str4))

    var str5: CString = unsafe { LibC.mallocCString("hello") }
    var str6: CString = unsafe { LibC.mallocCString("allow") }
    println(str5.compare(str6))

    unsafe {
        LibC.free(str1)
        LibC.free(str2)
        LibC.free(str3)
        LibC.free(str4)
        LibC.free(str5)
        LibC.free(str6)
    }
}
```

Execution result:

```text
0
-1
1
```

#### func endsWith(CString)

```cangjie
public func endsWith(suffix: CString): Bool
```

Function: Determines whether the string contains the specified suffix.

Parameters:

- suffix: [CString](core_package_intrinsics.md#cstring) - The target suffix string to match.

Return value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the string contains the suffix, false otherwise. Specifically, returns false if either the original string or the suffix string pointer is null.

Example:

<!-- verify -->
```cangjie
main() {
    var str1: CString = unsafe { LibC.mallocCString("hello") }
    var str2: CString = unsafe { LibC.mallocCString("lo") }
    var str3: CString = unsafe { LibC.mallocCString("ao") }

    println(str1.endsWith(str2))
    println(str1.endsWith(str3))

    unsafe {
        LibC.free(str1)
        LibC.free(str2)
        LibC.free(str3)
    }
}
```

Execution result:

```text
true
false
```

#### func equals(CString)

```cangjie
public func equals(rhs: CString): Bool
```

Function: Determines whether two strings are equal.

Parameters:

- rhs: [CString](core_package_intrinsics.md#cstring) - The target string to compare.

Return value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the two strings are equal, false otherwise.

Example:

<!-- verify -->
```cangjie
main() {
    var str1: CString = unsafe { LibC.mallocCString("hello") }
    var str2: CString = unsafe { LibC.mallocCString("hello") }
    var str3: CString = unsafe { LibC.mallocCString("Hello") }
    println(str1.equals(str2))
    println(str1.equals(str3))

    unsafe {
        LibC.free(str1)
        LibC.free(str2)
        LibC.free(str3)
    }
}
```

Execution result:

```text
true
false
```

#### func equalsLower(CString)

```cangjie
public func equalsLower(rhs: CString): Bool
```

Function: Determines whether two strings are equal, ignoring case.

Parameters:

- rhs: [CString](core_package_intrinsics.md#cstring) - The target string to match.

Return value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the two strings are equal ignoring case, false otherwise.

Example:

<!-- verify -->
```cangjie
main() {
    var str1: CString = unsafe { LibC.mallocCString("hello") }
    var str2: CString = unsafe { LibC.mallocCString("HELLO") }
    var str3: CString = unsafe { LibC.mallocCString("Hello") }
    println(str1.equalsLower(str2))
    println(str1.equalsLower(str3))

    unsafe {
        LibC.free(str1)
        LibC.free(str2)
        LibC.free(str3)
    }
}
```

Execution result:

```text
true
true
```

#### func getChars()

```cangjie
public func getChars(): CPointer<UInt8>
```

Function: Gets the pointer to the string.

Return value:

- [CPointer](./core_package_intrinsics.md#cpointert)\<[UInt8](./core_package_intrinsics.md#uint8)> - The pointer to the string.

Example:

<!-- verify -->
```cangjie
main() {
    var str1: CString = unsafe { LibC.mallocCString("hello") }
    var ptr: CPointer<UInt8> = unsafe { str1.getChars() }
    var c: UInt8 = unsafe { ptr.read() }
    println(c) // ASCII code of 'h' is 104
    unsafe {
        LibC.free(str1)
    }
}
```

Execution result:

```text
104
```

#### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Determines whether the string is empty.

Return value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the string is empty or the string pointer is null, false otherwise.

Example:

<!-- verify -->
```cangjie
main() {
    var str1: CString = unsafe { LibC.mallocCString("hello") }
    println(str1.isEmpty())

    unsafe {
        LibC.free(str1)
    }
}
```

Execution result:

```text
false
```

#### func isNotEmpty()

```cangjie
public func isNotEmpty(): Bool
```

Function: Determines whether the string is not empty.

Return value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the string is not empty, false if the string pointer is null.

Example:

<!-- verify -->
```cangjie
main() {
    var str1: CString = unsafe { LibC.mallocCString("hello") }
    println(str1.isNotEmpty())

    unsafe {
        LibC.free(str1)
    }
}
```

Execution result:

```text
true
```

#### func isNull()

```cangjie
public func isNull(): Bool
```

Function: Determines whether the string pointer is null.

Return value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the string pointer is null, false otherwise.

Example:

<!-- verify -->
```cangjie
main() {
    var str1: CString = unsafe { LibC.mallocCString("hello") }
    println(str1.isNull())

    unsafe {
        LibC.free(str1)
    }
}
```

Execution result:

```text
false
```

#### func size()

```cangjie
public func size(): Int64
```

Function: Returns the length of the string, equivalent to C's `strlen`.

Return value:

- [Int64](core_package_intrinsics.md#int64) - The length of the string.

Example:

<!-- verify -->
```cangjie
main() {
    var str1: CString = unsafe { LibC.mallocCString("hello") }
    println(str1.size())
    unsafe {
        LibC.free(str1)
    }
}
```

Execution Result:

```text
5
```

#### func startsWith(CString)

```cangjie
public func startsWith(prefix: CString): Bool
```

Function: Determines whether the string contains the specified prefix.

Parameters:

- prefix: [CString](core_package_intrinsics.md#cstring) - The target prefix string to match.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the string contains the prefix, false otherwise. Specifically, returns false if either the original string or the prefix string pointer is null.

Example:

<!-- verify -->
```cangjie
main() {
    var str1: CString = unsafe { LibC.mallocCString("hello") }
    var str2: CString = unsafe { LibC.mallocCString("he") }
    println(str1.startsWith(str2))

    unsafe {
        LibC.free(str1)
        LibC.free(str2)
    }
}
```

Execution Result:

```text
true
```

#### func subCString(UIntNative)

```cangjie
public func subCString(beginIndex: UIntNative): CString
```

Function: Extracts a substring starting from the specified position to the end of the string.

> **Note:**
>
> 1. This interface returns a copy of the substring, which must be manually freed after use.
> 2. If beginIndex equals the string length, a null pointer will be returned.

Parameters:

- beginIndex: [UIntNative](core_package_intrinsics.md#uintnative) - The starting position for extraction, ranging from [0, this.size()].

Return Value:

- [CString](core_package_intrinsics.md#cstring) - The extracted substring.

Exceptions:

- [IndexOutOfBoundsException](core_package_exceptions.md#class-indexoutofboundsexception) - Thrown if beginIndex exceeds the string length.
- [IllegalMemoryException](core_package_exceptions.md#class-illegalmemoryexception) - Thrown if memory allocation or copying fails.

Example:

<!-- verify -->
```cangjie
main() {
    let index: UIntNative = 2
    var str1: CString = unsafe { LibC.mallocCString("hello") }
    var str2: CString = str1.subCString(index)
    println(str2)

    unsafe {
        LibC.free(str1)
        LibC.free(str2)
    }
}
```

Execution Result:

```text
llo
```

#### func subCString(UIntNative, UIntNative)

```cangjie
public func subCString(beginIndex: UIntNative, subLen: UIntNative): CString
```

Function: Extracts a substring from the string, specifying the starting position and length.

If the end position exceeds the string length, extraction stops at the string's end.

> **Note:**
>
> 1. This interface returns a copy of the substring, which must be manually freed after use.
> 2. If beginIndex equals the string length or subLen is 0, a null pointer is returned.

Parameters:

- beginIndex: [UIntNative](core_package_intrinsics.md#uintnative) - The starting position for extraction, ranging from [0, this.size()].
- subLen: [UIntNative](core_package_intrinsics.md#uintnative) - The length to extract, ranging from [0, [UIntNative](core_package_intrinsics.md#uintnative).Max].

Return Value:

- [CString](core_package_intrinsics.md#cstring) - The extracted substring.

Exceptions:

- [IndexOutOfBoundsException](core_package_exceptions.md#class-indexoutofboundsexception) - Thrown if beginIndex exceeds the string length.
- [IllegalMemoryException](core_package_exceptions.md#class-illegalmemoryexception) - Thrown if memory allocation or copying fails.

Example:

<!-- verify -->
```cangjie
main() {
    let index: UIntNative = 2
    let len: UIntNative = 2
    var str1: CString = unsafe { LibC.mallocCString("hello") }
    var str2: CString = str1.subCString(index, len)
    println(str2)

    unsafe {
        LibC.free(str1)
        LibC.free(str2)
    }
}
```

Execution Result:

```text
ll
```

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts [CString](core_package_intrinsics.md#cstring) type to Cangjie's [String](core_package_structs.md#struct-string) type.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Invalid UTF-8 byte sequence.

Example:

<!-- verify -->
```cangjie
main() {
    var str1: CString = unsafe { LibC.mallocCString("hello") }
    println(str1.toString())

    unsafe {
        LibC.free(str1)
    }
}
```

Execution Result:

```text
hello
```

## Float16

Function: Represents a 16-bit floating-point number, conforming to the `IEEE 754` half-precision format (`binary16`).

### extend Float16

```cangjie
extend Float16
```

Function: Extends half-precision floating-point numbers to support certain mathematical constants.

#### static prop Inf

```cangjie
public static prop Inf: Float16
```

Function: Gets the infinity value for half-precision floating-point numbers.

Type: [Float16](./core_package_intrinsics.md#float16)

#### static prop Max

```cangjie
public static prop Max: Float16
```

Function: Gets the maximum value for half-precision floating-point numbers.

Type: [Float16](./core_package_intrinsics.md#float16)

#### static prop Min

```cangjie
public static prop Min: Float16
```

Function: Gets the minimum value for half-precision floating-point numbers.

Type: [Float16](./core_package_intrinsics.md#float16)

#### static prop MinDenormal

```cangjie
public static prop MinDenormal: Float16
```

Function: Gets the smallest denormal number for half-precision floating-point numbers. The smallest positive denormal number is the smallest positive number representable in IEEE double-precision format.

Type: [Float16](./core_package_intrinsics.md#float16)

#### static prop MinNormal

```cangjie
public static prop MinNormal: Float16
```

Function: Gets the smallest normal number for half-precision floating-point numbers.

Type: [Float16](./core_package_intrinsics.md#float16)

#### static prop NaN

```cangjie
public static prop NaN: Float16
```

Function: Gets the Not-a-Number (NaN) value for half-precision floating-point numbers.

Type: [Float16](./core_package_intrinsics.md#float16)

#### static func max(Float16, Float16, Array\<Float16>)

```cangjie
public static func max(a: Float16, b: Float16, others: Array<Float16>): Float16
```

Function: Returns the maximum value among a set of [Float16](./core_package_intrinsics.md#float16) numbers. The third parameter is a variadic argument, allowing comparison of more than two [Float16](./core_package_intrinsics.md#float16) values. If any parameter is `NaN`, the function returns `NaN`.

Parameters:

- a: [Float16](./core_package_intrinsics.md#float16) - The first number to compare.
- b: [Float16](./core_package_intrinsics.md#float16) - The second number to compare.
- others: [Array](core_package_structs.md#struct-arrayt)\<[Float16](./core_package_intrinsics.md#float16)> - Additional numbers to compare.

Return Value:

- [Float16](./core_package_intrinsics.md#float16) - The maximum value among the parameters.

#### static func min(Float16, Float16, Array\<Float16>)

```cangjie
public static func min(a: Float16, b: Float16, others: Array<Float16>): Float16
```

Function: Returns the minimum value among a set of [Float16](./core_package_intrinsics.md#float16) numbers. The third parameter is a variadic argument, allowing comparison of more than two [Float16](./core_package_intrinsics.md#float16) values. If any parameter is `NaN`, the function returns `NaN`.

Parameters:

- a: [Float16](./core_package_intrinsics.md#float16) - The first number to compare.
- b: [Float16](./core_package_intrinsics.md#float16) - The second number to compare.
- others: [Array](core_package_structs.md#struct-arrayt)\<[Float16](./core_package_intrinsics.md#float16)> - Additional numbers to compare.

Return Value:

- [Float16](./core_package_intrinsics.md#float16) - The minimum value among the parameters.

#### func isInf()

```cangjie
public func isInf(): Bool
```

Function: Determines whether a floating-point number [Float16](./core_package_intrinsics.md#float16) is an infinite value.

Return Value:

- [Bool](./core_package_intrinsics.md#bool) - Returns `true` if the [Float16](./core_package_intrinsics.md#float16) value is positive or negative infinity; otherwise, returns `false`.

#### func isNaN()

```cangjie
public func isNaN(): Bool
```

Function: Determines whether a floating-point number [Float16](./core_package_intrinsics.md#float16) is Not-a-Number (NaN).

Return Value:

- [Bool](./core_package_intrinsics.md#bool) - Returns `true` if the [Float16](./core_package_intrinsics.md#float16) value is NaN; otherwise, returns `false`.

#### func isNormal()

```cangjie
public func isNormal(): Bool
```

Function: Determines whether a floating-point number [Float16](./core_package_intrinsics.md#float16) is a normal value.

Return Value:

- [Bool](./core_package_intrinsics.md#bool) - Returns `true` if the [Float16](./core_package_intrinsics.md#float16) value is a normal floating-point number; otherwise, returns `false`.

### extend Float16 <: Comparable\<Float16>

```cangjie
extend Float16 <: Comparable<Float16>
```

Function: Extends the [Float16](core_package_intrinsics.md#float16) type with the [Comparable](core_package_interfaces.md#interface-comparablet)\<[Float16](core_package_intrinsics.md#float16)> interface to support comparison operations.

Parent Type:

- [Comparable](core_package_interfaces.md#interface-comparablet)\<[Float16](#float16)>

#### func compare(Float16)

```cangjie
public func compare(rhs: Float16): Ordering
```

Function: Compares the current [Float16](core_package_intrinsics.md#float16) value with another specified [Float16](core_package_intrinsics.md#float16) value.

Parameters:

- rhs: [Float16](core_package_intrinsics.md#float16) - The other [Float16](core_package_intrinsics.md#float16) value to compare.

Return Value:

- [Ordering](core_package_enums.md#enum-ordering) - Returns [Ordering](core_package_enums.md#enum-ordering).GT if greater than, [Ordering](core_package_enums.md#enum-ordering).EQ if equal, or [Ordering](core_package_enums.md#enum-ordering).LT if less than.

Example:

<!-- verify -->
```cangjie
main() {
    var num1: Float16 = 0.12
    var num2: Float16 = 0.234
    println(num1.compare(num2))
}
```

Output:

```text
Ordering.LT
```

### extend Float16

```cangjie
extend Float16
```

Function: Supports mutual conversion with [UInt16](core_package_intrinsics.md#uint16).

#### static func fromBits(UInt16)

```cangjie
public static func fromBits(bits: UInt16): Float16
```

Function: Converts a specified [UInt16](core_package_intrinsics.md#uint16) number to a [Float16](core_package_intrinsics.md#float16) number.

Parameters:

- bits: [UInt16](core_package_intrinsics.md#uint16) - The number to convert.

Return Value:

- [Float16](core_package_intrinsics.md#float16) - The conversion result, with bits identical to the parameter `bits`.

Example:

<!-- verify -->
```cangjie
main() {
    let v = Float16.fromBits(0x4A40)
    println(v)
}
```

Output:

```text
12.500000
```

#### func toBits()

```cangjie
public func toBits(): UInt16
```

Function: Converts a specified [Float16](core_package_intrinsics.md#float16) number to its corresponding [UInt16](core_package_intrinsics.md#uint16) bit representation.

Return Value:

- [UInt16](core_package_intrinsics.md#uint16) - The conversion result, with the same bit representation as the [Float16](core_package_intrinsics.md#float16) value.

Example:

<!-- verify -->
```cangjie
main() {
    println(12.5f16.toBits()) // 0x4A40 19008
}
```

Output:

```text
19008
```

### extend Float16 <: Hashable

```cangjie
extend Float16 <: Hashable
```

Function: Extends the [Float16](core_package_intrinsics.md#float16) type with the [Hashable](core_package_interfaces.md#interface-hashable) interface to support hash value computation.

Parent Type:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Computes the hash value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash value.

### extend Float16 <: ToString

```cangjie
extend Float16 <: ToString
```

Function: Extends the [Float16](core_package_intrinsics.md#float16) type with the [ToString](core_package_interfaces.md#interface-tostring) interface to support conversion to [String](core_package_structs.md#struct-string) type. By default, retains 6 decimal places.

Parent Type:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts a [Float16](core_package_intrinsics.md#float16) value to an output-ready string.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

## Float32

Function: Represents a 32-bit floating-point number, conforming to the single-precision format (`binary32`) in `IEEE 754`.

### extend Float32

```cangjie
extend Float32
```

Function: Extends single-precision floating-point numbers to support certain mathematical constants.

#### static prop Inf

```cangjie
public static prop Inf: Float32
```

Function: Gets the infinity value for single-precision floating-point numbers.

Type: [Float32](./core_package_intrinsics.md#float32)

#### static prop Max

```cangjie
public static prop Max: Float32
```

Function: Gets the maximum value for single-precision floating-point numbers.

Type: [Float32](./core_package_intrinsics.md#float32)

#### static prop Min

```cangjie
public static prop Min: Float32
```

Function: Gets the minimum value for single-precision floating-point numbers.

Type: [Float32](./core_package_intrinsics.md#float32)

#### static prop MinDenormal

```cangjie
public static prop MinDenormal: Float32
```

Function: Gets the smallest denormal number for single-precision floating-point numbers.

Type: [Float32](./core_package_intrinsics.md#float32)

#### static prop MinNormal

```cangjie
public static prop MinNormal: Float32
```

Function: Gets the smallest normal number for single-precision floating-point numbers.

Type: [Float32](./core_package_intrinsics.md#float32)

#### static prop NaN

```cangjie
public static prop NaN: Float32
```

Function: Gets the Not-a-Number (NaN) value for single-precision floating-point numbers.

Type: [Float32](./core_package_intrinsics.md#float32)

#### static func max(Float32, Float32, Array\<Float32>)

```cangjie
public static func max(a: Float32, b: Float32, others: Array<Float32>): Float32
```

Function: Returns the maximum value among a set of [Float32](./core_package_intrinsics.md#float32) numbers. The third parameter is a variadic argument, allowing comparison of more than two [Float32](./core_package_intrinsics.md#float32) values. If any parameter is `NaN`, the function returns `NaN`.

Parameters:

- a: [Float32](./core_package_intrinsics.md#float32) - The first number to compare.
- b: [Float32](./core_package_intrinsics.md#float32) - The second number to compare.
- others: [Array](core_package_structs.md#struct-arrayt)\<[Float32](./core_package_intrinsics.md#float32)> - Additional numbers to compare.

Return Value:

- [Float32](./core_package_intrinsics.md#float32) - The maximum value among the parameters.

#### static func min(Float32, Float32, Array\<Float32>)

```cangjie
public static func min(a: Float32, b: Float32, others: Array<Float32>): Float32
```

Function: Returns the minimum value among a set of [Float32](./core_package_intrinsics.md#float32) numbers. The third parameter is a variadic argument, allowing comparison of more than two [Float32](./core_package_intrinsics.md#float32) values. If any parameter is `NaN`, the function returns `NaN`.

Parameters:

- a: [Float32](./core_package_intrinsics.md#float32) - The first number to compare.
- b: [Float32](./core_package_intrinsics.md#float32) - The second number to compare.
- others: [Array](core_package_structs.md#struct-arrayt)\<[Float32](./core_package_intrinsics.md#float32)> - Additional numbers to compare.

Return Value:

- [Float32](./core_package_intrinsics.md#float32) - The minimum value among the parameters.

#### func isInf()

```cangjie
public func isInf(): Bool
```

Function: Determines whether a floating-point number [Float32](./core_package_intrinsics.md#float32) is an infinite value.

Return Value:

- [Bool](./core_package_intrinsics.md#bool) - Returns `true` if the [Float32](./core_package_intrinsics.md#float32) value is positive or negative infinity; otherwise, returns `false`.

#### func isNaN()

```cangjie
public func isNaN(): Bool
```

Function: Determines whether a floating-point number [Float32](./core_package_intrinsics.md#float32) is a non-number (NaN).

Return Value:

- [Bool](./core_package_intrinsics.md#bool) - Returns `true` if the [Float32](./core_package_intrinsics.md#float32) value is NaN; otherwise, returns `false`.

#### func isNormal()

```cangjie
public func isNormal(): Bool
```

Function: Determines whether a floating-point number [Float32](./core_package_intrinsics.md#float32) is a normal value.

Return Value:

- [Bool](./core_package_intrinsics.md#bool) - Returns `true` if the [Float32](./core_package_intrinsics.md#float32) value is a normal floating-point number; otherwise, returns `false`.

### extend Float32 <: Comparable\<Float32>

```cangjie
extend Float32 <: Comparable<Float32>
```

Function: Extends the [Float32](core_package_intrinsics.md#float32) type with the [Comparable](core_package_interfaces.md#interface-comparablet)\<[Float32](core_package_intrinsics.md#float32)> interface to support comparison operations.

Parent Type:

- [Comparable](core_package_interfaces.md#interface-comparablet)\<[Float32](#float32)>

#### func compare(Float32)

```cangjie
public func compare(rhs: Float32): Ordering
```

Function: Determines the size relationship between the current [Float32](core_package_intrinsics.md#float32) value and the specified [Float32](core_package_intrinsics.md#float32) value.

Parameters:

- rhs: [Float32](core_package_intrinsics.md#float32) - Another [Float32](core_package_intrinsics.md#float32) value to compare.

Return Value:

- [Ordering](core_package_enums.md#enum-ordering) - Returns [Ordering](core_package_enums.md#enum-ordering).GT if greater than, [Ordering](core_package_enums.md#enum-ordering).EQ if equal, and [Ordering](core_package_enums.md#enum-ordering).LT if less than.

Example:

<!-- verify -->
```cangjie
main() {
    var num1: Float32 = 0.12
    var num2: Float32 = 0.234
    println(num1.compare(num2))
}
```

Execution Result:

```text
Ordering.LT
```

### extend Float32

```cangjie
extend Float32
```

Function: Supports mutual conversion with [UInt32](core_package_intrinsics.md#uint32).

#### static func fromBits(UInt32)

```cangjie
public static func fromBits(bits: UInt32): Float32
```

Function: Converts the specified [UInt32](core_package_intrinsics.md#uint32) type to [Float32](core_package_intrinsics.md#float32) type.

Parameters:

- bits: [UInt32](core_package_intrinsics.md#uint32) - The number to convert.

Return Value:

- [Float32](core_package_intrinsics.md#float32) - The conversion result, whose bits are identical to the parameter bits.

Example:

<!-- verify -->
```cangjie
main() {
    let v = Float16.fromBits(0x4A40u16)
    println(v)
}
```

Execution Result:

```text
12.500000
```

#### func toBits()

```cangjie
public func toBits(): UInt32
```

Function: Converts the specified [Float32](core_package_intrinsics.md#float32) number to the corresponding [UInt32](core_package_intrinsics.md#uint32) number represented by its bits.

Return Value:

- [UInt32](core_package_intrinsics.md#uint32) - The conversion result, whose value is identical to the bit representation of [Float32](core_package_intrinsics.md#float32).

Example:

<!-- verify -->
```cangjie
main() {
    println(13.88f32.toBits()) // 0x415E147B 1096684667
}
```

Execution Result:

```text
1096684667
```

### extend Float32 <: Hashable

```cangjie
extend Float32 <: Hashable
```

Function: Extends the [Float32](core_package_intrinsics.md#float32) type with the [Hashable](core_package_interfaces.md#interface-hashable) interface to support hash value computation.

Parent Type:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash value.

### extend Float32 <: ToString

```cangjie
extend Float32 <: ToString
```

Function: Extends the [Float32](core_package_intrinsics.md#float32) type with the [ToString](core_package_interfaces.md#interface-tostring) interface to support conversion to [String](core_package_structs.md#struct-string) type. By default, it retains 6 decimal places.

Parent Type:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the [Float32](core_package_intrinsics.md#float32) value to an output-ready string.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

## Float64

Function: Represents a 64-bit floating-point number, conforming to the double-precision format (`binary64`) in `IEEE 754`.

### extend Float64

```cangjie
extend Float64
```

Function: Extends double-precision floating-point numbers to support certain mathematical constants.

#### static prop Inf

```cangjie
public static prop Inf: Float64
```

Function: Retrieves the infinity value for double-precision floating-point numbers.

Type: [Float64](./core_package_intrinsics.md#float64)

#### static prop Max

```cangjie
public static prop Max: Float64
```

Function: Retrieves the maximum value for double-precision floating-point numbers.

Type: [Float64](./core_package_intrinsics.md#float64)

#### static prop Min

```cangjie
public static prop Min: Float64
```

Function: Retrieves the minimum value for double-precision floating-point numbers.

Type: [Float64](./core_package_intrinsics.md#float64)

#### static prop MinDenormal

```cangjie
public static prop MinDenormal: Float64
```

Function: Retrieves the smallest denormal value for double-precision floating-point numbers.

Type: [Float64](./core_package_intrinsics.md#float64)

#### static prop MinNormal

```cangjie
public static prop MinNormal: Float64
```

Function: Retrieves the smallest normal value for double-precision floating-point numbers.

Type: [Float64](./core_package_intrinsics.md#float64)

#### static prop NaN

```cangjie
public static prop NaN: Float64
```

Function: Retrieves the NaN (Not a Number) value for double-precision floating-point numbers.

Type: [Float64](./core_package_intrinsics.md#float64)

#### static func max(Float64, Float64, Array\<Float64>)

```cangjie
public static func max(a: Float64, b: Float64, others: Array<Float64>): Float64
```

Function: Returns the maximum value among a set of [Float64](./core_package_intrinsics.md#float64) values. The third parameter of this function is a variadic parameter, allowing comparison of more than two [Float64](./core_package_intrinsics.md#float64) values. If any parameter is `NaN`, the function returns `NaN`.

Parameters:

- a: [Float64](./core_package_intrinsics.md#float64) - The first number to compare.
- b: [Float64](./core_package_intrinsics.md#float64) - The second number to compare.
- others: [Array](core_package_structs.md#struct-arrayt)\<[Float64](./core_package_intrinsics.md#float64)> - Other numbers to compare.

Return Value:

- [Float64](./core_package_intrinsics.md#float64) - The maximum value among the parameters.

#### static func min(Float64, Float64, Array\<Float64>)

```cangjie
public static func min(a: Float64, b: Float64, others: Array<Float64>): Float64
```

Function: Returns the minimum value among a set of [Float64](./core_package_intrinsics.md#float64) values. The third parameter of this function is a variadic parameter, allowing comparison of more than two [Float64](./core_package_intrinsics.md#float64) values. If any parameter is `NaN`, the function returns `NaN`.

Parameters:

- a: [Float64](./core_package_intrinsics.md#float64) - The first number to compare.
- b: [Float64](./core_package_intrinsics.md#float64) - The second number to compare.
- others: [Array](core_package_structs.md#struct-arrayt)\<[Float64](./core_package_intrinsics.md#float64)> - Other numbers to compare.Return Value:

- [Float64](./core_package_intrinsics.md#float64) - Returns the minimum value among the parameters.

#### func isInf()

```cangjie
public func isInf(): Bool
```

Function: Determines whether a floating-point number [Float64](./core_package_intrinsics.md#float64) is an infinite value.

Return Value:

- [Bool](./core_package_intrinsics.md#bool) - Returns `true` if the [Float64](./core_package_intrinsics.md#float64) value is positive or negative infinity; otherwise, returns `false`.

#### func isNaN()

```cangjie
public func isNaN(): Bool
```

Function: Determines whether a floating-point number [Float64](./core_package_intrinsics.md#float64) is a non-numeric value.

Return Value:

- [Bool](./core_package_intrinsics.md#bool) - Returns `true` if the [Float64](./core_package_intrinsics.md#float64) value is non-numeric; otherwise, returns `false`.

#### func isNormal()

```cangjie
public func isNormal(): Bool
```

Function: Determines whether a floating-point number [Float64](./core_package_intrinsics.md#float64) is a normal value.

Return Value:

- [Bool](./core_package_intrinsics.md#bool) - Returns `true` if the [Float64](./core_package_intrinsics.md#float64) value is a normal floating-point number; otherwise, returns `false`.

### extend Float64 <: Comparable\<Float64>

```cangjie
extend Float64 <: Comparable<Float64>
```

Function: Extends the [Float64](core_package_intrinsics.md#float64) type to implement the [Comparable](core_package_interfaces.md#interface-comparablet)\<[Float64](core_package_intrinsics.md#float64)> interface, supporting comparison operations.

Parent Type:

- [Comparable](core_package_interfaces.md#interface-comparablet)\<[Float64](#float64)>

#### func compare(Float64)

```cangjie
public func compare(rhs: Float64): Ordering
```

Function: Determines the size relationship between the current [Float64](core_package_intrinsics.md#float64) value and the specified [Float64](core_package_intrinsics.md#float64) value.

Parameters:

- rhs: [Float64](core_package_intrinsics.md#float64) - Another [Float64](core_package_intrinsics.md#float64) value to compare.

Return Value:

- [Ordering](core_package_enums.md#enum-ordering) - Returns [Ordering](core_package_enums.md#enum-ordering).GT if greater, [Ordering](core_package_enums.md#enum-ordering).EQ if equal, and [Ordering](core_package_enums.md#enum-ordering).LT if less.

Example:

<!-- verify -->
```cangjie
main() {
    var num1: Float64 = 0.12
    var num2: Float64 = 0.234
    println(num1.compare(num2))
}
```

Output:

```text
Ordering.LT
```

### extend Float64

```cangjie
extend Float64
```

Function: Supports mutual conversion with [UInt64](core_package_intrinsics.md#uint64).

#### static func fromBits(UInt64)

```cangjie
public static func fromBits(bits: UInt64): Float64
```

Function: Converts the specified [UInt64](core_package_intrinsics.md#uint64) number to a [Float64](core_package_intrinsics.md#float64) number.

Parameters:

- bits: [UInt64](core_package_intrinsics.md#uint64) - The number to convert.

Return Value:

- [Float64](core_package_intrinsics.md#float64) - The conversion result, with the same bit representation as the parameter `bits`.

Example:

<!-- verify -->
```cangjie
main() {
    let v = Float64.fromBits(0x402BC28F5C28F5C3)
    println(v)
}
```

Output:

```text
13.880000
```

#### func toBits()

```cangjie
public func toBits(): UInt64
```

Function: Converts the specified Float64 number to its corresponding [UInt64](core_package_intrinsics.md#uint64) bit representation.

Return Value:

- [UInt64](core_package_intrinsics.md#uint64) - The conversion result, with the same value as the bit representation of [Float64](core_package_intrinsics.md#float64).

Example:

<!-- verify -->
```cangjie
main() {
    println(13.88f64.toBits()) // 0x402BC28F5C28F5C3 4624003363408246211
}
```

Output:

```text
4624003363408246211
```

### extend Float64 <: Hashable

```cangjie
extend Float64 <: Hashable
```

Function: Extends the [Float64](core_package_intrinsics.md#float64) type to implement the [Hashable](core_package_interfaces.md#interface-hashable) interface, supporting hash value computation.

Parent Type:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Computes the hash value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash value.

### extend Float64 <: ToString

```cangjie
extend Float64 <: ToString
```

Function: Extends the [Float64](core_package_intrinsics.md#float64) type to implement the [ToString](core_package_interfaces.md#interface-tostring) interface, enabling conversion to [String](core_package_structs.md#struct-string) type. By default, retains 6 decimal places.

Parent Type:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the [Float64](core_package_intrinsics.md#float64) value to an output-ready string.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

## Int16

Function: Represents a 16-bit signed integer with a range of [-2^{15}, 2^{15} - 1].

### extend Int16

```cangjie
extend Int16
```

Function: Extends 16-bit signed integers to support certain mathematical constants.

#### static prop Max

```cangjie
public static prop Max: Int16
```

Function: Gets the maximum value of a 16-bit signed integer.

Type: [Int16](./core_package_intrinsics.md#int16)

#### static prop Min

```cangjie
public static prop Min: Int16
```

Function: Gets the minimum value of a 16-bit signed integer.

Type: [Int16](./core_package_intrinsics.md#int16)

### extend Int16 <: Comparable\<Int16>

```cangjie
extend Int16 <: Comparable<Int16>
```

Function: Extends the [Int16](core_package_intrinsics.md#int16) type to implement the [Comparable](core_package_interfaces.md#interface-comparablet)\<[Int16](core_package_intrinsics.md#int16)> interface, supporting comparison operations.

Parent Type:

- [Comparable](core_package_interfaces.md#interface-comparablet)\<[Int16](#int16)>

#### func compare(Int16)

```cangjie
public func compare(rhs: Int16): Ordering
```

Function: Determines the size relationship between the current [Int16](core_package_intrinsics.md#int16) value and the specified [Int16](core_package_intrinsics.md#int16) value.

Parameters:

- rhs: [Int16](core_package_intrinsics.md#int16) - Another [Int16](core_package_intrinsics.md#int16) value to compare.

Return Value:

- [Ordering](core_package_enums.md#enum-ordering) - Returns [Ordering](core_package_enums.md#enum-ordering).GT if greater, [Ordering](core_package_enums.md#enum-ordering).EQ if equal, and [Ordering](core_package_enums.md#enum-ordering).LT if less.

Example:

<!-- verify -->
```cangjie
main() {
    var num1: Int16 = 2
    var num2: Int16 = 3
    println(num1.compare(num2))
}
```

Output:

```text
Ordering.LT
```

### extend Int16 <: Countable\<Int16>

```cangjie
extend Int16 <: Countable<Int16>
```

Function: Extends the [Int16](core_package_intrinsics.md#int16) type to implement the [Countable](core_package_interfaces.md#interface-countablet)\<[Int16](core_package_intrinsics.md#int16)> interface, supporting counting operations.

Parent Type:

- [Countable](core_package_interfaces.md#interface-countablet)\<[Int16](#int16)>

#### func next(Int64)

```cangjie
public func next(right: Int64): Int16
```

Function: Gets the [Int16](core_package_intrinsics.md#int16) value at the position `right` units to the right of the current [Int16](core_package_intrinsics.md#int16) position on the number line. If the value overflows, it continues moving from the leftmost end of the number line.

Parameters:- right: [Int64](core_package_intrinsics.md#int64) - The number of positions to count rightward.

Return Value:

- [Int16](core_package_intrinsics.md#int16) - The [Int16](core_package_intrinsics.md#int16) value at the position after counting `right` positions rightward.

Example:

<!-- verify -->
```cangjie
main() {
    var num1: Int16 = 32767
    var num2: Int16 = 3
    println(num1.next(5))
    println(num2.next(10))
}
```

Execution Result:

```text
-32764
13
```

#### func position()

```cangjie
public func position(): Int64
```

Function: Retrieves the positional information of the current [Int16](core_package_intrinsics.md#int16) value by converting it to an [Int64](core_package_intrinsics.md#int64) value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The positional information of the current [Int16](core_package_intrinsics.md#int16) value.

Example:

<!-- verify -->
```cangjie
main() {
    var num1: Int16 = 32767
    var num2: Int16 = 3
    println(num1.position())
    println(num2.position())
}
```

Execution Result:

```text
32767
3
```

### extend Int16 <: Hashable

```cangjie
extend Int16 <: Hashable
```

Function: Extends the [Int16](core_package_intrinsics.md#int16) type with the [Hashable](core_package_interfaces.md#interface-hashable) interface to support hash value computation.

Parent Type:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Computes the hash value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash value.

### extend Int16 <: ToString

```cangjie
extend Int16 <: ToString
```

Function: Extends the [Int16](core_package_intrinsics.md#int16) type with the [ToString](core_package_interfaces.md#interface-tostring) interface to enable conversion to [String](core_package_structs.md#struct-string) type.

Parent Type:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the [Int16](core_package_intrinsics.md#int16) value to an output-ready string.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

## Int32

Function: Represents a 32-bit signed integer with a range of [-2^{31}, 2^{31} - 1].

### extend Int32

```cangjie
extend Int32
```

Function: Extends the 32-bit signed integer to support certain mathematical constants.

#### static prop Max

```cangjie
public static prop Max: Int32
```

Function: Retrieves the maximum value of a 32-bit signed integer.

Type: [Int32](./core_package_intrinsics.md#int32)

#### static prop Min

```cangjie
public static prop Min: Int32
```

Function: Retrieves the minimum value of a 32-bit signed integer.

Type: [Int32](./core_package_intrinsics.md#int32)

### extend Int32 <: Comparable\<Int32>

```cangjie
extend Int32 <: Comparable<Int32>
```

Function: Extends the [Int32](core_package_intrinsics.md#int32) type with the [Comparable](core_package_interfaces.md#interface-comparablet)\<[Int32](core_package_intrinsics.md#int32)> interface to support comparison operations.

Parent Type:

- [Comparable](core_package_interfaces.md#interface-comparablet)\<[Int32](#int32)>

#### func compare(Int32)

```cangjie
public func compare(rhs: Int32): Ordering
```

Function: Determines the size relationship between the current [Int32](core_package_intrinsics.md#int32) value and the specified [Int32](core_package_intrinsics.md#int32) value.

Parameter:

- rhs: [Int32](core_package_intrinsics.md#int32) - Another [Int32](core_package_intrinsics.md#int32) value to compare.

Return Value:

- [Ordering](core_package_enums.md#enum-ordering) - Returns [Ordering](core_package_enums.md#enum-ordering).GT if greater than, [Ordering](core_package_enums.md#enum-ordering).EQ if equal, and [Ordering](core_package_enums.md#enum-ordering).LT if less than.

Example:

<!-- verify -->
```cangjie
main() {
    var num1: Int32 = 8
    var num2: Int32 = 10
    println(num1.compare(num2))
}
```

Execution Result:

```text
Ordering.LT
```

### extend Int32 <: Countable\<Int32>

```cangjie
extend Int32 <: Countable<Int32>
```

Function: Extends the [Int32](core_package_intrinsics.md#int32) type with the [Countable](core_package_interfaces.md#interface-countablet)\<[Int32](core_package_intrinsics.md#int32)> interface to support counting operations.

Parent Type:

- [Countable](core_package_interfaces.md#interface-countablet)\<[Int32](#int32)>

#### func next(Int64)

```cangjie
public func next(right: Int64): Int32
```

Function: Retrieves the [Int32](core_package_intrinsics.md#int32) value at the position after moving `right` positions rightward from the current [Int32](core_package_intrinsics.md#int32) position on the number line. If overflow occurs, counting continues from the leftmost position of the number line.

Parameter:

- right: [Int64](core_package_intrinsics.md#int64) - The number of positions to count rightward.

Return Value:

- [Int32](core_package_intrinsics.md#int32) - The [Int32](core_package_intrinsics.md#int32) value at the position after counting `right` positions rightward.

Example:

<!-- verify -->
```cangjie
main() {
    var num: Int32 = 3
    println(num.next(10))
}
```

Execution Result:

```text
13
```

#### func position()

```cangjie
public func position(): Int64
```

Function: Retrieves the positional information of the current [Int32](core_package_intrinsics.md#int32) value by converting it to an [Int64](core_package_intrinsics.md#int64) value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The positional information of the current [Int32](core_package_intrinsics.md#int32) value.

Example:

<!-- verify -->
```cangjie
main() {
    var num: Int32 = 3
    println(num.position())
}
```

Execution Result:

```text
3
```

### extend Int32 <: Hashable

```cangjie
extend Int32 <: Hashable
```

Function: Extends the [Int32](core_package_intrinsics.md#int32) type with the [Hashable](core_package_interfaces.md#interface-hashable) interface to support hash value computation.

Parent Type:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Computes the hash value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash value.

### extend Int32 <: ToString

```cangjie
extend Int32 <: ToString
```

Function: Extends the [Int32](core_package_intrinsics.md#int32) type with the [ToString](core_package_interfaces.md#interface-tostring) interface to enable conversion to [String](core_package_structs.md#struct-string) type.

Parent Type:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the [Int32](core_package_intrinsics.md#int32) value to an output-ready string.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.
## Int64

Function: Represents a 64-bit signed integer with a range of [-2^{63}, 2^{63} - 1].

### extend Int64

```cangjie
extend Int64
```

Function: Extends 64-bit signed integers to support certain mathematical constants.

#### static prop Max

```cangjie
public static prop Max: Int64
```

Function: Gets the maximum value of a 64-bit signed integer.

Type: [Int64](./core_package_intrinsics.md#int64)

#### static prop Min

```cangjie
public static prop Min: Int64
```

Function: Gets the minimum value of a 64-bit signed integer.

Type: [Int64](./core_package_intrinsics.md#int64)

### extend Int64 <: Comparable\<Int64>

```cangjie
extend Int64 <: Comparable<Int64>
```

Function: Extends the [Int64](core_package_intrinsics.md#int64) type with the [Comparable](core_package_interfaces.md#interface-comparablet)\<[Int64](core_package_intrinsics.md#int64)> interface to support comparison operations.

Parent Types:

- [Comparable](core_package_interfaces.md#interface-comparablet)\<[Int64](#int64)>

#### func compare(Int64)

```cangjie
public func compare(rhs: Int64): Ordering
```

Function: Determines the size relationship between the current [Int64](core_package_intrinsics.md#int64) value and the specified [Int64](core_package_intrinsics.md#int64) value.

Parameters:

- rhs: [Int64](core_package_intrinsics.md#int64) - Another [Int64](core_package_intrinsics.md#int64) value to compare.

Return Value:

- [Ordering](core_package_enums.md#enum-ordering) - Returns [Ordering](core_package_enums.md#enum-ordering).GT if greater, [Ordering](core_package_enums.md#enum-ordering).EQ if equal, and [Ordering](core_package_enums.md#enum-ordering).LT if less.

Example:

<!-- verify -->
```cangjie
main() {
    var num1: Int64 = 2
    var num2: Int64 = 3
    println(num1.compare(num2))
}
```

Output:

```text
Ordering.LT
```

### extend Int64 <: Countable\<Int64>

```cangjie
extend Int64 <: Countable<Int64>
```

Function: Extends the [Int64](core_package_intrinsics.md#int64) type with the [Countable](core_package_interfaces.md#interface-countablet)\<[Int64](core_package_intrinsics.md#int64)> interface to support counting operations.

Parent Types:

- [Countable](core_package_interfaces.md#interface-countablet)\<[Int64](#int64)>

#### func next(Int64)

```cangjie
public func next(right: Int64): Int64
```

Function: Gets the [Int64](core_package_intrinsics.md#int32) value at the position `right` units to the right of the current [Int64](core_package_intrinsics.md#int32) value on the number line. If overflow occurs, counting continues from the leftmost position.

Parameters:

- right: [Int64](core_package_intrinsics.md#int64) - The number of units to count to the right.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The [Int64](core_package_intrinsics.md#int64) value at the position `right` units to the right.

Example:

<!-- verify -->
```cangjie
main() {
    var num: Int64 = 3
    println(num.next(10))
}
```

Output:

```text
13
```

#### func position()

```cangjie
public func position(): Int64
```

Function: Gets the position information of the current [Int64](core_package_intrinsics.md#int64) value, i.e., returns the [Int64](core_package_intrinsics.md#int64) value itself.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The position information of the current [Int64](core_package_intrinsics.md#int64) value.

Example:

<!-- verify -->
```cangjie
main() {
    var num: Int64 = 3
    println(num.position())
}
```

Output:

```text
3
```

### extend Int64 <: Hashable

```cangjie
extend Int64 <: Hashable
```

Function: Extends the [Int64](core_package_intrinsics.md#int64) type with the [Hashable](core_package_interfaces.md#interface-hashable) interface to support hash value computation.

Parent Types:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Gets the hash value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash value.

### extend Int64 <: ToString

```cangjie
extend Int64 <: ToString
```

Function: Extends the [Int64](core_package_intrinsics.md#int64) type with the [ToString](core_package_interfaces.md#interface-tostring) interface to support conversion to [String](core_package_structs.md#struct-string) type.

Parent Types:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the [Int64](core_package_intrinsics.md#int64) value to an output-ready string.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

## Int8

Function: Represents an 8-bit signed integer with a range of [-2^7, 2^7 - 1].

### extend Int8

```cangjie
extend Int8
```

Function: Extends 8-bit signed integers to support certain mathematical constants.

#### static prop Max

```cangjie
public static prop Max: Int8
```

Function: Gets the maximum value of an 8-bit signed integer.

Type: [Int8](./core_package_intrinsics.md#int8)

#### static prop Min

```cangjie
public static prop Min: Int8
```

Function: Gets the minimum value of an 8-bit signed integer.

Type: [Int8](./core_package_intrinsics.md#int8)

### extend Int8 <: Comparable\<Int8>

```cangjie
extend Int8 <: Comparable<Int8>
```

Function: Extends the [Int8](core_package_intrinsics.md#int8) type with the [Comparable](core_package_interfaces.md#interface-comparablet)\<[Int8](core_package_intrinsics.md#int8)> interface to support comparison operations.

Parent Types:

- [Comparable](core_package_interfaces.md#interface-comparablet)\<[Int8](#int8)>

#### func compare(Int8)

```cangjie
public func compare(rhs: Int8): Ordering
```

Function: Determines the size relationship between the current [Int8](core_package_intrinsics.md#int8) value and the specified [Int8](core_package_intrinsics.md#int8) value.

Parameters:

- rhs: [Int8](core_package_intrinsics.md#int8) - Another [Int8](core_package_intrinsics.md#int8) value to compare.

Return Value:

- [Ordering](core_package_enums.md#enum-ordering) - Returns [Ordering](core_package_enums.md#enum-ordering).GT if greater, [Ordering](core_package_enums.md#enum-ordering).EQ if equal, and [Ordering](core_package_enums.md#enum-ordering).LT if less.

Example:

<!-- verify -->
```cangjie
main() {
    var num1: Int8 = 2
    var num2: Int8 = 3
    println(num1.compare(num2))
}
```

Output:

```text
Ordering.LT
```

### extend Int8 <: Countable\<Int8>

```cangjie
extend Int8 <: Countable<Int8>
```

Function: Extends the [Int8](core_package_intrinsics.md#int8) type with the [Countable](core_package_interfaces.md#interface-countablet)\<[Int8](core_package_intrinsics.md#int8)> interface to support counting operations.

Parent Types:

- [Countable](core_package_interfaces.md#interface-countablet)\<[Int8](#int8)>

#### func next(Int64)

```cangjie
public func next(right: Int64): Int8
```

Function: Gets the [Int8](core_package_intrinsics.md#int32) value at the position `right` units to the right of the current [Int8](core_package_intrinsics.md#int32) value on the number line. If overflow occurs, counting continues from the leftmost position.

Parameters:

- right: [Int64](core_package_intrinsics.md#int64) - The number of units to count to the right.

Return Value:
- [Int8](core_package_intrinsics.md#int8) - The [Int8](core_package_intrinsics.md#int8) value obtained by moving `right` positions to the right.

Example:

<!-- verify -->
```cangjie
main() {
    var num: Int8 = 3
    println(num.next(5))
}
```

Execution Result:

```text
8
```

#### func position()

```cangjie
public func position(): Int64
```

Function: Retrieves the positional information of the current [Int8](core_package_intrinsics.md#int8) value, i.e., converts this [Int8](core_package_intrinsics.md#int8) to an [Int64](core_package_intrinsics.md#int64) value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The positional information of the current [Int8](core_package_intrinsics.md#int8) value.

Example:

<!-- verify -->
```cangjie
main() {
    var num: Int8 = 3
    println(num.position())
}
```

Execution Result:

```text
3
```

### extend Int8 <: Hashable

```cangjie
extend Int8 <: Hashable
```

Function: Extends the [Int8](core_package_intrinsics.md#int8) type with the [Hashable](core_package_interfaces.md#interface-hashable) interface to support hash value computation.

Parent Type:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash value.

### extend Int8 <: ToString

```cangjie
extend Int8 <: ToString
```

Function: Extends the [Int8](core_package_intrinsics.md#int8) type with the [ToString](core_package_interfaces.md#interface-tostring) interface to enable conversion to the [String](core_package_structs.md#struct-string) type.

Parent Type:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the [Int8](core_package_intrinsics.md#int8) value to an output-ready string.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

## IntNative

Function: Represents a platform-dependent signed integer type whose length matches the bit width of the current system.

### extend IntNative

```cangjie
extend IntNative
```

Function: Extends the platform-dependent signed integer to support certain mathematical constants.

#### static prop Max

```cangjie
public static prop Max: IntNative
```

Function: Retrieves the maximum value of the platform-dependent signed integer.

Type: [IntNative](./core_package_intrinsics.md#intnative)

#### static prop Min

```cangjie
public static prop Min: IntNative
```

Function: Retrieves the minimum value of the platform-dependent signed integer.

Type: [IntNative](./core_package_intrinsics.md#intnative)

### extend IntNative <: Comparable\<IntNative>

```cangjie
extend IntNative <: Comparable<IntNative>
```

Function: Extends the [IntNative](core_package_intrinsics.md#intnative) type with the [Comparable](core_package_interfaces.md#interface-comparablet)\<[IntNative](core_package_intrinsics.md#intnative)> interface to support comparison operations.

Parent Type:

- [Comparable](core_package_interfaces.md#interface-comparablet)\<[IntNative](#intnative)>

#### func compare(IntNative)

```cangjie
public func compare(rhs: IntNative): Ordering
```

Function: Determines the size relationship between the current [IntNative](core_package_intrinsics.md#intnative) value and the specified [IntNative](core_package_intrinsics.md#intnative) value.

Parameter:

- rhs: [IntNative](core_package_intrinsics.md#intnative) - Another [IntNative](core_package_intrinsics.md#intnative) value to compare.

Return Value:

- [Ordering](core_package_enums.md#enum-ordering) - Returns [Ordering](core_package_enums.md#enum-ordering).GT if greater, [Ordering](core_package_enums.md#enum-ordering).EQ if equal, and [Ordering](core_package_enums.md#enum-ordering).LT if less.

Example:

<!-- verify -->
```cangjie
main() {
    var num1: IntNative = 8
    var num2: IntNative = 10
    println(num1.compare(num2))
}
```

Execution Result:

```text
Ordering.LT
```

### extend IntNative <: Countable\<IntNative>

```cangjie
extend IntNative <: Countable<IntNative>
```

Function: Extends the [IntNative](core_package_intrinsics.md#intnative) type with the [Countable](core_package_interfaces.md#interface-countablet)\<[IntNative](core_package_intrinsics.md#intnative)> interface to support counting operations.

Parent Type:

- [Countable](core_package_interfaces.md#interface-countablet)\<[IntNative](#intnative)>

#### func next(Int64)

```cangjie
public func next(right: Int64): IntNative
```

Function: Retrieves the [IntNative](core_package_intrinsics.md#int32) value corresponding to the position obtained by moving `right` positions to the right from the current [IntNative](core_package_intrinsics.md#int32) position on the number axis. If the value overflows, it continues moving from the leftmost position of the number axis.

Parameter:

- right: [Int64](core_package_intrinsics.md#int64) - The number of positions to move to the right.

Return Value:

- [IntNative](core_package_intrinsics.md#intnative) - The [IntNative](core_package_intrinsics.md#intnative) value at the position after moving `right` positions to the right.

Example:

<!-- verify -->
```cangjie
main() {
    var num: IntNative = 8
    println(num.next(4))
}
```

Execution Result:

```text
12
```

#### func position()

```cangjie
public func position(): Int64
```

Function: Retrieves the positional information of the current [IntNative](core_package_intrinsics.md#intnative) value, i.e., converts this [IntNative](core_package_intrinsics.md#intnative) to an [Int64](core_package_intrinsics.md#int64) value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The positional information of the current [IntNative](core_package_intrinsics.md#intnative) value.

Example:

<!-- verify -->
```cangjie
main() {
    var num: IntNative = 8
    println(num.position())
}
```

Execution Result:

```text
8
```

### extend IntNative <: Hashable

```cangjie
extend IntNative <: Hashable
```

Function: Extends the [IntNative](core_package_intrinsics.md#intnative) type with the [Hashable](core_package_interfaces.md#interface-hashable) interface to support hash value computation.

Parent Type:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash value.

### extend IntNative <: ToString

```cangjie
extend IntNative <: ToString
```

Function: Extends the [IntNative](core_package_intrinsics.md#intnative) type with the [ToString](core_package_interfaces.md#interface-tostring) interface to enable conversion to the [String](core_package_structs.md#struct-string) type.

Parent Type:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the [IntNative](core_package_intrinsics.md#intnative) value to an output-ready string.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

## Rune

Function: Represents a character in the Unicode character set.

The range of representation is `Unicode scalar value`, i.e., characters from `\u{0000}` to `\u{D7FF}`, and from `\u{E000}` to `\u{10FFF}`.

### extend Rune

```cangjie
extend Rune
```

Function: Implements a series of extension methods for the [Rune](core_package_intrinsics.md#rune) type, primarily for character judgment and conversion operations within the ASCII character set range.

#### static func fromUtf8(Array\<UInt8>, Int64)

```cangjie
public static func fromUtf8(arr: Array<UInt8>, index: Int64): (Rune, Int64)
```

Function: Converts the specified element in a byte array to a character according to UTF-8 encoding rules and returns the byte length occupied by the character.

Parameters:

- arr: [Array](core_package_structs.md#struct-arrayt)\<[UInt8](core_package_intrinsics.md#uint8)> - The byte array containing the bytes to be converted.
- index: [Int64](core_package_intrinsics.md#int64) - The index of the byte to be converted in the array.

Return Value:

- ([Rune](core_package_intrinsics.md#rune), [Int64](core_package_intrinsics.md#int64)) - The converted character and the byte length occupied by the character.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Invalid UTF-8 byte sequence.

Example:

<!-- verify -->
```cangjie
main() {
    var arr: Array<UInt8> = [4u8, 8u8, 65u8] // A <=> 65
    var tuple = Rune.fromUtf8(arr, 2)
    println(tuple[0]) // Rune
    println(tuple[1]) // len
}
```

Output:

```text
A
1
```

#### static func getPreviousFromUtf8(Array\<UInt8>, Int64)

```cangjie
public static func getPreviousFromUtf8(arr: Array<UInt8>, index: Int64): (Rune, Int64)
```

Function: Retrieves the UTF-8 encoded character corresponding to the byte at the specified index in the byte array, along with the index of the first byte of the character in the array.

When a specific index is provided, the function locates the byte at that index and checks if it is the first byte of a UTF-8 character. If not, it continues traversing backward until the first byte is found, then uses the byte sequence to determine the corresponding character.

Parameters:

- arr: [Array](core_package_structs.md#struct-arrayt)\<[UInt8](core_package_intrinsics.md#uint8)> - The byte array from which to retrieve the character.
- index: [Int64](core_package_intrinsics.md#int64) - The index of the byte to be checked in the array.

Return Value:

- ([Rune](core_package_intrinsics.md#rune), [Int64](core_package_intrinsics.md#int64)) - The found character and the index of its first byte in the array.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown if the byte at the specified index does not conform to UTF-8 encoding rules (i.e., is not a valid first byte).

#### static func intoUtf8Array(Rune, Array\<UInt8>, Int64)

```cangjie
public static func intoUtf8Array(c: Rune, arr: Array<UInt8>, index: Int64): Int64
```

Function: Converts a character into a byte sequence and overwrites the bytes in the specified position of the [Array](core_package_structs.md#struct-arrayt).

Parameters:

- c: [Rune](core_package_intrinsics.md#rune) - The character to be converted.
- arr: [Array](core_package_structs.md#struct-arrayt)\<[UInt8](core_package_intrinsics.md#uint8)> - The target [Array](core_package_structs.md#struct-arrayt) to be overwritten.
- index: [Int64](core_package_intrinsics.md#int64) - The starting index of the target position.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The byte length of the character (e.g., 3 bytes for Chinese characters).

Example:

<!-- verify -->
```cangjie
main() {
    var arr: Array<UInt8> = [1u8, 2u8, 3u8, 230u8, 136u8, 145u8]
    var len: Int64 = Rune.intoUtf8Array(r'爱', arr, 2)
    println(len)
    println(arr[2]) // First byte of the UTF-8 encoding for the character '爱'
}
```

Output:

```text
3
231
```

#### static func utf8Size(Array\<UInt8>, Int64)

```cangjie
public static func utf8Size(arr: Array<UInt8>, index: Int64): Int64
```

Function: Returns the byte length of the character starting at the specified index in the byte array.

In UTF-8 encoding, the first bit of an ASCII byte is not 1, while for other characters, the number of leading 1s in the first byte indicates the byte length of the character. This function scans the first byte to determine the byte length. If the byte at the specified index is not a valid first byte, an exception is thrown.

Parameters:

- arr: [Array](core_package_structs.md#struct-arrayt)\<[UInt8](core_package_intrinsics.md#uint8)> - The byte array containing the character.
- index: [Int64](core_package_intrinsics.md#int64) - The index of the character's first byte.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The byte length of the character (e.g., 3 bytes for Chinese characters).

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown if the byte at the specified index does not conform to UTF-8 first byte rules.

Example:

<!-- verify -->
```cangjie
main() {
    var arr: Array<UInt8> = [1u8, 2u8, 231u8, 136u8, 177u8, 145u8]
    var len: Int64 = Rune.utf8Size(arr, 2)
    println(len) // Bytes at indices 2-4 represent the UTF-8 encoding of the Chinese character '爱', occupying 3 bytes
}
```

Output:

```text
3
```

#### static func utf8Size(Rune)

```cangjie
public static func utf8Size(c: Rune): Int64
```

Function: Returns the byte length of the UTF-8 encoding for the given character (e.g., 3 bytes for Chinese characters).

Parameters:

- c: [Rune](core_package_intrinsics.md#rune) - The character whose UTF-8 byte length is to be calculated.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The byte length of the character's UTF-8 encoding.

Example:

<!-- verify -->
```cangjie
main() {
    var char: Rune = r'爱'
    var len: Int64 = Rune.utf8Size(char)
    println(len) // UTF-8 encoding of the Chinese character '爱' occupies 3 bytes
}
```

Output:

```text
3
```

#### func isAscii()

```cangjie
public func isAscii(): Bool
```

Function: Determines if the character is an ASCII character.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns `true` if the character is ASCII, otherwise `false`.

#### func isAsciiControl()

```cangjie
public func isAsciiControl(): Bool
```

Function: Determines if the character is an ASCII control character. The valid range is the union of [00, 1F] and {7F}.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns `true` if the character is an ASCII control character, otherwise `false`.

#### func isAsciiGraphic()

```cangjie
public func isAsciiGraphic(): Bool
```

Function: Determines if the character is an ASCII graphic character. The valid range is [21, 7E].

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns `true` if the character is an ASCII graphic character, otherwise `false`.

#### func isAsciiHex()

```cangjie
public func isAsciiHex(): Bool
```

Function: Determines if the character is an ASCII hexadecimal character.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns `true` if the character is an ASCII hexadecimal character, otherwise `false`.

#### func isAsciiLetter()

```cangjie
public func isAsciiLetter(): Bool
```

Function: Determines if the character is an ASCII alphabetic character.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns `true` if the character is an ASCII alphabetic character, otherwise `false`.

#### func isAsciiLowerCase()

```cangjie
public func isAsciiLowerCase(): Bool
```

Function: Determines if the character is an ASCII lowercase character.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns `true` if the character is an ASCII lowercase character, otherwise `false`.

#### func isAsciiNumber()

```cangjie
public func isAsciiNumber(): Bool
```

Function: Determines if the character is an ASCII numeric character.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns `true` if the character is an ASCII numeric character, otherwise `false`.

#### func isAsciiNumberOrLetter()

```cangjie
public func isAsciiNumberOrLetter(): Bool
```

Function: Determines if the character is an ASCII numeric or Latin alphabetic character.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns `true` if the character is an ASCII numeric or Latin alphabetic character, otherwise `false`.

#### func isAsciiOct()

```cangjie
public func isAsciiOct(): Bool
```

Function: Determines if the character is an ASCII octal character.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns `true` if the character is an ASCII octal character, otherwise `false`.

#### func isAsciiPunctuation()

```cangjie
public func isAsciiPunctuation(): Bool
```

Function: Determines if the character is an ASCII punctuation character. The valid range is the union of [21, 2F], [3A, 40], [5B, 60], and [7B, 7E].

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns `true` if the character is an ASCII punctuation character, otherwise `false`.

#### func isAsciiUpperCase()

```cangjie
public func isAsciiUpperCase(): Bool
```

Function: Determines if the character is an ASCII uppercase character.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns `true` if the character is an ASCII uppercase character, otherwise returns `false`.

#### func isAsciiWhiteSpace()

```cangjie
public func isAsciiWhiteSpace(): Bool
```

Function: Determines if the character is an ASCII whitespace character. The valid range is the union of [09, 0D] and {20}.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns `true` if the character is an ASCII whitespace character, otherwise returns `false`.

#### func toAsciiLowerCase()

```cangjie
public func toAsciiLowerCase(): Rune
```

Function: Converts the character to an ASCII lowercase character. If conversion is not possible, the original character remains unchanged.

Return Value:

- [Rune](core_package_intrinsics.md#rune) - The converted character. If conversion is not possible, returns the original [Rune](core_package_intrinsics.md#rune).

#### func toAsciiUpperCase()

```cangjie
public func toAsciiUpperCase(): Rune
```

Function: Converts the character to an ASCII uppercase character. If conversion is not possible, the original character remains unchanged.

Return Value:

- [Rune](core_package_intrinsics.md#rune) - The converted character. If conversion is not possible, returns the original [Rune](core_package_intrinsics.md#rune).

### extend Rune <: Comparable\<Rune>

```cangjie
extend Rune <: Comparable<Rune>
```

Function: Extends the [Rune](core_package_intrinsics.md#rune) type with the [Comparable](core_package_interfaces.md#interface-comparablet)\<[Rune](core_package_intrinsics.md#rune)> interface to support comparison operations.

Parent Type:

- [Comparable](core_package_interfaces.md#interface-comparablet)\<[Rune](#rune)>

#### func compare(Rune)

```cangjie
public func compare(rhs: Rune): Ordering
```

Function: Determines the size relationship between the current [Rune](core_package_intrinsics.md#rune) instance and the specified [Rune](core_package_intrinsics.md#rune) instance.

The size relationship of [Rune](core_package_intrinsics.md#rune) refers to the comparison of their corresponding Unicode code points.

Parameters:

- rhs: [Rune](core_package_intrinsics.md#rune) - Another [Rune](core_package_intrinsics.md#rune) instance to compare.

Return Value:

- [Ordering](core_package_enums.md#enum-ordering) - Returns [Ordering](core_package_enums.md#enum-ordering).GT if greater, [Ordering](core_package_enums.md#enum-ordering).EQ if equal, and [Ordering](core_package_enums.md#enum-ordering).LT if less.

Example:

<!-- verify -->
```cangjie
main() {
    var char1: Rune = r'i'
    var char2: Rune = r'j'
    println(char1.compare(char2))
}
```

Output:

```text
Ordering.LT
```

### extend Rune <: Countable\<Rune>

```cangjie
extend Rune <: Countable<Rune>
```

Function: Extends the [Rune](core_package_intrinsics.md#rune) type with the [Countable](core_package_interfaces.md#interface-countablet)\<[Rune](core_package_intrinsics.md#rune)> interface to support counting operations.

Parent Type:

- [Countable](core_package_interfaces.md#interface-countablet)\<[Rune](#rune)>

#### func next(Int64)

```cangjie
public func next(right: Int64): Rune
```

Function: Gets the [Rune](core_package_intrinsics.md#rune) value at the position `right` steps to the right of the current [Rune](core_package_intrinsics.md#rune) value.

Parameters:

- right: [Int64](core_package_intrinsics.md#int64) - The number of steps to the right.

Return Value:

- [Rune](core_package_intrinsics.md#rune) - The [Rune](core_package_intrinsics.md#rune) value at the position `right` steps to the right.

Exceptions:

- [OverflowException](core_package_exceptions.md#class-overflowexception) - Throws an exception if the result of the addition operation with [Int64](core_package_intrinsics.md#int64) is an invalid Unicode value.

#### func position()

```cangjie
public func position(): Int64
```

Function: Gets the position information of the current [Rune](core_package_intrinsics.md#rune) value, i.e., converts the [Rune](core_package_intrinsics.md#rune) to an [Int64](core_package_intrinsics.md#int64) value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The position information of the current [Rune](core_package_intrinsics.md#rune) value.

### extend Rune <: Hashable

```cangjie
extend Rune <: Hashable
```

Function: Extends the [Rune](core_package_intrinsics.md#rune) type with the [Hashable](core_package_interfaces.md#interface-hashable) interface to support hash value computation.

Parent Type:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Computes the hash value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash value.

### extend Rune <: ToString

```cangjie
extend Rune <: ToString
```

Function: Extends the [Rune](core_package_intrinsics.md#rune) type with the [ToString](core_package_interfaces.md#interface-tostring) interface to support conversion to [String](core_package_structs.md#struct-string) type.

Parent Type:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the [Rune](core_package_intrinsics.md#rune) value to an outputtable string.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

## UInt16

Function: Represents a 16-bit unsigned integer with a range of [0, 2^{16} - 1].

### extend UInt16

```cangjie
extend UInt16
```

Function: Extends the 16-bit unsigned integer to support certain mathematical constants.

#### static prop Max

```cangjie
public static prop Max: UInt16
```

Function: Gets the maximum value of a 16-bit unsigned integer.

Type: [UInt16](./core_package_intrinsics.md#uint16)

#### static prop Min

```cangjie
public static prop Min: UInt16
```

Function: Gets the minimum value of a 16-bit unsigned integer.

Type: [UInt16](./core_package_intrinsics.md#uint16)

### extend UInt16 <: Comparable\<UInt16>

```cangjie
extend UInt16 <: Comparable<UInt16>
```

Function: Extends the [UInt16](core_package_intrinsics.md#uint16) type with the [Comparable](core_package_interfaces.md#interface-comparablet)\<[UInt16](core_package_intrinsics.md#uint16)> interface to support comparison operations.

Parent Type:

- [Comparable](core_package_interfaces.md#interface-comparablet)\<[UInt16](#uint16)>

#### func compare(UInt16)

```cangjie
public func compare(rhs: UInt16): Ordering
```

Function: Determines the size relationship between the current [UInt16](core_package_intrinsics.md#uint16) value and the specified [UInt16](core_package_intrinsics.md#uint16) value.

Parameters:

- rhs: [UInt16](core_package_intrinsics.md#uint16) - Another [UInt16](core_package_intrinsics.md#uint16) value to compare.

Return Value:

- [Ordering](core_package_enums.md#enum-ordering) - Returns [Ordering](core_package_enums.md#enum-ordering).GT if greater, [Ordering](core_package_enums.md#enum-ordering).EQ if equal, and [Ordering](core_package_enums.md#enum-ordering).LT if less.

Example:

<!-- verify -->
```cangjie
main() {
    var num1: UInt16 = 2
    var num2: UInt16 = 3
    println(num1.compare(num2))
}
```

Output:

```text
Ordering.LT
```

### extend UInt16 <: Countable\<UInt16>

```cangjie
extend UInt16 <: Countable<UInt16>
```

Function: Extends the [UInt16](core_package_intrinsics.md#uint16) type with the [Countable](core_package_interfaces.md#interface-countablet)\<[UInt16](core_package_intrinsics.md#uint16)> interface to support counting operations.

Parent Type:

- [Countable](core_package_interfaces.md#interface-countablet)\<[UInt16](#uint16)>

#### func next(Int64)

```cangjie
public func next(right: Int64): UInt16
```

Function: Gets the [UInt16](core_package_intrinsics.md#int32) value at the position `right` steps to the right of the current [UInt16](core_package_intrinsics.md#int32) value on the number axis. If the value overflows, it continues moving from the leftmost position of the axis.

Parameters:

- right: [Int64](core_package_intrinsics.md#int64) - The number of steps to the right.

Return Value:

- [UInt16](core_package_intrinsics.md#uint16) - The [UInt16](core_package_intrinsics.md#uint16) value at the position `right` steps to the right.

Example:

<!-- verify -->
```cangjie
main() {
    var num: UInt16 = 3
    println(num.next(10))
}
```Execution Result:

```text
13
```

#### func position()

```cangjie
public func position(): Int64
```

Function: Retrieves the position information of the current [UInt16](core_package_intrinsics.md#uint16) value, i.e., converts this [UInt16](core_package_intrinsics.md#uint16) to an [Int64](core_package_intrinsics.md#int64) value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The position information of the current [UInt16](core_package_intrinsics.md#uint16) value.

Example:

<!-- verify -->
```cangjie
main() {
    var num: UInt16 = 8
    println(num.position())
}
```

Execution Result:

```text
8
```

### extend UInt16 <: Hashable

```cangjie
extend UInt16 <: Hashable
```

Function: Extends the [UInt16](core_package_intrinsics.md#uint16) type to implement the [Hashable](core_package_interfaces.md#interface-hashable) interface, enabling hash value computation.

Parent Type:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash value.

### extend UInt16 <: ToString

```cangjie
extend UInt16 <: ToString
```

Function: Extends the [UInt16](core_package_intrinsics.md#uint16) type to implement the [ToString](core_package_interfaces.md#interface-tostring) interface, enabling conversion to the [String](core_package_structs.md#struct-string) type.

Parent Type:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the [UInt16](core_package_intrinsics.md#uint16) value to an output-ready string.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

## UInt32

Function: Represents a 32-bit unsigned integer with a range of [0, 2^{32} - 1].

### extend UInt32

```cangjie
extend UInt32
```

Function: Extends the 32-bit unsigned integer to support certain mathematical constants.

#### static prop Max

```cangjie
public static prop Max: UInt32
```

Function: Retrieves the maximum value of a 32-bit unsigned integer.

Type: [UInt32](./core_package_intrinsics.md#uint32)

#### static prop Min

```cangjie
public static prop Min: UInt32
```

Function: Retrieves the minimum value of a 32-bit unsigned integer.

Type: [UInt32](./core_package_intrinsics.md#uint32)

### extend UInt32 <: Comparable\<UInt32>

```cangjie
extend UInt32 <: Comparable<UInt32>
```

Function: Extends the [UInt32](core_package_intrinsics.md#uint32) type to implement the [Comparable](core_package_interfaces.md#interface-comparablet)\<[UInt32](core_package_intrinsics.md#uint32)> interface, enabling comparison operations.

Parent Type:

- [Comparable](core_package_interfaces.md#interface-comparablet)\<[UInt32](#uint32)>

#### func compare(UInt32)

```cangjie
public func compare(rhs: UInt32): Ordering
```

Function: Determines the size relationship between the current [UInt32](core_package_intrinsics.md#uint32) value and the specified [UInt32](core_package_intrinsics.md#uint32) value.

Parameter:

- rhs: [UInt32](core_package_intrinsics.md#uint32) - Another [UInt32](core_package_intrinsics.md#uint32) value to compare.

Return Value:

- [Ordering](core_package_enums.md#enum-ordering) - Returns [Ordering](core_package_enums.md#enum-ordering).GT if greater, [Ordering](core_package_enums.md#enum-ordering).EQ if equal, and [Ordering](core_package_enums.md#enum-ordering).LT if less.

Example:

<!-- verify -->
```cangjie
main() {
    var num1: UInt32 = 2
    var num2: UInt32 = 3
    println(num1.compare(num2))
}
```

Execution Result:

```text
Ordering.LT
```

### extend UInt32 <: Countable\<UInt32>

```cangjie
extend UInt32 <: Countable<UInt32>
```

Function: Extends the [UInt32](core_package_intrinsics.md#uint32) type to implement the [Countable](core_package_interfaces.md#interface-countablet)\<[UInt32](core_package_intrinsics.md#uint32)> interface, enabling counting operations.

Parent Type:

- [Countable](core_package_interfaces.md#interface-countablet)\<[UInt32](#uint32)>

#### func next(Int64)

```cangjie
public func next(right: Int64): UInt32
```

Function: Retrieves the [UInt32](core_package_intrinsics.md#uint32) value at the position obtained by moving `right` steps to the right from the current [UInt32](core_package_intrinsics.md#int32) position on the number axis. If the value overflows, it continues moving from the leftmost end of the axis.

Parameter:

- right: [Int64](core_package_intrinsics.md#int64) - The number of steps to move to the right.

Return Value:

- [UInt32](core_package_intrinsics.md#uint32) - The [UInt32](core_package_intrinsics.md#uint32) value at the position after moving `right` steps to the right.

Example:

<!-- verify -->
```cangjie
main() {
    var num: UInt32 = 3
    println(num.next(10))
}
```

Execution Result:

```text
13
```

#### func position()

```cangjie
public func position(): Int64
```

Function: Retrieves the position information of the current [UInt32](core_package_intrinsics.md#uint32) value, i.e., converts this [UInt32](core_package_intrinsics.md#uint32) to a [UInt64](core_package_intrinsics.md#uint64) value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The position information of the current [UInt32](core_package_intrinsics.md#uint32) value.

Example:

<!-- verify -->
```cangjie
main() {
    var num: UInt32 = 8
    println(num.position())
}
```

Execution Result:

```text
8
```

### extend UInt32 <: Hashable

```cangjie
extend UInt32 <: Hashable
```

Function: Extends the [UInt32](core_package_intrinsics.md#uint32) type to implement the [Hashable](core_package_interfaces.md#interface-hashable) interface, enabling hash value computation.

Parent Type:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash value.

### extend UInt32 <: ToString

```cangjie
extend UInt32 <: ToString
```

Function: Extends the [UInt32](core_package_intrinsics.md#uint32) type to implement the [ToString](core_package_interfaces.md#interface-tostring) interface, enabling conversion to the [String](core_package_structs.md#struct-string) type.

Parent Type:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the [UInt32](core_package_intrinsics.md#uint32) value to an output-ready string.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

## UInt64

Function: Represents a 64-bit unsigned integer with a range of [0, 2^{64} - 1].

### extend UInt64

```cangjie
extend UInt64
```

Function: Extends the 64-bit unsigned integer to support certain mathematical constants.

#### static prop Max

```cangjie
public static prop Max: UInt64
```

Function: Retrieves the maximum value of a 64-bit unsigned integer.Type: [UInt64](./core_package_intrinsics.md#uint64)

#### static prop Min

```cangjie
public static prop Min: UInt64
```

Function: Gets the minimum value of a 64-bit unsigned integer.

Type: [UInt64](./core_package_intrinsics.md#uint64)

### extend UInt64 <: Comparable\<UInt64>

```cangjie
extend UInt64 <: Comparable<UInt64>
```

Function: Extends the [UInt64](core_package_intrinsics.md#uint64) type with the [Comparable](core_package_interfaces.md#interface-comparablet)\<[UInt64](core_package_intrinsics.md#uint64)> interface to support comparison operations.

Parent Types:

- [Comparable](core_package_interfaces.md#interface-comparablet)\<[UInt64](#uint64)>

#### func compare(UInt64)

```cangjie
public func compare(rhs: UInt64): Ordering
```

Function: Determines the size relationship between the current [UInt64](core_package_intrinsics.md#uint64) value and the specified [UInt64](core_package_intrinsics.md#uint64) value.

Parameters:

- rhs: [UInt64](core_package_intrinsics.md#uint64) - Another [UInt64](core_package_intrinsics.md#uint64) value to compare.

Return Value:

- [Ordering](core_package_enums.md#enum-ordering) - Returns [Ordering](core_package_enums.md#enum-ordering).GT if greater than; [Ordering](core_package_enums.md#enum-ordering).EQ if equal; [Ordering](core_package_enums.md#enum-ordering).LT if less than.

Example:

<!-- verify -->
```cangjie
main() {
    var num1: UInt64 = 2
    var num2: UInt64 = 3
    println(num1.compare(num2))
}
```

Output:

```text
Ordering.LT
```

### extend UInt64 <: Countable\<UInt64>

```cangjie
extend UInt64 <: Countable<UInt64>
```

Function: Extends the [UInt64](core_package_intrinsics.md#uint64) type with the [Countable](core_package_interfaces.md#interface-countablet)\<[UInt64](core_package_intrinsics.md#uint64)> interface to support counting operations.

Parent Types:

- [Countable](core_package_interfaces.md#interface-countablet)\<[UInt64](#uint64)>

#### func next(Int64)

```cangjie
public func next(right: Int64): UInt64
```

Function: Gets the [UInt64](core_package_intrinsics.md#uint64) value at the position moved `right` steps to the right from the current [UInt64](core_package_intrinsics.md#uint64) position on the number axis. If the value overflows, it continues moving from the leftmost position of the axis.

Parameters:

- right: [Int64](core_package_intrinsics.md#int64) - The number of steps to move right.

Return Value:

- [UInt64](core_package_intrinsics.md#uint64) - The [UInt64](core_package_intrinsics.md#uint64) value at the position after moving `right` steps.

Example:

<!-- verify -->
```cangjie
main() {
    var num: UInt64 = 3
    println(num.next(10))
}
```

Output:

```text
13
```

#### func position()

```cangjie
public func position(): Int64
```

Function: Gets the position information of the current [UInt64](core_package_intrinsics.md#uint64) value, i.e., converts the [UInt64](core_package_intrinsics.md#uint64) to an [Int64](core_package_intrinsics.md#int64) value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The position information of the current [UInt64](core_package_intrinsics.md#uint64) value.

Example:

<!-- verify -->
```cangjie
main() {
    var num: UInt64 = 8
    println(num.position())
}
```

Output:

```text
8
```

### extend UInt64 <: Hashable

```cangjie
extend UInt64 <: Hashable
```

Function: Extends the [UInt64](core_package_intrinsics.md#uint64) type with the [Hashable](core_package_interfaces.md#interface-hashable) interface to support hash value computation.

Parent Types:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Gets the hash value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash value.

### extend UInt64 <: ToString

```cangjie
extend UInt64 <: ToString
```

Function: Extends the [UInt64](core_package_intrinsics.md#uint64) type with the [ToString](core_package_interfaces.md#interface-tostring) interface to support conversion to the [String](core_package_structs.md#struct-string) type.

Parent Types:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the [UInt64](core_package_intrinsics.md#uint64) value to an output-ready string.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

## UInt8

Function: Represents an 8-bit unsigned integer with a range of [0, 2^8 - 1].

### extend UInt8

```cangjie
extend UInt8
```

Function: Extends the 8-bit unsigned integer to support some mathematical constants.

#### static prop Max

```cangjie
public static prop Max: UInt8
```

Function: Gets the maximum value of an 8-bit unsigned integer.

Type: [UInt8](./core_package_intrinsics.md#uint8)

#### static prop Min

```cangjie
public static prop Min: UInt8
```

Function: Gets the minimum value of an 8-bit unsigned integer.

Type: [UInt8](./core_package_intrinsics.md#uint8)

### extend UInt8 <: Comparable\<UInt8>

```cangjie
extend UInt8 <: Comparable<UInt8>
```

Function: Extends the [UInt8](core_package_intrinsics.md#uint8) type with the [Comparable](core_package_interfaces.md#interface-comparablet)\<[UInt8](core_package_intrinsics.md#uint8)> interface to support comparison operations.

Parent Types:

- [Comparable](core_package_interfaces.md#interface-comparablet)\<[UInt8](#uint8)>

#### func compare(UInt8)

```cangjie
public func compare(rhs: UInt8): Ordering
```

Function: Determines the size relationship between the current [UInt8](core_package_intrinsics.md#uint8) value and the specified [UInt8](core_package_intrinsics.md#uint8) value.

Parameters:

- rhs: [UInt8](core_package_intrinsics.md#uint8) - Another [UInt8](core_package_intrinsics.md#uint8) value to compare.

Return Value:

- [Ordering](core_package_enums.md#enum-ordering) - Returns [Ordering](core_package_enums.md#enum-ordering).GT if greater than; [Ordering](core_package_enums.md#enum-ordering).EQ if equal; [Ordering](core_package_enums.md#enum-ordering).LT if less than.

Example:

<!-- verify -->
```cangjie
main() {
    var num1: UInt8 = 2
    var num2: UInt8 = 3
    println(num1.compare(num2))
}
```

Output:

```text
Ordering.LT
```

### extend UInt8 <: Countable\<UInt8>

```cangjie
extend UInt8 <: Countable<UInt8>
```

Function: Extends the [UInt8](core_package_intrinsics.md#uint8) type with the [Countable](core_package_interfaces.md#interface-countablet)\<[UInt8](core_package_intrinsics.md#uint8)> interface to support counting operations.

Parent Types:

- [Countable](core_package_interfaces.md#interface-countablet)\<[UInt8](#uint8)>

#### func next(Int64)

```cangjie
public func next(right: Int64): UInt8
```

Function: Gets the [UInt8](core_package_intrinsics.md#uint8) value at the position moved `right` steps to the right from the current [UInt8](core_package_intrinsics.md#uint8) position on the number axis. If the value overflows, it continues moving from the leftmost position of the axis.

Parameters:

- right: [Int64](core_package_intrinsics.md#int64) - The number of steps to move right.

Return Value:

- [UInt8](core_package_intrinsics.md#uint8) - The [UInt8](core_package_intrinsics.md#uint8) value at the position after moving `right` steps.

Example:

<!-- verify -->
```cangjie
main() {
    var num: UInt8 = 3
    println(num.next(10))
}
```

Output:

```text
13
```

#### func position()

```cangjie
public func position(): Int64
```

Function: Retrieves the position information of the current [UInt8](core_package_intrinsics.md#uint8) value, i.e., converting this [UInt8](core_package_intrinsics.md#uint8) to an [Int64](core_package_intrinsics.md#int64) value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The position information of the current [UInt8](core_package_intrinsics.md#uint8) value.

Example:

<!-- verify -->
```cangjie
main() {
    var num: UInt8 = 8
    println(num.position())
}
```

Execution Result:

```text
8
```

### extend UInt8 <: Hashable

```cangjie
extend UInt8 <: Hashable
```

Function: Extends the [UInt8](core_package_intrinsics.md#uint8) type with the [Hashable](core_package_interfaces.md#interface-hashable) interface to support hash value computation.

Parent Types:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash value.

### extend UInt8 <: ToString

```cangjie
extend UInt8 <: ToString
```

Function: Extends the [UInt8](core_package_intrinsics.md#uint8) type with the [ToString](core_package_interfaces.md#interface-tostring) interface to enable conversion to the [String](core_package_structs.md#struct-string) type.

Parent Types:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts a [UInt8](core_package_intrinsics.md#uint8) value to an output-ready string.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

## UIntNative

Function: Represents a platform-dependent unsigned integer type whose length matches the bit-width of the current system.

### extend UIntNative

```cangjie
extend UIntNative
```

Function: Extends platform-dependent unsigned integers to support certain mathematical constants.

#### static prop Max

```cangjie
public static prop Max: UIntNative
```

Function: Retrieves the maximum value of the platform-dependent unsigned integer.

Type: [UIntNative](./core_package_intrinsics.md#uintnative)

#### static prop Min

```cangjie
public static prop Min: UIntNative
```

Function: Retrieves the minimum value of the platform-dependent unsigned integer.

Type: [UIntNative](./core_package_intrinsics.md#uintnative)

### extend UIntNative <: Comparable\<UIntNative>

```cangjie
extend UIntNative <: Comparable<UIntNative>
```

Function: Extends the [UIntNative](core_package_intrinsics.md#uintnative) type with the [Comparable](core_package_interfaces.md#interface-comparablet)\<[UIntNative](core_package_intrinsics.md#uintnative)> interface to support comparison operations.

Parent Types:

- [Comparable](core_package_interfaces.md#interface-comparablet)\<[UIntNative](#uintnative)>

#### func compare(UIntNative)

```cangjie
public func compare(rhs: UIntNative): Ordering
```

Function: Determines the size relationship between the current [UIntNative](core_package_intrinsics.md#uintnative) value and the specified [UIntNative](core_package_intrinsics.md#uintnative) value.

Parameters:

- rhs: [UIntNative](core_package_intrinsics.md#uintnative) - Another [UIntNative](core_package_intrinsics.md#uintnative) value to compare.

Return Value:

- [Ordering](core_package_enums.md#enum-ordering) - Returns [Ordering](core_package_enums.md#enum-ordering).GT if greater; [Ordering](core_package_enums.md#enum-ordering).EQ if equal; [Ordering](core_package_enums.md#enum-ordering).LT if less.

Example:

<!-- verify -->
```cangjie
main() {
    var num1: UIntNative = 2
    var num2: UIntNative = 3
    println(num1.compare(num2))
}
```

Execution Result:

```text
Ordering.LT
```

### extend UIntNative <: Countable

```cangjie
extend UIntNative <: Countable<UIntNative>
```

Function: Extends the [UIntNative](core_package_intrinsics.md#uintnative) type with the [Countable](core_package_interfaces.md#interface-countablet)\<[UIntNative](core_package_intrinsics.md#uintnative)> interface to support counting operations.

Parent Types:

- [Countable](core_package_interfaces.md#interface-countablet)\<[UIntNative](#uintnative)>

#### func next(Int64)

```cangjie
public func next(right: Int64): UIntNative
```

Function: Retrieves the [UIntNative](core_package_intrinsics.md#int32) value at the position obtained by moving `right` units to the right from the current [UIntNative](core_package_intrinsics.md#int32) position on the number axis. If the value overflows, it continues moving from the leftmost position of the axis.

Parameters:

- right: [Int64](core_package_intrinsics.md#int64) - The number of units to move to the right.

Return Value:

- [UIntNative](core_package_intrinsics.md#uintnative) - The [UIntNative](core_package_intrinsics.md#uintnative) value at the position after moving `right` units to the right.

Example:

<!-- verify -->
```cangjie
main() {
    var num: UIntNative = 3
    println(num.next(10))
}
```

Execution Result:

```text
13
```

#### func position()

```cangjie
public func position(): Int64
```

Function: Retrieves the position information of the current [UIntNative](core_package_intrinsics.md#uintnative) value, i.e., converting this [UIntNative](core_package_intrinsics.md#uintnative) to an [Int64](core_package_intrinsics.md#int64) value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The position information of the current [UIntNative](core_package_intrinsics.md#uintnative) value.

Example:

<!-- verify -->
```cangjie
main() {
    var num: UIntNative = 8
    println(num.position())
}
```

Execution Result:

```text
8
```

### extend UIntNative <: Hashable

```cangjie
extend UIntNative <: Hashable
```

Function: Extends the [UIntNative](core_package_intrinsics.md#uintnative) type with the [Hashable](core_package_interfaces.md#interface-hashable) interface to support hash value computation.

Parent Types:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash value.

### extend UIntNative <: ToString

```cangjie
extend UIntNative <: ToString
```

Function: Extends the [UIntNative](core_package_intrinsics.md#uintnative) type with the [ToString](core_package_interfaces.md#interface-tostring) interface to enable conversion to the [String](core_package_structs.md#struct-string) type.

Parent Types:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts a [UIntNative](core_package_intrinsics.md#uintnative) value to an output-ready string.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

## Unit

Function: Represents the type of expressions in the Cangjie language where only side effects matter, not the value.

For example, the print function, assignment expressions, compound assignment expressions, increment and decrement expressions, and loop expressions all have the type [Unit](core_package_intrinsics.md#unit).

The [Unit](core_package_intrinsics.md#unit) type has only one value, which is also its literal: (). Apart from assignment, equality, and inequality checks, the [Unit](core_package_intrinsics.md#unit) type does not support other operations.

### extend Unit <: Equatable\<Unit>

```cangjie
extend Unit <: Equatable<Unit>
```

Function: Extends the [Unit](core_package_intrinsics.md#unit) type with the [Equatable](core_package_interfaces.md#interface-equatablet)\<[Unit](core_package_intrinsics.md#unit)> interface.

Parent Types:

- [Equatable](core_package_interfaces.md#interface-equatablet)\<[Unit](#unit)>

### extend Unit <: Hashable

```cangjie
extend Unit <: Hashable
```

Function: Extends the [Unit](core_package_intrinsics.md#unit) type with the [Hashable](core_package_interfaces.md#interface-hashable) interface to support hash value computation.

Parent Types:- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Get the hash code. The hash value of [Unit](core_package_intrinsics.md#unit) is 0.

Return value:

- [Int64](core_package_intrinsics.md#int64) - The hash value.

### extend Unit <: ToString

```cangjie
extend Unit <: ToString
```

Function: Extends the [ToString](core_package_interfaces.md#interface-tostring) interface for the [Unit](core_package_intrinsics.md#unit) type, implementing conversion to [String](core_package_structs.md#struct-string) type.

The string representation of [Unit](core_package_intrinsics.md#unit) is "()".

Parent types:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts a [Unit](core_package_intrinsics.md#unit) value to an outputtable string.

Return value:

- [String](core_package_structs.md#struct-string) - The converted string.