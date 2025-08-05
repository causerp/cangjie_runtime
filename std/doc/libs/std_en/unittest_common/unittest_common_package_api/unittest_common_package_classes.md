# Class

## class Configuration

```cangjie
public class Configuration <: ToString {
    public init()
}
```

Function: An object that stores `@Configure` macro-generated `unittest` configuration data. [Configuration](#class-configuration) is similar to [HashMap](../../collection/collection_package_api/collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek), but its keys are of type [KeyFor](./unittest_common_package_interfaces.md#interface-keyfor) and values can be of any given type.

Parent Types:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### init()

```cangjie
public init()
```

Function: Constructs an empty Configuration instance.

### func clone()

```cangjie
public func clone(): Configuration
```

Function: Creates a copy of the Configuration object.

Return Value:

- [Configuration](#class-configuration) - The copied object.

### func get\<T>(KeyFor\<T>)

```cangjie
public func get<T>(key: KeyFor<T>): ?T
```

Function: Retrieves the value associated with the given key.

T is a generic parameter used to look up values of the corresponding type in the object.

Parameters:

- key: [KeyFor](./unittest_common_package_interfaces.md#interface-keyfor) - The key of the configuration item.

Return Value:

- ?T - Returns None if not found, or Some\<T>(v) if a value matching the type and name is found.

### func getByName\<T>(name: String): ?T

```cangjie
public func getByName<T>(name: String): ?T
```

Function: Retrieves the value associated with the given key name.

T is a generic parameter used to look up values of the corresponding type in the object.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The key name.

### func remove\<T>(KeyFor\<T>)

```cangjie
public func remove<T>(key: KeyFor<T>): ?T
```

Function: Removes the value associated with the given key name and type.

Parameters:

- key: [KeyFor](./unittest_common_package_interfaces.md#interface-keyfor) - The key of the configuration item.

Return Value:

- ?T - Returns the value if it exists, or None if it does not.

### func removeByName\<T>(String)

```cangjie
public func removeByName<T>(name: String): ?T
```

Function: Removes the value associated with the given key name and type.

Parameters:

- key: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The key name.

Return Value:

- ?T - Returns the value if it exists, or None if it does not.

### func set\<T>(KeyFor\<T>, T)

```cangjie
public func set<T>(key: KeyFor<T>, value: T)
```

Function: Sets the value for the given key name and type.

Parameters:

- key: [KeyFor](./unittest_common_package_interfaces.md#interface-keyfor) - The key of the configuration item.
- value: T - The value.

### func setByName\<T>(name: String, value: T)

```cangjie
public func setByName<T>(name: String, value: T): Unit
```

Function: Sets the value for the given key name and type.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The key name.
- value: T - The value.

### func toString()

```cangjie
public func toString(): String
```

Function: Returns a string representation of the object. If an internal object does not implement the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface, it outputs '\<not printable>'.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation.

### static func merge(Configuration, Configuration)

```cangjie
public static func merge(parent: Configuration, child: Configuration): Configuration
```

Function: Merges the child configuration into the parent configuration. If there are duplicate keys, the child configuration overrides the parent.

Parameters:

- parent: [Configuration](#class-configuration) - The configuration to merge into.
- child: [Configuration](#class-configuration) - The configuration to merge.

Return Value:

- [Configuration](#class-configuration) - The merged configuration.

### extend Configuration <: BenchmarkConfig

```cangjie
extend Configuration <: BenchmarkConfig {}
```

Function: Extends [Configuration](#class-configuration) with the [BenchmarkConfig](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-benchmarkconfig) interface.

Parent Types:

- [BenchmarkConfig](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-benchmarkconfig)

#### func batchSize(Int64)

```cangjie
public func batchSize(b: Int64)
```

Function: Configures the number of executions per batch during performance testing.

Parameters:

- b: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of executions.

#### func batchSize(Range\<Int64>)

```cangjie
public func batchSize(x: Range<Int64>)
```

Function: Configures the range of executions per batch during performance testing.

Parameters:

- b: [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<Int64> - The range of executions.

#### func explicitGC(ExplicitGcType)

```cangjie
public func explicitGC(x: ExplicitGcType)
```

Function: Configures the garbage collection method during performance testing.

Parameters:

- x: [ExplicitGcType](../../unittest/unittest_package_api/unittest_package_enums.md#enum-explicitgctype) - The garbage collection method.

#### func minBatches(Int64)

```cangjie
public func minBatches(x: Int64)
```

Function: Configures the minimum number of batches during performance testing.

Parameters:

- x: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The minimum number of batches.

#### func minDuration(Duration)

```cangjie
public func minDuration(x: Duration)
```

Function: Configures the minimum execution duration during performance testing.

Parameters:

- x: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The minimum execution duration.

#### func warmup(Int64)

```cangjie
public func warmup(x: Int64)
```

Function: Configures the warm-up time in seconds during performance testing.

Parameters:

- x: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The warm-up time in seconds.

#### func warmup(Duration)

```cangjie
public func warmup(x: Duration)
```

Function: Configures the warm-up duration during performance testing.

Parameters:

- x: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The warm-up duration.

## class ConfigurationKey

```cangjie
abstract sealed class ConfigurationKey <: Equatable<ConfigurationKey> & Hashable {}
```

Function: A key object for configuration items. Provides equality comparison and hashCode methods.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[ConfigurationKey](#class-configurationkey)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)

### func equals(ConfigurationKey)

```cangjie
protected func equals(that: ConfigurationKey): Bool
```

Function: Determines equality.

Parameters:

- that: [ConfigurationKey](#class-configurationkey) - The object to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the objects are equal.

### func hashCode

```cangjie
public override func hashCode(): Int64
```

Function: Retrieves the hashCode value.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hashCode value.

### operator func ==(ConfigurationKey)

```cangjie
public override operator func ==(that: ConfigurationKey)
```

Function: Equality comparison.Parameters:

- that: [ConfigurationKey](#class-configurationkey) - The data to be compared

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether they are equal.

### public override operator func !=(that: ConfigurationKey)

```cangjie
public override operator func !=(that: ConfigurationKey)
```

Function: Inequality comparison.

Parameters:

- that: [ConfigurationKey](#class-configurationkey) - The data to be compared

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether they are not equal.

## class PrettyPrinter

```cangjie
public abstract class PrettyPrinter {
    public PrettyPrinter(let indentationSize!: UInt64 = 4, let startingIndent!: UInt64 = 0)
}
```

Function: A printer with color, alignment, and indentation control.

### PrettyPrinter(UInt64,UInt64)

```cangjie
public PrettyPrinter(let indentationSize!: UInt64 = 4, let startingIndent!: UInt64 = 0)
```

Function: PrettyPrinter constructor.

Parameters:

- indentationSize!: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of spaces per indentation level, default is 4 spaces.
- startingIndent!: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Initial number of indentations, default is 0.

### prop isTopLevel

```cangjie
public prop isTopLevel: Bool
```

Function: Gets whether currently at the top level of printing indentation.

Type: Bool.

### func append(String)

```cangjie
public func append(text: String): PrettyPrinter
```

Function: Appends a string to the printer. Does not support multi-line strings or indentation for multi-line strings.

Parameters:

- text: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be appended.

Return Value:

- [PrettyPrinter](#class-prettyprinter) - The printer.

### func append\<PP>(PP)where PP <: PrettyPrintable

```cangjie
public func append<PP>(value: PP): PrettyPrinter where PP <: PrettyPrintable
```

Function: Appends an object implementing [PrettyPrintable](./unittest_common_package_interfaces.md#interface-prettyprintable) to the printer.

Parameters:

- value: PP - An object implementing [PrettyPrintable](./unittest_common_package_interfaces.md#interface-prettyprintable).

Return Value:

- [PrettyPrinter](#class-prettyprinter) - The printer.

### func appendCentered(String, UInt64)

```cangjie
public func appendCentered(text: String, space: UInt64): PrettyPrinter
```

Function: Appends a string to the printer, center-aligned to the specified character count. Pads with spaces if needed. Does not support multi-line strings or indentation for multi-line strings.

Parameters:

- text: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be appended.
- space: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of characters to align to.

Return Value:

- [PrettyPrinter](#class-prettyprinter) - The printer.

### func appendLeftAligned(String, UInt64)

```cangjie
public func appendLeftAligned(text: String, space: UInt64): PrettyPrinter
```

Function: Appends a string to the printer, left-aligned to the specified character count. Pads with spaces if needed. Does not support multi-line strings or indentation for multi-line strings.

Parameters:

- text: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be appended.
- space: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of characters to align to.

Return Value:

- [PrettyPrinter](#class-prettyprinter) - The printer.

### func appendLine(String): PrettyPrinter

```cangjie
public func appendLine(text: String): PrettyPrinter
```

Function: Appends a string to the printer followed by a newline.

Parameters:

- text: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be appended.

Return Value:

- [PrettyPrinter](#class-prettyprinter) - The printer.

### func appendLine\<PP>(PP) where PP <: PrettyPrintable

```cangjie
public func appendLine<PP>(value: PP): PrettyPrinter where PP <: PrettyPrintable
```

Function: Appends an object implementing [PrettyPrintable](./unittest_common_package_interfaces.md#interface-prettyprintable) to the printer followed by a newline.

Parameters:

- value: PP - An object implementing [PrettyPrintable](./unittest_common_package_interfaces.md#interface-prettyprintable).

Return Value:

- [PrettyPrinter](#class-prettyprinter) - The printer.

### func appendRightAligned(String, UInt64)

```cangjie
public func appendRightAligned(text: String, space: UInt64): PrettyPrinter
```

Function: Appends a string to the printer, right-aligned to the specified character count. Does not support multi-line strings or indentation for multi-line strings.

Parameters:

- text: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be appended.
- space: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of characters to align to.

Return Value:

- [PrettyPrinter](#class-prettyprinter) - The printer.

### func colored(Color, body: () -> Unit)

```cangjie
public func colored(color: Color, body: () -> Unit): PrettyPrinter
```

Function: Specifies color for strings added to the printer within the closure.
Common usage:

```cangjie
pp.colored(RED) {
    pp.appendLine("1")
    pp.appendLine("2")
    pp.appendLine("3")
}
```

Strings "1", "2", "3" will all be printed in red.

Parameters:

- color: [Color](./unittest_common_package_enums.md#enum-color) - The specified print color.
- body: () -> Unit - The closure for adding strings.

Return Value:

- [PrettyPrinter](#class-prettyprinter) - The printer.

### func colored(Color, String)

```cangjie
public func colored(color: Color, text: String): PrettyPrinter
```

Function: Specifies color for a string added to the printer.

Parameters:

- color: [Color](./unittest_common_package_enums.md#enum-color) - The specified print color.
- text: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be added.

Return Value:

- [PrettyPrinter](#class-prettyprinter) - The printer.

### func customOffset(UInt64, body: () -> Unit)

```cangjie
public func customOffset(symbols: UInt64, body: () -> Unit): PrettyPrinter
```

Function: Specifies additional indentation for strings added to the printer within the closure.
Common usage:

```cangjie
pp.customOffset(5) {
    pp.appendLine("1")
    pp.appendLine("2")
    pp.appendLine("3")
}
```

Strings "1", "2", "3" will all have 5 additional characters of indentation.

Parameters:

- symbols: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of additional indentation characters.
- body: () -> Unit - The closure for adding strings.

Return Value:

- [PrettyPrinter](#class-prettyprinter) - The printer.

### func indent(body: () -> Unit)

```cangjie
public func indent(body: () -> Unit): PrettyPrinter
```

Function: Specifies one additional level of indentation for strings added to the printer within the closure.
Common usage:

```cangjie
pp.indent {
    pp.appendLine("1")
    pp.appendLine("2")
    pp.appendLine("3")
}
```

Strings "1", "2", "3" will all have one additional level of indentation.

Parameters:

- body: () -> Unit - The closure for adding strings.

Return Value:

- [PrettyPrinter](#class-prettyprinter) - The printer.

### func indent(UInt64, body: () -> Unit)

```cangjie
public func indent(indents: UInt64, body: () -> Unit): PrettyPrinter
```

Function: Specifies multiple additional levels of indentation for strings added to the printer within the closure.
Common usage:

```cangjie
pp.indent(2) {
    pp.appendLine("1")
    pp.appendLine("2")
    pp.appendLine("3")
}
```

Strings "1", "2", "3" will all have two additional levels of indentation.

Parameters:

- indents: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of additional indentation levels.
- body: () -> Unit - The closure for adding strings.

Return Value:

- [PrettyPrinter](#class-prettyprinter) - The printer.### func newLine()

```cangjie
public func newLine(): PrettyPrinter
```

Function: Adds a new line.

Return value:

- [PrettyPrinter](#class-prettyprinter) - The printer instance.

### func put(String)

```cangjie
protected func put(s: String): Unit
```

Function: Prints a string.

Parameters:

- s: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be printed.

### func putNewLine()

```cangjie
protected open func putNewLine(): Unit
```

Function: Prints a new line.

### func setColor(Color)

```cangjie
protected func setColor(color: Color): Unit
```

Function: Sets the color.

Parameters:

- color: [Color](./unittest_common_package_enums.md#enum-color) - The specified color.

## class PrettyText

```cangjie
public class PrettyText <: PrettyPrinter & PrettyPrintable & ToString {
    public init()
    public init(string: String)
}
```

Function: Stores printed output. Primarily used for intermediate storage and passing these values.

Implements methods from [PrettyPrinter](#class-prettyprinter) (can print to) and [PrettyPrintable](./unittest_common_package_interfaces.md#interface-prettyprintable) (can be printed from).

Parent types:

- [PrettyPrinter](#class-prettyprinter)
- [PrettyPrintable](unittest_common_package_interfaces.md#interface-prettyprintable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### init()

```cangjie
public init()
```

Function: Default constructor, creates an empty object.

### init(String)

```cangjie
public init(string: String)
```

Function: Constructor, creates a text builder initialized with the input parameter.

Parameters:

- string: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be placed at the beginning of the printed text.

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Returns whether the current builder is empty (i.e., no values have been passed to the builder).

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if no content has been passed, otherwise returns `false`.

### func pprint(PrettyPrinter)

```cangjie
public func pprint(to: PrettyPrinter): PrettyPrinter
```

Function: Prints information to the printer.

Parameters:

- to: [PrettyPrinter](#class-prettyprinter) - The printer instance.

Return value:

- [PrettyPrinter](#class-prettyprinter) - The printer instance.

### func toString()

```cangjie
public func toString(): String
```

Function: Prints the text to a string.

Return value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string containing the printed text.

### static func of\<PP>(PP) where PP <: PrettyPrintable

```cangjie
public static func of<PP>(pp: PP) where PP <: PrettyPrintable
```

Function: Creates a [PrettyText](#class-prettytext) by printing from a [PrettyPrintable](./unittest_common_package_interfaces.md#interface-prettyprintable).

Parameters:

- pp: PP - A type that implements [PrettyPrintable](./unittest_common_package_interfaces.md#interface-prettyprintable).

Return value:

- [PrettyText](#class-prettytext) - The printed text object.