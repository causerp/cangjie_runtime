# 执行事务控制语句示例

## 普通数据库事务

<!-- compile -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    let SQL_INSERT = "INSERT INTO EMPLOYEE (NAME, SALARY, CREATED_DATE) VALUES (?, ?, ?)"

    // 获取数据库驱动并打开数据源
    let driver = DriverManager.getDriver("opengauss") ?? return
    let dataSource = driver.open("opengauss://localhost:5432/testdb")

    try (conn = dataSource.connect()) {
        let insertStmt = conn.prepareStatement(SQL_INSERT)

        // 创建事务对象
        let transaction = conn.createTransaction()
        try {
            // 插入第一条数据
            insertStmt.set<String>(0, "mkyong")
            insertStmt.set<Array<Byte>>(1, Array<Byte>(1, repeat: 10))
            insertStmt.set<DateTime>(2, DateTime.now())
            insertStmt.update()

            // 插入第二条数据
            insertStmt.set<String>(0, "kungfu")
            insertStmt.set<Array<Byte>>(1, Array<Byte>(1, repeat: 20))
            insertStmt.set<DateTime>(2, DateTime.now())
            insertStmt.update()

            // 第三条数据故意不设置参数 3 的值，执行时将抛出 SqlException，用于演示回滚
            insertStmt.set<String>(0, "mkyong")
            insertStmt.set<Array<Byte>>(1, Array<Byte>(5, {i => UInt8(i + 1)}))
            insertStmt.update()

            // 提交事务
            transaction.commit()
        } catch (updateEx: SqlException) {
            updateEx.printStackTrace()
            try {
                // 发生异常，回滚所有事务
                transaction.rollback()
            } catch (rollbackEx: SqlException) {
                // 回滚失败
                rollbackEx.printStackTrace()
            }
        }
    } catch (e: SqlException) {
        // 连接失败
        e.printStackTrace()
    }
}
```

## 事务保存点

如果数据库事务支持保存点，可以参考如下样例：

<!-- compile -->
```cangjie
import std.database.sql.*
import std.time.*

main() {
    let SQL_INSERT = "INSERT INTO EMPLOYEE (NAME, SALARY, CREATED_DATE) VALUES (?, ?, ?)"

    // 获取数据库驱动并打开数据源
    let driver = DriverManager.getDriver("opengauss") ?? return
    let dataSource = driver.open("opengauss://localhost:5432/testdb")

    try (conn = dataSource.connect()) {
        let insertStmt = conn.prepareStatement(SQL_INSERT)

        // 创建事务对象
        let transaction = conn.createTransaction()
        try {
            // 创建保存点 1
            transaction.save("save1")
            insertStmt.set<String>(0, "mkyong")
            insertStmt.set<Array<Byte>>(1, Array<Byte>(1, repeat: 10))
            insertStmt.set<DateTime>(2, DateTime.now())
            insertStmt.update()

            // 创建保存点 2
            transaction.save("save2")
            insertStmt.set<String>(0, "kungfu")
            insertStmt.set<Array<Byte>>(1, Array<Byte>(1, repeat: 20))
            insertStmt.set<DateTime>(2, DateTime.now())
            insertStmt.update()

            // 创建保存点 3
            transaction.save("save3")
            insertStmt.set<String>(0, "mkyong")
            insertStmt.set<Array<Byte>>(1, Array<Byte>(5, {i => UInt8(i + 1)}))
            insertStmt.update()

            // 回滚到保存点 2，保存点 2 之后的数据不会被提交
            transaction.rollback("save2")

            // 提交事务
            transaction.commit()
        } catch (updateEx: SqlException) {
            updateEx.printStackTrace()
            try {
                // 发生异常，回滚所有事务
                transaction.rollback()
            } catch (rollbackEx: SqlException) {
                // 回滚失败
                rollbackEx.printStackTrace()
            }
        }
    } catch (e: SqlException) {
        // 连接失败
        e.printStackTrace()
    }
}
```
