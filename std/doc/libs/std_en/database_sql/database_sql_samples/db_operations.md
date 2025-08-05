# Database Operation Statement Examples

## Insert Data

<!-- compile -->

```cangjie
import std.database.sql.*

main() {
    // Example of obtaining database connection
    let drv = DriverManager.getDriver("opengauss") ?? return
    let ds = drv.open("opengauss://testuser:testpwd@localhost:5432/testdb", [])
    let conn = ds.connect()

    // Insert data 1
    var stmt = conn.prepareStatement("INSERT INTO test VALUES(?, ?)")
    stmt.set<String>(0, "li lei")
    stmt.set<Int32>(1, 12)
    var ur = stmt.update()
    println("Update Result: ${ur.rowCount} ${ur.lastInsertId}")

    // Insert data 2
    stmt.set<String>(0, "han meimei")
    stmt.set<Int32>(1, 13)
    ur = stmt.update()
    println("Update Result: ${ur.rowCount} ${ur.lastInsertId}")

    // To return the inserted id value after insertion, refer to the following approach:
    let sql = "INSERT INTO test (name, age) VALUES (?,?) RETURNING id, name"
    try (stmt = conn.prepareStatement(sql)) {
        stmt.set<String>(0, "li lei")
        stmt.set<Int32>(1, 12)
        let qr = stmt.query()
        while (qr.next()) {
            println("id = ${qr.get<Int32>(0)}, name=${qr.get<String>(1)}")
        }
    } catch (e: Exception) {
        e.printStackTrace()
    }
    stmt.close()
}
```

## Query Data

<!-- compile -->

```cangjie
import std.database.sql.*

main() {
    // Example of obtaining database connection
    let drv = DriverManager.getDriver("opengauss") ?? return
    let ds = drv.open("opengauss://testuser:testpwd@localhost:5432/testdb", [])
    let conn = ds.connect()

    // Query operation example
    var stmt = conn.prepareStatement("select * from test where name = ?")
    stmt.set<String>(0, "li lei")
    let qr = stmt.query()
    while (qr.next()) {
        println("id = ${qr.get<Int32>(0)}, name = ${qr.get<String>(1)}, age=${qr.get<Int32>(2)}")
    }
    stmt.close()
}
```

## Update Data

<!-- compile -->

```cangjie
import std.database.sql.*

main() {
    // Example of obtaining database connection
    let drv = DriverManager.getDriver("opengauss") ?? return
    let ds = drv.open("opengauss://testuser:testpwd@localhost:5432/testdb", [])
    let conn = ds.connect()

    // Update operation example
    var stmt = conn.prepareStatement("update test set age = ? where name = ?")
    stmt.set<Int32>(0, 15)
    stmt.set<String>(1, "li lei")
    var ur = stmt.update()
    println("Update Result: ${ur.rowCount} ${ur.lastInsertId}")
    stmt.close()
}
```

## Delete Data

<!-- compile -->

```cangjie
import std.database.sql.*

main() {
    // Example of obtaining database connection
    let drv = DriverManager.getDriver("opengauss") ?? return
    let ds = drv.open("opengauss://testuser:testpwd@localhost:5432/testdb", [])
    let conn = ds.connect()

    // Delete operation example
    var stmt = conn.prepareStatement("delete from test where name = ?")
    stmt.set<String>(0, "li lei")
    var ur = stmt.update()
    println("Update Result: ${ur.rowCount} ${ur.lastInsertId}")
    stmt.close()
}
```