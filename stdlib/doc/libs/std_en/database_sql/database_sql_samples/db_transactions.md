# Transaction Control Statement Examples

## Standard Database Transaction

<!-- compile -->

```cangjie
import std.database.sql.*
import std.time.*

main() {
    let SQL_INSERT = "INSERT INTO EMPLOYEE (NAME, SALARY, CREATED_DATE) VALUES (?, ?, ?)"
    let drv = DriverManager.getDriver("opengauss") ?? return
    let db = drv.open("opengauss://localhost:5432/testdb")
    try (cn = db.connect()) {
        let psInsert = cn.prepareStatement(SQL_INSERT)

        // Create transaction object
        let tx = cn.createTransaction()
        try {
            // Insert first record
            psInsert.set<String>(0, "mkyong")
            psInsert.set<Array<Byte>>(1, Array<Byte>(1, repeat: 10))
            psInsert.set<DateTime>(2, DateTime.now())
            psInsert.update()

            // Insert second record
            psInsert.set<String>(0, "kungfu")
            psInsert.set<Array<Byte>>(1, Array<Byte>(1, repeat: 20))
            psInsert.set<DateTime>(2, DateTime.now())
            psInsert.update()

            // Test rollback when connected to database: SQLException - No value specified for parameter 3
            psInsert.set<String>(0, "mkyong")
            psInsert.set<Array<Byte>>(1, Array<Byte>(5, {i => UInt8(i + 1)}))
            psInsert.update()

            // Commit transaction
            tx.commit()
        } catch (e1: SqlException) {
            e1.printStackTrace()
            try {
                // Rollback all transactions on exception
                tx.rollback()
            } catch (e2: SqlException) {
                // If rollback fails
                e2.printStackTrace()
            }
        }
    } catch (e: SqlException) {
        // If connection fails
        e.printStackTrace()
    }
}
```

## Transaction Savepoints

For databases supporting transaction savepoints, refer to the following example:

<!-- compile -->

```cangjie
import std.database.sql.*
import std.time.*

main() {
    let SQL_INSERT = "INSERT INTO EMPLOYEE (NAME, SALARY, CREATED_DATE) VALUES (?, ?, ?)"
    let drv = DriverManager.getDriver("opengauss") ?? return
    let db = drv.open("opengauss://localhost:5432/testdb")
    try (cn = db.connect()) {
        let psInsert = cn.prepareStatement(SQL_INSERT)

        let tx = cn.createTransaction()
        try {
            // Create savepoint 1
            tx.save("save1")
            psInsert.set<String>(0, "mkyong")
            psInsert.set<Array<Byte>>(1, Array<Byte>(1, repeat: 10))
            psInsert.set<DateTime>(2, DateTime.now())
            psInsert.update()

            // Create savepoint 2
            tx.save("save2")
            psInsert.set<String>(0, "kungfu")
            psInsert.set<Array<Byte>>(1, Array<Byte>(1, repeat: 20))
            psInsert.set<DateTime>(2, DateTime.now())
            psInsert.update()

            // Create savepoint 3
            tx.save("save3")
            psInsert.set<String>(0, "mkyong")
            psInsert.set<Array<Byte>>(1, Array<Byte>(5, {i => UInt8(i + 1)}))
            psInsert.update()

            // Rollback to savepoint 2
            tx.rollback("save2")

            // Commit transaction
            tx.commit()
        } catch (e1: SqlException) {
            e1.printStackTrace()
            try {
                // Rollback all transactions on exception
                tx.rollback()
            } catch (e2: SqlException) {
                e2.printStackTrace()
            }
        }
    } catch (e: SqlException) {
        e.printStackTrace()
    }
}
```