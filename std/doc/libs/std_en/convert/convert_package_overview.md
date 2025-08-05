# std.convert  

## Function Overview  

The `convert` package provides a series of `Convert` functions for converting strings to specific types.  

For example, converting the string `"true"` to the boolean value `true`, or the string `"123"` to the integer `123`.  

The `convert` package also offers formatting capabilities, primarily for converting Cangjie type instances into formatted strings.  

It defines the `Formattable` interface to standardize formatting methods and implements this interface for Cangjie types such as `Int8`, `Int16`, etc. Users can also implement this interface for custom types to gain formatting functionality.  

When converting Cangjie types to strings, the string format can be specified using formatting parameters such as width, alignment, etc. (In the methods defined by the `Formattable` interface, formatting parameters are passed as function arguments.)  

The detailed syntax for formatting parameters is as follows:  

```text  
format_spec := [flags][width][.precision][specifier]  
flags := '-' | '+' | '#' | '0'  
width := integer  
precision := integer  
specifier := 'b' | 'B' | 'o' | 'O' | 'x' | 'X' | 'e' | 'E' | 'g' | 'G'  
```  

### Flags:  

- `'-'`: Applies to `Int`, `UInt`, `Rune`, and `Float`. Indicates left alignment.  

    Example code:  

    ```cangjie  
    import std.convert.*  

    main() {  
        var c : Int32 = -20  
        print("\"${c.format("-10")}\"")  
    }  
    ```  

    Output:  

    ```text  
    "-20       "  
    ```  

- `'+'`: Applies to `Int`, `UInt`, and `Float`. Displays a `'+'` sign for positive numbers (negative numbers are unaffected).  

    Example code:  

    ```cangjie  
    import std.convert.*  

    main() {  
        var c: Int32 = 20  
        print("\"${c.format("+10")}\"")  
    }  
    ```  

    Output:  

    ```text  
    "       +20"  
    ```  

- `'#'`: Used for base-specific formatting. Prepends `'0b'` or `'0B'` for binary, `'0o'` or `'0O'` for octal, and `'0x'` or `'0X'` for hexadecimal.  

    Example code:  

    ```cangjie  
    import std.convert.*  

    main() {  
        var c: Int32 = 1  
        print("\"${c.format("#10x")}\"")  
    }  
    ```  

    Output:  

    ```text  
    "       0x1"  
    ```  

- `'0'`: Applies to `Int`, `UInt`, and `Float`. Pads empty spaces with zeros.  

    Example code:  

    ```cangjie  
    import std.convert.*  

    main() {  
        var c: Int32 = -20  
        print("\"${c.format("010")}\"")  
    }  
    ```  

    Output:  

    ```text  
    "-000000020"  
    ```  

### Width:  

- A positive integer applicable to `Int`, `UInt`, `Rune`, and `Float`. A negative sign before the width indicates left alignment; otherwise, right alignment is used. If the width is smaller than the actual length of the value, no truncation occurs.  
  Prefixes like `+`, `-`, `0x`, or `0o` occupy additional character positions.  

    Example code:  

    ```cangjie  
    import std.convert.*  

    main() {  
        var c: Int32 = 20  
        println("\"${c.format("1")}\"")  
        println("\"${c.format("+4")}\"")  
    }  
    ```  

    Output:  

    ```text  
    "20"  
    " +20"  
    ```  

### Precision:  

- A positive integer applicable to `Int`, `UInt`, and `Float`.  
  - For floating-point numbers, it specifies the number of decimal places. If unspecified, six decimal places are printed. If the precision is less than the actual length, rounding occurs; if greater, padding is applied (not necessarily zeros).  
  - For integer types, if unspecified or smaller than the actual length, no effect occurs. If greater, leading zeros are added.  

    Example code:  

    ```cangjie  
    import std.convert.*  

    main() {  
        var e: Float32 = 1234.1  
        println("\"${e.format("20.20")}\"")  
        var c: Int32 = -20  
        println("\"${c.format("10.8")}\"")  
    }  
    ```  

    Output:  

    ```text  
    "1234.09997558593750000000"  
    " -00000020"  
    ```  

### Specifiers:  

- `'b' | 'B' | 'o' | 'O' | 'x' | 'X'`: Applicable to `Int` and `UInt`.  
  - `'b' | 'B'`: Binary format.  
  - `'o' | 'O'`: Octal format.  
  - `'x' | 'X'`: Hexadecimal format.  

    Example code:  

    ```cangjie  
    import std.convert.*  

    main() {  
        var a = 20  
        println("\"${a.format("b")}\"")  
        println("\"${a.format("o")}\"")  
        println("\"${a.format("x")}\"")  
        println("\"${a.format("X")}\"")  
        println("\"${a.format("#X")}\"")  
    }  
    ```  

    Output:  

    ```text  
    "10100"  
    "24"  
    "14"  
    "14"  
    "0X14"  
    ```  

- `'e' | 'E' | 'g' | 'G'`: Applicable to `Float`.  
  - `'e' | 'E'`: Scientific notation (lowercase/uppercase).  
  - `'g' | 'G'`: General format. Chooses between decimal or scientific notation for concise representation.  

    Example code:  

    ```cangjie  
    import std.convert.*  

    main() {  
        var f: Float32 = 1234.1  
        var c: Float32 = 123412341234.1  
        println("\"${f.format("20.2e")}\"")  
        println("\"${f.format("20G")}\"")  
        println("\"${c.format("20G")}\"")  
        println("\"${f.format("20")}\"")  
        println("\"${c.format("20")}\"")  
    }  
    ```  

    Output:  

    ```text  
    "            1.23e+03"  
    "              1234.1"  
    "         1.23412E+11"  
    "         1234.099976"  
    " 123412340736.000000"  
    ```  

## API List  

### Interfaces  

| Interface Name | Description |  
| --------------------------- | ------------------------ |  
| [Formattable](./convert_package_api/convert_package_interfaces.md#interface-formattable) | Defines formatting functions to convert type instances into formatted strings based on parameters. |  
| [Parsable\<T>](./convert_package_api/convert_package_interfaces.md#interface-parsablet) | Interface for parsing strings into specific types. |  
| [RadixConvertible\<T>](./convert_package_api/convert_package_interfaces.md#interface-radixconvertiblet) | Interface for parsing strings into specific types with radix support. |