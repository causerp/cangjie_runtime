# Interfaces

## interface DataProvider\<T>

```cangjie
public interface DataProvider<T> {
    func provide(): Iterable<T>
}
```

Function: A component of [DataStrategy](#interface-datastrategyt) used to provide test data, where T specifies the data type provided by the provider.

### func provide()

```cangjie
func provide(): Iterable<T>
```

Function: Retrieves a data iterator.

Returns:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - Data iterator.

### extend\<T> Array\<T> <: DataProvider\<T>

```cangjie
extend<T> Array<T> <: DataProvider<T>
```

Function: Extends [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T>.

#### func provide()

```cangjie
public func provide(): Iterable<T>
```

Function: Retrieves a data iterator.

Returns:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - Data iterator.

### extend\<T> Range\<T> <: DataProvider\<T>

```cangjie
extend<T> Range<T> <: DataProvider<T>
```

Function: Extends [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<T>.

#### func provide()

```cangjie
public func provide(): Iterable<T>
```

Function: Retrieves a data iterator.

Returns:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - Data iterator.

See example: [datashrinker](#the-primary-use-of-datashrinkert)

## interface DataShrinker\<T>

```cangjie
public interface DataShrinker<T> {
    func shrink(value: T): Iterable<T>
}
```

Function: A component of [DataStrategy](#interface-datastrategyt) used to shrink data during testing, where T specifies the data type processed by this shrinker.

### func shrink(T)

```cangjie
func shrink(value: T): Iterable<T>
```

Function: Takes a value of type T and generates a collection of smaller values. What constitutes "smaller" depends on the data type.

Parameters:

- value: T - The value to be shrunk.

Returns:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - Collection of smaller values, returns an empty collection when data can no longer be shrunk.

Example:

<!-- run -->
```cangjie
import std.unittest.*
import std.unittest.prop_test.*
import std.collection.*
import std.random.*


class Person <: ToString {
    let name: String
    let age: Int64
    let email: String
    
    init(name: String, age: Int64, email: String) {
        this.name = name
        this.age = age
        this.email = email
    }
    
    public func toString(): String {
        return "Person(name='${name}', age=${age}, email='${email}')"
    }
}

class PersonShrinker <: DataShrinker<Person> {
    public func shrink(value: Person): Iterable<Person> {
        let results = ArrayList<Person>()
        
        // Strategy 1: Empty/default values
        results.add(Person("", 0, ""))
        
        // Strategy 2: Simplify each field individually
        if (value.name.size > 0) {
            results.add(Person("a", value.age, value.email))
        }
        if (value.age != 0) {
            results.add(Person(value.name, 0, value.email))
        }
        if (value.email.size > 0) {
            results.add(Person(value.name, value.age, "a@b"))
        }
        
        // Strategy 3: Halve numeric values
        if (value.age > 1) {
            results.add(Person(value.name, value.age / 2, value.email))
        }
        
        // Strategy 4: Shorten name
        if (value.name.size > 1) {
            let halfName = value.name[0..(value.name.size / 2)]
            results.add(Person(halfName, value.age, value.email))
        }
        
        return results
    }
}

extend Person <: Arbitrary<Person> {
    public static func arbitrary(random: RandomSource): Generator<Person> {
        let sampleNames = ["John", "Alice", "Bob", "Charlie", "Diana", "Eve", "Frank"]
        let sampleDomains = ["example.com", "work.com", "company.com", "email.com", "test.com"]
        // Generate random person using provided RandomSource
        let randomIndex = Int64(random.nextUInt32()) % Int64(sampleNames.size)
        let randomDomainIndex = Int64(random.nextUInt32()) % Int64(sampleDomains.size)
        let randomAge = Int64(random.nextUInt32()) % 80  // Age 0-79
        
        let name = sampleNames[randomIndex] + " Smith"
        let email = sampleNames[randomIndex] + "@" + sampleDomains[randomDomainIndex]
        
        return Generators.generate { Person(name, randomAge, email) }
    }
}


class PersonStrategy <: DataStrategy<Person> {
    let samplePeople: Array<Person>
    
    init() {
        this.samplePeople = [
            Person("John Doe", 25, "john@example.com"),
            Person("Alice Smith", 30, "alice@work.com"),
            Person("Bob Johnson", 45, "bob@company.com"),
            Person("Charlie Brown", 60, "charlie@email.com"),
            Person("Diana Prince", 35, "diana@justice.com")
        ]
    }
    
    public prop isInfinite: Bool {
        get() { return false }
    }
    
    public func provider(configuration: Configuration): DataProvider<Person> {
        return samplePeople
    }
    
    public func shrinker(configuration: Configuration): DataShrinker<Person> {
        return PersonShrinker()
    }
}

@Test
class PersonTests {
    @TestCase
    func testPersonShrinker() {
        let shrinker = PersonShrinker()
        let original = Person("John Doe", 35, "john.doe@example.com")
        
        println("Original person: ${original}")
        println("Shrunk versions:")
        
        for (shrunk in shrinker.shrink(original)) {
            println("  - ${shrunk}")
        }   
        
        @Assert(shrinker.shrink(original).iterator().next().isSome())
    }
    
    @TestCase
    func testPersonWithStrategy() {
        let personStrategy = PersonStrategy()
        let provider = personStrategy.provider(defaultConfiguration())
        
        println("Testing with deterministic strategy:")
        for (person in provider.provide()) {
            println("  - ${person}")
            @Assert(person.age <= 70)
        }
    }
    
    @TestCase
    func testPersonWithRandomData() {
        // Test with multiple random persons using Random
        for (i in 0..5) {
            let random = Random(UInt64(i))  // Use seed for reproducibility
            let generator = Person.arbitrary(random)
            let person = generator.next()  // Call the generator to get a Person
            
            println("Testing random person ${i}: ${person}")
            
            // Test that fails if person is too old
            @Assert(person.age <= 50)
        }
    }
    
    @TestCase[person in random<Person>()]
    func testPersonWithBuiltInRandomSyntax(person: Person) {
        println("Testing person with built-in random syntax: ${person}")
        @Assert(person.age <= 50)
    }
}
```

Output:

```text
Original person: Person(name='John Doe', age=35, email='john.doe@example.com')
Shrunk versions:
  - Person(name='', age=0, email='')
  - Person(name='a', age=35, email='john.doe@example.com')
  - Person(name='John Doe', age=0, email='john.doe@example.com')
  - Person(name='John Doe', age=35, email='a@b')
  - Person(name='John Doe', age=17, email='john.doe@example.com')
  - Person(name='John', age=35, email='john.doe@example.com')
Testing with deterministic strategy:
  - Person(name='John Doe', age=25, email='john@example.com')
  - Person(name='Alice Smith', age=30, email='alice@work.com')
  - Person(name='Bob Johnson', age=45, email='bob@company.com')
  - Person(name='Charlie Brown', age=60, email='charlie@email.com')
  - Person(name='Diana Prince', age=35, email='diana@justice.com')
Testing random person 0: Person(name='Alice Smith', age=57, email='Alice@test.com')
Testing person with built-in random syntax: Person(name='John Smith', age=7, email='John@test.com')
Testing person with built-in random syntax: Person(name='Eve Smith', age=27, email='Eve@work.com')
Testing person with built-in random syntax: Person(name='Eve Smith', age=12, email='Eve@work.com')
Testing person with built-in random syntax: Person(name='Charlie Smith', age=65, email='Charlie@example.com')
--------------------------------------------------------------------------------------------------
TP: default, time elapsed: 2870831 ns, RESULT:
    TCS: PersonTests, time elapsed: 2865917 ns, RESULT:
    [ PASSED ] CASE: testPersonShrinker (433985 ns)
    [ PASSED ] CASE: testPersonWithStrategy (152129 ns)
    [ FAILED ] CASE: testPersonWithRandomData (139911 ns)
    Assert Failed: `(person.age <= 50 == true)`
       left: false
      right: true

    [ FAILED ] CASE: testPersonWithBuiltInRandomSyntax (44782 ns)
    REASON: After 4 generation steps:
        person = Person(name=\'Charlie Smith\', age=65, email=\'Charlie@example.com\')
    with randomSeed = 1766660451293893218
    Assert Failed: `(person.age <= 50 == true)`
       left: false
      right: true

Summary: TOTAL: 4
    PASSED: 2, SKIPPED: 0, ERROR: 0
    FAILED: 2, listed below:
            TCS: PersonTests, CASE: testPersonWithRandomData
            TCS: PersonTests, CASE: testPersonWithBuiltInRandomSyntax (failed after 4 steps)
```

## interface DataStrategy

```cangjie
public interface DataStrategy<T> {
    func provider(configuration: Configuration): DataProvider<T>
    func shrinker(configuration: Configuration): DataShrinker<T>
    prop isInfinite: Bool
}
```

Function: Strategy for providing data for parameterized tests, where T specifies the data type operated by this strategy. The DataStrategy component is used to shrink data during testing. T specifies the data type that the shrinker handles. Random test data is generated via `Arbitrary<T>`, and when a test fails, `DataShrinker<T>` automatically finds smaller failure examples, which helps to pinpoint the smallest triggering condition that caused the failure.

### prop isInfinite

```cangjie
prop isInfinite: Bool
```

Function: Whether the data is inexhaustible.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

### func provider(Configuration)

```cangjie
func provider(configuration: Configuration): DataProvider<T>
```

Function: Retrieves the component for providing test data.

Parameters:

- configuration: [Configuration](unittest_common_package_classes.md#class-configuration) - Configuration information.

Returns:

- [DataProvider](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-dataprovider)\<T> - Component object for providing test data.

### func shrinker(Configuration)

```cangjie
func shrinker(configuration: Configuration): DataShrinker<T>
```

Function: Retrieves the component for shrinking test data.

Parameters:

- configuration: [Configuration](unittest_common_package_classes.md#class-configuration) - Configuration information.

Returns:

- [DataShrinker](#interface-datashrinkert)\<T> - Component object for shrinking test data.

### extend\<T> Array\<T> <: DataStrategy\<T>

```cangjie
extend<T> Array<T> <: DataStrategy<T>
```

Function: Extends [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T>.

#### prop isInfinite

```cangjie
public prop isInfinite: Bool
```

Function: Whether the data is inexhaustible.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

#### func provider(Configuration)

```cangjie
public func provider(_: Configuration): DataProvider<T>
```

Function: Retrieves the component for providing test data.

Parameters:

- _: [Configuration](unittest_common_package_classes.md#class-configuration) - Configuration information.

Returns:

- [DataProvider](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-dataprovidert)\<T> - Component object for providing test data.

#### func shrinker(Configuration)

```cangjie
func shrinker(configuration: Configuration): DataShrinker<T>
```

Function: Retrieves the component for shrinking test data.

Parameters:

- configuration: [Configuration](unittest_common_package_classes.md#class-configuration) - Configuration information.

Returns:

- [DataShrinker](#interface-datashrinkert)\<T> - Component object for shrinking test data.

### extend\<T> Range\<T> <: DataStrategy\<T>

```cangjie
extend<T> Range<T> <: DataStrategy<T>
```

Function: Extends [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<T>.

#### prop isInfinite

```cangjie
public prop isInfinite: Bool
```

Function: Whether the data is inexhaustible.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

#### func provider(Configuration)

```cangjie
public func provider(_: Configuration): DataProvider<T>
```

Function: Retrieves the component for providing test data.

Parameters:

- _: [Configuration](unittest_common_package_classes.md#class-configuration) - Configuration information.

Returns:

- [DataProvider](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-dataprovidert)\<T> - Component object for providing test data.

#### func shrinker(Configuration)

```cangjie
func shrinker(configuration: Configuration): DataShrinker<T>
```

Function: Retrieves the component for shrinking test data.

Parameters:

- configuration: [Configuration](unittest_common_package_classes.md#class-configuration) - Configuration information.

Returns:

- [DataShrinker](#interface-datashrinkert)\<T> - Component object for shrinking test data.

## interface PrettyPrintable

```cangjie
public interface PrettyPrintable {
    func pprint(to: PrettyPrinter): PrettyPrinter
}
```

Function: Types implementing this interface can be printed with proper color and indentation formatting.

### func pprint(PrettyPrinter)

```cangjie
func pprint(to: PrettyPrinter): PrettyPrinter
```

Function: Prints the type value to the specified printer.

Parameters:

- to: [PrettyPrinter](./unittest_common_package_classes.md#class-prettyprinter) - Printer.

Returns:

- [PrettyPrinter](./unittest_common_package_classes.md#class-prettyprinter) - Printer.

### extend\<T> Array\<T> <: PrettyPrintable where T <: PrettyPrintable

```cangjie
extend<T> Array<T> <: PrettyPrintable where T <: PrettyPrintable
```

Function: Extends [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> to implement [PrettyPrintable](#interface-prettyprintable).

#### func pprint(PrettyPrinter)

```cangjie
public func pprint(to: PrettyPrinter): PrettyPrinter
```

Function: Prints the type value to the specified printer.

Parameters:

- to: [PrettyPrinter](./unittest_common_package_classes.md#class-prettyprinter) - Printer.

Returns:

- [PrettyPrinter](./unittest_common_package_classes.md#class-prettyprinter) - Printer.

### extend\<T> ArrayList\<T> <: PrettyPrintable where T <: PrettyPrintable

```cangjie
extend<T> ArrayList<T>  <: PrettyPrintable where T <: PrettyPrintable
```

Function: Extends [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<T> to implement [PrettyPrintable](#interface-prettyprintable).

#### func pprint(PrettyPrinter)

```cangjie
public func pprint(to: PrettyPrinter): PrettyPrinter
```

Function: Prints the type value to the specified printer.

Parameters:

- to: [PrettyPrinter](./unittest_common_package_classes.md#class-prettyprinter) - Printer.

Returns:

- [PrettyPrinter](./unittest_common_package_classes.md#class-prettyprinter) - Printer.

## interface KeyFor\<T>

```cangjie
public interface KeyFor<T> {
    prop name: String
}
```

Function: The type of configuration keys in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration).

Custom configuration key-values can be defined via [@UnitestOption](./../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#unittestoption-macro). Built-in unittest configuration items can be obtained according to the [naming rules](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#customassertion-macro). For example, the `randomSeed` can be extracted from [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) using the `KeyRandomSeed.randomSeed` key.

### prop name

```cangjie
prop name: String
```

Function: String representation of the key name used in [Configuration](./unittest_common_package_classes.md#class-configuration).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).