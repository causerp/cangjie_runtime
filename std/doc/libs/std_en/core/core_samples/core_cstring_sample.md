# Example of Interacting with C Code Using CString

The C code provides two functions: `getCString` function, which returns a string pointer from the C side; and `printCString` function, which prints a CString from the Cangjie side.

```c
#include <stdio.h>

char *str = "CString in C code.";

char *getCString() { return str; }

void printCString(char *s) { printf("%s\n", s); }
```

In the Cangjie code, create a CString object and pass it to the C side for printing. Also retrieve a string from the C side and print it on the Cangjie side:

Example:

```cangjie
foreign func getCString(): CString
foreign func printCString(s: CString): Unit

main() {
    // Construct CString instance on Cangjie side and pass to C side
    unsafe {
        let s: CString = LibC.mallocCString("CString in Cangjie code.")
        printCString(s)
        LibC.free(s)
    }

    unsafe {
        // Retrieve string pointer from C side as CString instance, then convert to Cangjie String type
        let cs = getCString()
        println(cs.toString())
    }

    // Using CStringResource in try-with-resource syntax for automatic CString memory management
    let cs = unsafe { LibC.mallocCString("CString in Cangjie code.") }
    try (csr = cs.asResource()) {
        unsafe { printCString(csr.value) }
    }

    0
}
```

Execution result:

```text
CString in Cangjie code.
CString in C code.
CString in Cangjie code.
```

> **Note:**
>
> Compilation method: First compile the C code into a static or dynamic library, then compile the Cangjie code and link with the C library.
> Assuming the C file is test.c and Cangjie file is test.cj, the compilation process is as follows:
>
> 1. Use gcc command `gcc -fPIC -shared test.c -o libtest.so` to generate C library `libtest.so`.
> 2. Use cjc command `cjc -L . -l test test.cj` to generate executable `main`.