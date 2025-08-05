# Classes

## class AtomicBool

```cangjie
public class AtomicBool {
    public init(val: Bool)
}
```

Functionality: Provides atomic operation functions for the [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) type.

### init(Bool)

```cangjie
public init(val: Bool)
```

Functionality: Constructs an instance of atomic type [AtomicBool](sync_package_classes.md#class-atomicbool) encapsulating a [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) data type, with its internal data initialized to the value of parameter `val`.

Parameters:

- val: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The initial value of the atomic type.

### func compareAndSwap(Bool, Bool)

```cangjie
public func compareAndSwap(old: Bool, new: Bool): Bool
```

Functionality: CAS (Compare and Swap) operation using [default memory ordering](sync_package_constants_vars.md#let-defaultmemoryorder-deprecated).

Compares the current atomic value with the value specified by parameter `old`. If equal, writes the value specified by parameter `new` and returns `true`; otherwise, does not write the value and returns `false`.

Parameters:

- old: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The value to compare with the current atomic type.
- new: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The value to write to the atomic type if the comparison succeeds.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the swap succeeds after comparison, otherwise returns `false`.

### func compareAndSwap(Bool, Bool, MemoryOrder, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func compareAndSwap(old: Bool, new: Bool, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool
```

Functionality: CAS operation using `successOrder` specified memory ordering on success and `failureOrder` specified memory ordering on failure.

Compares the current atomic value with the value specified by parameter `old`. If equal, writes the value specified by parameter `new` and returns `true`; otherwise, does not write the value and returns `false`.

> **Note:**
>
> This will be deprecated in future versions. Use [compareAndSwap(Bool, Bool)](#func-compareandswapbool-bool) instead.

Parameters:

- old: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The value to compare with the current atomic type.
- new: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The value to write to the atomic type if the comparison succeeds.
- successOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for "read-modify-write" operations when the CAS operation succeeds.
- failureOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for "read" operations when the CAS operation fails.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the swap succeeds after comparison, otherwise returns `false`.

### func load()

```cangjie
public func load(): Bool
```

Functionality: Read operation using default memory ordering to retrieve the atomic value.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The current value of the atomic type.

### func load(MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func load(memoryOrder!: MemoryOrder): Bool
```

Functionality: Read operation using the memory ordering specified by parameter `memoryOrder` to retrieve the atomic value.

> **Note:**
>
> This will be deprecated in future versions. Use [load()](#func-load) instead.

Parameters:

- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The current value of the atomic type.

### func store(Bool)

```cangjie
public func store(val: Bool): Unit
```

Functionality: Write operation using default memory ordering to store the value specified by parameter `val` into the atomic type.

Parameters:

- val: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The value to write to the atomic type.

### func store(Bool, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func store(val: Bool, memoryOrder!: MemoryOrder): Unit
```

Functionality: Write operation using the memory ordering specified by parameter `memoryOrder` to store the value specified by parameter `val` into the atomic type.

> **Note:**
>
> This will be deprecated in future versions. Use [store(Bool)](#func-storebool) instead.

Parameters:

- val: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The value to write to the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

### func swap(Bool)

```cangjie
public func swap(val: Bool): Bool
```

Functionality: Swap operation using default memory ordering to store the value specified by parameter `val` into the atomic type and return the previous value.

Parameters:

- val: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The value to write to the atomic type.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The previous value before the write.

### func swap(Bool, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func swap(val: Bool, memoryOrder!: MemoryOrder): Bool
```

Function: Exchange Operation  
Using the memory ordering specified by the parameter `memoryOrder`, writes the value specified by parameter `val` to the atomic type and returns the value before writing.

> **Note:**  
>
> This will be deprecated in future versions. Use [swap(Bool)](#func-swapbool) instead.

Parameters:

- val: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The value to be written to the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The value before writing.

## class AtomicInt16

```cangjie
public class AtomicInt16 {
    public init(val: Int16)
}
```

Function: Provides atomic operation-related functions for the [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) type.

### init(Int16)

```cangjie
public init(val: Int16)
```

Function: Constructs an instance of the atomic type [AtomicInt16](sync_package_classes.md#class-atomicint16) encapsulating the [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) data type, with its internal data initialized to the value of parameter `val`.

Parameters:

- val: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The initial value of the atomic type.

### func compareAndSwap(Int16, Int16)

```cangjie
public func compareAndSwap(old: Int16, new: Int16): Bool
```

Function: CAS (Compare-And-Swap) operation using the default memory ordering.

Compares whether the current value of the atomic type is equal to the value specified by parameter `old`. If equal, writes the value specified by parameter `new` and returns `true`; otherwise, does not write the value and returns `false`.

Parameters:

- old: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to compare with the current atomic type.
- new: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to write to the atomic type if the comparison is equal.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the swap is successful after comparison, otherwise returns `false`.

### func compareAndSwap(Int16, Int16, MemoryOrder, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func compareAndSwap(old: Int16, new: Int16, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool
```

Function: CAS operation using the memory ordering specified by `successOrder` on success and `failureOrder` on failure.

Compares whether the current value of the atomic type is equal to the value specified by parameter `old`. If equal, writes the value specified by parameter `new` and returns `true`; otherwise, does not write the value and returns `false`.

> **Note:**  
>
> This will be deprecated in future versions. Use [compareAndSwap(Int16, Int16)](#func-compareandswapint16-int16) instead.

Parameters:

- old: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to compare with the current atomic type.
- new: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to write to the atomic type if the comparison is equal.
- successOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the "read-modify-write" operation upon successful CAS.
- failureOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the "read" operation upon failed CAS.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the swap is successful after comparison, otherwise returns `false`.

### func fetchAdd(Int16)

```cangjie
public func fetchAdd(val: Int16): Int16
```

Function: Performs an addition operation between the atomic type's value and the value specified by parameter `val` using the default memory ordering. Writes the result to the current atomic type instance and returns the value before the addition.

Parameters:

- val: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to be added to the atomic type.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value before the addition operation.

### func fetchAdd(Int16, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchAdd(val: Int16, memoryOrder!: MemoryOrder): Int16
```

Function: Performs an addition operation between the atomic type's value and the value specified by parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result to the current atomic type instance and returns the value before the addition.

> **Note:**  
>
> This will be deprecated in future versions. Use [fetchAdd(Int16)](#func-fetchaddint16) instead.

Parameters:

- val: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to be added to the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value before the addition operation.

### func fetchAnd(Int16)

```cangjie
public func fetchAnd(val: Int16): Int16
```

Function: Performs a bitwise AND operation between the current atomic type instance's value and the value specified by parameter `val` using the default memory ordering. Writes the result to the current atomic type instance and returns the value before the AND operation.

Parameters:

- val: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to perform the bitwise AND operation with the atomic type.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value before the AND operation.

### func fetchAnd(Int16, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchAnd(val: Int16, memoryOrder!: MemoryOrder): Int16
```

Function: Performs a bitwise AND operation between the current atomic type instance's value and the value specified by parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result to the current atomic type instance and returns the value before the AND operation.

> **Note:**  
>
> This will be deprecated in future versions. Use [fetchAnd(Int16)](#func-fetchandint16) instead.

Parameters:

- val: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to perform the bitwise AND operation with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value before the AND operation.- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering mode for the current operation.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value before performing the AND operation.

### func fetchOr(Int16)

```cangjie
public func fetchOr(val: Int16): Int16
```

Function: Performs a bitwise OR operation between the current atomic type instance's value and parameter `val` using the default memory ordering. Writes the result to the current atomic type instance and returns the value before the OR operation.

Parameters:

- val: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to perform OR operation with the atomic type.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value before performing the OR operation.

### func fetchOr(Int16, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchOr(val: Int16, memoryOrder!: MemoryOrder): Int16
```

Function: Performs a bitwise OR operation between the current atomic type instance's value and parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result to the current atomic type instance and returns the value before the OR operation.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchOr(Int16)](#func-fetchorint16) instead.

Parameters:

- val: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to perform OR operation with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering mode for the current operation.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value before performing the OR operation.

### func fetchSub(Int16)

```cangjie
public func fetchSub(val: Int16): Int16
```

Function: Performs a subtraction operation using the default memory ordering, where the atomic type's value is the minuend and parameter `val` is the subtrahend. Writes the result to the current atomic type instance and returns the value before the subtraction.

Parameters:

- val: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to subtract from the atomic type.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value before performing the subtraction.

### func fetchSub(Int16, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchSub(val: Int16, memoryOrder!: MemoryOrder): Int16
```

Function: Performs a subtraction operation using the memory ordering specified by `memoryOrder`, where the atomic type's value is the minuend and parameter `val` is the subtrahend. Writes the result to the current atomic type instance and returns the value before the subtraction.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchSub(Int16)](#func-fetchsubint16) instead.

Parameters:

- val: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to subtract from the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering mode for the current operation.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value before performing the subtraction.

### func fetchXor(Int16)

```cangjie
public func fetchXor(val: Int16): Int16
```

Function: Performs a bitwise XOR operation between the current atomic type instance's value and parameter `val` using the default memory ordering. Writes the result to the current atomic type instance and returns the value before the XOR operation.

Parameters:

- val: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to perform XOR operation with the atomic type.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value before performing the XOR operation.

### func fetchXor(Int16, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchXor(val: Int16, memoryOrder!: MemoryOrder): Int16
```

Function: Performs a bitwise XOR operation between the current atomic type instance's value and parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result to the current atomic type instance and returns the value before the XOR operation.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchXor(Int16)](#func-fetchxorint16) instead.

Parameters:

- val: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to perform XOR operation with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering mode for the current operation.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value before performing the XOR operation.

### func load()

```cangjie
public func load(): Int16
```

Function: Read operation using the default memory ordering to retrieve the atomic type's value.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The current value of the atomic type.

### func load(MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func load(memoryOrder!: MemoryOrder): Int16
```

Function: Read operation using the memory ordering specified by `memoryOrder` to retrieve the atomic type's value.

> **Note:**
>
> This will be deprecated in future versions. Use [load()](#func-load-1) instead.

Parameters:

- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering mode for the current operation.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The current value of the atomic type.

### func store(Int16)

```cangjie
public func store(val: Int16): Unit
```

Function: Write operation. Writes the value specified by parameter `val` to the atomic type using the default memory ordering.

Parameters:

- val: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to be written to the atomic type.

### func store(Int16, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func store(val: Int16, memoryOrder!: MemoryOrder): Unit
```

Function: Write operation. Writes the value specified by parameter `val` to the atomic type using the memory ordering specified by parameter `memoryOrder`.

> **Note:**
>
> This will be deprecated in future versions. Use [store(Int16)](#func-storeint16) instead.

Parameters:

- val: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to be written to the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for this operation.

### func swap(Int16)

```cangjie
public func swap(val: Int16): Int16
```

Function: Swap operation. Writes the value specified by parameter `val` to the atomic type using the default memory ordering, and returns the value before the write.

Parameters:

- val: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to be written to the atomic type.

Return value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value before the write.

### func swap(Int16, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func swap(val: Int16, memoryOrder!: MemoryOrder): Int16
```

Function: Swap operation. Writes the value specified by parameter `val` to the atomic type using the memory ordering specified by parameter `memoryOrder`, and returns the value before the write.

> **Note:**
>
> This will be deprecated in future versions. Use [swap(Int16)](#func-swapint16) instead.

Parameters:

- val: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to be written to the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for this operation.

Return value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value before the write.

## class AtomicInt32

```cangjie
public class AtomicInt32 {
    public init(val: Int32)
}
```

Function: Provides atomic operations for the [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) data type.

### init(Int32)

```cangjie
public init(val: Int32)
```

Function: Constructs an instance of [AtomicInt32](sync_package_classes.md#class-atomicint32) that encapsulates an [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) data type, with its internal data initialized to the value of parameter `val`.

Parameters:

- val: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The initial value of the atomic type.

### func compareAndSwap(Int32, Int32)

```cangjie
public func compareAndSwap(old: Int32, new: Int32): Bool
```

Function: CAS (Compare-And-Swap) operation using the default memory ordering.

Compares the current value of the atomic type with the value specified by parameter `old`. If they are equal, writes the value specified by parameter `new` and returns `true`; otherwise, does not write the value and returns `false`.

Parameters:

- old: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to compare with the current atomic type.
- new: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to write to the atomic type if the comparison succeeds.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the swap was successful, otherwise `false`.

### func compareAndSwap(Int32, Int32, MemoryOrder, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func compareAndSwap(old: Int32, new: Int32, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool
```

Function: CAS (Compare-And-Swap) operation. Uses the memory ordering specified by `successOrder` on success and `failureOrder` on failure.

Compares the current value of the atomic type with the value specified by parameter `old`. If they are equal, writes the value specified by parameter `new` and returns `true`; otherwise, does not write the value and returns `false`.

> **Note:**
>
> This will be deprecated in future versions. Use [compareAndSwap(Int32, Int32)](#func-compareandswapint32-int32) instead.

Parameters:

- old: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to compare with the current atomic type.
- new: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to write to the atomic type if the comparison succeeds.
- successOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the "read-modify-write" operation upon successful CAS.
- failureOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the "read" operation upon failed CAS.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the swap was successful, otherwise `false`.

### func fetchAdd(Int32)

```cangjie
public func fetchAdd(val: Int32): Int32
```

Function: Performs an addition operation between the atomic type's value and parameter `val` using the default memory ordering, writes the result to the current atomic type instance, and returns the value before the addition.

Parameters:

- val: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to be added to the atomic type.

Return value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value before the addition.

### func fetchAdd(Int32, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchAdd(val: Int32, memoryOrder!: MemoryOrder): Int32
```

Function: Performs an addition operation between the atomic type's value and the parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result to the current atomic type instance and returns the value before the addition operation.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchAdd(Int32)](#func-fetchaddint32) instead.

Parameters:

- val: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to be added to the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for this operation.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value before the addition operation.

### func fetchAnd(Int32)

```cangjie
public func fetchAnd(val: Int32): Int32
```

Function: Performs a bitwise AND operation between the current atomic type instance's value and parameter `val` using default memory ordering. Writes the result to the current atomic type instance and returns the value before the AND operation.

Parameters:

- val: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to perform bitwise AND with the atomic type.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value before the AND operation.

### func fetchAnd(Int32, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchAnd(val: Int32, memoryOrder!: MemoryOrder): Int32
```

Function: Performs a bitwise AND operation between the current atomic type instance's value and parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result to the current atomic type instance and returns the value before the AND operation.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchAnd(Int32)](#func-fetchandint32) instead.

Parameters:

- val: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to perform bitwise AND with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for this operation.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value before the AND operation.

### func fetchOr(Int32)

```cangjie
public func fetchOr(val: Int32): Int32
```

Function: Performs a bitwise OR operation between the current atomic type instance's value and parameter `val` using default memory ordering. Writes the result to the current atomic type instance and returns the value before the OR operation.

Parameters:

- val: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to perform bitwise OR with the atomic type.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value before the OR operation.

### func fetchOr(Int32, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchOr(val: Int32, memoryOrder!: MemoryOrder): Int32
```

Function: Performs a bitwise OR operation between the current atomic type instance's value and parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result to the current atomic type instance and returns the value before the OR operation.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchOr(Int32)](#func-fetchorint32) instead.

Parameters:

- val: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to perform bitwise OR with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for this operation.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value before the OR operation.

### func fetchSub(Int32)

```cangjie
public func fetchSub(val: Int32): Int32
```

Function: Performs a subtraction operation using the atomic type's value as the minuend and parameter `val` as the subtrahend, with default memory ordering. Writes the result to the current atomic type instance and returns the value before the subtraction operation.

Parameters:

- val: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to be subtracted from the atomic type.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value before the subtraction operation.

### func fetchSub(Int32, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchSub(val: Int32, memoryOrder!: MemoryOrder): Int32
```

Function: Performs a subtraction operation using the atomic type's value as the minuend and parameter `val` as the subtrahend, with the memory ordering specified by `memoryOrder`. Writes the result to the current atomic type instance and returns the value before the subtraction operation.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchSub(Int32)](#func-fetchsubint32) instead.

Parameters:

- val: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to be subtracted from the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for this operation.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value before the subtraction operation.

### func fetchXor(Int32)

```cangjie
public func fetchXor(val: Int32): Int32
```

Function: Performs a bitwise XOR operation between the current atomic type instance's value and parameter `val` using default memory ordering. Writes the result to the current atomic type instance and returns the value before the XOR operation.

Parameters:

- val: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to perform bitwise XOR with the atomic type.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value before the XOR operation.

### func fetchXor(Int32, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchXor(val: Int32, memoryOrder!: MemoryOrder): Int32
```

Function: Performs a bitwise XOR operation between the value of the current atomic type instance and the parameter `val`, using the memory ordering specified by `memoryOrder`. The result is written back to the current atomic type instance, and the value before the XOR operation is returned.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchXor(Int32)](#func-fetchxorint32) instead.

Parameters:

- val: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to perform the XOR operation with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value before the XOR operation was performed.

### func load()

```cangjie
public func load(): Int32
```

Function: A read operation that retrieves the value of the atomic type using the default memory ordering.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The current value of the atomic type.

### func load(MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func load(memoryOrder!: MemoryOrder): Int32
```

Function: A read operation that retrieves the value of the atomic type using the memory ordering specified by `memoryOrder`.

> **Note:**
>
> This will be deprecated in future versions. Use [load()](#func-load-2) instead.

Parameters:

- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The current value of the atomic type.

### func store(Int32)

```cangjie
public func store(val: Int32): Unit
```

Function: A write operation that stores the value specified by `val` into the atomic type using the default memory ordering.

Parameters:

- val: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to be stored in the atomic type.

### func store(Int32, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func store(val: Int32, memoryOrder!: MemoryOrder): Unit
```

Function: A write operation that stores the value specified by `val` into the atomic type using the memory ordering specified by `memoryOrder`.

> **Note:**
>
> This will be deprecated in future versions. Use [store(Int32)](#func-storeint32) instead.

Parameters:

- val: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to be stored in the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

### func swap(Int32)

```cangjie
public func swap(val: Int32): Int32
```

Function: A swap operation that stores the value specified by `val` into the atomic type using the default memory ordering and returns the previous value.

Parameters:

- val: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to be stored in the atomic type.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value before the swap operation.

### func swap(Int32, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func swap(val: Int32, memoryOrder!: MemoryOrder): Int32
```

Function: A swap operation that stores the value specified by `val` into the atomic type using the memory ordering specified by `memoryOrder` and returns the previous value.

> **Note:**
>
> This will be deprecated in future versions. Use [swap(Int32)](#func-swapint32) instead.

Parameters:

- val: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to be stored in the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value before the swap operation.

## class AtomicInt64

```cangjie
public class AtomicInt64 {
    public init(val: Int64)
}
```

Function: Provides atomic operations for the [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) data type.

### init(Int64)

```cangjie
public init(val: Int64)
```

Function: Constructs an instance of the atomic type [AtomicInt64](sync_package_classes.md#class-atomicint64) encapsulating an [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) data type, with its initial internal value set to the value of the parameter `val`.

Parameters:

- val: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The initial value of the atomic type.

### func compareAndSwap(Int64, Int64)

```cangjie
public func compareAndSwap(old: Int64, new: Int64): Bool
```

Function: A CAS (Compare-And-Swap) operation using the default memory ordering.

Compares the current value of the atomic type with the value specified by `old`. If they are equal, the value specified by `new` is written, and `true` is returned; otherwise, no value is written, and `false` is returned.

Parameters:

- old: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to compare with the current atomic type.
- new: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to write to the atomic type if the comparison is successful.Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the compare-and-swap operation succeeds, otherwise returns `false`.

### func compareAndSwap(Int64, Int64, MemoryOrder, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func compareAndSwap(old: Int64, new: Int64, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool
```

Function: Performs a CAS (Compare-And-Swap) operation. On success, uses the memory ordering specified by `successOrder`; on failure, uses the memory ordering specified by `failureOrder`.

Compares the current value of the atomic type with the value specified by parameter `old`. If they are equal, writes the value specified by parameter `new` and returns `true`; otherwise, does not write the value and returns `false`.

> **Note:**
>
> This method will be deprecated in future versions. Use [compareAndSwap(Int64, Int64)](#func-compareandswapint64-int64) instead.

Parameters:

- old: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to compare with the current atomic type.
- new: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to write to the atomic type if the comparison succeeds.
- successOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the "read-modify-write" operation upon successful CAS.
- failureOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the "read" operation upon failed CAS.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the compare-and-swap operation succeeds, otherwise returns `false`.

### func fetchAdd(Int64)

```cangjie
public func fetchAdd(val: Int64): Int64
```

Function: Performs an addition operation between the atomic type's value and parameter `val` using the default memory ordering. Writes the result to the current atomic type instance and returns the value before the addition.

Parameters:

- val: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to add to the atomic type.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value before the addition operation.

### func fetchAdd(Int64, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchAdd(val: Int64, memoryOrder!: MemoryOrder): Int64
```

Function: Performs an addition operation between the atomic type's value and parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result to the current atomic type instance and returns the value before the addition.

> **Note:**
>
> This method will be deprecated in future versions. Use [fetchAdd(Int64)](#func-fetchaddint64) instead.

Parameters:

- val: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to add to the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value before the addition operation.

### func fetchAnd(Int64)

```cangjie
public func fetchAnd(val: Int64): Int64
```

Function: Performs a bitwise AND operation between the current atomic type instance's value and parameter `val` using the default memory ordering. Writes the result to the current atomic type instance and returns the value before the AND operation.

Parameters:

- val: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to perform the AND operation with the atomic type.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value before the AND operation.

### func fetchAnd(Int64, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchAnd(val: Int64, memoryOrder!: MemoryOrder): Int64
```

Function: Performs a bitwise AND operation between the current atomic type instance's value and parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result to the current atomic type instance and returns the value before the AND operation.

> **Note:**
>
> This method will be deprecated in future versions. Use [fetchAnd(Int64)](#func-fetchandint64) instead.

Parameters:

- val: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to perform the AND operation with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value before the AND operation.

### func fetchOr(Int64)

```cangjie
public func fetchOr(val: Int64): Int64
```

Function: Performs a bitwise OR operation between the current atomic type instance's value and parameter `val` using the default memory ordering. Writes the result to the current atomic type instance and returns the value before the OR operation.

Parameters:

- val: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to perform the OR operation with the atomic type.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value before the OR operation.

### func fetchOr(Int64, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchOr(val: Int64, memoryOrder!: MemoryOrder): Int64
```

Function: Performs a bitwise OR operation between the current atomic type instance's value and parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result to the current atomic type instance and returns the value before the OR operation.

> **Note:**
>
> This method will be deprecated in future versions. Use [fetchOr(Int64)](#func-fetchorint64) instead.

Parameters:

- val: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to perform the OR operation with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value before the OR operation.

### func fetchSub(Int64)

```cangjie
public func fetchSub(val: Int64): Int64
```

Function: Performs a subtraction operation using the atomic type's value as the minuend and parameter `val` as the subtrahend, with the default memory ordering. Writes the result to the current atomic type instance and returns the value before the subtraction.

Parameters:

- val: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to be subtracted from the atomic type.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value before the subtraction operation.

### func fetchSub(Int64, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchSub(val: Int64, memoryOrder!: MemoryOrder): Int64
```

Function: Performs a subtraction operation using the memory order specified by the `memoryOrder` parameter, with the atomic type's value as the minuend and the parameter `val` as the subtrahend. Writes the result to the current atomic type instance and returns the value before the subtraction operation.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchSub(Int64)](#func-fetchsubint64) instead.

Parameters:

- val: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to be subtracted from the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value before the subtraction operation.

### func fetchXor(Int64)

```cangjie
public func fetchXor(val: Int64): Int64
```

Function: Performs a bitwise XOR operation between the current atomic type instance's value and the parameter `val` using the default memory ordering. Writes the result to the current atomic type instance and returns the value before the XOR operation.

Parameters:

- val: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to perform the XOR operation with the atomic type.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value before the XOR operation.

### func fetchXor(Int64, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchXor(val: Int64, memoryOrder!: MemoryOrder): Int64
```

Function: Performs a bitwise XOR operation between the current atomic type instance's value and the parameter `val` using the memory order specified by the `memoryOrder` parameter. Writes the result to the current atomic type instance and returns the value before the XOR operation.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchXor(Int64)](#func-fetchxorint64) instead.

Parameters:

- val: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to perform the XOR operation with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value before the XOR operation.

### func load()

```cangjie
public func load(): Int64
```

Function: Performs a read operation using the default memory ordering to read the value of the atomic type.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The current value of the atomic type.

### func load(MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func load(memoryOrder!: MemoryOrder): Int64
```

Function: Performs a read operation using the memory order specified by the `memoryOrder` parameter to read the value of the atomic type.

> **Note:**
>
> This will be deprecated in future versions. Use [load()](#func-load-3) instead.

Parameters:

- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The current value of the atomic type.

### func store(Int64)

```cangjie
public func store(val: Int64): Unit
```

Function: Performs a write operation using the default memory ordering to write the value specified by the parameter `val` to the atomic type.

Parameters:

- val: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to be written to the atomic type.

### func store(Int64, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func store(val: Int64, memoryOrder!: MemoryOrder): Unit
```

Function: Performs a write operation using the memory order specified by the `memoryOrder` parameter to write the value specified by the parameter `val` to the atomic type.

> **Note:**
>
> This will be deprecated in future versions. Use [store(Int64)](#func-storeint64) instead.

Parameters:

- val: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to be written to the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

### func swap(Int64)

```cangjie
public func swap(val: Int64): Int64
```

Function: Performs an exchange operation using the default memory ordering to write the value specified by the parameter `val` to the atomic type and returns the value before the write operation.

Parameters:

- val: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to be written to the atomic type.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value before the write operation.

### func swap(Int64, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func swap(val: Int64, memoryOrder!: MemoryOrder): Int64
```

Function: Performs an exchange operation using the memory order specified by the `memoryOrder` parameter to write the value specified by the parameter `val` to the atomic type and returns the value before the write operation.

> **Note:**
>
> This will be deprecated in future versions. Use [swap(Int64)](#func-swapint64) instead.

Parameters:

- val: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to be written to the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value before the write operation.

Example:  

<!-- verify -->  
```cangjie  
import std.sync.*  

let count = AtomicInt64(1)  

main(): Int64 {  
    var val1 = 0  
    if (count.compareAndSwap(1, 2)) {  
        val1 = count.load()  
        println("count1 = ${val1}")  
    }  

    if (count.fetchAdd(2) == val1) {  
        var val2 = count.load()  
        println("count2 = ${val2}")  
    }  

    count.store(6)  
    var val3 = count.load()  
    println("count3 = ${val3}")  

    if (count.swap(8) == val3) {  
        var val4 = count.load()  
        println("count4 = ${val4}")  
    }  

    return 0  
}  
```  

Execution Result:  

```text  
count1 = 2  
count2 = 4  
count3 = 6  
count4 = 8  
```  

## class AtomicInt8  

```cangjie  
public class AtomicInt8 {  
    public init(val: Int8)  
}  
```  

Function: Provides atomic operation functions for the [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) data type.  

### init(Int8)  

```cangjie  
public init(val: Int8)  
```  

Function: Constructs an instance of the atomic type [AtomicInt8](sync_package_classes.md#class-atomicint8) encapsulating an [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) data type, with its internal data initialized to the value of the parameter `val`.  

Parameters:  

- val: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The initial value of the atomic type.  

### func compareAndSwap(Int8, Int8)  

```cangjie  
public func compareAndSwap(old: Int8, new: Int8): Bool  
```  

Function: Performs a CAS (Compare-And-Swap) operation using the default memory ordering.  

Compares the current value of the atomic type with the value specified by the parameter `old`. If they are equal, writes the value specified by `new` and returns `true`; otherwise, does not write the value and returns `false`.  

Parameters:  

- old: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to compare with the current atomic type.  
- new: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to write to the atomic type if the comparison succeeds.  

Return Value:  

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the swap succeeds, otherwise `false`.  

### func compareAndSwap(Int8, Int8, MemoryOrder, MemoryOrder) <sup>(deprecated)</sup>  

```cangjie  
public func compareAndSwap(old: Int8, new: Int8, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool  
```  

Function: Performs a CAS operation using the memory ordering specified by `successOrder` on success and `failureOrder` on failure.  

Compares the current value of the atomic type with the value specified by `old`. If they are equal, writes the value specified by `new` and returns `true`; otherwise, does not write the value and returns `false`.  

> **Note:**  
>
> This feature will be deprecated in future versions. Use [compareAndSwap(Int8, Int8)](#func-compareandswapint8-int8) instead.  

Parameters:  

- old: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to compare with the current atomic type.  
- new: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to write to the atomic type if the comparison succeeds.  
- successOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering mode for the "read-modify-write" operation upon successful CAS.  
- failureOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering mode for the "read" operation upon failed CAS.  

Return Value:  

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the swap succeeds, otherwise `false`.  

### func fetchAdd(Int8)  

```cangjie  
public func fetchAdd(val: Int8): Int8  
```  

Function: Performs an addition operation between the atomic type's value and the parameter `val` using the default memory ordering, writes the result to the current atomic instance, and returns the value before the addition.  

Parameters:  

- val: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to be added to the atomic type.  

Return Value:  

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value before the addition operation.  

### func fetchAdd(Int8, MemoryOrder) <sup>(deprecated)</sup>  

```cangjie  
public func fetchAdd(val: Int8, memoryOrder!: MemoryOrder): Int8  
```  

Function: Performs an addition operation between the atomic type's value and the parameter `val` using the memory ordering specified by `memoryOrder`, writes the result to the current atomic instance, and returns the value before the addition.  

> **Note:**  
>
> This feature will be deprecated in future versions. Use [fetchAdd(Int8)](#func-fetchaddint8) instead.  

Parameters:- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering mode for the current operation.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value before the addition operation.

### func fetchAnd(Int8)

```cangjie
public func fetchAnd(val: Int8): Int8
```

Function: Performs a bitwise AND operation between the current atomic type instance's value and parameter `val` using the default memory ordering. Writes the result to the current atomic type instance and returns the value before the AND operation.

Parameters:

- val: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to perform bitwise AND operation with the atomic type.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value before the AND operation.

### func fetchAnd(Int8, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchAnd(val: Int8, memoryOrder!: MemoryOrder): Int8
```

Function: Performs a bitwise AND operation between the current atomic type instance's value and parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result to the current atomic type instance and returns the value before the AND operation.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchAnd(Int8)](#func-fetchandint8) instead.

Parameters:

- val: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to perform bitwise AND operation with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering mode for the current operation.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value before the AND operation.

### func fetchOr(Int8)

```cangjie
public func fetchOr(val: Int8): Int8
```

Function: Performs a bitwise OR operation between the current atomic type instance's value and parameter `val` using the default memory ordering. Writes the result to the current atomic type instance and returns the value before the OR operation.

Parameters:

- val: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to perform bitwise OR operation with the atomic type.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value before the OR operation.

### func fetchOr(Int8, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchOr(val: Int8, memoryOrder!: MemoryOrder): Int8
```

Function: Performs a bitwise OR operation between the current atomic type instance's value and parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result to the current atomic type instance and returns the value before the OR operation.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchOr(Int8)](#func-fetchorint8) instead.

Parameters:

- val: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to perform bitwise OR operation with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering mode for the current operation.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value before the OR operation.

### func fetchSub(Int8)

```cangjie
public func fetchSub(val: Int8): Int8
```

Function: Performs a subtraction operation using the current atomic type's value as the minuend and parameter `val` as the subtrahend, with default memory ordering. Writes the result to the current atomic type instance and returns the value before the subtraction.

Parameters:

- val: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to subtract from the atomic type.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value before the subtraction operation.

### func fetchSub(Int8, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchSub(val: Int8, memoryOrder!: MemoryOrder): Int8
```

Function: Performs a subtraction operation using the current atomic type's value as the minuend and parameter `val` as the subtrahend, with memory ordering specified by `memoryOrder`. Writes the result to the current atomic type instance and returns the value before the subtraction.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchSub(Int8)](#func-fetchsubint8) instead.

Parameters:

- val: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to subtract from the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering mode for the current operation.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value before the subtraction operation.

### func fetchXor(Int8)

```cangjie
public func fetchXor(val: Int8): Int8
```

Function: Performs a bitwise XOR operation between the current atomic type instance's value and parameter `val` using the default memory ordering. Writes the result to the current atomic type instance and returns the value before the XOR operation.

Parameters:

- val: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to perform bitwise XOR operation with the atomic type.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value before the XOR operation.

### func fetchXor(Int8, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchXor(val: Int8, memoryOrder!: MemoryOrder): Int8
```

Function: Performs a bitwise XOR operation between the current atomic type instance's value and parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result to the current atomic type instance and returns the value before the XOR operation.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchXor(Int8)](#func-fetchxorint8) instead.

Parameters:

- val: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to perform bitwise XOR operation with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering mode for the current operation.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value before the XOR operation.- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering mode for the current operation.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value before performing the XOR operation.

### func load()

```cangjie
public func load(): Int8
```

Function: Read operation using the default memory ordering mode to retrieve the value of the atomic type.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The current value of the atomic type.

### func load(MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func load(memoryOrder!: MemoryOrder): Int8
```

Function: Read operation using the memory ordering mode specified by parameter `memoryOrder` to retrieve the value of the atomic type.

> **Note:**
>
> This will be deprecated in future versions. Use [load()](#func-load-4) instead.

Parameters:

- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering mode for the current operation.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The current value of the atomic type.

### func store(Int8)

```cangjie
public func store(val: Int8): Unit
```

Function: Write operation using the default memory ordering mode to store the value specified by parameter `val` into the atomic type.

Parameters:

- val: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to be stored in the atomic type.

### func store(Int8, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func store(val: Int8, memoryOrder!: MemoryOrder): Unit
```

Function: Write operation using the memory ordering mode specified by parameter `memoryOrder` to store the value specified by parameter `val` into the atomic type.

> **Note:**
>
> This will be deprecated in future versions. Use [store(Int8)](#func-storeint8) instead.

Parameters:

- val: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to be stored in the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering mode for the current operation.

### func swap(Int8)

```cangjie
public func swap(val: Int8): Int8
```

Function: Swap operation using the default memory ordering mode to store the value specified by parameter `val` into the atomic type and return the value before the write.

Parameters:

- val: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to be stored in the atomic type.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value before the write.

### func swap(Int8, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func swap(val: Int8, memoryOrder!: MemoryOrder): Int8
```

Function: Swap operation using the memory ordering mode specified by parameter `memoryOrder` to store the value specified by parameter `val` into the atomic type and return the value before the write.

> **Note:**
>
> This will be deprecated in future versions. Use [swap(Int8)](#func-swapint8) instead.

Parameters:

- val: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to be stored in the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering mode for the current operation.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value before the write.

## class AtomicOptionReference\<T> where T <: Object

```cangjie
public class AtomicOptionReference<T> where T <: Object {
    public init()
    public init(val: Option<T>)
}
```

Function: Provides atomic operations for reference types.

The reference type must be a subclass of [Object](../../core/core_package_api/core_package_classes.md#class-object).

### init()

```cangjie
public init()
```

Function: Constructs an empty instance of [AtomicOptionReference](sync_package_classes.md#class-atomicoptionreferencet-where-t--object).

### init(Option\<T>)

```cangjie
public init(val: Option<T>)
```

Function: Constructs an instance of the atomic type [AtomicOptionReference](sync_package_classes.md#class-atomicoptionreferencet-where-t--object) encapsulating the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> data type, with its internal data initialized to the value of parameter `val`.

Parameters:

- val: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - The initial value of the atomic type.

### func compareAndSwap(Option\<T>, Option\<T>)

```cangjie
public func compareAndSwap(old: Option<T>, new: Option<T>): Bool
```

Function: CAS (Compare-And-Swap) operation using the default memory ordering mode.

Compares the current value of the atomic type with the value specified by parameter `old`. If they are equal, writes the value specified by parameter `new` and returns `true`; otherwise, does not write the value and returns `false`.

Parameters:

- old: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - The value to compare with the current atomic type value.- new: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - The value to write to the atomic type when the comparison result is equal.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the compare-and-swap operation succeeds, otherwise returns `false`.

### func compareAndSwap(Option\<T>, Option\<T>, MemoryOrder, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func compareAndSwap(old: Option<T>, new: Option<T>, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool
```

Function: Performs a CAS (Compare-And-Swap) operation. Uses the memory ordering specified by `successOrder` on success and `failureOrder` on failure.

Compares the current value of the atomic type with the value specified by parameter `old`. If equal, writes the value specified by parameter `new` and returns `true`; otherwise, does not write the value and returns `false`.

> **Note:**
>
> This will be deprecated in future versions. Use [compareAndSwap(Option\<T>, Option\<T>)](#func-compareandswapoptiont-optiont) instead.

Parameters:

- old: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - The value to compare with the current atomic type.
- new: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - The value to write to the atomic type when the comparison result is equal.
- successOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the "read-modify-write" operation on successful CAS.
- failureOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the "read" operation on failed CAS.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the compare-and-swap operation succeeds, otherwise returns `false`.

### func load()

```cangjie
public func load(): Option<T>
```

Function: Performs a read operation using the default memory ordering to retrieve the value of the atomic type.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - The current value of the atomic type.

### func load(MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func load(memoryOrder!: MemoryOrder): Option<T>
```

Function: Performs a read operation using the memory ordering specified by parameter `memoryOrder` to retrieve the value of the atomic type.

> **Note:**
>
> This will be deprecated in future versions. Use [load()](#func-load-5) instead.

Parameters:

- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - The current value of the atomic type.

### func store(Option\<T>)

```cangjie
public func store(val: Option<T>): Unit
```

Function: Performs a write operation using the default memory ordering to write the value specified by parameter `val` to the atomic type.

Parameters:

- val: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - The value to write to the atomic type.

### func store(Option\<T>, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func store(val: Option<T>, memoryOrder!: MemoryOrder): Unit
```

Function: Performs a write operation using the memory ordering specified by parameter `memoryOrder` to write the value specified by parameter `val` to the atomic type.

> **Note:**
>
> This will be deprecated in future versions. Use [store(Option\<T>)](#func-storeoptiont) instead.

Parameters:

- val: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - The value to write to the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

### func swap(Option\<T>)

```cangjie
public func swap(val: Option<T>): Option<T>
```

Function: Performs a swap operation using the default memory ordering to write the value specified by parameter `val` to the atomic type and returns the previous value.

Parameters:

- val: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - The value to write to the atomic type.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - The previous value before writing.

### func swap(Option\<T>, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func swap(val: Option<T>, memoryOrder!: MemoryOrder): Option<T>
```

Function: Performs a swap operation using the memory ordering specified by parameter `memoryOrder` to write the value specified by parameter `val` to the atomic type and returns the previous value.

> **Note:**
>
> This will be deprecated in future versions. Use [swap(Option\<T>)](#func-swapoptiont) instead.

Parameters:

- val: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - The value to write to the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - The previous value before writing.

## class AtomicReference\<T> where T <: Object

```cangjie
public class AtomicReference<T> where T <: Object {
    public init(val: T)
}
```

Function: Provides atomic operations for reference types.

The reference type must be a subclass of [Object](../../core/core_package_api/core_package_classes.md#class-object).

### init(T)

```cangjie
public init(val: T)
```

Function: Constructs an instance of the atomic type [AtomicReference](sync_package_classes.md#class-atomicreferencet-where-t--object) encapsulating the data type `T`, with its internal data initialized to the value of parameter `val`.

Parameters:- val: T - The initial value of the atomic type.

### func compareAndSwap(T, T)

```cangjie
public func compareAndSwap(old: T, new: T): Bool
```

Function: CAS operation using the default memory ordering.

Compares the current value of the atomic type with the value specified by the `old` parameter. If they are equal, writes the value specified by the `new` parameter and returns `true`; otherwise, does not write the value and returns `false`.

Parameters:

- old: T - The value to compare with the current atomic type.
- new: T - The value to write to the atomic type if the comparison is equal.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the compare-and-swap operation succeeds, otherwise returns `false`.

### func compareAndSwap(T, T, MemoryOrder, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func compareAndSwap(old: T, new: T, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool
```

Function: CAS operation using the `successOrder` memory ordering on success and `failureOrder` memory ordering on failure.

Compares the current value of the atomic type with the value specified by the `old` parameter. If they are equal, writes the value specified by the `new` parameter and returns `true`; otherwise, does not write the value and returns `false`.

> **Note:**
>
> This function will be deprecated in future versions. Use [compareAndSwap(T, T)](#func-compareandswapt-t) instead.

Parameters:

- old: T - The value to compare with the current atomic type.
- new: T - The value to write to the atomic type if the comparison is equal.
- successOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the "read-modify-write" operation upon successful CAS.
- failureOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the "read" operation upon failed CAS.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the compare-and-swap operation succeeds, otherwise returns `false`.

### func load()

```cangjie
public func load(): T
```

Function: Load operation using the default memory ordering to read the value of the atomic type.

Return Value:

- T - The current value of the atomic type.

### func load(MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func load(memoryOrder!: MemoryOrder): T
```

Function: Load operation using the specified `memoryOrder` memory ordering to read the value of the atomic type.

> **Note:**
>
> This function will be deprecated in future versions. Use [load()](#func-load-6) instead.

Parameters:

- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- T - The current value of the atomic type.

### func store(T)

```cangjie
public func store(val: T): Unit
```

Function: Store operation using the default memory ordering to write the value specified by `val` to the atomic type.

Parameters:

- val: T - The value to write to the atomic type.

### func store(T, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func store(val: T, memoryOrder!: MemoryOrder): Unit
```

Function: Store operation using the specified `memoryOrder` memory ordering to write the value specified by `val` to the atomic type.

> **Note:**
>
> This function will be deprecated in future versions. Use [store(T)](#func-storet) instead.

Parameters:

- val: T - The value to write to the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

### func swap(T)

```cangjie
public func swap(val: T): T
```

Function: Swap operation using the default memory ordering to write the value specified by `val` to the atomic type and return the previous value.

Parameters:

- val: T - The value to write to the atomic type.

Return Value:

- T - The previous value before the write.

### func swap(T, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func swap(val: T, memoryOrder!: MemoryOrder): T
```

Function: Swap operation using the specified `memoryOrder` memory ordering to write the value specified by `val` to the atomic type and return the previous value.

> **Note:**
>
> This function will be deprecated in future versions. Use [swap(T)](#func-swapt) instead.

Parameters:

- val: T - The value to write to the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- T - The previous value before the write.

## class AtomicUInt16

```cangjie
public class AtomicUInt16 {
    public init(val: UInt16)
```

Function: Provides atomic operation-related functions for the [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type.

### init(UInt16)

```cangjie
public init(val: UInt16)
```

Function: Constructs an instance of the atomic type [AtomicUInt16](sync_package_classes.md#class-atomicuint16) encapsulating the [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) data type, with its internal data initialized to the value of parameter `val`.

Parameters:

- val: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The initial value of the atomic type.

### func compareAndSwap(UInt16, UInt16)

```cangjie
public func compareAndSwap(old: UInt16, new: UInt16): Bool
```

Function: Performs a CAS (Compare-And-Swap) operation using the default memory ordering.

Compares the current value of the atomic type with the value specified by parameter `old`. If they are equal, writes the value specified by parameter `new` and returns `true`; otherwise, does not write the value and returns `false`.

Parameters:

- old: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to compare with the current atomic type.
- new: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to write to the atomic type if the comparison succeeds.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the compare-and-swap operation succeeds, otherwise returns `false`.

### func compareAndSwap(UInt16, UInt16, MemoryOrder, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func compareAndSwap(old: UInt16, new: UInt16, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool
```

Function: Performs a CAS operation, using the memory ordering specified by `successOrder` on success and `failureOrder` on failure.

Compares the current value of the atomic type with the value specified by parameter `old`. If they are equal, writes the value specified by parameter `new` and returns `true`; otherwise, does not write the value and returns `false`.

> **Note:**
>
> This method will be deprecated in future versions. Use [compareAndSwap(UInt16, UInt16)](#func-compareandswapuint16-uint16) instead.

Parameters:

- old: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to compare with the current atomic type.
- new: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to write to the atomic type if the comparison succeeds.
- successOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the "read-modify-write" operation upon successful CAS.
- failureOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the "read" operation upon failed CAS.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the compare-and-swap operation succeeds, otherwise returns `false`.

### func fetchAdd(UInt16)

```cangjie
public func fetchAdd(val: UInt16): UInt16
```

Function: Performs an addition operation between the atomic type's value and parameter `val` using the default memory ordering. Writes the result to the current atomic type instance and returns the value before the addition.

Parameters:

- val: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to add to the atomic type.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value before the addition operation.

### func fetchAdd(UInt16, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchAdd(val: UInt16, memoryOrder!: MemoryOrder): UInt16
```

Function: Performs an addition operation between the atomic type's value and parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result to the current atomic type instance and returns the value before the addition.

> **Note:**
>
> This method will be deprecated in future versions. Use [fetchAdd(UInt16)](#func-fetchadduint16) instead.

Parameters:

- val: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to add to the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the operation.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value before the addition operation.

### func fetchAnd(UInt16)

```cangjie
public func fetchAnd(val: UInt16): UInt16
```

Function: Performs a bitwise AND operation between the current atomic type instance's value and parameter `val` using the default memory ordering. Writes the result to the current atomic type instance and returns the value before the operation.

Parameters:

- val: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to perform the AND operation with.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value before the AND operation.

### func fetchAnd(UInt16, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchAnd(val: UInt16, memoryOrder!: MemoryOrder): UInt16
```

Function: Performs a bitwise AND operation between the current atomic type instance's value and parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result to the current atomic type instance and returns the value before the operation.

> **Note:**
>
> This method will be deprecated in future versions. Use [fetchAnd(UInt16)](#func-fetchanduint16) instead.

Parameters:

- val: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to perform the AND operation with.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the operation.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value before the AND operation.

### func fetchOr(UInt16)

```cangjie
public func fetchOr(val: UInt16): UInt16
```

Function: Performs a bitwise OR operation between the current atomic type instance's value and parameter `val` using the default memory ordering. Writes the result to the current atomic type instance and returns the value before the operation.

Parameters:

- val: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to perform the OR operation with.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value before the OR operation.

### func fetchOr(UInt16, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchOr(val: UInt16, memoryOrder!: MemoryOrder): UInt16
```

Function: Performs a bitwise OR operation between the current atomic type instance's value and the parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result back to the current atomic type instance and returns the value before the OR operation.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchOr(UInt16)](#func-fetchoruint16) instead.

Parameters:

- val: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to perform bitwise OR with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for this operation.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value before performing the OR operation.

### func fetchSub(UInt16)

```cangjie
public func fetchSub(val: UInt16): UInt16
```

Function: Performs a subtraction operation using default memory ordering, where the atomic type's value is the minuend and parameter `val` is the subtrahend. Writes the result back to the current atomic type instance and returns the value before the subtraction.

Parameters:

- val: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to subtract from the atomic type.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value before performing the subtraction.

### func fetchSub(UInt16, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchSub(val: UInt16, memoryOrder!: MemoryOrder): UInt16
```

Function: Performs a subtraction operation using the memory ordering specified by `memoryOrder`, where the atomic type's value is the minuend and parameter `val` is the subtrahend. Writes the result back to the current atomic type instance and returns the value before the subtraction.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchSub(UInt16)](#func-fetchsubuint16) instead.

Parameters:

- val: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to subtract from the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for this operation.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value before performing the subtraction.

### func fetchXor(UInt16)

```cangjie
public func fetchXor(val: UInt16): UInt16
```

Function: Performs a bitwise XOR operation between the current atomic type instance's value and parameter `val` using default memory ordering. Writes the result back to the current atomic type instance and returns the value before the XOR operation.

Parameters:

- val: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to perform bitwise XOR with the atomic type.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value before performing the XOR operation.

### func fetchXor(UInt16, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchXor(val: UInt16, memoryOrder!: MemoryOrder): UInt16
```

Function: Performs a bitwise XOR operation between the current atomic type instance's value and parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result back to the current atomic type instance and returns the value before the XOR operation.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchXor(UInt16)](#func-fetchxoruint16) instead.

Parameters:

- val: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to perform bitwise XOR with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for this operation.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value before performing the XOR operation.

### func load()

```cangjie
public func load(): UInt16
```

Function: Performs a read operation using default memory ordering to retrieve the atomic type's value.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The current value of the atomic type.

### func load(MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func load(memoryOrder!: MemoryOrder): UInt16
```

Function: Performs a read operation using the memory ordering specified by `memoryOrder` to retrieve the atomic type's value.

> **Note:**
>
> This will be deprecated in future versions. Use [load()](#func-load-7) instead.

Parameters:

- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for this operation.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The current value of the atomic type.

### func store(UInt16)

```cangjie
public func store(val: UInt16): Unit
```

Function: Performs a write operation using default memory ordering to store the value specified by `val` into the atomic type.

Parameters:

- val: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to store in the atomic type.

### func store(UInt16, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func store(val: UInt16, memoryOrder!: MemoryOrder): Unit
```

Function: Performs a write operation using the memory ordering specified by `memoryOrder` to store the value specified by `val` into the atomic type.

> **Note:**
>
> This will be deprecated in future versions. Use [store(UInt16)](#func-storeuint16) instead.

Parameters:

- val: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to store in the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for this operation.> This version will be deprecated in the future. Use [store(UInt16)](#func-storeuint16) instead.

Parameters:

- val: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to be written to the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

### func swap(UInt16)

```cangjie
public func swap(val: UInt16): UInt16
```

Function: Swap operation using default memory ordering. Writes the value specified by parameter `val` to the atomic type and returns the previous value.

Parameters:

- val: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to be written to the atomic type.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value before writing.

### func swap(UInt16, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func swap(val: UInt16, memoryOrder!: MemoryOrder): UInt16
```

Function: Swap operation using the memory ordering specified by parameter `memoryOrder`. Writes the value specified by parameter `val` to the atomic type and returns the previous value.

> **Note:**
>
> This version will be deprecated in the future. Use [swap(UInt16)](#func-swapuint16) instead.

Parameters:

- val: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to be written to the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value before writing.

## class AtomicUInt32

```cangjie
public class AtomicUInt32 {
    public init(val: UInt32)
}
```

Function: Provides atomic operations for the [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type.

### init(UInt32)

```cangjie
public init(val: UInt32)
```

Function: Constructs an instance of the atomic type [AtomicUInt32](sync_package_classes.md#class-atomicuint32) encapsulating a [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) data type, with its internal data initialized to the value specified by parameter `val`.

Parameters:

- val: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The initial value of the atomic type.

### func compareAndSwap(UInt32, UInt32)

```cangjie
public func compareAndSwap(old: UInt32, new: UInt32): Bool
```

Function: CAS operation using default memory ordering.

Compares the current value of the atomic type with the value specified by parameter `old`. If they are equal, writes the value specified by parameter `new` and returns `true`; otherwise, does not write the value and returns `false`.

Parameters:

- old: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to compare with the current atomic type.
- new: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to be written to the atomic type if the comparison is successful.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the compare-and-swap operation succeeds, otherwise returns `false`.

### func compareAndSwap(UInt32, UInt32, MemoryOrder, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func compareAndSwap(old: UInt32, new: UInt32, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool
```

Function: CAS operation using the memory ordering specified by `successOrder` on success and `failureOrder` on failure.

Compares the current value of the atomic type with the value specified by parameter `old`. If they are equal, writes the value specified by parameter `new` and returns `true`; otherwise, does not write the value and returns `false`.

> **Note:**
>
> This version will be deprecated in the future. Use [compareAndSwap(UInt32, UInt32)](#func-compareandswapuint32-uint32) instead.

Parameters:

- old: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to compare with the current atomic type.
- new: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to be written to the atomic type if the comparison is successful.
- successOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the "read-modify-write" operation if the CAS operation succeeds.
- failureOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the "read" operation if the CAS operation fails.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the compare-and-swap operation succeeds, otherwise returns `false`.

### func fetchAdd(UInt32)

```cangjie
public func fetchAdd(val: UInt32): UInt32
```

Function: Performs an addition operation using default memory ordering. Adds the value specified by parameter `val` to the atomic type, writes the result to the current atomic type instance, and returns the value before the addition.

Parameters:

- val: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to be added to the atomic type.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value before the addition operation.

### func fetchAdd(UInt32, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchAdd(val: UInt32, memoryOrder!: MemoryOrder): UInt32
```

Function: Performs an addition operation using the memory ordering specified by parameter `memoryOrder`. Adds the value specified by parameter `val` to the atomic type, writes the result to the current atomic type instance, and returns the value before the addition.

> **Note:**
>
> This version will be deprecated in the future. Use [fetchAdd(UInt32)](#func-fetchadduint32) instead.

Parameters:

- val: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to be added to the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value before the addition operation.

### func fetchAnd(UInt32)

```cangjie
public func fetchAnd(val: UInt32): UInt32
```

Function: Performs a bitwise AND operation between the current atomic type instance's value and the parameter `val` using the default memory ordering. Writes the result back to the current atomic type instance and returns the value before the AND operation.

Parameters:

- val: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to perform the AND operation with the atomic type.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value before performing the AND operation.

### func fetchAnd(UInt32, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchAnd(val: UInt32, memoryOrder!: MemoryOrder): UInt32
```

Function: Performs a bitwise AND operation between the current atomic type instance's value and the parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result back to the current atomic type instance and returns the value before the AND operation.

> **Note:**
>
> This method will be deprecated in future versions. Use [fetchAnd(UInt32)](#func-fetchanduint32) instead.

Parameters:

- val: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to perform the AND operation with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for this operation.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value before performing the AND operation.

### func fetchOr(UInt32)

```cangjie
public func fetchOr(val: UInt32): UInt32
```

Function: Performs a bitwise OR operation between the current atomic type instance's value and the parameter `val` using the default memory ordering. Writes the result back to the current atomic type instance and returns the value before the OR operation.

Parameters:

- val: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to perform the OR operation with the atomic type.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value before performing the OR operation.

### func fetchOr(UInt32, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchOr(val: UInt32, memoryOrder!: MemoryOrder): UInt32
```

Function: Performs a bitwise OR operation between the current atomic type instance's value and the parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result back to the current atomic type instance and returns the value before the OR operation.

> **Note:**
>
> This method will be deprecated in future versions. Use [fetchOr(UInt32)](#func-fetchoruint32) instead.

Parameters:

- val: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to perform the OR operation with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for this operation.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value before performing the OR operation.

### func fetchSub(UInt32)

```cangjie
public func fetchSub(val: UInt32): UInt32
```

Function: Performs a subtraction operation between the current atomic type instance's value (as the minuend) and the parameter `val` (as the subtrahend) using the default memory ordering. Writes the result back to the current atomic type instance and returns the value before the subtraction.

Parameters:

- val: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to perform the subtraction with the atomic type.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value before performing the subtraction.

### func fetchSub(UInt32, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchSub(val: UInt32, memoryOrder!: MemoryOrder): UInt32
```

Function: Performs a subtraction operation between the current atomic type instance's value (as the minuend) and the parameter `val` (as the subtrahend) using the memory ordering specified by `memoryOrder`. Writes the result back to the current atomic type instance and returns the value before the subtraction.

> **Note:**
>
> This method will be deprecated in future versions. Use [fetchSub(UInt32)](#func-fetchsubuint32) instead.

Parameters:

- val: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to perform the subtraction with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for this operation.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value before performing the subtraction.

### func fetchXor(UInt32)

```cangjie
public func fetchXor(val: UInt32): UInt32
```

Function: Performs a bitwise XOR operation between the current atomic type instance's value and the parameter `val` using the default memory ordering. Writes the result back to the current atomic type instance and returns the value before the XOR operation.

Parameters:

- val: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to perform the XOR operation with the atomic type.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value before performing the XOR operation.

### func fetchXor(UInt32, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchXor(val: UInt32, memoryOrder!: MemoryOrder): UInt32
```

Function: Performs a bitwise XOR operation between the current atomic type instance's value and the parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result back to the current atomic type instance and returns the value before the XOR operation.

> **Note:**
>
> This method will be deprecated in future versions. Use [fetchXor(UInt32)](#func-fetchxoruint32) instead.

Parameters:

- val: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to perform the XOR operation with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for this operation.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value before performing the XOR operation.

### func load()

```cangjie
public func load(): UInt32
```

Function: Read operation, using the default memory ordering, to read the value of an atomic type.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The current value of the atomic type.

### func load(MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func load(memoryOrder!: MemoryOrder): UInt32
```

Function: Read operation, using the memory ordering specified by the parameter `memoryOrder`, to read the value of an atomic type.

> **Note:**
>
> This will be deprecated in future versions. Use [load()](#func-load-8) instead.

Parameters:

- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The current value of the atomic type.

### func store(UInt32)

```cangjie
public func store(val: UInt32): Unit
```

Function: Write operation, using the default memory ordering, to write the value specified by the parameter `val` into the atomic type.

Parameters:

- val: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to be written into the atomic type.

### func store(UInt32, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func store(val: UInt32, memoryOrder!: MemoryOrder): Unit
```

Function: Write operation, using the memory ordering specified by the parameter `memoryOrder`, to write the value specified by the parameter `val` into the atomic type.

> **Note:**
>
> This will be deprecated in future versions. Use [store(UInt32)](#func-storeuint32) instead.

Parameters:

- val: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to be written into the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

### func swap(UInt32)

```cangjie
public func swap(val: UInt32): UInt32
```

Function: Swap operation, using the default memory ordering, to write the value specified by the parameter `val` into the atomic type and return the previous value.

Parameters:

- val: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to be written into the atomic type.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The previous value before the write.

### func swap(UInt32, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func swap(val: UInt32, memoryOrder!: MemoryOrder): UInt32
```

Function: Swap operation, using the memory ordering specified by the parameter `memoryOrder`, to write the value specified by the parameter `val` into the atomic type and return the previous value.

> **Note:**
>
> This will be deprecated in future versions. Use [swap(UInt32)](#func-swapuint32) instead.

Parameters:

- val: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to be written into the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The previous value before the write.

## class AtomicUInt64

```cangjie
public class AtomicUInt64 {
    public init(val: UInt64)
}
```

Function: Provides atomic operations for the [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) data type.

### init(UInt64)

```cangjie
public init(val: UInt64)
```

Function: Constructs an instance of the atomic type [AtomicUInt64](sync_package_classes.md#class-atomicuint64) encapsulating a [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) data type, with its internal data initialized to the value specified by the parameter `val`.

Parameters:

- val: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The initial value of the atomic type.

### func compareAndSwap(UInt64, UInt64)

```cangjie
public func compareAndSwap(old: UInt64, new: UInt64): Bool
```

Function: CAS (Compare-And-Swap) operation, using the default memory ordering.

Compares the current value of the atomic type with the value specified by the parameter `old`. If they are equal, writes the value specified by the parameter `new` and returns `true`; otherwise, does not write the value and returns `false`.

Parameters:

- old: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to compare with the current atomic type.
- new: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to write into the atomic type if the comparison is successful.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the swap is successful, otherwise returns `false`.

### func compareAndSwap(UInt64, UInt64, MemoryOrder, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func compareAndSwap(old: UInt64, new: UInt64, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool
```

Function: CAS (Compare-And-Swap) operation, using the memory ordering specified by `successOrder` on success and `failureOrder` on failure.

Compares the current value of the atomic type with the value specified by the parameter `old`. If they are equal, writes the value specified by the parameter `new` and returns `true`; otherwise, does not write the value and returns `false`.

> **Note:**
>
> This will be deprecated in future versions. Use [compareAndSwap(UInt64, UInt64)](#func-compareandswapuint64-uint64) instead.

Parameters:- old: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to compare with the current atomic type.

- new: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to write to the atomic type if the comparison succeeds.
- successOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the "read-modify-write" operation if the CAS operation succeeds.
- failureOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the "read" operation if the CAS operation fails.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the compare-and-swap succeeds, otherwise returns `false`.

### func fetchAdd(UInt64)

```cangjie
public func fetchAdd(val: UInt64): UInt64
```

Function: Performs an addition operation between the atomic type's value and the parameter `val` using the default memory ordering, writes the result to the current atomic type instance, and returns the value before the addition.

Parameters:

- val: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to add to the atomic type.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value before the addition operation.

### func fetchAdd(UInt64, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchAdd(val: UInt64, memoryOrder!: MemoryOrder): UInt64
```

Function: Performs an addition operation between the atomic type's value and the parameter `val` using the memory ordering specified by `memoryOrder`, writes the result to the current atomic type instance, and returns the value before the addition.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchAdd(UInt64)](#func-fetchadduint64) instead.

Parameters:

- val: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to add to the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the operation.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value before the addition operation.

### func fetchAnd(UInt64)

```cangjie
public func fetchAnd(val: UInt64): UInt64
```

Function: Performs a bitwise AND operation between the current atomic type instance's value and the parameter `val` using the default memory ordering, writes the result to the current atomic type instance, and returns the value before the operation.

Parameters:

- val: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to perform the bitwise AND with the atomic type.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value before the AND operation.

### func fetchAnd(UInt64, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchAnd(val: UInt64, memoryOrder!: MemoryOrder): UInt64
```

Function: Performs a bitwise AND operation between the current atomic type instance's value and the parameter `val` using the memory ordering specified by `memoryOrder`, writes the result to the current atomic type instance, and returns the value before the operation.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchAnd(UInt64)](#func-fetchanduint64) instead.

Parameters:

- val: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to perform the bitwise AND with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the operation.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value before the AND operation.

### func fetchOr(UInt64)

```cangjie
public func fetchOr(val: UInt64): UInt64
```

Function: Performs a bitwise OR operation between the current atomic type instance's value and the parameter `val` using the default memory ordering, writes the result to the current atomic type instance, and returns the value before the operation.

Parameters:

- val: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to perform the bitwise OR with the atomic type.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value before the OR operation.

### func fetchOr(UInt64, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchOr(val: UInt64, memoryOrder!: MemoryOrder): UInt64
```

Function: Performs a bitwise OR operation between the current atomic type instance's value and the parameter `val` using the memory ordering specified by `memoryOrder`, writes the result to the current atomic type instance, and returns the value before the operation.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchOr(UInt64)](#func-fetchoruint64) instead.

Parameters:

- val: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to perform the bitwise OR with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the operation.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value before the OR operation.

### func fetchSub(UInt64)

```cangjie
public func fetchSub(val: UInt64): UInt64
```

Function: Performs a subtraction operation where the atomic type's value is the minuend and the parameter `val` is the subtrahend, using the default memory ordering, writes the result to the current atomic type instance, and returns the value before the subtraction.

Parameters:

- val: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to subtract from the atomic type.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value before the subtraction operation.

### func fetchSub(UInt64, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchSub(val: UInt64, memoryOrder!: MemoryOrder): UInt64
```

Function: Performs a subtraction operation where the atomic type's value is the minuend and the parameter `val` is the subtrahend, using the memory ordering specified by `memoryOrder`, writes the result to the current atomic type instance, and returns the value before the subtraction.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchSub(UInt64)](#func-fetchsubuint64) instead.

Parameters:

- val: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to subtract from the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the operation.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value before the subtraction operation.- val: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to perform subtraction with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value before the subtraction operation.

### func fetchXor(UInt64)

```cangjie
public func fetchXor(val: UInt64): UInt64
```

Function: Performs a bitwise XOR operation between the current atomic type instance's value and the parameter `val` using the default memory ordering. Writes the result to the current atomic type instance and returns the value before the XOR operation.

Parameters:

- val: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to perform XOR with the atomic type.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value before the XOR operation.

### func fetchXor(UInt64, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchXor(val: UInt64, memoryOrder!: MemoryOrder): UInt64
```

Function: Performs a bitwise XOR operation between the current atomic type instance's value and the parameter `val` using the specified `memoryOrder`. Writes the result to the current atomic type instance and returns the value before the XOR operation.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchXor(UInt64)](#func-fetchxoruint64) instead.

Parameters:

- val: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to perform XOR with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value before the XOR operation.

### func load()

```cangjie
public func load(): UInt64
```

Function: Performs a read operation using the default memory ordering to retrieve the atomic type's value.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The current value of the atomic type.

### func load(MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func load(memoryOrder!: MemoryOrder): UInt64
```

Function: Performs a read operation using the specified `memoryOrder` to retrieve the atomic type's value.

> **Note:**
>
> This will be deprecated in future versions. Use [load()](#func-load-9) instead.

Parameters:

- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The current value of the atomic type.

### func store(UInt64)

```cangjie
public func store(val: UInt64): Unit
```

Function: Performs a write operation using the default memory ordering to store the value specified by `val` into the atomic type.

Parameters:

- val: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to be stored in the atomic type.

### func store(UInt64, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func store(val: UInt64, memoryOrder!: MemoryOrder): Unit
```

Function: Performs a write operation using the specified `memoryOrder` to store the value specified by `val` into the atomic type.

> **Note:**
>
> This will be deprecated in future versions. Use [store(UInt64)](#func-storeuint64) instead.

Parameters:

- val: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to be stored in the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

### func swap(UInt64)

```cangjie
public func swap(val: UInt64): UInt64
```

Function: Performs an exchange operation using the default memory ordering to store the value specified by `val` into the atomic type and returns the value before the write.

Parameters:

- val: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to be stored in the atomic type.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value before the write operation.

### func swap(UInt64, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func swap(val: UInt64, memoryOrder!: MemoryOrder): UInt64
```

Function: Performs an exchange operation using the specified `memoryOrder` to store the value specified by `val` into the atomic type and returns the value before the write.

> **Note:**
>
> This will be deprecated in future versions. Use [swap(UInt64)](#func-swapuint64) instead.

Parameters:

- val: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to be stored in the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the current operation.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value before the write operation.

## class AtomicUInt8

```cangjie
public class AtomicUInt8 {
    public init(val: UInt8)
}
```

Function: Provides atomic operation functions for the [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) type.

### init(UInt8)

```cangjie
public init(val: UInt8)
```

Function: Constructs an instance of the atomic type [AtomicUInt8](sync_package_classes.md#class-atomicuint8) encapsulating a [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) data type, with its internal data initialized to the value of parameter `val`.

Parameters:

- val: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The initial value of the atomic type.

### func compareAndSwap(UInt8, UInt8)

```cangjie
public func compareAndSwap(old: UInt8, new: UInt8): Bool
```

Function: CAS (Compare-And-Swap) operation using the default memory ordering.

Compares the current value of the atomic type with the value specified by parameter `old`. If they are equal, writes the value specified by parameter `new` and returns `true`; otherwise, does not write the value and returns `false`.

Parameters:

- old: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to compare with the current atomic type.
- new: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to write to the atomic type if the comparison succeeds.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the swap is successful, otherwise returns `false`.

### func compareAndSwap(UInt8, UInt8, MemoryOrder, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func compareAndSwap(old: UInt8, new: UInt8, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool
```

Function: CAS operation using the specified memory ordering for success (`successOrder`) and failure (`failureOrder`).

Compares the current value of the atomic type with the value specified by parameter `old`. If they are equal, writes the value specified by parameter `new` and returns `true`; otherwise, does not write the value and returns `false`.

> **Note:**
>
> This will be deprecated in future versions. Use [compareAndSwap(UInt8, UInt8)](#func-compareandswapuint8-uint8) instead.

Parameters:

- old: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to compare with the current atomic type.
- new: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to write to the atomic type if the comparison succeeds.
- successOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the "read-modify-write" operation upon successful CAS.
- failureOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the "read" operation upon failed CAS.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the swap is successful, otherwise returns `false`.

### func fetchAdd(UInt8)

```cangjie
public func fetchAdd(val: UInt8): UInt8
```

Function: Performs an addition operation on the atomic type's value with parameter `val` using the default memory ordering, writes the result to the current atomic type instance, and returns the value before the addition.

Parameters:

- val: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to add to the atomic type.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value before the addition operation.

### func fetchAdd(UInt8, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchAdd(val: UInt8, memoryOrder!: MemoryOrder): UInt8
```

Function: Performs an addition operation on the atomic type's value with parameter `val` using the specified memory ordering (`memoryOrder`), writes the result to the current atomic type instance, and returns the value before the addition.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchAdd(UInt8)](#func-fetchadduint8) instead.

Parameters:

- val: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to add to the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the operation.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value before the addition operation.

### func fetchAnd(UInt8)

```cangjie
public func fetchAnd(val: UInt8): UInt8
```

Function: Performs a bitwise AND operation on the current atomic type instance's value with parameter `val` using the default memory ordering, writes the result to the current atomic type instance, and returns the value before the operation.

Parameters:

- val: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to perform the AND operation with the atomic type.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value before the AND operation.

### func fetchAnd(UInt8, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchAnd(val: UInt8, memoryOrder!: MemoryOrder): UInt8
```

Function: Performs a bitwise AND operation on the current atomic type instance's value with parameter `val` using the specified memory ordering (`memoryOrder`), writes the result to the current atomic type instance, and returns the value before the operation.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchAnd(UInt8)](#func-fetchanduint8) instead.

Parameters:

- val: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to perform the AND operation with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for the operation.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value before the AND operation.

### func fetchOr(UInt8)

```cangjie
public func fetchOr(val: UInt8): UInt8
```

Function: Performs a bitwise OR operation on the current atomic type instance's value with parameter `val` using the default memory ordering, writes the result to the current atomic type instance, and returns the value before the operation.

Parameters:

- val: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to perform the OR operation with the atomic type.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value before the OR operation.

### func fetchOr(UInt8, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchOr(val: UInt8, memoryOrder!: MemoryOrder): UInt8
```

Function: Performs a bitwise OR operation between the current atomic type instance's value and the parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result back to the current atomic type instance and returns the value before the OR operation.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchOr(UInt8)](#func-fetchoruint8) instead.

Parameters:

- val: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to perform the OR operation with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for this operation.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value before the OR operation was performed.

### func fetchSub(UInt8)

```cangjie
public func fetchSub(val: UInt8): UInt8
```

Function: Performs a subtraction operation using default memory ordering, where the atomic type's value is the minuend and parameter `val` is the subtrahend. Writes the result back to the current atomic type instance and returns the value before the subtraction.

Parameters:

- val: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to subtract from the atomic type.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value before the subtraction was performed.

### func fetchSub(UInt8, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchSub(val: UInt8, memoryOrder!: MemoryOrder): UInt8
```

Function: Performs a subtraction operation using the memory ordering specified by `memoryOrder`, where the atomic type's value is the minuend and parameter `val` is the subtrahend. Writes the result back to the current atomic type instance and returns the value before the subtraction.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchSub(UInt8)](#func-fetchsubuint8) instead.

Parameters:

- val: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to subtract from the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for this operation.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value before the subtraction was performed.

### func fetchXor(UInt8)

```cangjie
public func fetchXor(val: UInt8): UInt8
```

Function: Performs a bitwise XOR operation between the current atomic type instance's value and parameter `val` using default memory ordering. Writes the result back to the current atomic type instance and returns the value before the XOR operation.

Parameters:

- val: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to perform the XOR operation with the atomic type.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value before the XOR operation was performed.

### func fetchXor(UInt8, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func fetchXor(val: UInt8, memoryOrder!: MemoryOrder): UInt8
```

Function: Performs a bitwise XOR operation between the current atomic type instance's value and parameter `val` using the memory ordering specified by `memoryOrder`. Writes the result back to the current atomic type instance and returns the value before the XOR operation.

> **Note:**
>
> This will be deprecated in future versions. Use [fetchXor(UInt8)](#func-fetchxoruint8) instead.

Parameters:

- val: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to perform the XOR operation with the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for this operation.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value before the XOR operation was performed.

### func load()

```cangjie
public func load(): UInt8
```

Function: Performs a read operation using default memory ordering to retrieve the atomic type's value.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The current value of the atomic type.

### func load(MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func load(memoryOrder!: MemoryOrder): UInt8
```

Function: Performs a read operation using the memory ordering specified by `memoryOrder` to retrieve the atomic type's value.

> **Note:**
>
> This will be deprecated in future versions. Use [load()](#func-load-10) instead.

Parameters:

- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering for this operation.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The current value of the atomic type.

### func store(UInt8)

```cangjie
public func store(val: UInt8): Unit
```

Function: Performs a write operation using default memory ordering to store the value specified by `val` into the atomic type.

Parameters:

- val: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to store in the atomic type.

### func store(UInt8, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func store(val: UInt8, memoryOrder!: MemoryOrder): Unit
```

Function: Performs a write operation using the memory ordering specified by `memoryOrder` to store the value specified by `val` into the atomic type.

> **Note:**
>
> This will be deprecated in future versions. Use [store(UInt8)](#func-storeuint8) instead.

Parameters:- val: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to be written to the atomic type.

- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering mode for the current operation.

### func swap(UInt8)

```cangjie
public func swap(val: UInt8): UInt8
```

Function: Swap operation using the default memory ordering mode. Writes the value specified by the parameter `val` to the atomic type and returns the value before the write.

Parameters:

- val: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to be written to the atomic type.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value before the write.

### func swap(UInt8, MemoryOrder) <sup>(deprecated)</sup>

```cangjie
public func swap(val: UInt8, memoryOrder!: MemoryOrder): UInt8
```

Function: Swap operation using the memory ordering mode specified by the parameter `memoryOrder`. Writes the value specified by the parameter `val` to the atomic type and returns the value before the write.

> **Note:**
>
> This will be deprecated in future versions. Use [swap(UInt8)](#func-swapuint8) instead.

Parameters:

- val: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to be written to the atomic type.
- memoryOrder!: [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated) - The memory ordering mode for the current operation.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value before the write.

## class Barrier

```cangjie
public class Barrier {
    public init(count: Int64)
}
```

Function: Provides the capability to coordinate multiple threads to reach a specific program point.

Threads that reach the program point first will enter a blocked state. Only when all threads have reached the program point will they continue execution together.

### init(Int64)

```cangjie
public init(count: Int64)
```

Function: Creates a [Barrier](sync_package_classes.md#class-barrier) object.

Parameters:

- count: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of threads to be coordinated.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the parameter [count](../../collection/collection_package_api/collection_package_function.md#func-counttiterablet) is negative.

### func wait(Duration)

```cangjie
public func wait(timeout!: Duration = Duration.Max): Unit
```

Function: A thread enters the [Barrier](sync_package_classes.md#class-barrier) wait point.

If the total number of `wait` calls (i.e., the number of threads entering the wait point) on the [Barrier](sync_package_classes.md#class-barrier) object equals the initial value, all waiting threads are awakened. If the number of `wait` method calls is still less than the initial value, the current thread enters a blocked state until awakened or the wait time exceeds `timeout`. If the number of `wait` calls exceeds the initial value, the thread continues execution.

Parameters:

- timeout!: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The maximum duration to wait while blocked, with a default value of [Duration.Max](../../core/core_package_api/core_package_structs.md#static-const-max).

## class Monitor <sup>(deprecated)<sup>

```cangjie
public class Monitor <: ReentrantMutex {
    public init()
}
```

Function: Provides the capability for threads to block and wait for signals from other threads to resume execution.

This is a mechanism for thread synchronization using shared variables. When some threads are suspended while waiting for a certain condition on a shared variable to be met, other threads modify the shared variable to satisfy the condition and then perform a wake-up operation. This allows the suspended threads to be awakened and continue execution.

> **Note:**
>
> This will be deprecated in future versions. Use [Condition](./sync_package_interfaces.md#interface-condition) instead.

Parent Type:

- [ReentrantMutex <sup>(deprecated)</sup>](#class-reentrantmutex-deprecated)

### init()

```cangjie
public init()
```

Function: Creates a [Monitor <sup>(deprecated)</sup>](sync_package_classes.md#class-monitor-deprecated) object using the default constructor.

### func notify()

```cangjie
public func notify(): Unit
```

Function: Wakes up one thread waiting on this `Monitor`.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.

### func notifyAll()

```cangjie
public func notifyAll(): Unit
```

Function: Wakes up all threads waiting on this `Monitor`.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.

### func wait(Duration)

```cangjie
public func wait(timeout!: Duration = Duration.Max): Bool
```

Function: Suspends the current thread until the corresponding `notify` function is called or the suspension time exceeds `timeout`.

> **Note:**
>
> The thread releases the corresponding mutex lock when entering the wait state and reacquires the mutex lock upon being awakened.

Parameters:- timeout!: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - Suspension duration, with a default value of [Duration.Max](../../core/core_package_api/core_package_structs.md#static-const-max).

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the [Monitor <sup>(deprecated)</sup>](sync_package_classes.md#class-monitor-deprecated) is awakened by another thread; returns `false` if it times out.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `timeout` is less than or equal to [Duration.Zero](../../core/core_package_api/core_package_structs.md#static-const-zero).
- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.

## class MultiConditionMonitor <sup>(deprecated)<sup>

```cangjie
public class MultiConditionMonitor <: ReentrantMutex {
    public init()
}
```

Functionality: Provides the capability to bind multiple condition variables to the same mutex.

> **Note:**
>
> - This class will be deprecated in future versions. Use [Mutex](#class-mutex) instead.
> - This class should only be used when the [Monitor <sup>(deprecated)</sup>](sync_package_classes.md#class-monitor-deprecated) class is insufficient for implementing advanced concurrency algorithms.
> - Upon initialization, [MultiConditionMonitor <sup>(deprecated)</sup>](sync_package_classes.md#class-multiconditionmonitor-deprecated) has no associated condition variables.
> - Each call to `newCondition` creates a new wait queue associated with the current object and returns an instance of [ConditionID <sup>(deprecated)</sup>](sync_package_structs.md#struct-conditionid-deprecated) as a unique identifier.

Parent Type:

- [ReentrantMutex <sup>(deprecated)</sup>](#class-reentrantmutex-deprecated)

### init()

```cangjie
public init()
```

Functionality: Creates a [MultiConditionMonitor <sup>(deprecated)</sup>](sync_package_classes.md#class-multiconditionmonitor-deprecated) using the default constructor.

### func newCondition()

```cangjie
public func newCondition(): ConditionID
```

Functionality: Creates a [ConditionID <sup>(deprecated)</sup>](sync_package_structs.md#struct-conditionid-deprecated) associated with this [Monitor <sup>(deprecated)</sup>](sync_package_classes.md#class-monitor-deprecated), which can be used to implement concurrency primitives with "single mutex, multiple wait queues."

Return Value:

- [ConditionID](sync_package_structs.md#struct-conditionid-deprecated) - A new [ConditionID <sup>(deprecated)</sup>](sync_package_structs.md#struct-conditionid-deprecated).

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.

### func notify(ConditionID)

```cangjie
public func notify(condID: ConditionID): Unit
```

Functionality: Wakes up a thread waiting on the specified condition variable (if any).

Parameters:

- condID: [ConditionID](sync_package_structs.md#struct-conditionid-deprecated) - The condition variable.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex or if `condID` was not created by this [MultiConditionMonitor <sup>(deprecated)</sup>](sync_package_classes.md#class-multiconditionmonitor-deprecated) instance via the `newCondition` function.

### func notifyAll(ConditionID)

```cangjie
public func notifyAll(condID: ConditionID): Unit
```

Functionality: Wakes up all threads waiting on the specified condition variable (if any).

Parameters:

- condID: [ConditionID](sync_package_structs.md#struct-conditionid-deprecated) - The condition variable.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex or if `condID` was not created by this [MultiConditionMonitor <sup>(deprecated)</sup>](sync_package_classes.md#class-multiconditionmonitor-deprecated) instance via the `newCondition` function.

### func wait(ConditionID, Duration)

```cangjie
public func wait(condID: ConditionID, timeout!: Duration = Duration.Max): Bool
```

Functionality: Suspends the current thread until the corresponding `notify` function is called.

> **Note:**
>
> The thread releases the associated mutex when entering the wait state and reacquires it upon being awakened.

Parameters:

- condID: [ConditionID](sync_package_structs.md#struct-conditionid-deprecated) - The condition variable.
- timeout!: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - Suspension duration, with a default value of [Duration.Max](../../core/core_package_api/core_package_structs.md#static-const-max).

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the specified condition variable of this [Monitor <sup>(deprecated)</sup>](sync_package_classes.md#class-monitor-deprecated) is awakened by another thread; returns `false` if it times out.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex, if the suspension duration exceeds `timeout`, or if `condID` was not created by this [MultiConditionMonitor <sup>(deprecated)</sup>](sync_package_classes.md#class-multiconditionmonitor-deprecated) instance via the `newCondition` function.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `timeout` is less than or equal to [Duration.Zero](../../core/core_package_api/core_package_structs.md#static-const-zero).

## class Mutex

```cangjie
public class Mutex <: UniqueLock {
    public init()
}
```

Functionality: Provides reentrant mutex-related capabilities.

A reentrant mutex protects critical sections, ensuring that only one thread can execute the critical section code at any given time. When a thread attempts to acquire a lock held by another thread, it is blocked until the lock is released. Reentrancy means a thread can acquire the same lock multiple times.

> **Note:**
>
> - The lock must be acquired before accessing shared data.
> - The lock must be released after processing shared data to allow other threads to acquire it.

Parent Type:

- [UniqueLock](./sync_package_interfaces.md#interface-uniquelock)

### init()

```cangjie
public init()
```

Functionality: Creates a reentrant mutex.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown when a system error occurs.

### func condition()

```cangjie
public func condition(): Condition
```

Function: Creates a [Condition](./sync_package_interfaces.md#interface-condition) associated with this [Mutex](#class-mutex).

Can be used to implement concurrent primitives with "single Lock multiple wait queues" pattern.

Return value:

- [Condition](./sync_package_interfaces.md#interface-condition) - The created [Condition](./sync_package_interfaces.md#interface-condition) instance associated with this [Mutex](#class-mutex).

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold this mutex.

### func lock()

```cangjie
public func lock(): Unit
```

Function: Locks the mutex, blocks if the mutex is already locked.

### func tryLock()

```cangjie
public func tryLock(): Bool
```

Function: Attempts to lock the mutex.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `false` if the mutex is already locked; otherwise, locks the mutex and returns `true`.

### func unlock

```cangjie
public func unlock(): Unit
```

Function: Unlocks the mutex.

If the mutex has been locked N times recursively, this function needs to be called N times to fully unlock it. Once the mutex is completely unlocked, if there are other threads blocked on this lock, one of them will be awakened.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold this mutex.

## class ReadWriteLock

```cangjie
public class ReadWriteLock {
    public init(fair!: Bool = false)
}
```

Function: Provides reentrant read-write lock functionality.

The difference from ordinary mutex locks is that a read-write lock carries two mutex locks simultaneously: a "read lock" and a "write lock", and it allows multiple threads to hold read locks concurrently.

Special properties of read-write locks:

- Write exclusivity: Only one thread can hold the write lock. When a thread holds the write lock, other threads attempting to acquire any lock (read or write) will be blocked.
- Read concurrency: Allows multiple threads to hold read locks simultaneously. When a thread holds a read lock, other threads can still acquire read locks, but attempts to acquire write locks will be blocked.
- Reentrancy: A thread can acquire locks multiple times.
  - When a thread holds the write lock, it can continue to acquire either write locks or read locks. The lock is only fully released when unlock operations match the number of lock operations.
  - When a thread holds a read lock, it can continue to acquire read locks. The lock is only fully released when unlock operations match the number of lock operations. Note: acquiring a write lock while holding a read lock is prohibited and will throw an exception.
- Lock downgrade: A thread can transition from "holding write lock → holding read lock → releasing write lock" to end up holding only a read lock.
- Read-write fairness: Read-write locks support two modes: "fair" and "non-fair".
  - In non-fair mode, the read-write lock makes no guarantees about the order in which threads acquire locks.
  - In fair mode, when a thread attempts to acquire a read lock (without currently holding any read lock), if the write lock is held or there are threads waiting for the write lock, the current thread cannot acquire the read lock and will wait.
  - In fair mode, write lock release will prioritize waking all waiting read threads, while read lock release will prioritize waking one write-waiting thread. When multiple threads wait for the write lock, their wake-up order is not guaranteed.

### prop readLock

```cangjie
public prop readLock: Lock
```

Function: Gets the read lock.

Type: [Lock](./sync_package_interfaces.md#interface-lock)

### prop writeLock

```cangjie
public prop writeLock: UniqueLock
```

Function: Gets the write lock.

Type: [UniqueLock](./sync_package_interfaces.md#interface-uniquelock)

### init(Bool)

```cangjie
public init(fair!: Bool = false)
```

Function: Constructs a read-write lock.

Parameters:

- fair!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the read-write lock operates in fair mode. Default is `false` (non-fair mode).

### func isFair()

```cangjie
public func isFair(): Bool
```

Function: Checks whether the read-write lock is in "fair" mode.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` indicates fair mode, otherwise indicates non-fair mode.

## class ReentrantMutex <sup>(deprecated)<sup>

```cangjie
public open class ReentrantMutex <: IReentrantMutex {
    public init()
}
```

Function: Provides reentrant lock functionality.

Reentrant mutex locks protect critical sections by ensuring that at most one thread can execute the critical section code at any time. When a thread attempts to acquire a lock held by another thread, it blocks until the lock is released. Reentrancy means a thread can acquire the same lock multiple times.

> **Note:**
>
> - Will be deprecated in future versions; use [Mutex](#class-mutex) instead.
> - [ReentrantMutex <sup>(deprecated)</sup>](sync_package_classes.md#class-reentrantmutex-deprecated) is a built-in mutex lock; developers must ensure they do not inherit from it.
> - The lock must be acquired before accessing shared data.
> - The lock must be released after processing shared data to allow other threads to acquire it.

Parent type:

- [IReentrantMutex <sup>(deprecated)</sup>](sync_package_interfaces.md#interface-ireentrantmutex-deprecated)

### init()

```cangjie
public init()
```

Function: Creates a reentrant mutex lock.Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown when a system error occurs.

### func lock()

```cangjie
public open func lock(): Unit
```

Function: Locks the mutex. If the mutex is already locked, the calling thread will block.

### func tryLock()

```cangjie
public open func tryLock(): Bool
```

Function: Attempts to lock the mutex.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `false` if the mutex is already locked; otherwise, locks the mutex and returns `true`.

### func unlock

```cangjie
public open func unlock(): Unit
```

Function: Unlocks the mutex.

If the mutex has been locked N times, this function must be called N times to fully unlock it. Once the mutex is fully unlocked, if there are other threads blocked on this lock, one of them will be awakened.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.

## class ReentrantReadMutex <sup>(deprecated)<sup>

```cangjie
public class ReentrantReadMutex <: ReentrantMutex
```

Function: Provides the read lock type for reentrant read-write locks.

> **Note:**
>
> This will be deprecated in future versions. Use [Lock](./sync_package_interfaces.md#interface-lock) instead.

Parent type:

- [ReentrantMutex <sup>(deprecated)</sup>](#class-reentrantmutex-deprecated)

### func lock()

```cangjie
public func lock(): Unit
```

Function: Acquires the read lock.

> **Note:**
>
> - In fair mode, if no other thread holds or is waiting for the write lock, or if the current thread already holds the read lock, the read lock is acquired immediately; otherwise, the current thread enters a waiting state.
> - In unfair mode, if no other thread holds or is waiting for the write lock, the read lock is acquired immediately; if another thread holds the write lock, the current thread enters a waiting state; otherwise, there is no guarantee that the thread will acquire the read lock immediately.
> - Multiple threads can hold the read lock simultaneously, and a thread can hold the read lock multiple times. If a thread holds the write lock, it can still hold the read lock.

### func tryLock()

```cangjie
public func tryLock(): Bool
```

Function: Attempts to acquire the read lock. This method does not follow fair mode when acquiring the read lock.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the read lock is successfully acquired; otherwise, returns `false`.

### func unlock()

```cangjie
public func unlock(): Unit
```

Function: Releases the read lock. If a thread holds the read lock multiple times, the read lock is only released when the number of unlock operations matches the number of lock operations. If the read lock is released and there are threads waiting for the write lock, one of them will be awakened.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the read lock.

## class ReentrantReadWriteMutex <sup>(deprecated)<sup>

```cangjie
public class ReentrantReadWriteMutex {
    public init(mode!: ReadWriteMutexMode = ReadWriteMutexMode.Unfair)
}
```

Function: Provides functionality for reentrant read-write locks.

The difference between this and a regular mutex is that a read-write lock carries two mutexes: a "read lock" and a "write lock," and it allows multiple threads to hold the read lock simultaneously.

> **Note:**
>
> This will be deprecated in future versions. Use [ReadWriteLock](#class-readwritelock) instead.

Special properties of read-write locks:

- **Write exclusivity**: Only one thread can hold the write lock. When a thread holds the write lock, other threads attempting to acquire any lock (read or write) will be blocked.
- **Read concurrency**: Allows multiple threads to hold the read lock simultaneously. When a thread holds the read lock, other threads can still acquire the read lock but will be blocked when attempting to acquire the write lock.
- **Reentrancy**: A thread can acquire the lock multiple times.
  - If a thread already holds the write lock, it can continue to acquire the write lock or the read lock. The lock is only fully released when the number of unlock operations matches the number of lock operations.
  - If a thread already holds the read lock, it can continue to acquire the read lock. The lock is only fully released when the number of unlock operations matches the number of lock operations. Note that acquiring the write lock while holding the read lock is not allowed and will throw an exception.
- **Lock downgrade**: A thread can transition from holding the write lock to holding the read lock by performing "hold write lock → hold read lock → release write lock."
- **Fairness**: Read-write locks support two modes: "fair" and "unfair."
  - In unfair mode, the order in which threads acquire the lock is not guaranteed.
  - In fair mode, when a thread attempts to acquire the read lock (and does not already hold it), if the write lock is held or there are threads waiting for the write lock, the thread will be unable to acquire the read lock and will enter a waiting state.
  - In fair mode, releasing the write lock will prioritize waking up all waiting read threads, and releasing the read lock will prioritize waking up one waiting write thread. If multiple threads are waiting for the write lock, the order in which they are awakened is not guaranteed.

### prop readMutex

```cangjie
public prop readMutex: ReentrantReadMutex
```

Function: Gets the read lock.

Type: [ReentrantReadMutex <sup>(deprecated)</sup>](sync_package_classes.md#class-reentrantreadmutex-deprecated)

### prop writeMutex

```cangjie
public prop writeMutex: ReentrantWriteMutex
```

Function: Gets the write lock.

Type: [ReentrantWriteMutex <sup>(deprecated)</sup>](sync_package_classes.md#class-reentrantwritemutex-deprecated)

### init(ReadWriteMutexMode)

```cangjie
public init(mode!: ReadWriteMutexMode = ReadWriteMutexMode.Unfair)
```

Function: Constructs a read-write lock.Parameters:

- mode!: [ReadWriteMutexMode <sup>(deprecated)</sup>](sync_package_enums.md#enum-readwritemutexmode-deprecated) - Read-write lock mode, default value is `Unfair`, which constructs an "unfair" read-write lock.

## class ReentrantWriteMutex <sup>(deprecated)<sup>

```cangjie
public class ReentrantWriteMutex <: ReentrantMutex
```

Function: Provides the write lock type in a reentrant read-write lock.

> **Note:**
>
> Will be deprecated in future versions, use [UniqueLock](./sync_package_interfaces.md#interface-uniquelock) instead.

Parent Types:

- [ReentrantMutex <sup>(deprecated)</sup>](#class-reentrantmutex-deprecated)

### func lock()

```cangjie
public func lock(): Unit
```

Function: Acquires the write lock. Only a single thread can hold the write lock, and this thread can repeatedly acquire it multiple times. If other threads hold either write locks or read locks, the current thread enters a waiting state.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - The current thread already holds a read lock.

### func tryLock()

```cangjie
public func tryLock(): Bool
```

Function: Attempts to acquire the write lock. This method does not follow fair mode when acquiring the read lock.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the write lock is successfully acquired; returns `false` if the write lock cannot be acquired.

### func unlock()

```cangjie
public func unlock(): Unit
```

Function: Releases the write lock.

> **Note:**
>
> - If a thread holds the read lock multiple times, the read lock is only released when the number of release operations matches the number of acquire operations. If the read lock is released and there are threads waiting for the write lock, one of them is awakened.
> - In fair mode, if the write lock is released and there are threads waiting for read locks, these waiting threads are prioritized for awakening. If no threads are waiting for read locks but there are threads waiting for write locks, one of them is awakened.
> - In unfair mode, if the write lock is released, there is no guarantee whether threads waiting for write locks or read locks will be awakened first; this is left to the implementation's discretion.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - The current thread does not hold the write lock.

## class Semaphore

```cangjie
public class Semaphore {
    public init(count: Int64)
}
```

Function: Provides semaphore-related functionality.

[Semaphore](sync_package_classes.md#class-semaphore) can be considered as a [Monitor <sup>(deprecated)</sup>](sync_package_classes.md#class-monitor-deprecated) with a counter, commonly used to control the number of threads accessing shared resources concurrently.

### prop count

```cangjie
public prop count: Int64
```

Function: Returns the current value of the internal counter.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### init(Int64)

```cangjie
public init(count: Int64)
```

Function: Creates a [Semaphore](sync_package_classes.md#class-semaphore) object and initializes the value of the internal counter.

Parameters:

- [count](../../collection/collection_package_api/collection_package_function.md#func-counttiterablet): [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Initial value of the counter, range [0, [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).Max].

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the parameter [count](../../collection/collection_package_api/collection_package_function.md#func-counttiterablet) is negative.

### func acquire(Int64)

```cangjie
public func acquire(amount!: Int64 = 1): Unit
```

Function: Acquires the specified value from the [Semaphore](sync_package_classes.md#class-semaphore) object.

If the current counter value is less than the requested amount, the current thread will be blocked until it acquires the required amount.

Parameters:

- amount!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The amount to acquire from the object's internal counter, default value is 1.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the parameter `amount` is negative or exceeds the initial value.

### func release(Int64)

```cangjie
public func release(amount!: Int64 = 1): Unit
```

Function: Releases the specified value to the [Semaphore](sync_package_classes.md#class-semaphore) object.

If the internal counter, after incrementing by the released amount, can satisfy any threads currently blocked on the [Semaphore](sync_package_classes.md#class-semaphore) object, those threads are awakened. The internal counter's value will not exceed the initial value; if the counter's value after incrementing would exceed the initial value, it is set to the initial value instead. All operations before calling `release` happen before operations after calling `acquire/tryAcquire`.

Parameters:

- amount!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The amount to release to the object's internal counter, default value is 1.

Return Value:

- [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - Returns `false` if the current counter value is less than the requested amount, indicating failure to acquire; returns `true` if the acquisition is successful.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the parameter `amount` is negative or exceeds the initial value.

### func tryAcquire(Int64)

```cangjie
public func tryAcquire(amount!: Int64 = 1): Bool
```

Function: Attempts to acquire the specified value from the [Semaphore](sync_package_classes.md#class-semaphore) object.

This method does not block the thread. If multiple threads concurrently perform acquisition operations, the order of acquisition between threads is not guaranteed.Parameters:

- `amount!`: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to be retrieved from the object's internal counter, with a default value of 1.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `false` if the current counter value is less than the requested amount, indicating retrieval failure; returns `true` upon successful retrieval.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when parameter `amount` is negative or exceeds the initial value.

## class SyncCounter

```cangjie
public class SyncCounter {
    public init(count: Int64)
}
```

Functionality: Provides countdown counter capability.

Threads can wait until the counter reaches zero.

### prop count

```cangjie
public prop count: Int64
```

Functionality: Gets the current value of the counter.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### init(Int64)

```cangjie
public init(count: Int64)
```

Functionality: Creates a countdown counter.

Parameters:

- [count](../../collection/collection_package_api/collection_package_function.md#func-counttiterablet): [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The initial value of the countdown counter.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when parameter [count](../../collection/collection_package_api/collection_package_function.md#func-counttiterablet) is negative.

### func dec()

```cangjie
public func dec(): Unit
```

Functionality: Decrements the counter by one.

If the counter reaches zero, all waiting threads are awakened; if the counter is already zero, the value remains unchanged.

### func waitUntilZero(Duration)

```cangjie
public func waitUntilZero(timeout!: Duration = Duration.Max): Unit
```

Functionality: Causes the current thread to wait until the counter reaches zero or the specified `timeout` duration elapses.

Parameters:

- `timeout!`: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The maximum duration to block while waiting, with a default value of [Duration.Max](../../core/core_package_api/core_package_structs.md#static-const-max).

## class Timer

```cangjie
public class Timer <: Equatable<Timer> & Hashable
```

Functionality: Provides timer capability.

Used to execute specified tasks once or repeatedly at designated time points or after specified intervals.

> **Note:**
>
> - [Timer](sync_package_classes.md#class-timer) implicitly includes a `spawn` operation, meaning each [Timer](sync_package_classes.md#class-timer) creates a thread to execute its associated Task.
> - Each [Timer](sync_package_classes.md#class-timer) can only bind to one Task during initialization. After initialization, the associated Task cannot be reset.
> - The lifecycle of a [Timer](sync_package_classes.md#class-timer) ends only when its associated Task completes or when actively canceled via the `cancel` interface, after which it can be reclaimed by [GC](../../runtime/runtime_package_api/runtime_package_funcs.md#func-gcbool). In other words, a [Timer](sync_package_classes.md#class-timer) instance will not be reclaimed by [GC](../../runtime/runtime_package_api/runtime_package_funcs.md#func-gcbool) until its associated Task completes or the timer is actively canceled, ensuring the Task executes normally.
> - When the system is busy, Task execution timing may be affected. [Timer](sync_package_classes.md#class-timer) does not guarantee exact Task execution timing but ensures execution occurs no later than the designated time.
> - [Timer](sync_package_classes.md#class-timer) does not automatically catch exceptions thrown by its associated Task. Any uncaught exception will render the [Timer](sync_package_classes.md#class-timer) invalid.
> - [Timer](sync_package_classes.md#class-timer) is typically categorized into one-shot timers and recurring timers. One-shot timers execute their Task once, while recurring timers execute their Task at specified intervals until actively canceled via the `cancel` interface or meeting the termination conditions specified during creation.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[Timer](#class-timer)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)

### static func after(Duration, ()->Option\<Duration>)

```cangjie
public static func after(delay: Duration, task: () -> Option<Duration>): Timer
```

Functionality: Initializes a [Timer](sync_package_classes.md#class-timer) whose associated Task's execution frequency depends on its return value. If the first scheduled execution time is earlier than the current time, the Task executes immediately. If the Task returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont).None, the [Timer](sync_package_classes.md#class-timer) becomes invalid and stops scheduling the Task. If the Task returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont).Some(v) with `v` greater than [Duration.Zero](../../core/core_package_api/core_package_structs.md#static-const-zero), `v` becomes the minimum interval before the next execution. Otherwise, the Task executes again immediately.

Parameters:

- `delay`: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The time interval from now until the first scheduled execution of the Task.
- `task`: () ->[Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Duration](../../core/core_package_api/core_package_structs.md#struct-duration)> - The Task to be scheduled by this [Timer](sync_package_classes.md#class-timer).

Return Value:

- [Timer](sync_package_classes.md#class-timer) - A [Timer](sync_package_classes.md#class-timer) instance.

### static func once(Duration, ()->Unit)

```cangjie
public static func once(delay: Duration, task: ()->Unit): Timer
```

Functionality: Sets and starts a one-shot timer task, returning a [Timer](sync_package_classes.md#class-timer) instance controlling this task.

Parameters:

- `delay`: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The time interval from now until Task execution. Valid range: [[Duration.Min](../../core/core_package_api/core_package_structs.md#static-const-min), [Duration.Max](../../core/core_package_api/core_package_structs.md#static-const-max)]. Tasks execute immediately if `delay` is less than or equal to [Duration.Zero](../../core/core_package_api/core_package_structs.md#static-const-zero).
- `task`: ()->Unit - The task to be executed.

Return Value:

- [Timer](sync_package_classes.md#class-timer) - The created instance.

Example:

<!-- run -->

```cangjie
import std.time.MonoTime
import std.sync.Timer

main() {
    let start = MonoTime.now()
    Timer.once(Duration.second, {=>
        println("Tick at: ${MonoTime.now() - start}")
    })

    sleep(Duration.second * 2)
    0
}
```

Possible execution result:

```text
Tick at: 1s2ms74us551ns
```

### static func repeat(Duration, Duration, ()->Unit, CatchupStyle)

```cangjie
public static func repeat(delay: Duration, interval: Duration, task: ()->Unit, style!: CatchupStyle = Burst): Timer
```

Function: Sets up and starts a recurring timer task, returning a [Timer](sync_package_classes.md#class-timer) object instance to control this task.

Parameters:

- delay: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The time interval from now until the Task is executed. Valid range: [[Duration.Min](../../core/core_package_api/core_package_structs.md#static-const-min), [Duration.Max](../../core/core_package_api/core_package_structs.md#static-const-max)]. If less than or equal to [Duration.Zero](../../core/core_package_api/core_package_structs.md#static-const-zero), the Task will be executed immediately.
- interval: [Duration](../../../std_en/core/core_package_api/core_package_structs.md#struct-duration) - The time interval between two Task executions. Valid range: ([Duration.Zero](../../core/core_package_api/core_package_structs.md#static-const-zero), [Duration.Max](../../core/core_package_api/core_package_structs.md#static-const-max)].
- task: ()->Unit - The task to be executed periodically.
- style!: [CatchupStyle](./sync_package_enums.md#enum-catchupstyle) - Catch-up strategy, defaults to Burst. When Task execution takes too long, subsequent task execution times may be delayed. Different catch-up strategies suit different scenarios. See [CatchupStyle](sync_package_enums.md#enum-catchupstyle) for details.

Return value:

- [Timer](sync_package_classes.md#class-timer) - The created object instance.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when `interval` is less than or equal to [Duration.Zero](../../core/core_package_api/core_package_structs.md#static-const-zero).

Example:

<!-- run -->

```cangjie
import std.sync.Timer
import std.time.MonoTime

main() {
    let start = MonoTime.now()
    let timer = Timer.repeat(Duration.second, Duration.second, {=>
        println("Tick at: ${MonoTime.now() - start}")
    })

    sleep(Duration.second * 5)
    timer.cancel()
    0
}
```

Possible output:

```text
Tick at: 1s2ms72us188ns
Tick at: 2s4ms185us160ns
Tick at: 3s6ms275us464ns
Tick at: 4s8ms18us399ns
```

### static func repeatDuring(Duration, Duration, Duration, ()->Unit, CatchupStyle)

```cangjie
public static func repeatDuring(period: Duration, delay: Duration, interval: Duration, task: () -> Unit, style!: CatchupStyle = Burst): Timer
```

Function: Sets up and starts a recurring timer task with a maximum duration for the repetition period, returning a [Timer](sync_package_classes.md#class-timer) object instance to control this task.

Parameters:

- period: [Duration](../../../std_en/core/core_package_api/core_package_structs.md#struct-duration) - Maximum duration of the repetition period, starting after the delay. Valid range: ([Duration.Zero](../../core/core_package_api/core_package_structs.md#static-const-zero), [Duration.Max](../../core/core_package_api/core_package_structs.md#static-const-max)].
- delay: [Duration](../../../std_en/core/core_package_api/core_package_structs.md#struct-duration) - The time interval from now until the Task is executed. Valid range: [Duration.Min, [Duration.Max](../../core/core_package_api/core_package_structs.md#static-const-max)]. If less than or equal to [Duration.Zero](../../core/core_package_api/core_package_structs.md#static-const-zero), the Task will be executed immediately.
- interval: [Duration](../../../std_en/core/core_package_api/core_package_structs.md#struct-duration) - The time interval between two Task executions. Valid range: ([Duration.Zero](../../core/core_package_api/core_package_structs.md#static-const-zero), [Duration.Max](../../core/core_package_api/core_package_structs.md#static-const-max)].
- task: ()->Unit - The task to be executed periodically.
- style!: [CatchupStyle](./sync_package_enums.md#enum-catchupstyle) - Catch-up strategy, defaults to Burst. When Task execution takes too long, subsequent task execution times may be delayed. Different catch-up strategies suit different scenarios. See [CatchupStyle](sync_package_enums.md#enum-catchupstyle) for details.

Return value:

- [Timer](sync_package_classes.md#class-timer) - The created object instance.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception): Thrown when period is less than or equal to [Duration.Zero](../../core/core_package_api/core_package_structs.md#static-const-zero) or interval is less than or equal to [Duration.Zero](../../core/core_package_api/core_package_structs.md#static-const-zero).

Example:

<!-- run -->

```cangjie
import std.sync.Timer
import std.time.MonoTime

main() {
    let start = MonoTime.now()
    Timer.repeatDuring(Duration.second * 5, Duration.second, Duration.second, {=>
        println("Tick at: ${MonoTime.now() - start}")
    })

    sleep(Duration.second * 7)
    0
}
```

Possible output:

```text
Tick at: 1s2ms372us626ns
Tick at: 2s4ms714us879ns
Tick at: 3s6ms769us623ns
Tick at: 4s8ms780us235ns
Tick at: 5s660us104ns
Tick at: 6s3ms257us508ns
```

### static func repeatTimes(Int64, Duration, Duration, ()->Unit, CatchupStyle)

```cangjie
public static func repeatTimes(count: Int64, delay: Duration, interval: Duration, task: () -> Unit, style!: CatchupStyle = Burst): Timer
```

Function: Sets up and starts a recurring timer task with a maximum execution count for the Task, returning a [Timer](sync_package_classes.md#class-timer) object instance to control this task.

Parameters:

- count: [Int64](../../../std_en/core/core_package_api/core_package_intrinsics.md#int64) - Maximum execution count for the Task. Valid range: (0, [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).Max].
- delay: [Duration](../../../std_en/core/core_package_api/core_package_structs.md#struct-duration) - The time interval from now until the Task is executed. Valid range: [Duration.Min, [Duration.Max](../../core/core_package_api/core_package_structs.md#static-const-max)]. If less than or equal to [Duration.Zero](../../core/core_package_api/core_package_structs.md#static-const-zero), the Task will be executed immediately.
- interval: [Duration](../../../std_en/core/core_package_api/core_package_structs.md#struct-duration) - The time interval between two Task executions. Valid range: ([Duration.Zero](../../core/core_package_api/core_package_structs.md#static-const-zero), [Duration.Max](../../core/core_package_api/core_package_structs.md#static-const-max)].
- task: ()->Unit - The task to be executed periodically.
- style!: [CatchupStyle](./sync_package_enums.md#enum-catchupstyle) - Catch-up strategy, defaults to Burst. When Task execution takes too long, subsequent task execution times may be delayed. Different catch-up strategies suit different scenarios. See [CatchupStyle](sync_package_enums.md#enum-catchupstyle) for details.

Return value:

- [Timer](sync_package_classes.md#class-timer) - The created object instance.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when [count](../../collection/collection_package_api/collection_package_function.md#func-counttiterablet) <= 0 or interval is less than or equal to [Duration.Zero](../../core/core_package_api/core_package_structs.md#static-const-zero).

Example:

<!-- run -->

```cangjie
import std.sync.Timer
import std.time.MonoTime

main() {
    let start = MonoTime.now()
    Timer.repeatTimes(3, Duration.second, Duration.second, {=>
        println("Tick at: ${MonoTime.now() - start}")
    })

    sleep(Duration.second * 4)
    0
}
```

Possible execution result:

```text
Tick at: 1s2ms855us251ns
Tick at: 2s5ms390us18ns
Tick at: 3s7ms935us552ns
```

### func cancel()

```cangjie
public func cancel(): Unit
```

Function: Cancels this [Timer](sync_package_classes.md#class-timer), and the associated Task will no longer be scheduled for execution.

If the associated Task is executing when this function is called, the current execution will not be interrupted. This function does not block the current thread. Calling this function multiple times is equivalent to calling it once.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Gets the hash value of the [Timer](sync_package_classes.md#class-timer) object.

Return value:

- [Int64](../../../std_en/core/core_package_api/core_package_intrinsics.md#int64) - The hash value of the object.

### operator func !=(Timer)

```cangjie
public operator func !=(rhs: Timer): Bool
```

Function: Determines whether the current [Timer](sync_package_classes.md#class-timer) and the [Timer](sync_package_classes.md#class-timer) specified by the parameter `rhs` are not the same instance.

Parameters:

- rhs: [Timer](#class-timer) - Another [Timer](#class-timer) object to compare.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the two [Timer](sync_package_classes.md#class-timer) instances are not the same, otherwise returns `false`.

### operator func ==(Timer)

```cangjie
public operator func ==(rhs: Timer): Bool
```

Function: Determines whether the current [Timer](sync_package_classes.md#class-timer) and the [Timer](sync_package_classes.md#class-timer) specified by the parameter `rhs` are the same instance.

Parameters:

- rhs: [Timer](#class-timer) - Another [Timer](#class-timer) object to compare.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the two [Timer](sync_package_classes.md#class-timer) instances are the same, otherwise returns `false`.
