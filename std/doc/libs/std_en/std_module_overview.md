# Cangjie Programming Language Standard Library API

The Cangjie Programming Language Standard Library (std) is a default library included with the Cangjie SDK installation. The standard library predefines a set of functions, classes, structures, etc., aiming to provide commonly used functionalities and tools to enable developers to write programs more quickly and efficiently.

The Cangjie Standard Library has three key characteristics and objectives:

- **Ease of Use**: The standard library is distributed with the compiler and toolchain, requiring no additional downloads from users—ready to use out of the box.
- **General Functionality**: The standard library offers the most frequently used library capabilities for developers, designed to address most fundamental problems.
- **Quality Benchmark**: The standard library strives to set examples and benchmarks in performance, code style, and other aspects for other Cangjie libraries.

## Usage Guide

In the Cangjie programming language, the standard library consists of several packages, where a package is the smallest compilation unit. Each package can independently output artifacts such as AST (Abstract Syntax Trees) files, static library files, and dynamic library files. Packages can define sub-packages, forming a tree-like structure. A package without a parent is called a root package, and the entire tree composed of the root package and its sub-packages (including sub-packages of sub-packages) is called a module. The module's name is the same as the root package's name and represents the smallest unit for developer distribution.

Package import rules are as follows:

- You can import a top-level declaration or definition from a package using the following syntax:

    ```cangjie
    import fullPackageName.itemName
    ```

    Here, `fullPackageName` is the full path package name, and `itemName` is the name of the declaration, for example:

    ```cangjie
    import std.collection.ArrayList
    ```

- If multiple `itemName`s belong to the same `fullPackageName`, you can use:

    ```cangjie
    import fullPackageName.{itemName[, itemName]*}
    ```

    For example:

    ```cangjie
    import std.collection.{ArrayList, HashMap}
    ```

- Alternatively, you can import all top-level declarations or definitions marked as `public` from the `fullPackageName` package using:

    ```cangjie
    import fullPackageName.*
    ```

    For example:

    ```cangjie
    import std.collection.*
    ```

## Package List

The `std` library includes several packages, providing a rich set of foundational functionalities:

| Package Name | Functionality |
| ------------ | ------------ |
| [core](./core/core_package_overview.md) | The `core` package is the core of the standard library, providing the most fundamental API capabilities for Cangjie language programming. |
| [argopt](./argopt/argopt_package_overview.md) | The `argopt` package provides functionality to parse parameter names and values from command-line argument strings. |
| [ast](./ast/ast_package_overview.md) | The `ast` package primarily includes the Cangjie source code parser and syntax tree nodes, offering syntax parsing functions. |
| [binary](./binary/binary_package_overview.md) | The `binary` package provides interfaces for converting between basic data types and binary byte arrays in different endianness, as well as endianness reversal. |
| [collection](./collection/collection_package_overview.md) | The `collection` package offers efficient implementations of common data structures, definitions of related abstract interfaces, and frequently used functions in collection types. |
| [collection.concurrent](./collection_concurrent/collection_concurrent_package_overview.md) | The `collection.concurrent` package provides thread-safe collection type implementations. |
| [console](./console/console_package_overview.md) | The `console` package provides methods to interact with standard input, output, and error streams. |
| [convert](./convert/convert_package_overview.md) | The `convert` package offers `Convert` series functions for converting strings to specific types, as well as formatting capabilities, primarily for converting Cangjie type instances into formatted strings. |
| [crypto.cipher](./crypto/cipher/cipher_package_overview.md) | The `crypto.cipher` package provides generic interfaces for symmetric encryption and decryption. |
| [crypto.digest](./crypto/digest/digest_package_overview.md) | The `crypto.digest` package offers generic interfaces for common digest algorithms, including MD5, SHA1, SHA224, SHA256, SHA384, SHA512, HMAC, and SM3. |
| [database.sql](./database_sql/database_sql_package_overview.md) | The `database.sql` package provides interfaces for Cangjie to access databases. |
| [deriving](./deriving/deriving_package_overview.md) | The `deriving` package provides a set of macros to automatically generate interface implementations. |
| [env](./env/env_package_overview.md) | The `env` package offers information and functionalities related to the current process, including environment variables, command-line arguments, standard streams, and program termination. |
| [fs](./fs/fs_package_overview.md) | The `fs` (file system) package provides functions for operations on files, directories, paths, and file metadata. |
| [io](./io/io_package_overview.md) | The `io` package enables data exchange between programs and external devices. |
| [math](./math/math_package_overview.md) | The `math` package provides common mathematical operations, constant definitions, floating-point number handling, and other functionalities. |
| [math.numeric](./math_numeric/math_numeric_package_overview.md) | The `math.numeric` package extends capabilities beyond the expressible range of basic types. |
| [net](./net/net_package_overview.md) | The `net` package offers common network communication functionalities. |
| [objectpool](./objectpool/objectpool_package_overview.md) | The `objectpool` package provides object caching and reuse functionalities. |
| [overflow](./overflow/overflow_package_overview.md) | The `overflow` package provides overflow handling capabilities. |
| [posix](./posix/posix_package_overview.md) | The `posix` package primarily adapts POSIX system interfaces. |
| [process](./process/process_package_overview.md) | The `process` package mainly provides `Process` operation interfaces, including process creation, standard stream retrieval, process waiting, and process information querying. |
| [random](./random/random_package_overview.md) | The `random` package provides pseudo-random number generation capabilities. |
| [reflect](./reflect/reflect_package_overview.md) | The `reflect` package offers reflection functionalities, enabling programs to retrieve type information of various instances at runtime and perform read/write and invocation operations. |
| [regex](./regex/regex_package_overview.md) | The `regex` package provides text analysis and processing capabilities using regular expressions (supporting UTF-8 encoded Unicode strings), including search, split, replace, and validation functionalities. |
| [runtime](./runtime/runtime_package_overview.md) | The `runtime` package interacts with the program's runtime environment, providing a series of functions and variables for controlling, managing, and monitoring program execution. |
| [sort](./sort/sort_package_overview.md) | The `sort` package provides sorting functions for array types. |
| [sync](./sync/sync_package_overview.md) | The `sync` package offers concurrency programming-related capabilities. |
| [time](./time/time_package_overview.md) | The `time` package provides time-related types, including date-time, time intervals, monotonic time, and time zones, along with calculation and comparison functionalities. |
| [unicode](./unicode/unicode_package_overview.md) | The `unicode` package provides character processing capabilities according to the Unicode encoding standard. |
| [unittest](./unittest/unittest_package_overview.md) | The `unittest` package is used for writing unit test code for Cangjie projects, providing basic functionalities including code writing, execution, and debugging. |
| [unittest.mock](./unittest_mock/unittest_mock_package_overview.md) | The `unittest.mock` package provides a mock framework for Cangjie unit tests, offering APIs to create and configure mock objects with signatures consistent with real objects. |
| [unittest.testmacro](./unittest_testmacro/unittest_testmacro_package_overview.md) | The `unittest.testmacro` package provides macros required by users for the unit testing framework. |
| [unittest.mock.mockmacro](./unittest_mock_mockmacro/unittest_mock_mockmacro_package_overview.md) | The `unittest.mock.mockmacro` package provides macros required by users for the mock framework. |
| [unittest.common](./unittest_common/unittest_common_package_overview.md) | The `unittest.common` package provides types and general methods required for printing in the unit testing framework. |
| [unittest.diff](./unittest_diff/unittest_diff_package_overview.md) | The `unittest.diff` package provides APIs for printing difference comparison information in the unit testing framework. |
| [unittest.prop_test](./unittest_prop_test/unittest_prop_test_package_overview.md) | The `unittest.prop_test` package provides types and general methods required for parameterized testing in the unit testing framework. |