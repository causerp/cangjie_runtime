# Functions

## func all\<T>((T) -> Bool)

```cangjie
public func all<T>(predicate: (T) -> Bool): (Iterable<T>) -> Bool
```

Function: Determines whether all elements in the iterator satisfy the given condition.

Parameters:

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The condition to test.

Returns:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns a function that checks if all elements satisfy the condition.

Example:

<!-- verify -->
```cangjie
import std.collection.*

func isPositive(x: Int64): Bool {
    return x > 0
}

main() {
    // Create a function to check if all elements are positive
    let allPositive = all<Int64>(isPositive)
    
    // Test case where all elements are positive
    let list1 = ArrayList.of([1, 2, 3, 4, 5])
    let result1 = allPositive(list1)
    println("All elements are positive: ${result1}")
    
    // Test case where not all elements are positive
    let list2 = ArrayList.of([1, -2, 3, 4, 5])
    let result2 = allPositive(list2)
    println("All elements are positive: ${result2}")
    
    return 0
}
```

Output:

```text
All elements are positive: true
All elements are positive: false
```

## func any\<T>((T) -> Bool)

```cangjie
public func any<T>(predicate: (T) -> Bool): (Iterable<T>) -> Bool
```

Function: Determines whether any element in the iterator satisfies the given condition.

Parameters:

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The condition to test.

Returns:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns a function that checks if any element satisfies the condition.

Example:

<!-- verify -->
```cangjie
import std.collection.*

func isNegative(x: Int64): Bool {
    return x < 0
}

main() {
    // Create a function to check if any element is negative
    let hasNegative = any<Int64>(isNegative)
    
    // Test case with no negative elements
    let list1 = ArrayList.of([1, 2, 3, 4, 5])
    let result1 = hasNegative(list1)
    println("Contains negative: ${result1}")
    
    // Test case with negative elements
    let list2 = ArrayList.of([1, -2, 3, 4, 5])
    let result2 = hasNegative(list2)
    println("Contains negative: ${result2}")
    
    return 0
}
```

Output:

```text
Contains negative: false
Contains negative: true
```

## func at\<T>(Int64)

```cangjie
public func at<T>(n: Int64): (Iterable<T>) -> Option<T>
```

Function: Retrieves the element at the specified position in the iterator.

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index position.

Returns:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns a function that gets the element at the specified position, returns None if the iterator is empty.

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // Create a function to get element at position 2
    let getElementAt = at<Int64>(2)
    
    // Test case where position exists
    let list1 = ArrayList.of([10, 20, 30, 40, 50])
    let result1 = getElementAt(list1)
    match (result1) {
        case Some(value) => println("Element at position 2: ${value}")
        case None => println("No element at position 2")
    }
    
    // Test case where position doesn't exist
    let list2 = ArrayList.of([10, 20])
    let result2 = getElementAt(list2)
    match (result2) {
        case Some(value) => println("Element at position 2: ${value}")
        case None => println("No element at position 2")
    }
    
    return 0
}
```

Output:

```text
Element at position 2: 30
No element at position 2
```

## func collectArrayList\<T>(Iterable\<T>)

```cangjie
public func collectArrayList<T>(it: Iterable<T>): ArrayList<T>
```

Function: Converts an iterator to [ArrayList](collection_package_class.md#class-arraylistt) type.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The input iterator.

Returns:

- [ArrayList](collection_package_class.md#class-arraylistt)\<T> - Returns an [ArrayList](collection_package_class.md#class-arraylistt).

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // Create an array
    let hashSet = [1, 2, 3, 4, 5]
    let iterator = hashSet.iterator()
    
    // Convert iterator to ArrayList
    let arrayList = collectArrayList<Int64>(iterator)
    println("ArrayList size: ${arrayList.size}")
    println("ArrayList content: ${arrayList}")
    
    return 0
}
```

Output:

```text
ArrayList size: 5
ArrayList content: [1, 2, 3, 4, 5]
```

## func collectArray\<T>(Iterable\<T>)

```cangjie
public func collectArray<T>(it: Iterable<T>): Array<T>
```

Function: Converts an iterator to [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt) type.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The input iterator.

Returns:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - Returns an array.

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // Create an ArrayList
    let hashSet = [1, 2, 3, 4, 5]
    let iterator = hashSet.iterator()
    
    // Convert iterator to array
    let array = collectArray<Int64>(iterator)
    println("Array size: ${array.size}")
    println("Array content: ${array}")
    
    return 0
}
```

Output:

```text
Array size: 5
Array content: [1, 2, 3, 4, 5]
```

## func collectHashMap\<K, V>(Iterable\<(K, V)>) where K <: Hashable & Equatable\<K>

```cangjie
public func collectHashMap<K, V>(it: Iterable<(K, V)>): HashMap<K, V> where K <: Hashable & Equatable<K>
```

Function: Converts an iterator to [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) type.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<(K, V)> - The input iterator of key-value pairs.

Returns:

- [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V> - Returns a [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // Create an array of key-value pairs
    let pairs = [(1, "one"), (2, "two"), (3, "three")]
    let iterator = pairs.iterator()
    
    // Convert iterator to HashMap
    let hashMap = collectHashMap<Int64, String>(iterator)
    println("HashMap size: ${hashMap.size}")
    println("HashMap content: ${hashMap}")
    
    return 0
}
```

Output:

```text
HashMap size: 3
HashMap content: [(1, one), (2, two), (3, three)]
```

## func collectHashSet\<T>(Iterable\<T>) where T <: Hashable & Equatable\<T>

```cangjie
public func collectHashSet<T>(it: Iterable<T>): HashSet<T> where T <: Hashable & Equatable<T>
```

Function: Converts an iterator to [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) type (automatically removes duplicates).

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The input iterator.

Returns:

- [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - Returns a [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // Create an array with duplicate elements
    let array = [1, 2, 2, 3, 3, 4, 5, 5]
    let iterator = array.iterator()
    
    // Convert iterator to HashSet (duplicates removed)
    let hashSet = collectHashSet<Int64>(iterator)
    println("HashSet size: ${hashSet.size}")
    println("HashSet content: ${hashSet}")
    
    return 0
}
```

Output:

```text
HashSet size: 5
HashSet content: [1, 2, 3, 4, 5]
```

## func collectString\<T>(String) where T <: ToString

```cangjie
public func collectString<T>(delimiter!: String = ""): (Iterable<T>) -> String where T <: ToString
```

Function: Converts an iterator (whose elements implement [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)) to [String](../../core/core_package_api/core_package_structs.md#struct-string) type.

Parameters:

- delimiter!: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The separator string for joining elements.

Returns:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [String](../../core/core_package_api/core_package_structs.md#struct-string) - Returns a conversion function.

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // Create a function to join elements with comma
    let joinWithComma = collectString<Int64>(delimiter: ", ")
    
    // Create an array
    let array = [1, 2, 3, 4, 5]
    let iterator = array.iterator()
    
    // Convert iterator to string
    let result = joinWithComma(iterator)
    println("Joined result: ${result}")
    
    // Create another array for joining without delimiter
    let array2 = [1, 2, 3, 4, 5]
    let iterator2 = array2.iterator()
    
    // Create a function to join without delimiter
    let joinWithoutDelimiter = collectString<Int64>()
    let result2 = joinWithoutDelimiter(iterator2)
    println("Joined without delimiter: ${result2}")
    
    return 0
}
```

Output:

```text
Joined result: 1, 2, 3, 4, 5
Joined without delimiter: 12345
```

## func concat\<T>(Iterable\<T>)

```cangjie
public func concat<T>(other: Iterable<T>): (Iterable<T>) -> Iterator<T>
```

Function: Concatenates two iterators.

Parameters:

- other: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The iterator to concatenate.

Returns:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Returns a concatenation function.

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // Create two arrays
    let array1 = [1, 2, 3]
    let array2 = [4, 5, 6]
    
    // Get iterator of first array
    let iterator1 = array1.iterator()
    
    // Create concatenation function
    let concatFunc = concat<Int64>(array2)
    
    // Concatenate iterators
    let concatenated = concatFunc(iterator1)
    
    // Iterate through concatenated iterator
    var result = ""
    for (value in concatenated) {
        result = result + "${value} "
    }
    println("Concatenated result: ${result}")
    
    return 0
}
```

Output:

```text
Concatenated result: 1 2 3 4 5 6 
``````markdown
## func contains\<T>(T) where T <: Equatable\<T>

```cangjie
public func contains<T>(element: T): (Iterable<T>) -> Bool where T <: Equatable<T>
```

Function: Obtains a search function for a specific element.

Parameters:

- element: T - The element to search for.

Returns:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns a search function.

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    var searchFunc = contains<Int64>(6) // Obtains a function to search for element 6
    let arr = ArrayList.of([1, 2, 3, 4, 5, 6])
    let i = arr.iterator()
    var result = searchFunc(i) // Calls the function
    println(result)
    searchFunc = contains<Int64>(7) // Obtains a function to search for element 7
    result = searchFunc(i) // Calls the function
    println(result)
    return 0
}
```

Execution Result:

```text
true
false
```

## func count\<T>(Iterable\<T>)

```cangjie
public func count<T>(it: Iterable<T>): Int64
```

Function: Counts the number of elements in an iterator.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The given iterator.

Returns:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the number of elements in the iterator.

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // Creates an array
    let array = [1, 2, 3, 4, 5]
    
    // Counts the number of array elements
    let countResult = count<Int64>(array)
    println("Number of array elements: ${countResult}")
    
    // Creates an empty array
    let emptyArray: Array<Int64> = []
    
    // Counts the number of empty array elements
    let emptyCount = count<Int64>(emptyArray)
    println("Number of empty array elements: ${emptyCount}")
    
    return 0
}
```

Execution Result:

```text
Number of array elements: 5
Number of empty array elements: 0
```

## func enumerate\<T>(Iterable\<T>)

```cangjie
public func enumerate<T>(it: Iterable<T>): Iterator<(Int64, T)>
```

Function: Obtains an iterator with indices.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The given iterator.

Returns:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<([Int64](../../core/core_package_api/core_package_intrinsics.md#int64), T)> - Returns an iterator with indices.

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // Creates an array
    let array = ["a", "b", "c", "d"]
    
    // Obtains an iterator with indices
    let enumIterator = enumerate<String>(array)
    
    // Iterates through the indexed iterator
    println("Elements with indices:")
    for ((index, value) in enumIterator) {
        println("Index: ${index}, Value: ${value}")
    }
    
    return 0
}
```

Execution Result:

```text
Elements with indices:
Index: 0, Value: a
Index: 1, Value: b
Index: 2, Value: c
Index: 3, Value: d
```

## func filter\<T>((T) -> Bool)

```cangjie
public func filter<T>(predicate: (T) -> Bool): (Iterable<T>) -> Iterator<T>
```

Function: Filters elements that satisfy a condition.

Parameters:

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The given condition.

Returns:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Returns a filter function.

Example:

<!-- verify -->
```cangjie
import std.collection.*

func isEven(x: Int64): Bool {
    return x % 2 == 0
}

main() {
    // Creates an array
    let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    let iterator = array.iterator()
    
    // Creates a function to filter even numbers
    let filterEven = filter<Int64>(isEven)
    
    // Filters out even numbers
    let evenIterator = filterEven(iterator)
    
    // Iterates through the filtered results
    var result = "Even numbers: "
    for (value in evenIterator) {
        result = result + "${value} "
    }
    println(result)
    
    return 0
}
```

Execution Result:

```text
Even numbers: 2 4 6 8 10 
```

## func filterMap\<T, R>((T) -> ?R)

```cangjie
public func filterMap<T, R>(transform: (T) -> ?R): (Iterable<T>) -> Iterator<R>
```

Function: Performs both filtering and mapping operations, returning a new iterator.

Parameters:

- transform: (T) -> ?R - The given mapping function. A return value of Some corresponds to a filter predicate of true, while None indicates false.

Returns:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<R> - Returns a combined filter and map function.

Example:

<!-- verify -->
```cangjie
import std.collection.*

func parseInt(str: String): ?Int64 {
    // Simplified string-to-integer function, only handles pure numeric strings
    if (str == "1") {
        return Some(1)
    }
    if (str == "2") {
        return Some(2)
    }
    if (str == "3") {
        return Some(3)
    }
    if (str == "4") {
        return Some(4)
    }
    if (str == "5") {
        return Some(5)
    }
    return None
}

main() {
    // Creates a string array
    let array = ["1", "2", "a", "3", "b", "4", "c", "5"]
    let iterator = array.iterator()
    
    // Creates a function to filter and convert
    let parseAndFilter = filterMap<String, Int64>(parseInt)
    
    // Filters and converts strings to integers
    let parsedIterator = parseAndFilter(iterator)
    
    // Iterates through the filtered and converted results
    var result = "Parsed integers: "
    for (value in parsedIterator) {
        result = result + "${value} "
    }
    println(result)
    
    return 0
}
```

Execution Result:

```text
Parsed integers: 1 2 3 4 5 
```

## func first\<T>(Iterable\<T>)

```cangjie
public func first<T>(it: Iterable<T>): Option<T>
```

Function: Retrieves the first element.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The given iterator.

Returns:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the first element, or None if empty.

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // Creates an array
    let array = [10, 20, 30, 40, 50]
    
    // Retrieves the first element
    let firstElement = first<Int64>(array)
    match (firstElement) {
        case Some(value) => println("First element: ${value}")
        case None => println("Array is empty")
    }
    
    // Creates an empty array
    let emptyArray: Array<Int64> = []
    
    // Attempts to retrieve the first element of an empty array
    let emptyFirst = first<Int64>(emptyArray)
    match (emptyFirst) {
        case Some(value) => println("First element: ${value}")
        case None => println("Array is empty")
    }
    
    return 0
}
```

Execution Result:

```text
First element: 10
Array is empty
```

## func flatMap\<T, R>((T) -> Iterable\<R>)

```cangjie
public func flatMap<T, R>(transform: (T) -> Iterable<R>): (Iterable<T>) -> Iterator<R>
```

Function: Creates a mapping with [flatten](collection_package_function.md#func-flattent-riterablet-where-t--iterabler) functionality.

Parameters:

- transform: (T) -> [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<R> - The given mapping function.

Returns:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<R> - Returns a mapping function with [flatten](collection_package_function.md#func-flattent-riterablet-where-t--iterabler) functionality.

Example:

<!-- verify -->
```cangjie
import std.collection.*

func getDivisors(n: Int64): ArrayList<Int64> {
    // Gets all divisors of a number (simplified implementation)
    let result = ArrayList<Int64>()
    if (n == 1) {
        result.add(1)
        return result
    }
    if (n == 2) {
        result.add(1)
        result.add(2)
        return result
    }
    if (n == 3) {
        result.add(1)
        result.add(3)
        return result
    }
    if (n == 4) {
        result.add(1)
        result.add(2)
        result.add(4)
        return result
    }
    if (n == 5) {
        result.add(1)
        result.add(5)
        return result
    }
    if (n == 6) {
        result.add(1)
        result.add(2)
        result.add(3)
        result.add(6)
        return result
    }
    return result
}

main() {
    // Creates an array
    let array = [1, 2, 3, 4, 5, 6]
    
    // Creates a flatMap function
    let flatMapFunc = flatMap<Int64, Int64>(getDivisors)
    
    // Applies the flatMap function
    let flatIterator = flatMapFunc(array)
    
    // Iterates through the results
    var result = "All divisors: "
    for (value in flatIterator) {
        result = result + "${value} "
    }
    println(result)
    
    return 0
}
```

Execution Result:

```text
All divisors: 1 1 2 1 3 1 2 4 1 5 1 2 3 6 
```

## func flatten\<T, R>(Iterable\<T>) where T <: Iterable\<R>

```cangjie
public func flatten<T, R>(it: Iterable<T>): Iterator<R> where T <: Iterable<R>
```

Function: Flattens a nested iterator by one level.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The given iterator.

Returns:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<R> - Returns an iterator flattened by one level.

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // Create a nested array
    let nestedArray = [[1, 2], [3, 4], [5, 6]]
    
    // Flatten the nested array
    let flattenedIterator = flatten<Array<Int64>, Int64>(nestedArray)
    
    // Iterate through the flattened result
    var result = "Flattened elements: "
    for (value in flattenedIterator) {
        result = result + "${value} "
    }
    println(result)
    
    return 0
}
```

Output:

```text
Flattened elements: 1 2 3 4 5 6 
```

## func fold\<T, R>(R, (R, T) -> R)

```cangjie
public func fold<T, R>(initial: R, operation: (R, T) -> R): (Iterable<T>) -> R
```

Function: Computes from left to right using the specified initial value.

Parameters:

- initial: R - The initial value of type R.
- operation: (R, T) -> R - The given computation function.

Returns:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> R - Returns a folding function.

Example:

<!-- verify -->
```cangjie
import std.collection.*

func sumOperation(acc: Int64, value: Int64): Int64 {
    return acc + value
}

func concatOperation(acc: String, value: String): String {
    return acc + value
}

main() {
    // Create an array
    let array = [1, 2, 3, 4, 5]
    
    // Create a folding function for summation
    let sumFold = fold<Int64, Int64>(0, sumOperation)
    
    // Compute the sum of array elements
    let sumResult = sumFold(array)
    println("Sum of array elements: ${sumResult}")
    
    // Create a folding function for string concatenation
    let stringArray = ["Hello", " ", "World", "!"]
    let concatFold = fold<String, String>("", concatOperation)
    
    // Concatenate strings
    let concatResult = concatFold(stringArray)
    println("Concatenated string: ${concatResult}")
    
    return 0
}
```

Output:

```text
Sum of array elements: 15
Concatenated string: Hello World!
```

## func forEach\<T>((T) -> Unit)

```cangjie
public func forEach<T>(action: (T) -> Unit): (Iterable<T>) -> Unit
```

Function: Iterates through all elements and applies the given operation.

Parameters:

- action: (T) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - The given operation function.

Returns:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - Returns a function that performs the iteration operation.

Example:

<!-- verify -->
```cangjie
import std.collection.*

func printElement(element: Int64): Unit {
    println("Element: ${element}")
}

main() {
    // Create an array
    let array = [1, 2, 3, 4, 5]
    let iterator = array.iterator()
    
    // Create a function to iterate and print elements
    let printFunc = forEach<Int64>(printElement)
    
    // Iterate and print all elements
    println("Iterating through array elements:")
    printFunc(iterator)
    
    return 0
}
```

Output:

```text
Iterating through array elements:
Element: 1
Element: 2
Element: 3
Element: 4
Element: 5
```

## func inspect\<T>((T) -> Unit)

```cangjie
public func inspect<T>(action: (T) -> Unit): (Iterable<T>) -> Iterator<T>
```

Function: Performs an additional operation on the current element each time next() is called on the iterator (does not consume elements from the iterator).

Parameters:

- action: (T) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - The given operation function.

Returns:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Returns a function that performs additional operations on each element of the iterator.

Example:

<!-- verify -->
```cangjie
import std.collection.*

var inspectionCount: Int64 = 0

func inspectElement(element: Int64): Unit {
    inspectionCount = inspectionCount + 1
    println("Inspected element: ${element} (Inspection count: ${inspectionCount})")
}

main() {
    // Create an array
    let array = [10, 20, 30, 40, 50]
    let iterator = array.iterator()
    
    // Create an inspection function
    let inspectFunc = inspect<Int64>(inspectElement)
    
    // Apply the inspection function
    let inspectedIterator = inspectFunc(iterator)
    
    // Iterate through the iterator (the inspection function executes on each next() call)
    println("Iterating and inspecting elements:")
    for (value in inspectedIterator) {
        println("Processed element: ${value}")
    }
    
    return 0
}
```

Output:

```text
Iterating and inspecting elements:
Inspected element: 10 (Inspection count: 1)
Processed element: 10
Inspected element: 20 (Inspection count: 2)
Processed element: 20
Inspected element: 30 (Inspection count: 3)
Processed element: 30
Inspected element: 40 (Inspection count: 4)
Processed element: 40
Inspected element: 50 (Inspection count: 5)
Processed element: 50
```

## func isEmpty\<T>(Iterable\<T>)

```cangjie
public func isEmpty<T>(it: Iterable<T>): Bool
```

Function: Determines whether the iterator is empty.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The given iterator.

Returns:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns whether the iterator is empty.

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // Create a non-empty array
    let array = [1, 2, 3, 4, 5]
    
    // Check if the array is empty
    let isEmptyResult = isEmpty<Int64>(array)
    println("Is array empty: ${isEmptyResult}")
    
    // Create an empty array
    let emptyArray: Array<Int64> = []
    
    // Check if the empty array is empty
    let isEmptyEmpty = isEmpty<Int64>(emptyArray)
    println("Is empty array empty: ${isEmptyEmpty}")
    
    return 0
}
```

Output:

```text
Is array empty: false
Is empty array empty: true
```

## func last\<T>(Iterable\<T>)

```cangjie
public func last<T>(it: Iterable<T>): Option<T>
```

Function: Retrieves the last element.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The given iterator.

Returns:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the last element, or None if empty.

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // Create an array
    let array = [10, 20, 30, 40, 50]
    
    // Get the last element
    let lastElement = last<Int64>(array)
    match (lastElement) {
        case Some(value) => println("Last element: ${value}")
        case None => println("Array is empty")
    }
    
    // Create an empty array
    let emptyArray: Array<Int64> = []
    
    // Attempt to get the last element of an empty array
    let emptyLast = last<Int64>(emptyArray)
    match (emptyLast) {
        case Some(value) => println("Last element: ${value}")
        case None => println("Array is empty")
    }
    
    return 0
}
```

Output:

```text
Last element: 50
Array is empty
```

## func map\<T, R>((T) -> R)

```cangjie
public func map<T, R>(transform: (T) -> R): (Iterable<T>) -> Iterator<R>
```

Function: Creates a mapping.

Parameters:

- transform: (T) -> R - The given mapping function.

Returns:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<R> - Returns a mapping function.

Example:

<!-- verify -->
```cangjie
import std.collection.*

func square(x: Int64): Int64 {
    return x * x
}

main() {
    // Create an array
    let array = [1, 2, 3, 4, 5]
    let iterator = array.iterator()
    
    // Create a mapping function (computes squares)
    let squareMap = map<Int64, Int64>(square)
    
    // Apply the mapping function
    let squaredIterator = squareMap(iterator)
    
    // Iterate through the mapped result
    var result = "Squared values: "
    for (value in squaredIterator) {
        result = result + "${value} "
    }
    println(result)
    
    return 0
}
```

Output:

```text
Squared values: 1 4 9 16 25 
```

## func max\<T>(Iterable\<T>) where T <: Comparable\<T>

```cangjie
public func max<T>(it: Iterable<T>): Option<T> where T <: Comparable<T>
```

Function: Finds the maximum element.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The given iterator.

Returns:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the maximum element, or None if empty.

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // Create an array
    let array = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3]
    
    // Get the maximum element
    let maxElement = max<Int64>(array)
    match (maxElement) {
        case Some(value) => println("Maximum element: ${value}")
        case None => println("Array is empty")
    }
    
    // Create an empty array
    let emptyArray: Array<Int64> = []
    
    // Attempt to get the maximum element of an empty array
    let emptyMax = max<Int64>(emptyArray)
    match (emptyMax) {
        case Some(value) => println("Maximum element: ${value}")
        case None => println("Array is empty")
    }
    
    return 0
}
```

Output:

```text
Maximum element: 9
Array is empty
``````markdown
## func min\<T>(Iterable\<T>) where T <: Comparable\<T>

```cangjie
public func min<T>(it: Iterable<T>): Option<T> where T <: Comparable<T>
```

Function: Filters the smallest element.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The given iterator.

Returns:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the smallest element, or None if empty.

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // Create an array
    let array = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3]
    
    // Get the smallest element
    let minElement = min<Int64>(array)
    match (minElement) {
        case Some(value) => println("Smallest element: ${value}")
        case None => println("Array is empty")
    }
    
    // Create an empty array
    let emptyArray: Array<Int64> = []
    
    // Attempt to get the smallest element from an empty array
    let emptyMin = min<Int64>(emptyArray)
    match (emptyMin) {
        case Some(value) => println("Smallest element: ${value}")
        case None => println("Array is empty")
    }
    
    return 0
}
```

Execution Result:

```text
Smallest element: 1
Array is empty
```

## func none\<T>((T) -> Bool)

```cangjie
public func none<T>(predicate: (T) -> Bool): (Iterable<T>) -> Bool
```

Function: Determines if none of the elements in the iterator satisfy the condition.

Parameters:

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The given condition.

Returns:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns a function that checks if none satisfy the condition.

Example:

<!-- verify -->
```cangjie
import std.collection.*

func isNegative(x: Int64): Bool {
    return x < 0
}

main() {
    // Create a function to check if all elements are non-negative
    let allNonNegative = none<Int64>(isNegative)
    
    // Test case where all elements are non-negative
    let list1 = ArrayList.of([1, 2, 3, 4, 5])
    let result1 = allNonNegative(list1)
    println("All elements are non-negative: ${result1}")
    
    // Test case with negative elements
    let list2 = ArrayList.of([1, -2, 3, 4, 5])
    let result2 = allNonNegative(list2)
    println("All elements are non-negative: ${result2}")
    
    return 0
}
```

Execution Result:

```text
All elements are non-negative: true
All elements are non-negative: false
```

## func reduce\<T>((T, T) -> T)

```cangjie
public func reduce<T>(operation: (T, T) -> T): (Iterable<T>) -> Option<T>
```

Function: Computes from left to right using the first element as the initial value.

Parameters:

- operation: (T, T) -> T - The given operation function.

Returns:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns a reduction function.

Example:

<!-- verify -->
```cangjie
import std.collection.*

func sumOperation(x: Int64, y: Int64): Int64 {
    return x + y
}

main() {
    // Create an array
    let array = [1, 2, 3, 4, 5]
    
    // Create a summation reduction function
    let sumReduce = reduce<Int64>(sumOperation)
    
    // Calculate the sum of array elements
    let sumResult = sumReduce(array)
    match (sumResult) {
        case Some(value) => println("Sum of array elements: ${value}")
        case None => println("Array is empty")
    }
    
    // Create an empty array
    let emptyArray: Array<Int64> = []
    
    // Attempt to calculate the sum of an empty array
    let emptySum = sumReduce(emptyArray)
    match (emptySum) {
        case Some(value) => println("Sum of array elements: ${value}")
        case None => println("Array is empty")
    }
    
    return 0
}
```

Execution Result:

```text
Sum of array elements: 15
Array is empty
```

## func skip\<T>(Int64)

```cangjie
public func skip<T>(count: Int64): (Iterable<T>) -> Iterator<T>
```

Function: Skips a specified number of elements from the iterator.

Throws an exception when count < 0. When count == 0, returns the original iterator unchanged. When count > 0 and less than the iterator size, skips count elements and returns a new iterator with remaining elements. When count >= iterator size, skips all elements and returns an empty iterator.

Parameters:

- count: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of elements to skip.

Returns:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Returns a function that skips the specified number of elements.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when count < 0.

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // Create an array
    let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    let iterator = array.iterator()
    
    // Create a function to skip the first 3 elements
    let skipFunc = skip<Int64>(3)
    
    // Skip the first 3 elements
    let skippedIterator = skipFunc(iterator)
    
    // Iterate through remaining elements
    var result = "After skipping first 3 elements: "
    for (value in skippedIterator) {
        result = result + "${value} "
    }
    println(result)
    
    return 0
}
```

Execution Result:

```text
After skipping first 3 elements: 4 5 6 7 8 9 10 
```

## func step\<T>(Int64)

```cangjie
public func step<T>(count: Int64): (Iterable<T>) -> Iterator<T>
```

Function: Specifies the number of positions the iterator pointer moves per next() call. For example: if 1, the iterator pointer moves 1 position backward (default next() behavior); if 2, it moves 2 positions per call.

Throws an exception when count <= 0. When count > 0, each next() call skips count positions until the iterator is exhausted.

Parameters:

- count: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of positions to move per next() call.

Returns:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Returns an iterator with modified step size.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when count <= 0.

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // Create an array
    let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    let iterator = array.iterator()
    
    // Create a function to move 2 positions per step
    let stepFunc = step<Int64>(2)
    
    // Apply the function
    let steppedIterator = stepFunc(iterator)
    
    // Iterate through stepped elements
    var result = "Taking every other element: "
    for (value in steppedIterator) {
        result = result + "${value} "
    }
    println(result)
    
    return 0
}
```

Execution Result:

```text
Taking every other element: 1 3 5 7 9 
```

## func take\<T>(Int64)

```cangjie
public func take<T>(count: Int64): (Iterable<T>) -> Iterator<T>
```

Function: Takes a specified number of elements from the iterator.

Throws an exception when count < 0. When count == 0, takes no elements and returns an empty iterator. When count > 0 and less than the iterator size, takes the first count elements and returns a new iterator. When count >= iterator size, takes all elements and returns the original iterator.

Parameters:

- count: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of elements to take.

Returns:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Returns a function that takes the specified number of elements.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when count < 0.

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // Create an array
    let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    let iterator = array.iterator()
    
    // Create a function to take the first 5 elements
    let takeFunc = take<Int64>(5)
    
    // Take the first 5 elements
    let takenIterator = takeFunc(iterator)
    
    // Iterate through taken elements
    var result = "First 5 elements: "
    for (value in takenIterator) {
        result = result + "${value} "
    }
    println(result)
    
    return 0
}
```

Execution Result:

```text
First 5 elements: 1 2 3 4 5 
```

## func zip\<T, R>(Iterable\<R>)

```cangjie
public func zip<T, R>(other: Iterable<R>): (Iterable<T>) -> Iterator<(T, R)>
```

Function: Merges two iterators into one (length determined by the shorter iterator).

Parameters:

- other: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<R> - One of the iterators to merge.

Returns:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<(T, R)> - Returns a merging function.

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // Create two arrays
    let numbers = [1, 2, 3, 4, 5]
    let letters = ["a", "b", "c", "d", "e"]
    
    // Get the iterator of the first array
    let numberIterator = numbers.iterator()
    
    // Create a merging function
    let zipFunc = zip<Int64, String>(letters)
    
    // Merge the two iterators
    let zippedIterator = zipFunc(numberIterator)
    
    // Iterate through merged elements
    println("Merged elements:")
    for ((num, letter) in zippedIterator) {
        println("${num}: ${letter}")
    }
    
    return 0
}
```

Execution Result:

```text
Merged elements:
1: a
2: b
3: c
4: d
5: e
```
