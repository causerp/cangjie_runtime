# Interface

## interface ValueListener\<T>

```cangjie
public interface ValueListener<T> {
    func lastValue(): Option<T>
    func allValues(): Array<T>
    func addCallback(callback: (T) -> Unit): Unit
    static func new(): ValueListener<T>
    static func onEach(callback: (T) -> Unit): ValueListener<T>
}
```

Functionality: This interface provides multiple member functions to support "listening" to parameters passed to stub signatures. It performs specified operations on parameters passed to stub signatures during each invocation (the closure functions in `addCallback()` or `onEach` define the operations performed on the parameters).

Typically used in conjunction with argument matcher generator functions `argThat` or `capture`.

Value listeners, along with argument captors, are passed into stub signatures as a type of argument matcher. They define the parameter value range while also inspecting the parameter values.

For example:

```cangjie
struct Animal {
    Animal(
        let name: String,
        let info: String
    ) {}
}

abstract class AnimalUi {
    func showAnimal(animal: Animal): Unit
}

let animals = [Animal("Smokey", "Cat, age: 5"), Animal("Daisy", "Dog, age: 9")]

@Test func testAnimal(): Unit {
    let ui = mock<AnimalUi>()
    // Define a value listener: checks each value and throws an exception if the value doesn't meet the condition.
    let listener = ValueListener<Animal>.onEach { animal =>
        if (animal.name == "Smokey") {
            @Assert(animal.info.contains("Cat"))
        }
    }
    // Define a "stub behavior" for the stub signature, with an argument captor that can execute the above value listener as the argument matcher.
    @On(ui.showAnimal(capture(listener))).returns(())

    for (animal in animals) {
        // Here, the passed animal object will be captured and subjected to the inspection behavior defined in the value listener.
        ui.showAnimal(animal)
    }
}
```

### func addCallback((T) -> Unit)

```cangjie
func addCallback(callback: (T) -> Unit): Unit
```

Functionality: Adds a closure function to the current "value listener" object, which will process the incoming parameter values.

Parameters:

- callback: (T) ->[Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - The closure function that processes parameter values.

### func allValues()

```cangjie
func allValues(): Array<T>
```

Functionality: Returns all values processed by the current "value listener" object.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - Returns a list of all values processed by the "value listener" object.

### func lastValue()

```cangjie
func lastValue(): Option<T>
```

Functionality: Returns the last value processed by the current "value listener" object.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the last value processed by the "value listener" object, or None if no value exists.

### func new()

```cangjie
static func new(): ValueListener<T>
```

Functionality: Creates a new "value listener" object without any closure methods for processing parameters.

Return Value:

- [ValueListener](unittest_mock_package_interfaces.md#interface-valuelistenert)\<T> - The "value listener" object.

### func onEach((T) -> Unit)

```cangjie
static func onEach(callback: (T) -> Unit): ValueListener<T>
```

Functionality: Creates a new "value listener" object with a closure method for processing parameters.

Parameters:

- callback: (T) ->[Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - The closure function that processes parameter values.

Return Value:

- [ValueListener](unittest_mock_package_interfaces.md#interface-valuelistenert)\<T> - The "value listener" object.