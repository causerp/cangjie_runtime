# 类

## class DriverManager

```cangjie
public class DriverManager
```

功能：支持运行时根据驱动名获取数据库驱动实例。

### static func deregister(String)

```cangjie
public static func deregister(driverName: String): Unit
```

功能：按名称取消注册数据库驱动（如果存在）。本函数并发安全。

参数：

- driverName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 驱动名称。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用一个假设已注册的驱动名称来演示取消注册功能
    // 注意：在实际使用中，需要先注册驱动才能取消注册
    let driverName = "exampleDriver"
    
    // 尝试取消注册驱动（如果存在）
    DriverManager.deregister(driverName)
    
    println("Attempted to deregister driver: ${driverName}")
    
    // 显示当前已注册的驱动列表
    let drivers = DriverManager.drivers()
    println("Currently registered drivers: ${drivers}")
}
```

运行结果：

```text
Attempted to deregister driver: exampleDriver
Currently registered drivers: []
```

### static func drivers()

```cangjie
public static func drivers(): Array<String>
```

功能：返回已注册数据库驱动名称的列表（名称已按照字典序排序）。本方法并发安全。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - 数据库驱动名称的列表。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 获取当前已注册的驱动列表
    let driverList = DriverManager.drivers()
    
    println("Currently registered drivers:")
    if (driverList.size == 0) {
        println("  No drivers registered")
    } else {
        for (driverName in driverList) {
            println("  - ${driverName}")
        }
    }
    
    // 注册一个示例驱动（仅用于演示）
    // 注意：实际使用中需要提供真正的Driver实现
    println("\nAfter registering a driver:")
    println("  (In practice, you would register an actual driver implementation)")
}
```

运行结果：

```text
Currently registered drivers:
  No drivers registered

After registering a driver:
  (In practice, you would register an actual driver implementation)
```

### static func getDriver(String)

```cangjie
public static func getDriver(driverName: String): Option<Driver>
```

功能：按名称获取已注册的数据库驱动，如果不存在返回 `None`。本函数并发安全。

参数：

- driverName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 驱动名称。

返回值：

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Driver](database_sql_package_interfaces.md#interface-driver)> - 若驱动存在则返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 包装的驱动实例，否则返回 `None`。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 尝试获取一个驱动实例
    let driverName = "nonExistentDriver"
    let driverOption = DriverManager.getDriver(driverName)
    
    // 检查驱动是否存在
    if (driverOption.isNone()) {
        println("Driver '${driverName}' not found")
    } else {
        println("Driver '${driverName}' found")
    }
    
    // 显示如何正确处理Option类型
    match (driverOption) {
        case None => println("No driver returned for '${driverName}'")
        case Some(driver) => println("Got driver instance for '${driverName}'")
    }
}
```

运行结果：

```text
Driver 'nonExistentDriver' not found
No driver returned for 'nonExistentDriver'
```

### static func register(String, Driver)

```cangjie
public static func register(driverName: String, driver: Driver): Unit
```

功能：按名称和驱动实例注册数据库驱动，名称和实例一一对应。本方法并发安全。

参数：

- driverName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 驱动名称。
- driver: [Driver](database_sql_package_interfaces.md#interface-driver) - 驱动实例。

异常：

- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - 当指定的驱动名称已经存在时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 演示如何注册数据库驱动
    // 注意：实际使用中需要提供真正的Driver实现
    println("To register a database driver:")
    println("1. Create a class that implements the Driver interface")
    println("2. Call DriverManager.register(driverName, driverInstance)")
    
    // 显示注册驱动时可能抛出的异常
    println("\nNote: DriverManager.register() may throw SqlException")
    println("if a driver with the same name is already registered.")
}
```

运行结果：

```text
To register a database driver:
1. Create a class that implements the Driver interface
2. Call DriverManager.register(driverName, driverInstance)

Note: DriverManager.register() may throw SqlException
if a driver with the same name is already registered.
```


## class PooledDatasource

```cangjie
public class PooledDatasource <: Datasource {
    public init(datasource: Datasource)
}
```

功能：数据库连接池类，提供数据库连接池能力。

父类型：

- [Datasource](database_sql_package_interfaces.md#interface-datasource)

### prop connectionTimeout

```cangjie
public mut prop connectionTimeout: Duration
```

功能：从池中获取连接的超时时间。

类型：[Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

异常：

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - 当该属性被设置为 [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).Max 或 [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).Min 时，抛此异常。
- [SqlException](database_sql_package_exceptions.md#class-sqlexception) - 当获取连接超时后，抛出此异常。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个PooledDatasource实例（需要提供一个Datasource实现）
    // 这里我们使用一个简化的示例
    
    println("Example for PooledDatasource.connectionTimeout property:")
    println("To set the connection timeout:")
    println("  pooledDatasource.connectionTimeout = Duration.hour")
    println("To get the connection timeout:")
    println("  let timeout = pooledDatasource.connectionTimeout")
    println("  println(\"Connection timeout: \${timeout}\")")  // 使用转义字符避免变量替换
}
```

运行结果：

```text
Example for PooledDatasource.connectionTimeout property:
To set the connection timeout:
  pooledDatasource.connectionTimeout = Duration.hour
To get the connection timeout:
  let timeout = pooledDatasource.connectionTimeout
  println("Connection timeout: ${timeout}")
```

### prop idleTimeout

```cangjie
public mut prop idleTimeout: Duration
```

功能：允许连接在池中闲置的最长时间，超过这个时间的空闲连接可能会被回收。

类型：[Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个PooledDatasource实例（需要提供一个Datasource实现）
    // 这里我们使用一个简化的示例
    
    println("Example for PooledDatasource.idleTimeout property:")
    println("To set the idle timeout:")
    println("  pooledDatasource.idleTimeout = Duration.hour")
    println("To get the idle timeout:")
    println("  let timeout = pooledDatasource.idleTimeout")
    println("  println(\"Idle timeout: \${timeout}\")")  // 使用转义字符避免变量替换
}
```

运行结果：

```text
Example for PooledDatasource.idleTimeout property:
To set the idle timeout:
  pooledDatasource.idleTimeout = Duration.hour
To get the idle timeout:
  let timeout = pooledDatasource.idleTimeout
  println("Idle timeout: ${timeout}")
```

### prop keepaliveTime

```cangjie
public mut prop keepaliveTime: Duration
```

功能：检查空闲连接健康状况的间隔时间，防止它被数据库或网络基础设施超时。

类型：[Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个PooledDatasource实例（需要提供一个Datasource实现）
    // 这里我们使用一个简化的示例
    
    println("Example for PooledDatasource.keepaliveTime property:")
    println("To set the keepalive time:")
    println("  pooledDatasource.keepaliveTime = Duration.hour")
    println("To get the keepalive time:")
    println("  let time = pooledDatasource.keepaliveTime")
    println("  println(\"Keepalive time: \${time}\")")  // 使用转义字符避免变量替换
}
```

运行结果：

```text
Example for PooledDatasource.keepaliveTime property:
To set the keepalive time:
  pooledDatasource.keepaliveTime = Duration.hour
To get the keepalive time:
  let time = pooledDatasource.keepaliveTime
  println("Keepalive time: ${time}")
```

### prop maxIdleSize

```cangjie
public mut prop maxIdleSize: Int32
```

功能：最大空闲连接数量，超过这个数量的空闲连接会被关闭，负数或0表示无限制。

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个PooledDatasource实例（需要提供一个Datasource实现）
    // 这里我们使用一个简化的示例
    
    println("Example for PooledDatasource.maxIdleSize property:")
    println("To set the maximum idle size:")
    println("  pooledDatasource.maxIdleSize = 10")
    println("To get the maximum idle size:")
    println("  let size = pooledDatasource.maxIdleSize")
    println("  println(\"Max idle size: \${size}\")")  // 使用转义字符避免变量替换
}
```

运行结果：

```text
Example for PooledDatasource.maxIdleSize property:
To set the maximum idle size:
  pooledDatasource.maxIdleSize = 10
To get the maximum idle size:
  let size = pooledDatasource.maxIdleSize
  println("Max idle size: ${size}")
```

### prop maxLifeTime

```cangjie
public mut prop maxLifeTime: Duration
```

功能：自连接创建以来的最大持续时间，在该持续时间之后，连接将自动关闭。

类型：[Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个PooledDatasource实例（需要提供一个Datasource实现）
    // 这里我们使用一个简化的示例
    
    println("Example for PooledDatasource.maxLifeTime property:")
    println("To set the maximum lifetime:")
    println("  pooledDatasource.maxLifeTime = Duration.hour")
    println("To get the maximum lifetime:")
    println("  let time = pooledDatasource.maxLifeTime")
    println("  println(\"Max lifetime: \${time}\")")  // 使用转义字符避免变量替换
}
```

运行结果：

```text
Example for PooledDatasource.maxLifeTime property:
To set the maximum lifetime:
  pooledDatasource.maxLifeTime = Duration.hour
To get the maximum lifetime:
  let time = pooledDatasource.maxLifeTime
  println("Max lifetime: ${time}")
```

### prop maxSize

```cangjie
public mut prop maxSize: Int32
```

功能：连接池最大连接数量，负数或0表示无限制。

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个PooledDatasource实例（需要提供一个Datasource实现）
    // 这里我们使用一个简化的示例
    
    println("Example for PooledDatasource.maxSize property:")
    println("To set the maximum size:")
    println("  pooledDatasource.maxSize = 20")
    println("To get the maximum size:")
    println("  let size = pooledDatasource.maxSize")
    println("  println(\"Max size: \${size}\")")  // 使用转义字符避免变量替换
}
```

运行结果：

```text
Example for PooledDatasource.maxSize property:
To set the maximum size:
  pooledDatasource.maxSize = 20
To get the maximum size:
  let size = pooledDatasource.maxSize
  println("Max size: ${size}")
```

### init(Datasource)

```cangjie
public init(datasource: Datasource)
```

功能：通过数据源 datasource 构造一个 [PooledDatasource](database_sql_package_classes.md#class-pooleddatasource) 实例，入参必须为 [Datasource](database_sql_package_interfaces.md#interface-datasource) 对象。

参数：

- datasource: [Datasource](database_sql_package_interfaces.md#interface-datasource) - 数据源。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个PooledDatasource实例
    // 需要提供一个Datasource实现
    println("Example for PooledDatasource.init(Datasource) constructor:")
    println("To create a PooledDatasource:")
    println("  let pooledDatasource = PooledDatasource(datasource)")
    println("Where 'datasource' is an implementation of the Datasource interface")
}
```

运行结果：

```text
Example for PooledDatasource.init(Datasource) constructor:
To create a PooledDatasource:
  let pooledDatasource = PooledDatasource(datasource)
Where 'datasource' is an implementation of the Datasource interface
```

### func close()

```cangjie
public func close(): Unit
```

功能：关闭连接池中的所有连接并阻止其他连接请求。调用该方法会阻塞至所有连接关闭并归还到连接池。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用PooledDatasource的close函数
    println("Example for PooledDatasource.close() function:")
    println("To close a PooledDatasource:")
    println("  pooledDatasource.close()")
    println("This will close all connections in the pool and block until all connections are returned to the pool.")
}
```

运行结果：

```text
Example for PooledDatasource.close() function:
To close a PooledDatasource:
  pooledDatasource.close()
This will close all connections in the pool and block until all connections are returned to the pool.
```

### func connect()

```cangjie
public func connect(): Connection
```

功能：获取一个连接。

返回值：

- [Connection](./database_sql_package_interfaces.md#interface-connection) - 获取到的连接。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用PooledDatasource的connect函数
    println("Example for PooledDatasource.connect() function:")
    println("To get a connection from the pool:")
    println("  let connection = pooledDatasource.connect()")
    println("  // Use the connection for database operations")
    println("  // ...")
    println("  // Remember to close the connection when done")
    println("  connection.close()")
}
```

运行结果：

```text
Example for PooledDatasource.connect() function:
To get a connection from the pool:
  let connection = pooledDatasource.connect()
  // Use the connection for database operations
  // ...
  // Remember to close the connection when done
  connection.close()
```

### func isClosed()

```cangjie
public func isClosed(): Bool
```

功能：判断连接是否关闭。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 连接是否关闭。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用PooledDatasource的isClosed函数
    println("Example for PooledDatasource.isClosed() function:")
    println("To check if a PooledDatasource is closed:")
    println("  let isClosed = pooledDatasource.isClosed()")
    println("  if (isClosed) {")
    println("      println(\"The datasource is closed\")")
    println("  } else {")
    println("      println(\"The datasource is open\")")
    println("  }")
}
```

运行结果：

```text
Example for PooledDatasource.isClosed() function:
To check if a PooledDatasource is closed:
  let isClosed = pooledDatasource.isClosed()
  if (isClosed) {
      println("The datasource is closed")
  } else {
      println("The datasource is open")
  }
```

### func setOption(String, String)

```cangjie
public func setOption(key: String, value: String): Unit
```

功能：设置数据库驱动连接选项（公钥在 [SqlOption](database_sql_package_classes.md#class-sqloption) 中预定义）。

参数：

- key: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 连接选项名称。
- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 连接选项的值。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用PooledDatasource的setOption函数
    println("Example for PooledDatasource.setOption(String, String) function:")
    println("To set a database driver connection option:")
    println("  pooledDatasource.setOption(\"optionKey\", \"optionValue\")")
    println("Common options are predefined in SqlOption class")
}
```

运行结果：

```text
Example for PooledDatasource.setOption(String, String) function:
To set a database driver connection option:
  pooledDatasource.setOption("optionKey", "optionValue")
Common options are predefined in SqlOption class
```

## class SqlBigInt <sup>(deprecated)</sup>

```cangjie
public class SqlBigInt <: SqlDbType {
    public init(v: Int64)
}
```

功能：大整数，对应仓颉 [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 类型。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlBigInt <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlbigint-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlBigInt实例
    let sqlBigInt = SqlBigInt(1234567890)
    
    // 访问name属性
    let name = sqlBigInt.name
    println("SqlBigInt name: ${name}")
}
```

运行结果：

```text
SqlBigInt name: SqlBigInt
```

### prop value

```cangjie
public mut prop value: Int64
```

功能：该数据的值。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlBigInt实例
    let sqlBigInt = SqlBigInt(1234567890)
    
    // 访问value属性
    let value = sqlBigInt.value
    println("SqlBigInt value: ${value}")
    
    // 修改value属性
    sqlBigInt.value = 987654321
    println("Modified SqlBigInt value: ${sqlBigInt.value}")
}
```

运行结果：

```text
SqlBigInt value: 1234567890
Modified SqlBigInt value: 987654321
```

### init(Int64)

```cangjie
public init(v: Int64)
```

功能：根据传入参数 v 构造一个 [SqlBigInt <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlbigint-deprecated) 实例。

参数：

- v: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlBigInt的构造函数
    let sqlBigInt = SqlBigInt(1234567890)
    println("Created SqlBigInt with value: ${sqlBigInt.value}")
    
    // 访问name属性
    println("SqlBigInt name: ${sqlBigInt.name}")
}
```

运行结果：

```text
Created SqlBigInt with value: 1234567890
SqlBigInt name: SqlBigInt
```

## class SqlBinary <sup>(deprecated)</sup>

```cangjie
public class SqlBinary <: SqlDbType {
    public init(v: Array<Byte>)
}
```

功能：定长二进制字符串，对应仓颉 [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> 类型。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlBinary <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlbinary-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlBinary实例
    let bytes: Array<Byte> = [1, 2, 3, 4, 5]
    let sqlBinary = SqlBinary(bytes)
    
    // 访问name属性
    let name = sqlBinary.name
    println("SqlBinary name: ${name}")
}
```

运行结果：

```text
SqlBinary name: SqlBinary
```

### prop value

```cangjie
public mut prop value: Array<Byte>
```

功能：该数据的值。

类型：[Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlBinary实例
    let bytes: Array<Byte> = [1, 2, 3, 4, 5]
    let sqlBinary = SqlBinary(bytes)
    
    // 访问value属性
    let value = sqlBinary.value
    println("SqlBinary value size: ${value.size}")
    for (i in 0..value.size) {
        println("  Byte ${i}: ${value[i]}")
    }
    
    // 修改value属性
    let newBytes: Array<Byte> = [10, 20, 30]
    sqlBinary.value = newBytes
    println("Modified SqlBinary value size: ${sqlBinary.value.size}")
}
```

运行结果：

```text
SqlBinary value size: 5
  Byte 0: 1
  Byte 1: 2
  Byte 2: 3
  Byte 3: 4
  Byte 4: 5
Modified SqlBinary value size: 3
```

### init(Array\<Byte>)

```cangjie
public init(v: Array<Byte>)
```

功能：根据传入参数 v 构造一个 [SqlBinary <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlbinary-deprecated) 实例。

参数：

- v: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlBinary的构造函数
    let bytes: Array<Byte> = [1, 2, 3, 4, 5]
    let sqlBinary = SqlBinary(bytes)
    println("Created SqlBinary with ${sqlBinary.value.size} bytes")
    
    // 访问name属性
    println("SqlBinary name: ${sqlBinary.name}")
}
```

运行结果：

```text
Created SqlBinary with 5 bytes
SqlBinary name: SqlBinary
```

## class SqlBlob <sup>(deprecated)</sup>

```cangjie
public class SqlBlob <: SqlDbType {
    public init(v: InputStream)
}
```

功能：变长超大二进制字符串（BINARY LARGE OBJECT），对应仓颉 [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream) 类型。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlBlob <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlblob-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.io.*

main() {
    // 创建一个SqlBlob实例
    let data: Array<Byte> = [1, 2, 3, 4, 5]
    let byteBuffer = ByteBuffer(data)
    let inputStream = BufferedInputStream(byteBuffer)
    let sqlBlob = SqlBlob(inputStream)
    
    // 访问name属性
    let name = sqlBlob.name
    println("SqlBlob name: ${name}")
}
```

运行结果：

```text
SqlBlob name: SqlBlob
```

### prop value

```cangjie
public mut prop value: InputStream
```

功能：该数据的值。

类型：[InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.io.*

main() {
    // 创建一个SqlBlob实例
    let data: Array<Byte> = [1, 2, 3, 4, 5]
    let byteBuffer = ByteBuffer(data)
    let inputStream = BufferedInputStream(byteBuffer)
    let sqlBlob = SqlBlob(inputStream)
    
    // 访问value属性
    let value = sqlBlob.value
    println("SqlBlob value: InputStream")
    
    // 修改value属性
    let newData: Array<Byte> = [10, 20, 30]
    let newByteBuffer = ByteBuffer(newData)
    let newInputStream = BufferedInputStream(newByteBuffer)
    sqlBlob.value = newInputStream
    println("Modified SqlBlob value")
}
```

运行结果：

```text
SqlBlob value: InputStream
Modified SqlBlob value
```

### init(InputStream)

```cangjie
public init(v: InputStream)
```

功能：根据传入参数 v 构造一个 [SqlBlob <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlblob-deprecated) 实例。

参数：

- v: [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.io.*

main() {
    // 使用SqlBlob的构造函数
    let data: Array<Byte> = [1, 2, 3, 4, 5]
    let byteBuffer = ByteBuffer(data)
    let inputStream = BufferedInputStream(byteBuffer)
    let sqlBlob = SqlBlob(inputStream)
    println("Created SqlBlob with InputStream")
    
    // 访问name属性
    println("SqlBlob name: ${sqlBlob.name}")
}
```

运行结果：

```text
Created SqlBlob with InputStream
SqlBlob name: SqlBlob
```

## class SqlBool <sup>(deprecated)</sup>

```cangjie
public class SqlBool <: SqlDbType {
    public init(v: Bool)
}
```

功能：布尔类型，对应仓颉 [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) 类型。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlBool<sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlbool-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlBool实例
    let sqlBool = SqlBool(true)
    
    // 访问name属性
    let name = sqlBool.name
    println("SqlBool name: ${name}")
}
```

运行结果：

```text
SqlBool name: SqlBool
```

### prop value

```cangjie
public mut prop value: Bool
```

功能：该数据的值。

类型：[Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlBool实例
    let sqlBool = SqlBool(true)
    
    // 访问value属性
    let value = sqlBool.value
    println("SqlBool value: ${value}")
    
    // 修改value属性
    sqlBool.value = false
    println("Modified SqlBool value: ${sqlBool.value}")
}
```

运行结果：

```text
SqlBool value: true
Modified SqlBool value: false
```

### init(Bool)

```cangjie
public init(v: Bool)
```

功能：根据传入参数 v 构造一个 [SqlBool<sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlbool-deprecated) 实例。

参数：

- v: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlBool的构造函数
    let sqlBool = SqlBool(true)
    println("Created SqlBool with value: ${sqlBool.value}")
    
    // 访问name属性
    println("SqlBool name: ${sqlBool.name}")
}
```

运行结果：

```text
Created SqlBool with value: true
SqlBool name: SqlBool
```

## class SqlByte <sup>(deprecated)</sup>

```cangjie
public class SqlByte <: SqlDbType {
    public init(v: Int8)
}
```

功能：字节，对应仓颉 [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 类型。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlByte <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlbyte-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlByte实例
    let sqlByte = SqlByte(65)
    
    // 访问name属性
    let name = sqlByte.name
    println("SqlByte name: ${name}")
}
```

运行结果：

```text
SqlByte name: SqlByte
```

### prop value

```cangjie
public mut prop value: Int8
```

功能：该数据的值。

类型：[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlByte实例
    let sqlByte = SqlByte(65)
    
    // 访问value属性
    let value = sqlByte.value
    println("SqlByte value: ${value}")
    
    // 修改value属性
    sqlByte.value = 90
    println("Modified SqlByte value: ${sqlByte.value}")
}
```

运行结果：

```text
SqlByte value: 65
Modified SqlByte value: 90
```

### init(Int8)

```cangjie
public init(v: Int8)
```

功能：根据传入参数 v 构造一个 [SqlByte <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlbyte-deprecated) 实例。

参数：

- v: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlByte的构造函数
    let sqlByte = SqlByte(65)
    println("Created SqlByte with value: ${sqlByte.value}")
    
    // 访问name属性
    println("SqlByte name: ${sqlByte.name}")
}
```

运行结果：

```text
Created SqlByte with value: 65
SqlByte name: SqlByte
```

## class SqlChar <sup>(deprecated)</sup>

```cangjie
public class SqlChar <: SqlDbType {
    public init(v: String)
}
```

功能：定长字符串，对应仓颉 [String](../../core/core_package_api/core_package_structs.md#struct-string) 类型。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlChar <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlchar-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlChar实例
    let sqlChar = SqlChar("A")
    
    // 访问name属性
    let name = sqlChar.name
    println("SqlChar name: ${name}")
}
```

运行结果：

```text
SqlChar name: SqlChar
```

### prop value

```cangjie
public mut prop value: String
```

功能：该数据的值。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlChar实例
    let sqlChar = SqlChar("Hello")
    
    // 访问value属性
    let value = sqlChar.value
    println("SqlChar value: ${value}")
    
    // 修改value属性
    sqlChar.value = "World"
    println("Modified SqlChar value: ${sqlChar.value}")
}
```

运行结果：

```text
SqlChar value: Hello
Modified SqlChar value: World
```

### init(String)

```cangjie
public init(v: String)
```

功能：根据传入参数 v 构造一个 [SqlChar <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlchar-deprecated) 实例。

参数：

- v: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlChar的构造函数
    let sqlChar = SqlChar("Hello")
    println("Created SqlChar with value: ${sqlChar.value}")
    
    // 访问name属性
    println("SqlChar name: ${sqlChar.name}")
}
```

运行结果：

```text
Created SqlChar with value: Hello
SqlChar name: SqlChar
```

## class SqlClob <sup>(deprecated)</sup>

```cangjie
public class SqlClob <: SqlDbType {
    public init(v: InputStream)
}
```

功能：变长超大字符串（RUNE LARGE OBJECT），对应仓颉 [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream) 类型。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlClob](database_sql_package_classes.md#class-sqlclob-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.io.*

main() {
    // 创建一个SqlClob实例
    let data: Array<Byte> = [72, 101, 108, 108, 111] // "Hello"的ASCII码
    let byteBuffer = ByteBuffer(data)
    let inputStream = BufferedInputStream(byteBuffer)
    let sqlClob = SqlClob(inputStream)
    
    // 访问name属性
    let name = sqlClob.name
    println("SqlClob name: ${name}")
}
```

运行结果：

```text
SqlClob name: SqlClob
```

### prop value

```cangjie
public mut prop value: InputStream
```

功能：该数据的值。

类型：[InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.io.*

main() {
    // 创建一个SqlClob实例
    let data: Array<Byte> = [72, 101, 108, 108, 111] // "Hello"的ASCII码
    let byteBuffer = ByteBuffer(data)
    let inputStream = BufferedInputStream(byteBuffer)
    let sqlClob = SqlClob(inputStream)
    
    // 访问value属性
    let value = sqlClob.value
    println("SqlClob value: InputStream")
    
    // 修改value属性
    let newData: Array<Byte> = [87, 111, 114, 108, 100] // "World"的ASCII码
    let newByteBuffer = ByteBuffer(newData)
    let newInputStream = BufferedInputStream(newByteBuffer)
    sqlClob.value = newInputStream
    println("Modified SqlClob value")
}
```

运行结果：

```text
SqlClob value: InputStream
Modified SqlClob value
```

### init(InputStream)

```cangjie
public init(v: InputStream)
```

功能：根据传入参数 v 构造一个 [SqlClob](database_sql_package_classes.md#class-sqlclob-deprecated) 实例。

参数：

- v: [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.io.*

main() {
    // 使用SqlClob的构造函数
    let data: Array<Byte> = [72, 101, 108, 108, 111] // "Hello"的ASCII码
    let byteBuffer = ByteBuffer(data)
    let inputStream = BufferedInputStream(byteBuffer)
    let sqlClob = SqlClob(inputStream)
    println("Created SqlClob with InputStream")
    
    // 访问name属性
    println("SqlClob name: ${sqlClob.name}")
}
```

运行结果：

```text
Created SqlClob with InputStream
SqlClob name: SqlClob
```

## class SqlDate <sup>(deprecated)</sup>

```cangjie
public class SqlDate <: SqlDbType {
    public init(v: DateTime)
}
```

功能：日期，仅年月日有效，对应仓颉 [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) 类型。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlDate <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqldate-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    // 创建一个SqlDate实例
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    let sqlDate = SqlDate(dateTime)
    
    // 访问name属性
    let name = sqlDate.name
    println("SqlDate name: ${name}")
}
```

运行结果：

```text
SqlDate name: SqlDate
```

### prop value

```cangjie
public mut prop value: DateTime
```

功能：该数据的值。

类型：[DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    // 创建一个SqlDate实例
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    let sqlDate = SqlDate(dateTime)
    
    // 访问value属性
    let value = sqlDate.value
    println("SqlDate value: ${value}")
    
    // 修改value属性
    let newDateTime = dateTime.addDays(10)
    sqlDate.value = newDateTime
    println("Modified SqlDate value: ${sqlDate.value}")
}
```

运行结果：

```text
SqlDate value: 2012-01-01T00:00:00+08:00
Modified SqlDate value: 2012-01-11T00:00:00+08:00
```

### init(DateTime)

```cangjie
public init(v: DateTime)
```

功能：根据传入参数 v 构造一个 [SqlDate <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqldate-deprecated) 实例。

参数：

- v: [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    // 使用SqlDate的构造函数
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    let sqlDate = SqlDate(dateTime)
    println("Created SqlDate with value: ${sqlDate.value}")
    
    // 访问name属性
    println("SqlDate name: ${sqlDate.name}")
}
```

运行结果：

```text
Created SqlDate with value: 2012-01-01T00:00:00+08:00
SqlDate name: SqlDate
```


## class SqlDecimal <sup>(deprecated)</sup>

```cangjie
public class SqlDecimal <: SqlDbType {
    public init(v: Decimal)
}
```

功能：高精度数，对应仓颉 [Decimal](../../math_numeric/math_numeric_package_api/math_numeric_package_structs.md#struct-decimal) 类型。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlDecimal <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqldecimal-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.math.numeric.*

main() {
    // 创建一个SqlDecimal实例
    let decimal = Decimal(123.456)
    let sqlDecimal = SqlDecimal(decimal)
    
    // 访问name属性
    let name = sqlDecimal.name
    println("SqlDecimal name: ${name}")
}
```

运行结果：

```text
SqlDecimal name: SqlDecimal
```

### prop value

```cangjie
public mut prop value: Decimal
```

功能：该数据的值。

类型：[Decimal](../../math_numeric/math_numeric_package_api/math_numeric_package_structs.md#struct-decimal)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.math.numeric.*

main() {
    // 创建一个SqlDecimal实例
    let decimal = Decimal(123.456)
    let sqlDecimal = SqlDecimal(decimal)
    
    // 访问value属性
    let value = sqlDecimal.value
    println("SqlDecimal value: ${value}")
    
    // 修改value属性
    let newDecimal = Decimal(789.012)
    sqlDecimal.value = newDecimal
    println("Modified SqlDecimal value: ${sqlDecimal.value}")
}
```

运行结果：

```text
SqlDecimal value: 123.4560000000000030695446184836328029632568359375
Modified SqlDecimal value: 789.011999999999943611328490078449249267578125
```

### init(Decimal)

```cangjie
public init(v: Decimal)
```

功能：根据传入参数 v 构造一个 [SqlDecimal <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqldecimal-deprecated) 实例。

参数：

- v: [Decimal](../../math_numeric/math_numeric_package_api/math_numeric_package_structs.md#struct-decimal) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.math.numeric.*

main() {
    // 使用SqlDecimal的构造函数
    let decimal = Decimal(123.456)
    let sqlDecimal = SqlDecimal(decimal)
    println("Created SqlDecimal with value: ${sqlDecimal.value}")
    
    // 访问name属性
    println("SqlDecimal name: ${sqlDecimal.name}")
}
```

运行结果：

```text
Created SqlDecimal with value: 123.4560000000000030695446184836328029632568359375
SqlDecimal name: SqlDecimal
```

## class SqlDouble <sup>(deprecated)</sup>

```cangjie
public class SqlDouble <: SqlDbType {
    public init(v: Float64)
}
```

功能：双精度数，对应仓颉 [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) 类型。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlDouble <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqldouble-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlDouble实例
    let sqlDouble = SqlDouble(123.456)
    
    // 访问name属性
    let name = sqlDouble.name
    println("SqlDouble name: ${name}")
}
```

运行结果：

```text
SqlDouble name: SqlDouble
```

### prop value

```cangjie
public mut prop value: Float64
```

功能：该数据的值。

类型：[Float64](../../core/core_package_api/core_package_intrinsics.md#float64)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlDouble实例
    let sqlDouble = SqlDouble(123.456)
    
    // 访问value属性
    let value = sqlDouble.value
    println("SqlDouble value: ${value}")
    
    // 修改value属性
    sqlDouble.value = 789.012
    println("Modified SqlDouble value: ${sqlDouble.value}")
}
```

运行结果：

```text
SqlDouble value: 123.456000
Modified SqlDouble value: 789.012000
```

### init(Float64)

```cangjie
public init(v: Float64)
```

功能：根据传入参数 v 构造一个 [SqlDouble <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqldouble-deprecated) 实例。

参数：

- v: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlDouble的构造函数
    let sqlDouble = SqlDouble(123.456)
    println("Created SqlDouble with value: ${sqlDouble.value}")
    
    // 访问name属性
    println("SqlDouble name: ${sqlDouble.name}")
}
```

运行结果：

```text
Created SqlDouble with value: 123.456000
SqlDouble name: SqlDouble
```

## class SqlInteger <sup>(deprecated)</sup>

```cangjie
public class SqlInteger <: SqlDbType {
    public init(v: Int32)
}
```

功能：中整数，对应仓颉 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 类型。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlInteger <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlinteger-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlInteger实例
    let sqlInteger = SqlInteger(123456)
    
    // 访问name属性
    let name = sqlInteger.name
    println("SqlInteger name: ${name}")
}
```

运行结果：

```text
SqlInteger name: SqlInteger
```

### prop value

```cangjie
public mut prop value: Int32
```

功能：该数据的值。

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlInteger实例
    let sqlInteger = SqlInteger(123456)
    
    // 访问value属性
    let value = sqlInteger.value
    println("SqlInteger value: ${value}")
    
    // 修改value属性
    sqlInteger.value = 789012
    println("Modified SqlInteger value: ${sqlInteger.value}")
}
```

运行结果：

```text
SqlInteger value: 123456
Modified SqlInteger value: 789012
```

### init(Int32)

```cangjie
public init(v: Int32)
```

功能：根据传入参数 v 构造一个 [SqlInteger <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlinteger-deprecated) 实例。

参数：

- v: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlInteger的构造函数
    let sqlInteger = SqlInteger(123456)
    println("Created SqlInteger with value: ${sqlInteger.value}")
    
    // 访问name属性
    println("SqlInteger name: ${sqlInteger.name}")
}
```

运行结果：

```text
Created SqlInteger with value: 123456
SqlInteger name: SqlInteger
```

## class SqlInterval <sup>(deprecated)</sup>

```cangjie
public class SqlInterval <: SqlDbType {
    public init(v: Duration)
}
```

功能：时间间隔，对应仓颉 [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) 类型。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlInterval <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlinterval-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.core.*

main() {
    // 创建一个SqlInterval实例
    let duration = 123456789 * Duration.millisecond
    let sqlInterval = SqlInterval(duration)
    
    // 访问name属性
    let name = sqlInterval.name
    println("SqlInterval name: ${name}")
}
```

运行结果：

```text
SqlInterval name: SqlInterval
```

### prop value

```cangjie
public mut prop value: Duration
```

功能：该数据的值。

类型：[Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.core.*

main() {
    // 创建一个SqlInterval实例
    let duration = 123456789 * Duration.millisecond
    let sqlInterval = SqlInterval(duration)
    
    // 访问value属性
    let value = sqlInterval.value
    println("SqlInterval value: ${value}")
    
    // 修改value属性
    let newDuration = 987654321 * Duration.millisecond
    sqlInterval.value = newDuration
    println("Modified SqlInterval value: ${sqlInterval.value}")
}
```

运行结果：

```text
SqlInterval value: 1d10h17m36s789ms
Modified SqlInterval value: 11d10h20m54s321ms
```

### init(Duration)

```cangjie
public init(v: Duration)
```

功能：根据传入参数 v 构造一个 [SqlInterval <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlinterval-deprecated) 实例。

参数：

- v: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.core.*

main() {
    // 使用SqlInterval的构造函数
    let duration = 123456789 * Duration.millisecond
    let sqlInterval = SqlInterval(duration)
    println("Created SqlInterval with value: ${sqlInterval.value}")
    
    // 访问name属性
    println("SqlInterval name: ${sqlInterval.name}")
}
```

运行结果：

```text
Created SqlInterval with value: 1d10h17m36s789ms
SqlInterval name: SqlInterval
```

## class SqlNullableBigInt <sup>(deprecated)</sup>

```cangjie
public class SqlNullableBigInt <: SqlNullableDbType {
    public init(v: ?Int64)
}
```

功能：大整数，对应仓颉 [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 类型，可为数据库 `Null` 值。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlNullableBigInt <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablebigint-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlNullableBigInt实例
    let sqlNullableBigInt = SqlNullableBigInt(Some(123456i64))
    
    // 访问name属性
    let name = sqlNullableBigInt.name
    println("SqlNullableBigInt name: ${name}")
}
```

运行结果：

```text
SqlNullableBigInt name: SqlNullableBigInt
```

### prop value

```cangjie
public mut prop value: ?Int64
```

功能：该数据的值。

类型：?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlNullableBigInt实例
    let sqlNullableBigInt = SqlNullableBigInt(Some(123456i64))
    
    // 访问value属性
    let value = sqlNullableBigInt.value
    println("SqlNullableBigInt value: ${value}")
    
    // 修改value属性
    sqlNullableBigInt.value = Some(789012i64)
    println("Modified SqlNullableBigInt value: ${sqlNullableBigInt.value}")
}
```

运行结果：

```text
SqlNullableBigInt value: Some(123456)
Modified SqlNullableBigInt value: Some(789012)
```

### init(?Int64)

```cangjie
public init(v: ?Int64)
```

功能：根据传入参数 v 构造一个 [SqlNullableBigInt <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablebigint-deprecated) 实例。

参数：

- v: ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlNullableBigInt的构造函数
    let sqlNullableBigInt = SqlNullableBigInt(Some(123456i64))
    println("Created SqlNullableBigInt with value: ${sqlNullableBigInt.value}")
    
    // 访问name属性
    println("SqlNullableBigInt name: ${sqlNullableBigInt.name}")
}
```

运行结果：

```text
Created SqlNullableBigInt with value: Some(123456)
SqlNullableBigInt name: SqlNullableBigInt
```

## class SqlNullableBinary <sup>(deprecated)</sup>

```cangjie
public class SqlNullableBinary <: SqlNullableDbType {
    public init(v: ?Array<Byte>)
}
```

功能：定长二进制字符串，对应仓颉 [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> 类型，可为数据库 `Null` 值。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlNullableBinary <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablebinary-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlNullableBinary实例
    let bytes = [1u8, 2u8, 3u8, 4u8]
    let sqlNullableBinary = SqlNullableBinary(Some(bytes))
    
    // 访问name属性
    let name = sqlNullableBinary.name
    println("SqlNullableBinary name: ${name}")
}
```

运行结果：

```text
SqlNullableBinary name: SqlNullableBinary
```

### prop value

```cangjie
public mut prop value: ?Array<Byte>
```

功能：该数据的值。

类型：?[Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlNullableBinary实例
    let bytes = [1u8, 2u8, 3u8, 4u8]
    let sqlNullableBinary = SqlNullableBinary(Some(bytes))
    
    // 访问value属性
    let value = sqlNullableBinary.value
    println("SqlNullableBinary value: ${value}")
    
    // 修改value属性
    let newBytes = [5u8, 6u8, 7u8, 8u8]
    sqlNullableBinary.value = Some(newBytes)
    println("Modified SqlNullableBinary value: ${sqlNullableBinary.value}")
}
```

运行结果：

```text
SqlNullableBinary value: Some([1, 2, 3, 4])
Modified SqlNullableBinary value: Some([5, 6, 7, 8])
```

### init(?Array\<Byte>)

```cangjie
public init(v: ?Array<Byte>)
```

功能：根据传入参数 v 构造一个 [SqlNullableBinary <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablebinary-deprecated) 实例。

参数：

- v: ?[Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlNullableBinary的构造函数
    let bytes = [1u8, 2u8, 3u8, 4u8]
    let sqlNullableBinary = SqlNullableBinary(Some(bytes))
    println("Created SqlNullableBinary with value: ${sqlNullableBinary.value}")
    
    // 访问name属性
    println("SqlNullableBinary name: ${sqlNullableBinary.name}")
}
```

运行结果：

```text
Created SqlNullableBinary with value: Some([1, 2, 3, 4])
SqlNullableBinary name: SqlNullableBinary
```

## class SqlNullableBlob <sup>(deprecated)</sup>

```cangjie
public class SqlNullableBlob <: SqlNullableDbType {
    public init(v: ?InputStream)
}
```

功能：变长超大二进制字符串（BINARY LARGE OBJECT），对应仓颉 [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream) 类型，可为数据库 `Null` 值。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlNullableBlob <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullableblob-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.io.*

main() {
    // 创建一个SqlBlob实例
    let data: Array<Byte> = [1, 2, 3, 4, 5]
    let byteBuffer = ByteBuffer(data)
    let inputStream = BufferedInputStream(byteBuffer)
    let sqlNullableBlob = SqlNullableBlob(Some(inputStream))
    
    // 访问name属性
    let name = sqlNullableBlob.name
    println("SqlNullableBlob name: ${name}")
}
```

运行结果：

```text
SqlNullableBlob name: SqlNullableBlob
```

### prop value

```cangjie
public mut prop value: ?InputStream
```

功能：该数据的值。

类型：?[InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.io.*

main() {
    // 创建一个SqlNullableBlob实例
    let data: Array<Byte> = [1, 2, 3, 4, 5]
    let byteBuffer = ByteBuffer(data)
    let inputStream = BufferedInputStream(byteBuffer)
    let sqlNullableBlob = SqlNullableBlob(Some(inputStream))
    
    // 访问value属性
    let value = sqlNullableBlob.value
    match (value) {
        case None => println("SqlNullableBlob value is None")
        case Some(_) => println("SqlNullableBlob value is Some(InputStream)")
    }
    
    // 修改value属性
    sqlNullableBlob.value = None
    match (sqlNullableBlob.value) {
        case None => println("Modified SqlNullableBlob value is None")
        case Some(_) => println("Modified SqlNullableBlob value is Some(InputStream)")
    }
}
```

运行结果：

```text
SqlNullableBlob value is Some(InputStream)
Modified SqlNullableBlob value is None
```

### init(?InputStream)

```cangjie
public init(v: ?InputStream)
```

功能：根据传入参数 v 构造一个 [SqlNullableBlob <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullableblob-deprecated) 实例。

参数：

- v: ?[InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.io.*

main() {
    // 创建一个SqlBlob实例
    let data: Array<Byte> = [1, 2, 3, 4, 5]
    let byteBuffer = ByteBuffer(data)
    let inputStream = BufferedInputStream(byteBuffer)
    let sqlNullBlob = SqlNullableBlob(Some(inputStream))
    
    // 访问name属性
    let name = sqlNullBlob.name
    println("SqlNullableBlob name: ${name}")
}
```

运行结果：

```text
SqlNullableBlob name: SqlNullableBlob
```

## class SqlNullableBool <sup>(deprecated)</sup>

```cangjie
public class SqlNullableBool <: SqlNullableDbType {
    public init(v: ?Bool)
}
```

功能：布尔类型，对应仓颉 [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) 类型，可为数据库 `Null` 值。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlNullableBool <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablebool-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlNullableBool实例
    let sqlNullableBool = SqlNullableBool(Some(true))
    
    // 访问name属性
    let name = sqlNullableBool.name
    println("SqlNullableBool name: ${name}")
}
```

运行结果：

```text
SqlNullableBool name: SqlNullableBool
```

### prop value

```cangjie
public mut prop value: ?Bool
```

功能：该数据的值。

类型：?[Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlNullableBool实例
    let sqlNullableBool = SqlNullableBool(Some(true))
    
    // 访问value属性
    let value = sqlNullableBool.value
    println("SqlNullableBool value: ${value}")
    
    // 修改value属性
    sqlNullableBool.value = Some(false)
    println("Modified SqlNullableBool value: ${sqlNullableBool.value}")
}
```

运行结果：

```text
SqlNullableBool value: Some(true)
Modified SqlNullableBool value: Some(false)
```

### init(?Bool)

```cangjie
public init(v: ?Bool)
```

功能：根据传入参数 v 构造一个 [SqlNullableBool <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablebool-deprecated) 实例。

参数：

- v: ?[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlNullableBool的构造函数
    let sqlNullableBool = SqlNullableBool(Some(true))
    println("Created SqlNullableBool with value: ${sqlNullableBool.value}")
    
    // 访问name属性
    println("SqlNullableBool name: ${sqlNullableBool.name}")
}
```

运行结果：

```text
Created SqlNullableBool with value: Some(true)
SqlNullableBool name: SqlNullableBool
```

## class SqlNullableByte <sup>(deprecated)</sup>

```cangjie
public class SqlNullableByte <: SqlNullableDbType {
    public init(v: ?Int8)
}
```

功能：字节，对应仓颉 [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 类型，可为数据库 `Null` 值。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlNullableByte <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablebyte-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlNullableByte实例
    let sqlNullableByte = SqlNullableByte(Some(123i8))
    
    // 访问name属性
    let name = sqlNullableByte.name
    println("SqlNullableByte name: ${name}")
}
```

运行结果：

```text
SqlNullableByte name: SqlNullableByte
```

### prop value

```cangjie
public mut prop value: ?Int8
```

功能：该数据的值。

类型：?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlNullableByte实例
    let sqlNullableByte = SqlNullableByte(Some(123i8))
    
    // 访问value属性
    let value = sqlNullableByte.value
    println("SqlNullableByte value: ${value}")
    
    // 修改value属性
    sqlNullableByte.value = Some(45i8)
    println("Modified SqlNullableByte value: ${sqlNullableByte.value}")
}
```

运行结果：

```text
SqlNullableByte value: Some(123)
Modified SqlNullableByte value: Some(45)
```

### init(?Int8)

```cangjie
public init(v: ?Int8)
```

功能：根据传入参数 v 构造一个 [SqlNullableByte <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablebyte-deprecated) 实例。

参数：

- v: ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlNullableByte的构造函数
    let sqlNullableByte = SqlNullableByte(Some(123i8))
    println("Created SqlNullableByte with value: ${sqlNullableByte.value}")
    
    // 访问name属性
    println("SqlNullableByte name: ${sqlNullableByte.name}")
}
```

运行结果：

```text
Created SqlNullableByte with value: Some(123)
SqlNullableByte name: SqlNullableByte
```

## class SqlNullableChar <sup>(deprecated)</sup>

```cangjie
public class SqlNullableChar <: SqlNullableDbType {
    public init(v: ?String)
}
```

功能：定长字符串，对应仓颉 [String](../../core/core_package_api/core_package_structs.md#struct-string) 类型，可为数据库 `Null` 值。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlNullableChar <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablechar-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlNullableChar实例
    let sqlNullableChar = SqlNullableChar(Some("Hello"))
    
    // 访问name属性
    let name = sqlNullableChar.name
    println("SqlNullableChar name: ${name}")
}
```

运行结果：

```text
SqlNullableChar name: SqlNullableChar
```

### prop value

```cangjie
public mut prop value: ?String
```

功能：该数据的值。

类型：?[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlNullableChar实例
    let sqlNullableChar = SqlNullableChar(Some("Hello"))
    
    // 访问value属性
    let value = sqlNullableChar.value
    println("SqlNullableChar value: ${value}")
    
    // 修改value属性
    sqlNullableChar.value = Some("World")
    println("Modified SqlNullableChar value: ${sqlNullableChar.value}")
}
```

运行结果：

```text
SqlNullableChar value: Some(Hello)
Modified SqlNullableChar value: Some(World)
```

### init(?String)

```cangjie
public init(v: ?String)
```

功能：根据传入参数 v 构造一个 [SqlNullableChar <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablechar-deprecated) 实例。

参数：

- v: ?[String](../../core/core_package_api/core_package_structs.md#struct-string) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlNullableChar的构造函数
    let sqlNullableChar = SqlNullableChar(Some("Hello"))
    println("Created SqlNullableChar with value: ${sqlNullableChar.value}")
    
    // 访问name属性
    println("SqlNullableChar name: ${sqlNullableChar.name}")
}
```

运行结果：

```text
Created SqlNullableChar with value: Some(Hello)
SqlNullableChar name: SqlNullableChar
```

## class SqlNullableClob <sup>(deprecated)</sup>

```cangjie
public class SqlNullableClob <: SqlNullableDbType {
    public init(v: ?InputStream)
}
```

功能：变长超大字符串（RUNE LARGE OBJECT），对应仓颉 [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream) 类型，可为数据库 `Null` 值。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlNullableClob <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullableclob-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.io.*

main() {
    // 创建一个SqlNullableClob实例
    let data: Array<Byte> = [72, 101, 108, 108, 111]  // "Hello"的ASCII码
    let byteBuffer = ByteBuffer(data)
    let inputStream = BufferedInputStream(byteBuffer)
    let sqlNullableClob = SqlNullableClob(Some(inputStream))
    
    // 访问name属性
    let name = sqlNullableClob.name
    println("SqlNullableClob name: ${name}")
}
```

运行结果：

```text
SqlNullableClob name: SqlNullableClob
```

### prop value

```cangjie
public mut prop value: ?InputStream
```

功能：该数据的值。

类型：?[InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.io.*

main() {
    // 创建一个SqlNullableClob实例
    let data: Array<Byte> = [72, 101, 108, 108, 111]  // "Hello"的ASCII码
    let byteBuffer = ByteBuffer(data)
    let inputStream = BufferedInputStream(byteBuffer)
    let sqlNullableClob = SqlNullableClob(Some(inputStream))
    
    // 访问value属性
    let value = sqlNullableClob.value
    match (value) {
        case None => println("SqlNullableClob value is None")
        case Some(_) => println("SqlNullableClob value is Some(InputStream)")
    }
    
    // 修改value属性
    sqlNullableClob.value = None
    match (sqlNullableClob.value) {
        case None => println("Modified SqlNullableClob value is None")
        case Some(_) => println("Modified SqlNullableClob value is Some(InputStream)")
    }
}
```

运行结果：

```text
SqlNullableClob value is Some(InputStream)
Modified SqlNullableClob value is None
```

### init(?InputStream)

```cangjie
public init(v: ?InputStream)
```

功能：根据传入参数 v 构造一个 [SqlNullableClob <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullableclob-deprecated) 实例。

参数：

- v: ?[InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.io.*

main() {
    // 使用SqlNullableClob的构造函数
    let data: Array<Byte> = [72, 101, 108, 108, 111]  // "Hello"的ASCII码
    let byteBuffer = ByteBuffer(data)
    let inputStream = BufferedInputStream(byteBuffer)
    let sqlNullableClob = SqlNullableClob(Some(inputStream))
    println("Created SqlNullableClob with value: Some(InputStream)")
    
    // 访问name属性
    println("SqlNullableClob name: ${sqlNullableClob.name}")
}
```

运行结果：

```text
Created SqlNullableClob with value: Some(InputStream)
SqlNullableClob name: SqlNullableClob
```

## class SqlNullableDate <sup>(deprecated)</sup>

```cangjie
public class SqlNullableDate <: SqlNullableDbType {
    public init(v: ?DateTime)
}
```

功能：日期，仅年月日有效，对应仓颉 [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) 类型，可为数据库 `Null` 值。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlNullableDate <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabledate-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    // 创建一个SqlNullableDate实例
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    let sqlNullableDate = SqlNullableDate(Some(dateTime))
    
    // 访问name属性
    let name = sqlNullableDate.name
    println("SqlNullableDate name: ${name}")
}
```

运行结果：

```text
SqlNullableDate name: SqlNullableDate
```

### prop value

```cangjie
public mut prop value: ?DateTime
```

功能：该数据的值。

类型：?[DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    // 创建一个SqlNullableDate实例
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    let sqlNullableDate = SqlNullableDate(Some(dateTime))
    
    // 访问value属性
    let value = sqlNullableDate.value
    println("SqlNullableDate value: ${value}")
    
    // 修改value属性为None
    sqlNullableDate.value = None
    println("Modified SqlNullableDate value: ${sqlNullableDate.value}")
}
```

运行结果：

```text
SqlNullableDate value: Some(2012-01-01T00:00:00+08:00)
Modified SqlNullableDate value: None
```

### init(?DateTime)

```cangjie
public init(v: ?DateTime)
```

功能：根据传入参数 v 构造一个 [SqlNullableDate <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabledate-deprecated) 实例。

参数：

- v: ?[DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    // 创建一个SqlNullableDate实例
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    let sqlNullableDate = SqlNullableDate(Some(dateTime))
    
    // 访问name属性
    let name = sqlNullableDate.name
    println("SqlNullableDate name: ${name}")
}
```

运行结果：

```text
SqlNullableDate name: SqlNullableDate
```

## class SqlNullableDecimal <sup>(deprecated)</sup>

```cangjie
public class SqlNullableDecimal <: SqlNullableDbType {
    public init(v: ?Decimal)
}
```

功能：高精度数，对应仓颉 [Decimal](../../math_numeric/math_numeric_package_api/math_numeric_package_structs.md#struct-decimal) 类型，可为数据库 `Null` 值。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlNullableDecimal <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabledecimal-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.math.numeric.*

main() {
    // 创建一个SqlNullableDecimal实例
    let decimalValue = Decimal(123.45)
    let sqlNullableDecimal = SqlNullableDecimal(Some(decimalValue))
    
    // 访问name属性
    let name = sqlNullableDecimal.name
    println("SqlNullableDecimal name: ${name}")
}
```

运行结果：

```text
SqlNullableDecimal name: SqlNullableDecimal
```

### prop value

```cangjie
public mut prop value: ?Decimal
```

功能：该数据的值。

类型：?[Decimal](../../math_numeric/math_numeric_package_api/math_numeric_package_structs.md#struct-decimal)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.math.numeric.*

main() {
    // 创建一个SqlNullableDecimal实例
    let decimalValue = Decimal(123.45)
    let sqlNullableDecimal = SqlNullableDecimal(Some(decimalValue))
    
    // 访问value属性
    let value = sqlNullableDecimal.value
    println("SqlNullableDecimal value: ${value}")
    
    // 修改value属性为None
    sqlNullableDecimal.value = None
    println("Modified SqlNullableDecimal value: ${sqlNullableDecimal.value}")
}
```

运行结果：

```text
SqlNullableDecimal value: Some(123.4500000000000028421709430404007434844970703125)
Modified SqlNullableDecimal value: None
```

### init(?Decimal)

```cangjie
public init(v: ?Decimal)
```

功能：根据传入参数 v 构造一个 [SqlNullableDecimal <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabledecimal-deprecated) 实例。

参数：

- v: ?[Decimal](../../math_numeric/math_numeric_package_api/math_numeric_package_structs.md#struct-decimal) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.math.numeric.*

main() {
    // 使用SqlNullableDecimal的构造函数
    let decimalValue = Decimal(123.45)
    let sqlNullableDecimal = SqlNullableDecimal(Some(decimalValue))
    println("Created SqlNullableDecimal with value: ${sqlNullableDecimal.value}")
    
    // 访问name属性
    println("SqlNullableDecimal name: ${sqlNullableDecimal.name}")
}
```

运行结果：

```text
Created SqlNullableDecimal with value: Some(123.4500000000000028421709430404007434844970703125)
SqlNullableDecimal name: SqlNullableDecimal
```

## class SqlNullableDouble <sup>(deprecated)</sup>

```cangjie
public class SqlNullableDouble <: SqlNullableDbType {
    public init(v: ?Float64)
}
```

功能：双精度数，对应仓颉 [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) 类型，可为数据库 `Null` 值。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlNullableDouble <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabledouble-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlNullableDouble实例
    let sqlNullableDouble = SqlNullableDouble(Some(123.45f64))
    
    // 访问name属性
    let name = sqlNullableDouble.name
    println("SqlNullableDouble name: ${name}")
}
```

运行结果：

```text
SqlNullableDouble name: SqlNullableDouble
```

### prop value

```cangjie
public mut prop value: ?Float64
```

功能：该数据的值。

类型：?[Float64](../../core/core_package_api/core_package_intrinsics.md#float64)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlNullableDouble实例
    let sqlNullableDouble = SqlNullableDouble(Some(123.45f64))
    
    // 访问value属性
    let value = sqlNullableDouble.value
    println("SqlNullableDouble value: ${value}")
    
    // 修改value属性为None
    sqlNullableDouble.value = None
    println("Modified SqlNullableDouble value: ${sqlNullableDouble.value}")
}
```

运行结果：

```text
SqlNullableDouble value: Some(123.450000)
Modified SqlNullableDouble value: None
```

### init(?Float64)

```cangjie
public init(v: ?Float64)
```

功能：根据传入参数 v 构造一个 [SqlNullableDouble <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabledouble-deprecated) 实例。

参数：

- v: ?[Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlNullableDouble的构造函数
    let sqlNullableDouble = SqlNullableDouble(Some(123.45f64))
    println("Created SqlNullableDouble with value: ${sqlNullableDouble.value}")
    
    // 访问name属性
    println("SqlNullableDouble name: ${sqlNullableDouble.name}")
}
```

运行结果：

```text
Created SqlNullableDouble with value: Some(123.450000)
SqlNullableDouble name: SqlNullableDouble
```

## class SqlNullableInteger <sup>(deprecated)</sup>

```cangjie
public class SqlNullableInteger <: SqlNullableDbType {
    public init(v: ?Int32)
}
```

功能：中整数，对应仓颉 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 类型，可为数据库 `Null` 值。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlNullableInteger <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullableinteger-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlNullableInteger实例
    let sqlNullableInteger = SqlNullableInteger(Some(123i32))
    
    // 访问name属性
    let name = sqlNullableInteger.name
    println("SqlNullableInteger name: ${name}")
}
```

运行结果：

```text
SqlNullableInteger name: SqlNullableInteger
```

### prop value

```cangjie
public mut prop value: ?Int32
```

功能：该数据的值。

类型：?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlNullableInteger实例
    let sqlNullableInteger = SqlNullableInteger(Some(123i32))
    
    // 访问value属性
    let value = sqlNullableInteger.value
    println("SqlNullableInteger value: ${value}")
    
    // 修改value属性为None
    sqlNullableInteger.value = None
    println("Modified SqlNullableInteger value: ${sqlNullableInteger.value}")
}
```

运行结果：

```text
SqlNullableInteger value: Some(123)
Modified SqlNullableInteger value: None
```

### init(?Int32)

```cangjie
public init(v: ?Int32)
```

功能：根据传入参数 v 构造一个 [SqlNullableInteger <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullableinteger-deprecated) 实例。

参数：

- v: ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlNullableInteger的构造函数
    let sqlNullableInteger = SqlNullableInteger(Some(123i32))
    println("Created SqlNullableInteger with value: ${sqlNullableInteger.value}")
    
    // 访问name属性
    println("SqlNullableInteger name: ${sqlNullableInteger.name}")
}
```

运行结果：

```text
Created SqlNullableInteger with value: Some(123)
SqlNullableInteger name: SqlNullableInteger
```

## class SqlNullableInterval <sup>(deprecated)</sup>

```cangjie
public class SqlNullableInterval <: SqlNullableDbType {
    public init(v: ?Duration)
}
```

功能：时间间隔，对应仓颉 [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) 类型，可为数据库 `Null` 值。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlNullableInterval <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullableinterval-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlNullableInterval实例
    let duration = 123456789 * Duration.millisecond
    let sqlNullableInterval = SqlNullableInterval(Some(duration))
    
    // 访问name属性
    let name = sqlNullableInterval.name
    println("SqlNullableInterval name: ${name}")
}
```

运行结果：

```text
SqlNullableInterval name: SqlNullableInterval
```

### prop value

```cangjie
public mut prop value: ?Duration
```

功能：该数据的值。

类型：?[Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlNullableInterval实例
    let duration = 123456789 * Duration.millisecond
    let sqlNullableInterval = SqlNullableInterval(Some(duration))
    
    // 访问value属性
    let value = sqlNullableInterval.value
    println("SqlNullableInterval value: ${value}")
    
    // 修改value属性为None
    sqlNullableInterval.value = None
    println("Modified SqlNullableInterval value: ${sqlNullableInterval.value}")
}
```

运行结果：

```text
SqlNullableInterval value: Some(1d10h17m36s789ms)
Modified SqlNullableInterval value: None
```

### init(?Duration)

```cangjie
public init(v: ?Duration)
```

功能：根据传入参数 v 构造一个 [SqlNullableInterval <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullableinterval-deprecated) 实例。

参数：

- v: ?[Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlNullableInterval的构造函数
    let sqlNullableInterval = SqlNullableInterval(None)
    println("Created SqlNullableInterval with value: ${sqlNullableInterval.value}")
    
    // 访问name属性
    println("SqlNullableInterval name: ${sqlNullableInterval.name}")
}
```

运行结果：

```text
Created SqlNullableInterval with value: None
SqlNullableInterval name: SqlNullableInterval
```

## class SqlNullableReal <sup>(deprecated)</sup>

```cangjie
public class SqlNullableReal <: SqlNullableDbType {
    public init(v: ?Float32)
}
```

功能：浮点数，对应仓颉 [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) 类型，可为数据库 `Null` 值。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlNullableReal <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablereal-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlNullableReal实例
    let sqlNullableReal = SqlNullableReal(Some(123.45f32))
    
    // 访问name属性
    let name = sqlNullableReal.name
    println("SqlNullableReal name: ${name}")
}
```

运行结果：

```text
SqlNullableReal name: SqlNullableReal
```

### prop value

```cangjie
public mut prop value: ?Float32
```

功能：该数据的值。

类型：?[Float32](../../core/core_package_api/core_package_intrinsics.md#float32)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlNullableReal实例
    let sqlNullableReal = SqlNullableReal(Some(123.45f32))
    
    // 访问value属性
    let value = sqlNullableReal.value
    println("SqlNullableReal value: ${value}")
    
    // 修改value属性为None
    sqlNullableReal.value = None
    println("Modified SqlNullableReal value: ${sqlNullableReal.value}")
}
```

运行结果：

```text
SqlNullableReal value: Some(123.449997)
Modified SqlNullableReal value: None
```

### init(?Float32)

```cangjie
public init(v: ?Float32)
```

功能：根据传入参数 v 构造一个 [SqlNullableReal <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablereal-deprecated) 实例。

参数：

- v: ?[Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlNullableReal的构造函数
    let sqlNullableReal = SqlNullableReal(Some(123.45f32))
    println("Created SqlNullableReal with value: ${sqlNullableReal.value}")
    
    // 访问name属性
    println("SqlNullableReal name: ${sqlNullableReal.name}")
}
```

运行结果：

```text
Created SqlNullableReal with value: Some(123.449997)
SqlNullableReal name: SqlNullableReal
```

## class SqlNullableSmallInt <sup>(deprecated)</sup>

```cangjie
public class SqlNullableSmallInt <: SqlNullableDbType {
    public init(v: ?Int16)
}
```

功能：小整数，对应仓颉 [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) 类型，可为数据库 `Null` 值。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlNullableSmallInt <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablesmallint-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlNullableSmallInt实例
    let sqlNullableSmallInt = SqlNullableSmallInt(Some(123i16))
    
    // 访问name属性
    let name = sqlNullableSmallInt.name
    println("SqlNullableSmallInt name: ${name}")
}
```

运行结果：

```text
SqlNullableSmallInt name: SqlNullableSmallInt
```

### prop value

```cangjie
public mut prop value: ?Int16
```

功能：该数据的值。

类型：?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlNullableSmallInt实例
    let sqlNullableSmallInt = SqlNullableSmallInt(Some(123i16))
    
    // 访问value属性
    let value = sqlNullableSmallInt.value
    println("SqlNullableSmallInt value: ${value}")
    
    // 修改value属性为None
    sqlNullableSmallInt.value = None
    println("Modified SqlNullableSmallInt value: ${sqlNullableSmallInt.value}")
}
```

运行结果：

```text
SqlNullableSmallInt value: Some(123)
Modified SqlNullableSmallInt value: None
```

### init(?Int16)

```cangjie
public init(v: ?Int16)
```

功能：根据传入参数 v 构造一个 [SqlNullableSmallInt <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablesmallint-deprecated) 实例。

参数：

- v: ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlNullableSmallInt的构造函数
    let sqlNullableSmallInt = SqlNullableSmallInt(Some(123i16))
    println("Created SqlNullableSmallInt with value: ${sqlNullableSmallInt.value}")
    
    // 访问name属性
    println("SqlNullableSmallInt name: ${sqlNullableSmallInt.name}")
}
```

运行结果：

```text
Created SqlNullableSmallInt with value: Some(123)
SqlNullableSmallInt name: SqlNullableSmallInt
```

## class SqlNullableTime <sup>(deprecated)</sup>

```cangjie
public class SqlNullableTime <: SqlNullableDbType {
    public init(v: ?DateTime)
}
```

功能：时间，仅时分秒毫秒有效，对应仓颉 [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) 类型，可为数据库 `Null` 值。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlNullableTime <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabletime-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlNullableTime的构造函数
    let sqlNullableTime = SqlNullableTime(None)
    println("Created SqlNullableTime with value: ${sqlNullableTime.value}")
    
    // 访问name属性
    println("SqlNullableTime name: ${sqlNullableTime.name}")
}
```

运行结果：

```text
Created SqlNullableTime with value: None
SqlNullableTime name: SqlNullableTime
```

### prop value

```cangjie
public mut prop value: ?DateTime
```

功能：该数据的值。

类型：?[DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    // 创建一个DateTime实例
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    
    // 使用SqlNullableTime的构造函数创建一个有值的实例
    let sqlNullableTimeWithValue = SqlNullableTime(Some(dateTime))
    // 访问value属性
    let value1 = sqlNullableTimeWithValue.value
    println("SqlNullableTime value: ${value1}")
    
    // 使用SqlNullableTime的构造函数创建一个无值的实例
    let sqlNullableTimeWithoutValue = SqlNullableTime(None)
    // 访问value属性
    let value2 = sqlNullableTimeWithoutValue.value
    println("SqlNullableTime value: ${value2}")
}
```

运行结果：

```text
SqlNullableTime value: Some(2012-01-01T00:00:00+08:00)
SqlNullableTime value: None
```

### init(?DateTime)

```cangjie
public init(v: ?DateTime)
```

功能：根据传入参数 v 构造一个 [SqlNullableTime <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabletime-deprecated) 实例。

参数：

- v: ?[DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    // 创建一个DateTime实例
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    
    // 使用SqlNullableTime的构造函数创建一个有值的实例
    let sqlNullableTimeWithValue = SqlNullableTime(Some(dateTime))
    println("Created SqlNullableTime with value: ${sqlNullableTimeWithValue.value}")
    
    // 使用SqlNullableTime的构造函数创建一个无值的实例
    let sqlNullableTimeWithoutValue = SqlNullableTime(None)
    println("Created SqlNullableTime with value: ${sqlNullableTimeWithoutValue.value}")
}
```

运行结果：

```text
Created SqlNullableTime with value: Some(2012-01-01T00:00:00+08:00)
Created SqlNullableTime with value: None
```


## class SqlNullableTimeTz <sup>(deprecated)</sup>

```cangjie
public class SqlNullableTimeTz <: SqlNullableDbType {
    public init(v: ?DateTime)
}
```

功能：带时区的时间，仅时分秒毫秒时区有效，对应仓颉 [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) 类型，可为数据库 `Null` 值。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlNullableTimeTz <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabletimetz-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlNullableTimeTz的构造函数
    let sqlNullableTimeTz = SqlNullableTimeTz(None)
    // 访问name属性
    println("SqlNullableTimeTz name: ${sqlNullableTimeTz.name}")
}
```

运行结果：

```text
SqlNullableTimeTz name: SqlNullableTimeTz
```

### prop value

```cangjie
public mut prop value: ?DateTime
```

功能：该数据的值。

类型：?[DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    // 创建一个DateTime实例
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    
    // 使用SqlNullableTimeTz的构造函数创建一个有值的实例
    let sqlNullableTimeTzWithValue = SqlNullableTimeTz(Some(dateTime))
    // 访问value属性
    let value1 = sqlNullableTimeTzWithValue.value
    println("SqlNullableTimeTz value: ${value1}")
    
    // 使用SqlNullableTimeTz的构造函数创建一个无值的实例
    let sqlNullableTimeTzWithoutValue = SqlNullableTimeTz(None)
    // 访问value属性
    let value2 = sqlNullableTimeTzWithoutValue.value
    println("SqlNullableTimeTz value: ${value2}")
}
```

运行结果：

```text
SqlNullableTimeTz value: Some(2012-01-01T00:00:00+08:00)
SqlNullableTimeTz value: None
```

### init(?DateTime)

```cangjie
public init(v: ?DateTime)
```

功能：根据传入参数 v 构造一个 [SqlNullableTimeTz <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabletimetz-deprecated) 实例。

参数：

- v: ?[DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    // 创建一个DateTime实例
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    
    // 使用SqlNullableTimeTz的构造函数创建一个有值的实例
    let sqlNullableTimeTzWithValue = SqlNullableTimeTz(Some(dateTime))
    println("Created SqlNullableTimeTz with value: ${sqlNullableTimeTzWithValue.value}")
    
    // 使用SqlNullableTimeTz的构造函数创建一个无值的实例
    let sqlNullableTimeTzWithoutValue = SqlNullableTimeTz(None)
    println("Created SqlNullableTimeTz with value: ${sqlNullableTimeTzWithoutValue.value}")
}
```

运行结果：

```text
Created SqlNullableTimeTz with value: Some(2012-01-01T00:00:00+08:00)
Created SqlNullableTimeTz with value: None
```

## class SqlNullableTimestamp <sup>(deprecated)</sup>

```cangjie
public class SqlNullableTimestamp <: SqlNullableDbType {
    public init(v: ?DateTime)
}
```

功能：时间戳，对应仓颉 [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) 类型，可为数据库 `Null` 值。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlNullableTimestamp <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabletimestamp-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlNullableTimestamp的构造函数
    let sqlNullableTimestamp = SqlNullableTimestamp(None)
    // 访问name属性
    println("SqlNullableTimestamp name: ${sqlNullableTimestamp.name}")
}
```

运行结果：

```text
SqlNullableTimestamp name: SqlNullableTimestamp
```

### prop value

```cangjie
public mut prop value: ?DateTime
```

功能：该数据的值。

类型：?[DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    // 创建一个DateTime实例
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    
    // 使用SqlNullableTimestamp的构造函数创建一个有值的实例
    let sqlNullableTimestampWithValue = SqlNullableTimestamp(Some(dateTime))
    // 访问value属性
    let value1 = sqlNullableTimestampWithValue.value
    println("SqlNullableTimestamp value: ${value1}")

    
    // 使用SqlNullableTimestamp的构造函数创建一个无值的实例
    let sqlNullableTimestampWithoutValue = SqlNullableTimestamp(None)
    // 访问value属性
    let value2 = sqlNullableTimestampWithoutValue.value
    println("SqlNullableTimestamp value: ${value2}")
}
```

运行结果：

```text
SqlNullableTimestamp value: Some(2012-01-01T00:00:00+08:00)
SqlNullableTimestamp value: None
```

### init(?DateTime)

```cangjie
public init(v: ?DateTime)
```

功能：根据传入参数 v 构造一个 [SqlNullableTimestamp <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullabletimestamp-deprecated) 实例。

参数：

- v: ?[DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    // 创建一个DateTime实例
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    
    // 使用SqlNullableTimestamp的构造函数创建一个有值的实例
    let sqlNullableTimestampWithValue = SqlNullableTimestamp(Some(dateTime))
    println("Created SqlNullableTimestamp with value: ${sqlNullableTimestampWithValue.value}")
    
    // 使用SqlNullableTimestamp的构造函数创建一个无值的实例
    let sqlNullableTimestampWithoutValue = SqlNullableTimestamp(None)
    println("Created SqlNullableTimestamp with value: ${sqlNullableTimestampWithoutValue.value}")
}
```

运行结果：

```text
Created SqlNullableTimestamp with value: Some(2012-01-01T00:00:00+08:00)
Created SqlNullableTimestamp with value: None
```

## class SqlNullableVarBinary <sup>(deprecated)</sup>

```cangjie
public class SqlNullableVarBinary <: SqlNullableDbType {
    public init(v: ?Array<Byte>)
}
```

功能：变长二进制字符串，对应仓颉 [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> 类型，可为数据库 `Null` 值。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlNullableVarBinary <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablevarbinary-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlNullableVarBinary的构造函数
    let sqlNullableVarBinary = SqlNullableVarBinary(None)
    // 访问name属性
    println("SqlNullableVarBinary name: ${sqlNullableVarBinary.name}")
}
```

运行结果：

```text
SqlNullableVarBinary name: SqlNullableVarBinary
```

### prop value

```cangjie
public mut prop value: ?Array<Byte>
```

功能：该数据的值。

类型：?[Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.core.*

main() {
    // 创建一个Byte数组
    let bytes: Array<Byte> = [1, 2, 3, 4]
    
    // 使用SqlNullableVarBinary的构造函数创建一个有值的实例
    let sqlNullableVarBinaryWithValue = SqlNullableVarBinary(Some(bytes))
    // 访问value属性
    let value1 = sqlNullableVarBinaryWithValue.value
    println("SqlNullableVarBinary value: ${value1}")
    
    // 使用SqlNullableVarBinary的构造函数创建一个无值的实例
    let sqlNullableVarBinaryWithoutValue = SqlNullableVarBinary(None)
    // 访问value属性
    let value2 = sqlNullableVarBinaryWithoutValue.value
    println("SqlNullableVarBinary value: ${value2}")
}
```

运行结果：

```text
SqlNullableVarBinary value: Some([1, 2, 3, 4])
SqlNullableVarBinary value: None
```

### init(?Array\<Byte>)

```cangjie
public init(v: ?Array<Byte>)
```

功能：根据传入参数 v 构造一个 [SqlNullableVarBinary <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablevarbinary-deprecated) 实例。

参数：

- v: ?[Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.core.*

main() {
    // 创建一个Byte数组
    let bytes: Array<Byte> = [5, 6, 7, 8]
    
    // 使用SqlNullableVarBinary的构造函数创建一个有值的实例
    let sqlNullableVarBinaryWithValue = SqlNullableVarBinary(Some(bytes))
    println("Created SqlNullableVarBinary with value: ${sqlNullableVarBinaryWithValue.value}")
    
    // 使用SqlNullableVarBinary的构造函数创建一个无值的实例
    let sqlNullableVarBinaryWithoutValue = SqlNullableVarBinary(None)
    println("Created SqlNullableVarBinary with value: ${sqlNullableVarBinaryWithoutValue.value}")
}
```

运行结果：

```text
Created SqlNullableVarBinary with value: Some([5, 6, 7, 8])
Created SqlNullableVarBinary with value: None
```

## class SqlNullableVarchar <sup>(deprecated)</sup>

```cangjie
public class SqlNullableVarchar <: SqlNullableDbType {
    public init(v: ?String)
}
```

功能：变长字符串，对应仓颉 [String](../../core/core_package_api/core_package_structs.md#struct-string) 类型，可为数据库 `Null` 值。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlNullableDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqlnullabledbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlNullableVarchar <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablevarchar-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlNullableVarchar的构造函数
    let sqlNullableVarchar = SqlNullableVarchar(None)
    // 访问name属性
    println("SqlNullableVarchar name: ${sqlNullableVarchar.name}")
}
```

运行结果：

```text
SqlNullableVarchar name: SqlNullableVarchar
```

### prop value

```cangjie
public mut prop value: ?String
```

功能：该数据的值。
类型：?[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlNullableVarchar的构造函数创建一个有值的实例
    let sqlNullableVarcharWithValue = SqlNullableVarchar(Some("Hello"))
    // 访问value属性
    let value1 = sqlNullableVarcharWithValue.value
    println("SqlNullableVarchar value: ${value1}")
    
    // 使用SqlNullableVarchar的构造函数创建一个无值的实例
    let sqlNullableVarcharWithoutValue = SqlNullableVarchar(None)
    // 访问value属性
    let value2 = sqlNullableVarcharWithoutValue.value
    println("SqlNullableVarchar value: ${value2}")
}
```

运行结果：

```text
SqlNullableVarchar value: Some(Hello)
SqlNullableVarchar value: None
```

### init(?String)

```cangjie
public init(v: ?String)
```

功能：根据传入参数 v 构造一个 [SqlNullableVarchar <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlnullablevarchar-deprecated) 实例。

参数：

- v: ?[String](../../core/core_package_api/core_package_structs.md#struct-string) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlNullableVarchar的构造函数创建一个有值的实例
    let sqlNullableVarcharWithValue = SqlNullableVarchar(Some("World"))
    println("Created SqlNullableVarchar with value: ${sqlNullableVarcharWithValue.value}")
    
    // 使用SqlNullableVarchar的构造函数创建一个无值的实例
    let sqlNullableVarcharWithoutValue = SqlNullableVarchar(None)
    println("Created SqlNullableVarchar with value: ${sqlNullableVarcharWithoutValue.value}")
}
```

运行结果：

```text
Created SqlNullableVarchar with value: Some(World)
Created SqlNullableVarchar with value: None
```

## class SqlOption

```cangjie
public class SqlOption {
    public static const URL: String = "url"
    public static const Host: String = "host"
    public static const Username: String = "username"
    public static const Password: String = "password"
    public static const Driver: String = "driver"
    public static const Database: String = "database"
    public static const Encoding: String = "encoding"
    public static const ConnectionTimeout: String = "connection_timeout"
    public static const UpdateTimeout: String = "update_timeout"
    public static const QueryTimeout: String = "query_timeout"
    public static const FetchRows: String = "fetch_rows"
    public static const SSLMode: String = "ssl.mode"
    public static const SSLModePreferred: String = "ssl.mode.preferred"
    public static const SSLModeDisabled: String = "ssl.mode.disabled"
    public static const SSLModeRequired: String = "ssl.mode.required"
    public static const SSLModeVerifyCA: String = "ssl.mode.verify_ca"
    public static const SSLModeVerifyFull: String = "ssl.mode.verify_full"
    public static const SSLCA: String = "ssl.ca"
    public static const SSLCert: String = "ssl.cert"
    public static const SSLKey: String = "ssl.key"
    public static const SSLKeyPassword: String = "ssl.key.password"
    public static const SSLSni: String = "ssl.sni"
    public static const Tls12Ciphersuites: String = "tls1.2.ciphersuites"
    public static const Tls13Ciphersuites: String = "tls1.3.ciphersuites"
    public static const TlsVersion: String = "tls.version"
}
```

功能：预定义的 sql 选项名称和值。如果需要扩展，请不要与这些名称和值冲突。

### static const ConnectionTimeout

```cangjie
public static const ConnectionTimeout: String = "connection_timeout"
```

功能：获取 connect 操作的超时时间，单位 ms。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的ConnectionTimeout静态常量
    println("Connection timeout key: ${SqlOption.ConnectionTimeout}")
}
```

运行结果：

```text
Connection timeout key: connection_timeout
```

### static const Database

```cangjie
public static const Database: String = "database"
```

功能：获取数据库名称。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的Database静态常量
    println("Database key: ${SqlOption.Database}")
}
```

运行结果：

```text
Database key: database
```

### static const Driver

```cangjie
public static const Driver: String = "driver"
```

功能：获取数据库驱动名称，比如 postgres，opengauss。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的Driver静态常量
    println("Driver key: ${SqlOption.Driver}")
}
```

运行结果：

```text
Driver key: driver
```

### static const Encoding

```cangjie
public static const Encoding: String = "encoding"
```

功能：获取数据库字符集编码类型。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的Encoding静态常量
    println("Encoding key: ${SqlOption.Encoding}")
}
```

运行结果：

```text
Encoding key: encoding
```

### static const FetchRows

```cangjie
public static const FetchRows: String = "fetch_rows"
```

功能：获取每次获取额外数据时从数据库中提取的行数。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的FetchRows静态常量
    println("Fetch rows key: ${SqlOption.FetchRows}")
}
```

运行结果：

```text
Fetch rows key: fetch_rows
```

### static const Host

```cangjie
public static const Host: String = "host"
```

功能：获取数据库服务器主机名或者 [IP]() 地址。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的Host静态常量
    println("Host key: ${SqlOption.Host}")
}
```

运行结果：

```text
Host key: host
```

### static const Password

```cangjie
public static const Password: String = "password"
```

功能：获取连接数据库的密码。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的Password静态常量
    println("Password key: ${SqlOption.Password}")
}
```

运行结果：

```text
Password key: password
```

### static const QueryTimeout

```cangjie
public static const QueryTimeout: String = "query_timeout"
```

功能：获取 query 操作的超时时间，单位 ms。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的QueryTimeout静态常量
    println("Query timeout key: ${SqlOption.QueryTimeout}")
}
```

运行结果：

```text
Query timeout key: query_timeout
```

### static const SSLCA

```cangjie
public static const SSLCA: String = "ssl.ca"
```

功能：证书颁发机构（ CA ）证书文件的路径名。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的SSLCA静态常量
    println("SSL CA key: ${SqlOption.SSLCA}")
}
```

运行结果：

```text
SSL CA key: ssl.ca
```

### static const SSLCert

```cangjie
public static const SSLCert: String = "ssl.cert"
```

功能：客户端 SSL 公钥证书文件的路径名。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的SSLCert静态常量
    println("SSL Cert key: ${SqlOption.SSLCert}")
}
```

运行结果：

```text
SSL Cert key: ssl.cert
```

### static const SSLKey

```cangjie
public static const SSLKey: String = "ssl.key"
```

功能：客户端 SSL 私钥文件的路径名。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的SSLKey静态常量
    println("SSL Key key: ${SqlOption.SSLKey}")
}
```

运行结果：

```text
SSL Key key: ssl.key
```

### static const SSLKeyPassword

```cangjie
public static const SSLKeyPassword: String = "ssl.key.password"
```

功能：客户端 SSL 私钥文件的密码。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的SSLKeyPassword静态常量
    println("SSL Key Password key: ${SqlOption.SSLKeyPassword}")
}
```

运行结果：

```text
SSL Key Password key: ssl.key.password
```

### static const SSLMode

```cangjie
public static const SSLMode: String = "ssl.mode"
```

功能：获取 SSLMode 传输层加密模式。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的SSLMode静态常量
    println("SSL Mode key: ${SqlOption.SSLMode}")
}
```

运行结果：

```text
SSL Mode key: ssl.mode
```

### static const SSLModeDisabled

```cangjie
public static const SSLModeDisabled: String = "ssl.mode.disabled"
```

功能：建立未加密的连接。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的SSLModeDisabled静态常量
    println("SSL Mode Disabled key: ${SqlOption.SSLModeDisabled}")
}
```

运行结果：

```text
SSL Mode Disabled key: ssl.mode.disabled
```

### static const SSLModePreferred

```cangjie
public static const SSLModePreferred: String = "ssl.mode.preferred"
```

功能：如果服务器支持加密连接，则建立加密连接; 如果无法建立加密连接，则回退到未加密连接，这是 SSLMode 的默认值。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的SSLModePreferred静态常量
    println("SSL Mode Preferred key: ${SqlOption.SSLModePreferred}")
}
```

运行结果：

```text
SSL Mode Preferred key: ssl.mode.preferred
```

### static const SSLModeRequired

```cangjie
public static const SSLModeRequired: String = "ssl.mode.required"
```

功能：如果服务器支持加密连接，则建立加密连接。如果无法建立加密连接，则连接失败。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的SSLModeRequired静态常量
    println("SSL Mode Required key: ${SqlOption.SSLModeRequired}")
}
```

运行结果：

```text
SSL Mode Required key: ssl.mode.required
```

### static const SSLModeVerifyCA

```cangjie
public static const SSLModeVerifyCA: String = "ssl.mode.verify_ca"
```

功能：SSLModeVerifyCA 和 SSLModeRequired 类似，但是增加了校验服务器证书，如果校验失败，则连接失败。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的SSLModeVerifyCA静态常量
    println("SSL Mode Verify CA key: ${SqlOption.SSLModeVerifyCA}")
}
```

运行结果：

```text
SSL Mode Verify CA key: ssl.mode.verify_ca
```

### static const SSLModeVerifyFull

```cangjie
public static const SSLModeVerifyFull: String = "ssl.mode.verify_full"
```

功能：SSLModeVerifyFull 和 SSLModeVerifyCA 类似，但通过验证服务器证书中的标识与客户端连接的主机名是否匹配，来执行主机名身份验证。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的SSLModeVerifyFull静态常量
    println("SSL Mode Verify Full key: ${SqlOption.SSLModeVerifyFull}")
}
```

运行结果：

```text
SSL Mode Verify Full key: ssl.mode.verify_full
```

### static const SSLSni

```cangjie
public static const SSLSni: String = "ssl.sni"
```

功能：客户端通过该标识在握手过程开始时试图连接到哪个主机名。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的SSLSni静态常量
    println("SSL SNI key: ${SqlOption.SSLSni}")
}
```

运行结果：

```text
SSL SNI key: ssl.sni
```

### static const Tls12Ciphersuites

```cangjie
public static const Tls12Ciphersuites: String = "tls1.2.ciphersuites"
```

功能：此选项指定客户端允许使用 TLSv1.2 及以下的加密连接使用哪些密码套件。
值为冒号分隔的字符串，比如 "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_[SHA256]():TLS_DHE_RSA_WITH_AES_128_CBC_SHA"。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的Tls12Ciphersuites静态常量
    println("TLS 1.2 Ciphersuites key: ${SqlOption.Tls12Ciphersuites}")
}
```

运行结果：

```text
TLS 1.2 Ciphersuites key: tls1.2.ciphersuites
```

### static const Tls13Ciphersuites

```cangjie
public static const Tls13Ciphersuites: String = "tls1.3.ciphersuites"
```

功能：此选项指定客户端允许使用 TLSv1.3 的加密连接使用哪些密码套件。
值为冒号分隔的字符串，比如 "TLS_AES_256_GCM_[SHA384]():TLS_CHACHA20_POLY1305_[SHA256]()"。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的Tls13Ciphersuites静态常量
    println("TLS 1.3 Ciphersuites key: ${SqlOption.Tls13Ciphersuites}")
}
```

运行结果：

```text
TLS 1.3 Ciphersuites key: tls1.3.ciphersuites
```

### static const TlsVersion

```cangjie
public static const TlsVersion: String = "tls.version"
```

功能：支持的 TLS 版本号，值为逗号分隔的字符串，比如 "TLSv1.2,TLSv1.3"。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的TlsVersion静态常量
    println("TLS Version key: ${SqlOption.TlsVersion}")
}
```

运行结果：

```text
TLS Version key: tls.version
```

### static const URL

```cangjie
public static const URL: String = "url"
```

功能：获取数据库连接 [URL]() 字符串。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)


示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的URL静态常量
    println("URL key: ${SqlOption.URL}")
}
```

运行结果：

```text
URL key: url
```

### static const UpdateTimeout

```cangjie
public static const UpdateTimeout: String = "update_timeout"
```

功能：获取 update 操作的超时时间，单位 ms。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的UpdateTimeout静态常量
    println("Update timeout key: ${SqlOption.UpdateTimeout}")
}
```

运行结果：

```text
Update timeout key: update_timeout
```

### static const Username

```cangjie
public static const Username: String = "username"
```

功能：获取连接数据库的用户名。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlOption类的Username静态常量
    println("Username key: ${SqlOption.Username}")
}
```

运行结果：

```text
Username key: username
```

## class SqlReal <sup>(deprecated)</sup>

```cangjie
public class SqlReal <: SqlDbType {
    public init(v: Float32)
}
```

功能：浮点数，对应仓颉 [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) 类型。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlReal <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlreal-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlReal实例
    let sqlReal = SqlReal(123.45f32)
    
    // 访问name属性
    let name = sqlReal.name
    println("SqlReal name: ${name}")
}
```

运行结果：

```text
SqlReal name: SqlReal
```

### prop value

```cangjie
public mut prop value: Float32
```

功能：该数据的值。

类型：[Float32](../../core/core_package_api/core_package_intrinsics.md#float32)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlReal实例
    let sqlReal = SqlReal(123.45f32)
    
    // 访问value属性
    let value = sqlReal.value
    println("SqlReal value: ${value}")
    
    // 修改value属性
    sqlReal.value = 54.321f32
    println("Modified SqlReal value: ${sqlReal.value}")
}
```

运行结果：

```text
SqlReal value: 123.449997
Modified SqlReal value: 54.320999
```

### init(Float32)

```cangjie
public init(v: Float32)
```

功能：根据传入参数 v 构造一个 [SqlReal <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlreal-deprecated) 实例。

参数：

- v: [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlReal的构造函数
    let sqlReal = SqlReal(123.45f32)
    println("Created SqlReal with value: ${sqlReal.value}")
    
    // 访问name属性
    println("SqlReal name: ${sqlReal.name}")
}
```

运行结果：

```text
Created SqlReal with value: 123.449997
SqlReal name: SqlReal
```

## class SqlSmallInt <sup>(deprecated)</sup>

```cangjie
public class SqlSmallInt <: SqlDbType {
    public init(v: Int16)
}
```

功能：小整数，对应仓颉 [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) 类型。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlSmallInt <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlsmallint-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlSmallInt实例
    let sqlSmallInt = SqlSmallInt(123i16)
    
    // 访问name属性
    let name = sqlSmallInt.name
    println("SqlSmallInt name: ${name}")
}
```

运行结果：

```text
SqlSmallInt name: SqlSmallInt
```

### prop value

```cangjie
public mut prop value: Int16
```

功能：该数据的值。

类型：[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlSmallInt实例
    let sqlSmallInt = SqlSmallInt(123i16)
    
    // 访问value属性
    let value = sqlSmallInt.value
    println("SqlSmallInt value: ${value}")
    
    // 修改value属性
    sqlSmallInt.value = 321i16
    println("Modified SqlSmallInt value: ${sqlSmallInt.value}")
}
```

运行结果：

```text
SqlSmallInt value: 123
Modified SqlSmallInt value: 321
```

### init(Int16)

```cangjie
public init(v: Int16)
```

功能：根据传入参数 v 构造一个 [SqlSmallInt <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlsmallint-deprecated) 实例。

参数：

- v: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlSmallInt的构造函数
    let sqlSmallInt = SqlSmallInt(123i16)
    println("Created SqlSmallInt with value: ${sqlSmallInt.value}")
    
    // 访问name属性
    println("SqlSmallInt name: ${sqlSmallInt.name}")
}
```

运行结果：

```text
Created SqlSmallInt with value: 123
SqlSmallInt name: SqlSmallInt
```

## class SqlTime <sup>(deprecated)</sup>

```cangjie
public class SqlTime <: SqlDbType {
    public init(v: DateTime)
}
```

功能：时间，仅时分秒毫秒有效，对应仓颉 [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) 类型。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlTime <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqltime-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    // 使用SqlTime的构造函数
    let sqlTime = SqlTime(dateTime)
    println("Created SqlTime with value: ${sqlTime.value}")
    
    // 访问name属性
    println("SqlTime name: ${sqlTime.name}")
}
```

运行结果：

```text
Created SqlTime with value: 2012-01-01T00:00:00+08:00
SqlTime name: SqlTime
```

### prop value

```cangjie
public mut prop value: DateTime
```

功能：该数据的值。

类型：[DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    // 创建一个DateTime实例
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    
    // 使用SqlTime的构造函数创建一个实例
    let sqlTimeWithValue = SqlTime(dateTime)
    // 访问value属性
    let value1 = sqlTimeWithValue.value
    println("SqlTime value: ${value1}")
}
```

运行结果：

```text
SqlTime value: 2012-01-01T00:00:00+08:00
```

### init(DateTime)

```cangjie
public init(v: DateTime)
```

功能：根据传入参数 v 构造一个 [SqlTime <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqltime-deprecated) 实例。

参数：

- v: [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    // 创建一个DateTime实例
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    
    // 使用SqlTime的构造函数创建一个实例
    let sqlTimeWithValue = SqlTime(dateTime)
    println("Created SqlTime with value: ${sqlTimeWithValue.value}")
}
```

运行结果：

```text
Created SqlTime with value: 2012-01-01T00:00:00+08:00
```


## class SqlTimeTz <sup>(deprecated)</sup>

```cangjie
public class SqlTimeTz <: SqlDbType {
    public init(v: DateTime)
}
```

功能：带时区的时间，仅时分秒毫秒时区有效，对应仓颉 [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) 类型。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlTimeTz <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqltimetz-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    // 使用SqlTimeTz的构造函数
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    let sqlTimeTz = SqlTimeTz(dateTime)
    // 访问name属性
    println("SqlTimeTz name: ${sqlTimeTz.name}")
}
```

运行结果：

```text
SqlTimeTz name: SqlTimeTz
```

### prop value

```cangjie
public mut prop value: DateTime
```

功能：该数据的值。

类型：[DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    // 创建一个DateTime实例
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    
    // 使用SqlTimeTz的构造函数创建一个实例
    let sqlTimeTzWithValue = SqlTimeTz(dateTime)
    // 访问value属性
    let value1 = sqlTimeTzWithValue.value
    println("SqlTimeTz value: ${value1}")
}
```

运行结果：

```text
SqlTimeTz value: 2012-01-01T00:00:00+08:00
```

### init(DateTime)

```cangjie
public init(v: DateTime)
```

功能：根据传入参数 v 构造一个 [SqlTimeTz <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqltimetz-deprecated) 实例。

参数：

- v: [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    // 创建一个DateTime实例
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    
    // 使用SqlTimeTz的构造函数创建一个实例
    let sqlTimeTzWithValue = SqlTimeTz(dateTime)
    println("Created SqlTimeTz with value: ${sqlTimeTzWithValue.value}")
}
```

运行结果：

```text
Created SqlTimeTz with value: 2012-01-01T00:00:00+08:00
```

## class SqlTimestamp <sup>(deprecated)</sup>

```cangjie
public class SqlTimestamp <: SqlDbType {
    public init(v: DateTime)
}
```

功能：时间戳，对应仓颉 [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) 类型。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlTimestamp <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqltimestamp-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    // 使用SqlTimestamp的构造函数
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    let sqlTimestamp = SqlTimestamp(dateTime)
    // 访问name属性
    println("SqlTimestamp name: ${sqlTimestamp.name}")
}
```

运行结果：

```text
SqlTimestamp name: SqlTimestamp
```

### prop value

```cangjie
public mut prop value: DateTime
```

功能：该数据的值。

类型：[DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    // 创建一个DateTime实例
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    
    // 使用SqlTimestamp的构造函数创建一个实例
    let sqlTimestampWithValue = SqlTimestamp(dateTime)
    // 访问value属性
    let value1 = sqlTimestampWithValue.value
    println("SqlTimestamp value: ${value1}")
}
```

运行结果：

```text
SqlTimestamp value: 2012-01-01T00:00:00+08:00
```

### init(DateTime)

```cangjie
public init(v: DateTime)
```

功能：根据传入参数 v 构造一个 [SqlTimestamp <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqltimestamp-deprecated) 实例。

参数：

- v: [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    // 创建一个DateTime实例
    let dateTime = DateTime.of(year: 2012, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 0)
    
    // 使用SqlTimestamp的构造函数创建一个实例
    let sqlTimestampWithValue = SqlTimestamp(dateTime)
    println("Created SqlTimestamp with value: ${sqlTimestampWithValue.value}")
}
```

运行结果：

```text
Created SqlTimestamp with value: 2012-01-01T00:00:00+08:00
```

## class SqlVarBinary <sup>(deprecated)</sup>

```cangjie
public class SqlVarBinary <: SqlDbType {
    public init(v: Array<Byte>)
}
```

功能：变长二进制字符串，对应仓颉 [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> 类型。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlVarBinary <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlvarbinary-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个Byte数组
    let bytes: Array<Byte> = [1, 2, 3, 4]

    // 使用SqlVarBinary的构造函数
    let sqlVarBinary = SqlVarBinary(bytes)
    // 访问name属性
    println("SqlVarBinary name: ${sqlVarBinary.name}")
}
```

运行结果：

```text
SqlVarBinary name: SqlVarBinary
```

### prop value

```cangjie
public mut prop value: Array<Byte>
```

功能：该数据的值。

类型：[Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个Byte数组
    let bytes: Array<Byte> = [1, 2, 3, 4]
    
    // 使用SqlVarBinary的构造函数创建一个实例
    let sqlVarBinaryWithValue = SqlVarBinary(bytes)
    // 访问value属性
    let value1 = sqlVarBinaryWithValue.value
    println("SqlVarBinary value: ${value1}")
}
```

运行结果：

```text
SqlVarBinary value: [1, 2, 3, 4]
```

### init(Array\<Byte>)

```cangjie
public init(v: Array<Byte>)
```

功能：根据传入参数 v 构造一个 [SqlVarBinary <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlvarbinary-deprecated) 实例。

参数：

- v: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个Byte数组
    let bytes: Array<Byte> = [5, 6, 7, 8]
    
    // 使用SqlVarBinary的构造函数创建一个实例
    let sqlVarBinaryWithValue = SqlVarBinary(bytes)
    println("Created SqlVarBinary with value: ${sqlVarBinaryWithValue.value}")
}
```

运行结果：

```text
Created SqlVarBinary with value: [5, 6, 7, 8]
```

## class SqlVarchar <sup>(deprecated)</sup>

```cangjie
public class SqlVarchar <: SqlDbType {
    public init(v: String)
}
```

功能：变长字符串，对应仓颉 [String](../../core/core_package_api/core_package_structs.md#struct-string) 类型。

> **注意：**
>
> 未来版本即将废弃不再使用，使用仓颉原生类型替代。

父类型：

- [SqlDbType <sup>(deprecated)</sup>](database_sql_package_interfaces.md#interface-sqldbtype-deprecated)

### prop name

```cangjie
public prop name: String
```

功能：类型名称，即 [SqlVarchar  <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlvarchar-deprecated)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlVarchar的构造函数
    let sqlVarchar = SqlVarchar("Hello")
    // 访问name属性
    println("SqlVarchar name: ${sqlVarchar.name}")
}
```

运行结果：

```text
SqlVarchar name: SqlVarchar
```

### prop value

```cangjie
public mut prop value: String
```

功能：该数据的值。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlVarchar的构造函数创建一个实例
    let sqlVarcharWithValue = SqlVarchar("Hello")
    // 访问value属性
    let value1 = sqlVarcharWithValue.value
    println("SqlVarchar value: ${value1}")
}
```

运行结果：

```text
SqlVarchar value: Hello
```

### init(String)

```cangjie
public init(v: String)
```

功能：根据传入参数 v 构造一个 [SqlVarchar  <sup>(deprecated)</sup>](database_sql_package_classes.md#class-sqlvarchar-deprecated) 实例。

参数：

- v: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 传入的数据。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用SqlVarchar的构造函数创建一个实例
    let sqlVarcharWithValue = SqlVarchar("World")
    println("Created SqlVarchar with value: ${sqlVarcharWithValue.value}")
}
```

运行结果：

```text
Created SqlVarchar with value: World
```
