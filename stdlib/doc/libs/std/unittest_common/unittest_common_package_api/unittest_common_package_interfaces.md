# 接口

## interface DataProvider\<T>

```cangjie
public interface DataProvider<T> {
    func provide(): Iterable<T>
}
```

功能：[DataStrategy](#interface-datastrategyt) 的组件，用于提供测试数据，T 指定提供者提供的数据类型。

### func provide()

```cangjie
func provide(): Iterable<T>
```

功能：获取数据迭代器。

返回值：

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - 数据迭代器。

参考示例：[DataShrinker](#datashrinkert-的主要用途)

### extend\<T> Array\<T> <: DataProvider\<T>

```cangjie
extend<T> Array<T> <: DataProvider<T>
```

功能：对 [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> 进行扩展。

#### func provide()

```cangjie
public func provide(): Iterable<T>
```

功能：获取数据迭代器。

返回值：

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - 数据迭代器。

### extend\<T> Range\<T> <: DataProvider\<T>

```cangjie
extend<T> Range<T> <: DataProvider<T>
```

功能：对 [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<T> 进行扩展。

#### func provide()

```cangjie
public func provide(): Iterable<T>
```

功能：获取数据迭代器。

返回值：

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - 数据迭代器。

## interface DataShrinker\<T>

```cangjie
public interface DataShrinker<T> {
    func shrink(value: T): Iterable<T>
}
```

功能：[DataStrategy](#interface-datastrategyt) 的组件，用于在测试期间缩减数据，T 指定该收缩器处理的数据类型。

### func shrink(T)

```cangjie
func shrink(value: T): Iterable<T>
```

功能：获取类型 T 的值并生成较小值的集合。什么被认为是“较小”取决于数据的类型。

参数：

- value: T - 被缩减的值。

返回值：

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - 较小值的集合，当数据无法再被缩减时返回空集合。

示例：

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
        
        // 策略 1：空值/默认值
        results.add(Person("", 0, ""))
        
        // 策略 2：单独简化每个字段
        if (value.name.size > 0) {
            results.add(Person("a", value.age, value.email))
        }
        if (value.age != 0) {
            results.add(Person(value.name, 0, value.email))
        }
        if (value.email.size > 0) {
            results.add(Person(value.name, value.age, "a@b"))
        }
        
        // 策略 3：数值减半
        if (value.age > 1) {
            results.add(Person(value.name, value.age / 2, value.email))
        }
        
        // 策略 4：缩短姓名
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
        // 使用提供的 RandomSource 生成随机人员
        let randomIndex = Int64(random.nextUInt32()) % Int64(sampleNames.size)
        let randomDomainIndex = Int64(random.nextUInt32()) % Int64(sampleDomains.size)
        let randomAge = Int64(random.nextUInt32()) % 80  // 年龄 0-79
        
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
        
        println("原始人员：${original}")
        println("缩减版本：")
        
        for (shrunk in shrinker.shrink(original)) {
            println("  - ${shrunk}")
        }   
        
        @Assert(shrinker.shrink(original).iterator().next().isSome())
    }
    
    @TestCase
    func testPersonWithStrategy() {
        let personStrategy = PersonStrategy()
        let provider = personStrategy.provider(defaultConfiguration())
        
        println("使用确定性策略测试：")
        for (person in provider.provide()) {
            println("  - ${person}")
            @Assert(person.age <= 70)
        }
    }
    
    @TestCase
    func testPersonWithRandomData() {
        // 使用 Random 测试多个随机人员
        for (i in 0..5) {
            let random = Random(UInt64(i))  // 使用种子保证可重现性
            let generator = Person.arbitrary(random)
            let person = generator.next()  // 调用生成器获取 Person
            
            println("测试随机人员 ${i}：${person}")
            
            // 测试：如果人员年龄过大则失败
            @Assert(person.age <= 50)
        }
    }
    
    @TestCase[person in random<Person>()]
    func testPersonWithBuiltInRandomSyntax(person: Person) {
        println("使用内置随机语法测试人员：${person}")
        @Assert(person.age <= 50)
    }
}
```

可能的运行结果：

```text
原始人员：Person(name='John Doe', age=35, email='john.doe@example.com')
缩减版本：
  - Person(name='', age=0, email='')
  - Person(name='a', age=35, email='john.doe@example.com')
  - Person(name='John Doe', age=0, email='john.doe@example.com')
  - Person(name='John Doe', age=35, email='a@b')
  - Person(name='John Doe', age=17, email='john.doe@example.com')
  - Person(name='John', age=35, email='john.doe@example.com')
使用确定性策略测试：
  - Person(name='John Doe', age=25, email='john@example.com')
  - Person(name='Alice Smith', age=30, email='alice@work.com')
  - Person(name='Bob Johnson', age=45, email='bob@company.com')
  - Person(name='Charlie Brown', age=60, email='charlie@email.com')
  - Person(name='Diana Prince', age=35, email='diana@justice.com')
测试随机人员 0：Person(name='Alice Smith', age=57, email='Alice@test.com')
使用内置随机语法测试人员：Person(name='John Smith', age=7, email='John@test.com')
使用内置随机语法测试人员：Person(name='Eve Smith', age=27, email='Eve@work.com')
使用内置随机语法测试人员：Person(name='Eve Smith', age=12, email='Eve@work.com')
使用内置随机语法测试人员：Person(name='Charlie Smith', age=65, email='Charlie@example.com')
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

## interface DataStrategy\<T>

```cangjie
public interface DataStrategy<T> {
    func provider(configuration: Configuration): DataProvider<T>
    func shrinker(configuration: Configuration): DataShrinker<T>
    prop isInfinite: Bool
}
```

功能：为参数化测试提供数据的策略，T 指定该策略操作的数据类型。

### prop isInfinite

```cangjie
prop isInfinite: Bool
```

功能：是否无法穷尽。

类型：[Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

### func provider(Configuration)

```cangjie
func provider(configuration: Configuration): DataProvider<T>
```

功能：获取提供测试数据组件。

参数：

- configuration: [Configuration](unittest_common_package_classes.md#class-configuration) - 配置信息。

返回值：

- [DataProvider](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-dataprovidert)\<T> - 提供测试数据的组件对象。

### func shrinker(Configuration)

```cangjie
func shrinker(configuration: Configuration): DataShrinker<T>
```

功能：获取缩减测试数据的组件。

参数：

- configuration: [Configuration](unittest_common_package_classes.md#class-configuration) - 配置信息。

返回值：

- [DataShrinker](#interface-datashrinkert)\<T> - 缩减测试数据的组件对象。

### extend\<T> Array\<T> <: DataStrategy\<T>

```cangjie
extend<T> Array<T> <: DataStrategy<T>
```

功能：对 [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> 进行扩展。

#### prop isInfinite

```cangjie
public prop isInfinite: Bool
```

功能：是否无法穷尽。

类型：[Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

#### func provider(Configuration)

```cangjie
public func provider(_: Configuration): DataProvider<T>
```

功能：获取提供测试数据组件。

参数：

- _: [Configuration](unittest_common_package_classes.md#class-configuration) - 配置信息。

返回值：

- [DataProvider](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-dataprovidert)\<T> - 提供测试数据的组件对象。

#### func shrinker(Configuration)

```cangjie
func shrinker(configuration: Configuration): DataShrinker<T>
```

功能：获取缩减测试数据的组件。

参数：

- configuration: [Configuration](unittest_common_package_classes.md#class-configuration) - 配置信息。

返回值：

- [DataShrinker](#interface-datashrinkert)\<T> - 缩减测试数据的组件对象。

### extend\<T> Range\<T> <: DataStrategy\<T>

```cangjie
extend<T> Range<T> <: DataStrategy<T>
```

功能：对 [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<T> 进行扩展。

#### prop isInfinite

```cangjie
public prop isInfinite: Bool
```

功能：是否无法穷尽。

类型：[Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

#### func provider(Configuration)

```cangjie
public func provider(_: Configuration): DataProvider<T>
```

功能：获取提供测试数据组件。

参数：

- _: [Configuration](unittest_common_package_classes.md#class-configuration) - 配置信息。

返回值：

- [DataProvider](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-dataprovidert)\<T> - 提供测试数据的组件对象。

#### func shrinker(Configuration)

```cangjie
func shrinker(configuration: Configuration): DataShrinker<T>
```

功能：获取缩减测试数据的组件。

参数：

- configuration: [Configuration](unittest_common_package_classes.md#class-configuration) - 配置信息。

返回值：

- [DataShrinker](#interface-datashrinkert)\<T> - 缩减测试数据的组件对象。

## interface PrettyPrintable

```cangjie
public interface PrettyPrintable {
    func pprint(to: PrettyPrinter): PrettyPrinter
}
```

功能：类型实现该接口表示可以较好地进行颜色及缩进格式的打印。

示例：

<!-- run -->
```cangjie
import std.unittest.common.*

main() {
    let prettyPrintable = [PrettyText("hello "), PrettyText("world")]
    let prettyPrinter = PrettyText()
    prettyPrintable.pprint(prettyPrinter)
    println(prettyPrinter.toString())
}
```

可能的运行结果：

```text
hello world
```

### func pprint(PrettyPrinter)

```cangjie
func pprint(to: PrettyPrinter): PrettyPrinter
```

功能：将类型值打印到指定的打印器中。

参数：

- to: [PrettyPrinter](./unittest_common_package_classes.md#class-prettyprinter) - 打印器。

返回值：

- [PrettyPrinter](./unittest_common_package_classes.md#class-prettyprinter) - 打印器。

### extend\<T> Array\<T> <: PrettyPrintable where T <: PrettyPrintable

```cangjie
extend<T> Array<T> <: PrettyPrintable where T <: PrettyPrintable
```

功能：对 [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> 扩展实现 [PrettyPrintable](#interface-prettyprintable)。

#### func pprint(PrettyPrinter)

```cangjie
public func pprint(to: PrettyPrinter): PrettyPrinter
```

功能：将类型值打印到指定的打印器中。

参数：

- to: [PrettyPrinter](./unittest_common_package_classes.md#class-prettyprinter) - 打印器。

返回值：

- [PrettyPrinter](./unittest_common_package_classes.md#class-prettyprinter) - 打印器。

### extend\<T> ArrayList\<T> <: PrettyPrintable where T <: PrettyPrintable

```cangjie
extend<T> ArrayList<T>  <: PrettyPrintable where T <: PrettyPrintable
```

功能：对 [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<T> 扩展实现 [PrettyPrintable](#interface-prettyprintable)。

#### func pprint(PrettyPrinter)

```cangjie
public func pprint(to: PrettyPrinter): PrettyPrinter
```

功能：将类型值打印到指定的打印器中。

参数：

- to: [PrettyPrinter](./unittest_common_package_classes.md#class-prettyprinter) - 打印器。

返回值：

- [PrettyPrinter](./unittest_common_package_classes.md#class-prettyprinter) - 打印器。

## interface KeyFor\<T>

```cangjie
public interface KeyFor<T> {
    prop name: String
}
```

功能：[Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) 中配置型的键的类型。

可以通过 [@UnitestOption](./../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#unittestoption-宏) 定义自定义配置项键值。内置的 unittest 配置项可以根据[命名规则](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#customassertion-宏)获取。例如，可以通过 `KeyRandomSeed.randomSeed` 键从 [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) 中提取 `randomSeed` 。

### prop name

```cangjie
prop name: String
```

功能：[Configuration](./unittest_common_package_classes.md#class-configuration) 中使用的键名称的字符串表示形式。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)。
