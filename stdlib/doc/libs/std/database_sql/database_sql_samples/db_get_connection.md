# 获取数据库连接示例

<!-- compile -->
```cangjie
import std.database.sql.*

main(): Unit {
    // 获取已经注册的驱动
    let driver = DriverManager.getDriver("opengauss") ?? return

    // 设置打开数据源的选项
    let options = [
        ("cachePrepStmts", "true"),
        ("prepStmtCacheSize", "250"),
        ("prepStmtCacheSqlLimit", "2048")
    ]

    // 通过连接路径和选项打开数据源
    let dataSource = driver.open("opengauss://testuser:testpwd@localhost:5432/testdb", options)

    // 设置连接选项
    dataSource.setOption(SqlOption.SSLMode, SqlOption.SSLModeVerifyCA)
    dataSource.setOption(SqlOption.SSLCA, "ca.crt")
    dataSource.setOption(SqlOption.SSLCert, "server.crt")
    dataSource.setOption(SqlOption.SSLKey, "server.key")
    dataSource.setOption(SqlOption.SSLKeyPassword, "key_password")
    dataSource.setOption(SqlOption.TlsVersion, "TLSv1.2,TLSv1.3")

    // 返回一个可用连接
    dataSource.connect()
}
```
