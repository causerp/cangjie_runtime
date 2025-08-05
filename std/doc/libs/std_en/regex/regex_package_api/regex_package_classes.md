# Class

## class Matcher <sup>(deprecated)</sup>

```cangjie
public class Matcher {
    public init(re: Regex, input: String)
}
```

Function: A regular expression matcher used for scanning input sequences and performing matches.

> **Note:**
>
> This will be deprecated in future versions. Use [Regex](#class-regex) instead.

### init(Regex, String)

```cangjie
public init(re: Regex, input: String)
```

Function: Creates a [Matcher](#class-matcher-deprecated) instance with the provided regular expression and input sequence.

Parameters:

- re: [Regex](regex_package_classes.md#class-regex) - The regular expression.
- input: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The input sequence.

### func allCount()

```cangjie
public func allCount(): Int64
```

Function: Gets the total number of matches for the regular expression.

By default, it matches from start to end. After using setRegion, it only searches within the specified range.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The total number of matches.

### func find()

```cangjie
public func find(): Option<MatchData>
```

Function: Starting from the current string offset position, finds the first matching subsequence.

Each call to find advances the current offset position to the first character after the latest matched subsequence. Subsequent calls start matching from this new position.

Return value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[MatchData](regex_package_structs.md#struct-matchdata)> - Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[MatchData](regex_package_structs.md#struct-matchdata)> if a match is found; otherwise returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[MatchData](regex_package_structs.md#struct-matchdata)>.None.

Exceptions:

- [RegexException](regex_package_exceptions.md#class-regexexception) - Throws an exception when a match exists but fails to extract match information.

### func find(Int64)

```cangjie
public func find(index: Int64): Option<MatchData>
```

Function: Resets the matcher's index position and starts matching the input sequence from the specified index, returning the matched subsequence.

Return value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[MatchData](regex_package_structs.md#struct-matchdata)> - Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[MatchData](regex_package_structs.md#struct-matchdata)> if a match is found; otherwise returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[MatchData](regex_package_structs.md#struct-matchdata)>.None.

Exceptions:

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Throws an exception when index is less than 0 or greater than or equal to the input sequence's size.
- [RegexException](regex_package_exceptions.md#class-regexexception) - Throws an exception when a match exists but fails to extract match information.

### func findAll()

```cangjie
public func findAll(): Option<Array<MatchData>>
```

Function: Matches the entire input sequence and finds all matching subsequences.

Return value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[MatchData](regex_package_structs.md#struct-matchdata)>> - Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[MatchData](regex_package_structs.md#struct-matchdata)>> if matches are found; otherwise returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[MatchData](regex_package_structs.md#struct-matchdata)>>.None.

Exceptions:

- [RegexException](regex_package_exceptions.md#class-regexexception) - Throws an exception when a match exists but fails to extract match information.

### func fullMatch()

```cangjie
public func fullMatch(): Option<MatchData>
```

Function: Matches the entire input sequence.

Return value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[MatchData](regex_package_structs.md#struct-matchdata)> - Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[MatchData](regex_package_structs.md#struct-matchdata)> if the entire sequence matches successfully; otherwise returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[MatchData](regex_package_structs.md#struct-matchdata)>.None.

Exceptions:

- [RegexException](regex_package_exceptions.md#class-regexexception) - Throws an exception when a match exists but fails to extract match information.

### func getString()

```cangjie
public func getString(): String
```

Function: Gets the matched sequence.

Return value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The matched sequence.

### func matchStart()

```cangjie
public func matchStart(): Option<MatchData>
```

Function: Matches the beginning of the input sequence.

Return value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[MatchData](regex_package_structs.md#struct-matchdata)> - Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[MatchData](regex_package_structs.md#struct-matchdata)> if the match is successful; otherwise returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[MatchData](regex_package_structs.md#struct-matchdata)>.None.

Exceptions:

- [RegexException](regex_package_exceptions.md#class-regexexception) - Throws an exception when a match exists but fails to extract match information.

### func region()

```cangjie
public func region(): Position
```

Function: Returns the matcher's region settings.

Return value:

- [Position](regex_package_structs.md#struct-position) - The matcher's region settings.

### func replace(String)

```cangjie
public func replace(replacement: String): String
```

Function: Starting from the current string offset position, replaces the first matched subsequence with the target string and sets the current index position to the next position after the matched subsequence.

Parameters:

- replacement: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The replacement string.

Return value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The replaced string.

### func replace(String, Int64)

```cangjie
public func replace(replacement: String, index: Int64): String
```

Function: Starting from the specified index position in the input sequence, matches the regular expression and replaces the first matched subsequence with the target string.

Parameters:

- replacement: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The replacement string.
- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The starting position for matching.

Return value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The replaced string.

Exceptions:

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Throws an exception when index is less than 0 or greater than or equal to the input sequence's size.

### func replaceAll(String)

```cangjie
public func replaceAll(replacement: String): String
```

Function: Replaces all subsequences in the input sequence that match the regular expression with the given target string.

Parameters:

- replacement: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The replacement string.

Return value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The replaced string.

### func replaceAll(String, Int64)

```cangjie
public func replaceAll(replacement: String, limit: Int64): String
```

Function: Replaces the first 'limit' subsequences in the input sequence that match the regular expression with the given replacement string.

Parameters:

- replacement: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The replacement string.
- limit: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The maximum number of replacements. If limit is 0, returns the original sequence; if limit is negative, replaces as many times as possible.

Return value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The replaced string.

### func resetRegion()

```cangjie
public func resetRegion(): Matcher
```

Function: Resets the matcher's start and end positions.

Return value:

- [Matcher](#class-matcher-deprecated) - The matcher itself.

### func resetString(String)

```cangjie
public func resetString(input: String): Matcher
```

Function: Resets the matching sequence and the matcher.

Parameters:

- input: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The new matching sequence.

Return value:

- [Matcher](#class-matcher-deprecated) - The matcher itself.

### func setRegion(Int64, Int64)

```cangjie
public func setRegion(beginIndex: Int64, endIndex: Int64): Matcher
```

Function: Sets the searchable region of the matcher, with specific positions determined by the provided begin and end indices.

Parameters:

- beginIndex: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The start position of the region.
- endIndex: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The end position of the region.

Return value:

- [Matcher](#class-matcher-deprecated) - The matcher itself.

Exceptions:

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Throws an exception when beginIndex is less than 0 or greater than the input sequence's size; when endIndex is less than 0 or greater than the input sequence's size; or when beginIndex is greater than endIndex.

### func split()

```cangjie
public func split(): Array<String>
```

Function: Splits the given input sequence into as many subsequences as possible based on the regular expression.

Return value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - An array of subsequences.

### func split(Int64)

```cangjie
public func split(limit: Int64): Array<String>
```

Function: Splits the given input sequence into as many subsequences as possible based on the regular expression (up to 'limit' substrings).

Parameters:

- limit: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The maximum number of substrings to split into.

Return value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - If limit > 0, returns up to 'limit' substrings; if limit <= 0, returns the maximum possible number of substrings.

## class Regex

```cangjie
public class Regex {
    public init(pattern: String, flags: Array<RegexFlag>)
    public init(pattern: String, option: RegexOption)
}
```

Function: Used to specify compilation type and create regular expression instances.

For regex matching rules, see [regex rule set](../regex_package_overview.md#-regex-rule-set).

### init(String, Array\<RegexFlag>)

```cangjie
public init(pattern: String, flags: Array<RegexFlag>)
```

Function: Creates a [Regex](regex_package_classes.md#class-regex) instance.

Parameters:

- pattern: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The regular expression.
- flags: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[RegexFlag](regex_package_enums.md#enum-regexflag)> - List of regex matching modes.

Exceptions:

- [RegexException](regex_package_exceptions.md#class-regexexception) - Throws exception when initialization fails.

### init(String, RegexOption) <sup>(deprecated)</sup>

```cangjie
public init(pattern: String, option: RegexOption)
```

Function: Creates a [Regex](regex_package_classes.md#class-regex) instance with specified mode.

> **Note:**
>
> Will be deprecated in future versions. Use [init(String, Array\<RegexFlag>)](#initstring-arrayregexflag) instead.

Parameters:

- pattern: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The regular expression.
- option: [RegexOption](#class-regexoption-deprecated) - The regex matching mode.

Exceptions:

- [RegexException](regex_package_exceptions.md#class-regexexception) - Throws exception when initialization fails.

### func find(String, Bool)

```cangjie
public func find(input: String, group!: Bool = false): Option<MatchData>
```

Function: Finds the first matching subsequence.

Parameters:

- input: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The sequence to be matched.
- group!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Specifies whether to enable capture group extraction.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[MatchData](regex_package_structs.md#struct-matchdata)> - Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[MatchData](regex_package_structs.md#struct-matchdata)> if matched, otherwise returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[MatchData](regex_package_structs.md#struct-matchdata)>.None.

Exceptions:

- [RegexException](regex_package_exceptions.md#class-regexexception) - Throws exception when matching exists but fails to extract matching information.

Example:

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    let r1 = Regex("ab")
    let r2 = Regex("ab", IgnoreCase)
    match (r1.find("aB")) {
        case Some(r) => println(r.matchString())
        case None => println("None")
    }
    match (r2.find("aB")) {
        case Some(r) => println(r.matchString())
        case None => println("None")
    }
}
```

Execution Result:

```text
None
aB
```

### func findAll(String, Bool)

```cangjie
public func findAll(input: String, group!: Bool = false): Array<MatchData>
```

Function: Matches the entire input sequence and finds all matching subsequences.

Parameters:

- input: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The sequence to be matched.
- group!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Specifies whether to enable capture group extraction.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[MatchData](regex_package_structs.md#struct-matchdata)> - Array storing matching results. Returns empty array if no match is found.

Exceptions:

- [RegexException](regex_package_exceptions.md#class-regexexception) - Throws exception when matching exists but fails to extract matching information.

Example:

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    let r = Regex("ab")
    let arr = r.findAll("ababaaab")
    let iter = arr.iterator()
    println(arr.size)
    while (true) {
        match (iter.next()) {
            case Some(i) => println(i.matchString())
            case None => break
        }
    }
}
```

Execution Result:

```text
3
ab
ab
ab
```

### func getNamedGroups()

```cangjie
public func getNamedGroups(): Map<String, Int64>
```

Function: Gets the name-to-index mapping of named capture groups.

Return Value:

- [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v)\<[String](../../core/core_package_api/core_package_structs.md#struct-string), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> - Name-to-index mapping of named capture groups.

Example:

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    let r = Regex(#"(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})"#)
    let arr = r.findAll("2024-10-24&2025-01-01", group: true)
    for (md in arr) {
        println("# found: `${md.matchString()}` and groupCount: ${md.groupCount()}")
        for ((name, index) in r.getNamedGroups()) {
            println("${name} => ${index}")
        }
    }
}
```

Execution Result:

```text
# found: `2024-10-24` and groupCount: 3
day => 3
month => 2
year => 1
# found: `2025-01-01` and groupCount: 3
day => 3
month => 2
year => 1
```

### func lazyFindAll(String, Bool)

```cangjie
public func lazyFindAll(input: String, group!: Bool = false): Iterator<MatchData>
```

Function: Matches the entire input sequence and obtains a matching iterator.

Parameters:

- input: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The sequence to be matched.
- group!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Specifies whether to enable capture group extraction.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<[MatchData](regex_package_structs.md#struct-matchdata)> - Matching iterator.

Example:

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    let r = Regex(#"(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})"#)
    let iter = r.lazyFindAll("2024-10-24&2025-01-01", group: true)
    while (true) {
        match (iter.next()) {
            case Some(md) =>
                println("# found: `${md.matchString()}` and groupCount: ${md.groupCount()}")
                for ((name, index) in r.getNamedGroups()) {
                    println("${name} => ${index}")
                }
            case None => break
        }
    }
}
```

Execution Result:

```text
# found: `2024-10-24` and groupCount: 3
day => 3
month => 2
year => 1
# found: `2025-01-01` and groupCount: 3
day => 3
month => 2
year => 1
```

### func matcher(String) <sup>(deprecated)</sup>

```cangjie
public func matcher(input: String): Matcher
```

Function: Creates a matcher.

> **Note:**
>
> Will be deprecated in future versions.

Parameters:

- input: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be matched.

Return Value:

- [Matcher](#class-matcher-deprecated) - The created matcher.

### func matches(String)

```cangjie
public func matches(input: String): Bool
```

Function: Determines whether the input parameter matches the regular expression.

Parameters:

- input: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string to be matched.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if matched, otherwise returns false.

Example:

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    let r = Regex(#"(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})"#)
    println(r.matches("2024-10-24&2025-01-01"))
}
```

Execution Result:

```text
true
```

### func replace(String, String)

```cangjie
public func replace(input: String, replacement: String): String
```

Function: Replace the first matched subsequence from the start of the current string with the target string.

Parameters:

- input: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The sequence to be matched.
- replacement: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The specified replacement string.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string after replacement.

Example:

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    let r = Regex(#"(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})"#)
    println(r.replace("2024-10-24&2025-01-01", "time"))
}
```

Execution Result:

```text
time&2025-01-01
```

### func replace(String, String, Int64)

```cangjie
public func replace(input: String, replacement: String, index: Int64): String
```

Function: Match the regular expression starting from the specified index position of the input sequence and replace the first matched subsequence with the target string.

Parameters:

- input: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The sequence to be matched.
- replacement: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The specified replacement string.
- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The starting position for matching.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string after replacement.

Exceptions:

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Thrown when the index is less than 0 or greater than or equal to the size of the input sequence.

Example:

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    let r = Regex(#"(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})"#)
    println(r.replace("2024-10-24&2025-01-01", "time", 10))
}
```

Execution Result:

```text
2024-10-24&time
```

### func replaceAll(String, String)

```cangjie
public func replaceAll(input: String, replacement: String): String
```

Function: Replace all subsequences in the input sequence that match the regular expression with the given target string.

Parameters:

- input: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The sequence to be matched.
- replacement: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The specified replacement string.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string after replacement.

Example:

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    let r = Regex(#"(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})"#)
    println(r.replaceAll("2024-10-24&2025-01-01", "time"))
}
```

Execution Result:

```text
time&time
```

### func replaceAll(String, String, Int64)

```cangjie
public func replaceAll(input: String, replacement: String, limit: Int64): String
```

Function: Replace the first `limit` subsequences in the input sequence that match the regular expression with the given replacement string.

Parameters:

- input: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The sequence to be matched.
- replacement: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The specified replacement string.
- limit: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of replacements. If `limit` is 0, the original sequence is returned; if `limit` is negative, replacements will be performed as many times as possible.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string after replacement.

Example:

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    let r = Regex(#"(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})"#)
    println(r.replaceAll("2019-4-5&2024-10-24&2025-01-01", "time", 10))
}
```

Execution Result:

```text
2019-4-5&time&time
```

### func split(String)

```cangjie
public func split(input: String): Array<String>
```

Function: Split the given input sequence into multiple subsequences based on the regular expression as much as possible.

Parameters:

- input: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The sequence to be matched.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - An array of subsequences.

Example:

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    let r = Regex("&")
    for (subStr in r.split("2019-4-5&2024-10-24&2025-01-01")) {
        println(subStr)
    }
}
```

Execution Result:

```text
2019-4-5
2024-10-24
2025-01-01
```

### func split(String, Int64)

```cangjie
public func split(input: String, limit: Int64): Array<String>
```

Function: Split the given input sequence into multiple subsequences based on the regular expression as much as possible (up to `limit` substrings).

Parameters:

- input: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The sequence to be matched.
- limit: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The maximum number of substrings to split into.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - If `limit > 0`, returns up to `limit` substrings; if `limit <= 0`, returns the maximum possible number of substrings.

### func string()

```cangjie
public func string(): String
```

Function: Get the input sequence of the regular expression.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The input sequence.

## class RegexOption <sup>(deprecated)</sup>

```cangjie
public class RegexOption <: ToString {
    public init()
}
```

Function: Used to specify the matching mode for regular expressions.

> **Note:**
>
> This will be deprecated in future versions. Use [RegexFlag](regex_package_enums.md#enum-regexflag) instead.

Parent Type:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### init()

```cangjie
public init()
```

Function: Create a [RegexOption](#class-regexoption-deprecated) instance with the matching mode set to normal (NORMAL).

### func ignoreCase()

```cangjie
public func ignoreCase(): RegexOption
```

Function: Modify the [RegexOption](#class-regexoption-deprecated) to set the matching mode to case-insensitive (IGNORECASE).

Return Value:

- [RegexOption](#class-regexoption-deprecated) - The modified [RegexOption](#class-regexoption-deprecated).

### func multiLine()

```cangjie
public func multiLine(): RegexOption
```

Function: Modify the [RegexOption](#class-regexoption-deprecated) to set the matching mode to multi-line text mode (MULTILINE).

Return Value:

- [RegexOption](#class-regexoption-deprecated) - The modified [RegexOption](#class-regexoption-deprecated).

### func toString()

```cangjie
public func toString(): String
```

Function: Get the current regular expression matching mode represented by the [RegexOption](#class-regexoption-deprecated).

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The regular expression matching mode.