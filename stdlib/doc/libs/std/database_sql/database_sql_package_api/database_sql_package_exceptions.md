# 异常类

## class SqlException

```cangjie
public open class SqlException <: Exception {
    public init()
    public init(message: String)
    public init(message: String, sqlState: String, errorCode: Int64)
}
```

功能：用于处理 sql 相关的异常。

父类型：

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### prop errorCode

```cangjie
public prop errorCode: Int64
```

功能：数据库供应商返回的整数错误代码。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlException实例
    let exception = SqlException("Error message", "SQLST", 12345i64)

    // 访问errorCode属性
    let errorCode = exception.errorCode
    println("Error code: ${errorCode}")
}
```

运行结果：

```text
Error code: 12345
```

### prop message

```cangjie
public override prop message: String
```

功能：获取异常信息字符串。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlException实例
    let exception = SqlException("Error message", "SQLST", 12345i64)

    // 访问message属性
    let message = exception.message
    println("Error message: ${message}")
}
```

运行结果：

```text
Error message: Error message, SqlState: SQLST, errorCode: 12345
```

### prop sqlState

```cangjie
public prop sqlState: String
```

功能：长度为五个字符的字符串，是数据库系统返回的最后执行的 sql 语句状态。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlException实例
    let exception = SqlException("Error message", "SQLST", 12345i64)

    // 访问sqlState属性
    let sqlState = exception.sqlState
    println("SQL state: ${sqlState}")
}
```

运行结果：

```text
SQL state: SQLST
```

### init()

```cangjie
public init()
```

功能：无参构造函数。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用无参构造函数创建SqlException实例
    let exception = SqlException()

    // 打印异常信息
    println("Exception message: ${exception.message}")
    println("SQL state: ${exception.sqlState}")
    println("Error code: ${exception.errorCode}")
}
```

运行结果：

```text
Exception message: errorCode: 0
SQL state: 
Error code: 0
```

### init(String)

```cangjie
public init(message: String)
```

功能：根据异常信息创建 [SqlException](database_sql_package_exceptions.md#class-sqlexception) 实例。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 异常信息。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用带消息参数的构造函数创建SqlException实例
    let exception = SqlException("Database connection failed")

    // 打印异常信息
    println("Exception message: ${exception.message}")
    println("SQL state: ${exception.sqlState}")
    println("Error code: ${exception.errorCode}")
}
```

运行结果：

```text
Exception message: Database connection failed, errorCode: 0
SQL state: 
Error code: 0
```

### init(String, String, Int64)

```cangjie
public init(message: String, sqlState: String, errorCode: Int64)
```

功能：根据异常信息、SQL语句状态、错误码信息，创建 [SqlException](database_sql_package_exceptions.md#class-sqlexception) 实例。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 异常信息。
- sqlState: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 长度为五个字符的字符串，是数据库系统返回的最后执行的 sql 语句状态。
- errorCode: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 数据库供应商返回的整数错误代码。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 使用带所有参数的构造函数创建SqlException实例
    let exception = SqlException("Database connection failed", "SQLST", 12345i64)

    // 打印异常信息
    println("Exception message: ${exception.message}")
    println("SQL state: ${exception.sqlState}")
    println("Error code: ${exception.errorCode}")
}
```

运行结果：

```text
Exception message: Database connection failed, SqlState: SQLST, errorCode: 12345
SQL state: SQLST
Error code: 12345
```

### func getClassName()

```cangjie
protected override open func getClassName(): String
```

功能：获得类名。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 类名。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建一个SqlException实例
    let exception = MyException()

    // 调用getClassName函数获取类名
    let className = exception.myGetClassName()
    println("Class name: ${className}")
}

class MyException <: SqlException {
    func myGetClassName(): String {
        return getClassName()
    }
}
```

运行结果：

```text
Class name: SqlException
```
