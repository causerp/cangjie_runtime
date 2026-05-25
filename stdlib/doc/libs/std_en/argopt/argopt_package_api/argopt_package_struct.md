# Struct

## struct ParsedArguments

```cangjie
public struct ParsedArguments {
}
```

Function: Stores the results of argument parsing.

### prop nonOptions

```cangjie
public prop nonOptions: Array<String>
```

Function: This struct stores the results of argument parsing.

Type: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)>

Example:

<!-- verify -->
```cangjie
import std.argopt.*

main(): Unit {
    // Obtain a ParsedArguments instance through the parsing function
    let helpSpec = ArgumentSpec.Short(r'h', ArgumentMode.NoValue)
    let outputSpec = ArgumentSpec.Long("output", ArgumentMode.RequiredValue)
    let specs = [helpSpec, outputSpec]
    let args = ["-h", "--output", "output.txt", "file1.txt", "file2.txt"]
    
    let parsedResult = parseArguments(args, specs)
    
    // Access the nonOptions property
    println("Parsed nonOptions: ${parsedResult.nonOptions}")
    println("nonOptions size: ${parsedResult.nonOptions.size}")
    
    // Iterate through nonOptions
    println("All non-option arguments:")
    for (nonOption in parsedResult.nonOptions) {
        println("  ${nonOption}")
    }
}
```

Execution result:

```text
Parsed nonOptions: [file1.txt, file2.txt]
nonOptions size: 2
All non-option arguments:
  file1.txt
  file2.txt
```

### prop options

```cangjie
public prop options: ReadOnlyMap<String, String>
```

Function: Stores options obtained from argument parsing.

Type: [ReadOnlyMap](../../collection/collection_package_api/collection_package_interface.md#interface-readonlymapk-v)\<[String](../../core/core_package_api/core_package_structs.md#struct-string), [String](../../core/core_package_api/core_package_structs.md#struct-string)>

Example:

<!-- verify -->
```cangjie
import std.argopt.*

main(): Unit {
    // Obtain a ParsedArguments instance through the parsing function
    let helpSpec = ArgumentSpec.Short(r'h', ArgumentMode.NoValue)
    let outputSpec = ArgumentSpec.Long("output", ArgumentMode.RequiredValue)
    let verboseSpec = ArgumentSpec.Short(r'v', ArgumentMode.OptionalValue)
    let specs = [helpSpec, outputSpec, verboseSpec]
    let args = ["-h", "--output", "output.txt", "-v", "file1.txt"]
    
    let parsedResult = parseArguments(args, specs)
    
    // Access the options property
    println("Parsed options size: ${parsedResult.options.size}")
    
    // Check if specific options exist
    if (parsedResult.options.contains("h")) {
        println("Contains help option h")
    }
    
    if (parsedResult.options.contains("output")) {
        println("Output option value: ${parsedResult.options["output"]}")
    }
    
    if (parsedResult.options.contains("v")) {
        println("Verbose option value: '${parsedResult.options["v"]}'")
    }
    
    // Iterate through all options
    println("All options:")
    for (key in parsedResult.options.keys()) {
        println("  ${key}: '${parsedResult.options[key]}'")
    }
}
```

Execution result:

```text
Parsed options size: 3
Contains help option h
Output option value: output.txt
Verbose option value: ''
All options:
  h: ''
  output: 'output.txt'
  v: ''
```
