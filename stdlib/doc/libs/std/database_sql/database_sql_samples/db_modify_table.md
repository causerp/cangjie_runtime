# 删除表、创建表示例

<!-- compile -->
```cangjie
import std.database.sql.*

main() {
    // 获取数据库驱动并打开数据源
    let driver = DriverManager.getDriver("opengauss") ?? return
    let options = [
        ("cachePrepStmts", "true"),
        ("prepStmtCacheSize", "250"),
        ("prepStmtCacheSqlLimit", "2048")
    ]
    let dataSource = driver.open("opengauss://testuser:testpwd@localhost:5432/testdb", options)

    // 获取数据库连接
    let conn = dataSource.connect()

    // 删除已存在的 test 表
    var stmt = conn.prepareStatement("DROP TABLE IF EXISTS test")
    var updateResult = stmt.update()
    println("DROP TABLE 影响行数: ${updateResult.rowCount}")
    stmt.close()

    // 创建 test 表
    stmt = conn.prepareStatement("CREATE TABLE test(id SERIAL PRIMARY KEY, name VARCHAR(20) NOT NULL, age INT)")
    updateResult = stmt.update()
    println("CREATE TABLE 影响行数: ${updateResult.rowCount}")
    stmt.close()
}
```
