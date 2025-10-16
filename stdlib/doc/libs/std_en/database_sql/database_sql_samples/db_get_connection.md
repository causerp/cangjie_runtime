# Database Connection Acquisition Example

<!-- compile -->

```cangjie
import std.database.sql.*

main(): Unit {
    // Get the registered driver
    let drv = DriverManager.getDriver("opengauss") ?? return

    // Set data source opening options
    let opts = [
        ("cachePrepStmts", "true"),
        ("prepStmtCacheSize", "250"),
        ("prepStmtCacheSqlLimit", "2048")
    ]

    // Open data source with connection path and options
    let ds = drv.open("opengauss://testuser:testpwd@localhost:5432/testdb", opts)

    // Set connection options
    ds.setOption(SqlOption.SSLMode, SqlOption.SSLModeVerifyCA)
    ds.setOption(SqlOption.SSLCA, "ca.crt")
    ds.setOption(SqlOption.SSLCert, "server.crt")
    ds.setOption(SqlOption.SSLKey, "server.key")
    ds.setOption(SqlOption.SSLKeyPassword, "key_password")
    ds.setOption(SqlOption.TlsVersion, "TLSv1.2,TLSv1.3")

    // Return an available connection
    ds.connect()
}
```