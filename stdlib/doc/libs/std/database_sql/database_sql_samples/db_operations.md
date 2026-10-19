# 执行数据库操作语句示例

## 插入数据

<!-- compile -->
```cangjie
import std.database.sql.*

main() {
    // 获取数据库连接
    let driver = DriverManager.getDriver("opengauss") ?? return
    let dataSource = driver.open("opengauss://testuser:testpwd@localhost:5432/testdb", [])
    let conn = dataSource.connect()

    // 插入数据 1
    var stmt = conn.prepareStatement("INSERT INTO test VALUES(?, ?)")
    stmt.set<String>(0, "li lei")
    stmt.set<Int32>(1, 12)
    var updateResult = stmt.update()
    println("插入结果: 影响行数 = ${updateResult.rowCount}, 自增 ID = ${updateResult.lastInsertId}")

    // 插入数据 2
    stmt.set<String>(0, "han meimei")
    stmt.set<Int32>(1, 13)
    updateResult = stmt.update()
    println("插入结果: 影响行数 = ${updateResult.rowCount}, 自增 ID = ${updateResult.lastInsertId}")
    stmt.close()

    // 如果需要在插入数据后返回插入的 id 值，可以参考如下方式：
    let sql = "INSERT INTO test (name, age) VALUES (?,?) RETURNING id, name"
    try (insertStmt = conn.prepareStatement(sql)) {
        insertStmt.set<String>(0, "li lei")
        insertStmt.set<Int32>(1, 12)
        let queryResult = insertStmt.query()
        while (queryResult.next()) {
            println("插入返回: id = ${queryResult.get<Int32>(0)}, name = ${queryResult.get<String>(1)}")
        }
    } catch (e: Exception) {
        e.printStackTrace()
    }
}
```

## 查询数据

<!-- compile -->
```cangjie
import std.database.sql.*

main() {
    // 获取数据库连接
    let driver = DriverManager.getDriver("opengauss") ?? return
    let dataSource = driver.open("opengauss://testuser:testpwd@localhost:5432/testdb", [])
    let conn = dataSource.connect()

    // 按姓名查询数据
    var stmt = conn.prepareStatement("select * from test where name = ?")
    stmt.set<String>(0, "li lei")
    let queryResult = stmt.query()

    // 逐行读取查询结果
    while (queryResult.next()) {
        println(
            "id = ${queryResult.get<Int32>(0)}, name = ${queryResult.get<String>(1)}, age = ${queryResult.get<Int32>(2)}")
    }
    stmt.close()
}
```

## 更新数据

<!-- compile -->
```cangjie
import std.database.sql.*

main() {
    // 获取数据库连接
    let driver = DriverManager.getDriver("opengauss") ?? return
    let dataSource = driver.open("opengauss://testuser:testpwd@localhost:5432/testdb", [])
    let conn = dataSource.connect()

    // 更新指定姓名的 age 字段
    var stmt = conn.prepareStatement("update test set age = ? where name = ?")
    stmt.set<Int32>(0, 15)
    stmt.set<String>(1, "li lei")
    var updateResult = stmt.update()
    println("更新结果: 影响行数 = ${updateResult.rowCount}")
    stmt.close()
}
```

## 删除数据

<!-- compile -->
```cangjie
import std.database.sql.*

main() {
    // 获取数据库连接
    let driver = DriverManager.getDriver("opengauss") ?? return
    let dataSource = driver.open("opengauss://testuser:testpwd@localhost:5432/testdb", [])
    let conn = dataSource.connect()

    // 删除指定姓名的数据
    var stmt = conn.prepareStatement("delete from test where name = ?")
    stmt.set<String>(0, "li lei")
    var updateResult = stmt.update()
    println("删除结果: 影响行数 = ${updateResult.rowCount}")
    stmt.close()
}
```
