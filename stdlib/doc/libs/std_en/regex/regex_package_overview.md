# std.regex

## Functionality Overview

The regex package provides text analysis and processing capabilities using regular expressions, supporting functions such as searching, splitting, replacing, and validation.

### Regex Rule Set

The current Cangjie regular expressions only support the following rules. Using unsupported rules will result in output that does not match expectations.

| Character | Description |
| :-------: | ----------- |
| `\` | Marks the next character as a special character (File Format Escape, see list in this table), a literal character (Identity Escape, including `^$()*+?.[{\|` totaling 12 characters), or a backreference. For example, "n" matches the character "n". `\n` matches a newline character. The sequence `\\` matches `\`, while `\(` matches `(`. |
| `^` | Matches the starting position of the input string. If the multiLine() option in RegexOption is set, ^ also matches positions after `\n` or `\r`. |
| `$` | Matches the ending position of the input string. |
| `*` | Matches the preceding subexpression zero or more times. For example, `zo*` matches `z`, `zo`, and `zoo`. `*` is equivalent to `{0,}`. |
| `+` | Matches the preceding subexpression one or more times. For example, `zo+` matches `zo` and `zoo` but not `z`. `+` is equivalent to `{1,}`. |
| `?` | Matches the preceding subexpression zero or one time. For example, `do(es)?` matches `do` in `does` and `does`. `?` is equivalent to `{0,1}`. |
| `{n}` | n is a non-negative integer. Matches exactly n times. For example, `o{2}` does not match `o` in `Bob` but matches the two `o`s in `food`. |
| `{n,}` | n is a non-negative integer. Matches at least n times. For example, `o{2,}` does not match `o` in `Bob` but matches all `o`s in `foooood`. `o{1,}` is equivalent to `o+`. `o{0,}` is equivalent to `o*`. |
| `{n,m}` | m and n are non-negative integers where n<=m. Matches at least n and at most m times. For example, `o{1,3}` matches the first three `o`s in `fooooood`. `o{0,1}` is equivalent to `o?`. Note: No spaces are allowed between the comma and numbers. |
| `?` | Non-greedy quantifiers: When this character follows any other repetition modifier (*, +, ?, {n}, {n,}, {n,m}), the matching mode is non-greedy. Non-greedy mode matches as few characters as possible, while the default greedy mode matches as many as possible. For example, for the string `oooo`, `o+?` matches a single `o`, while `o+` matches all `o`s. |
| `.` | Matches any single character except `\n`. To match any character including `\n`, use a pattern like `(.|\n)`. |
| `(pattern)` | Matches pattern and captures the substring. The captured substring can be used for backreferences. The matches can be obtained from the resulting Matches collection. To match parentheses, use `\(` or `\)`. Can be followed by a quantifier. |
| `x\|y` | When not enclosed in (), the scope is the entire regex. For example, `z\|food` matches `z` or `food`. `(?:z\|f)ood` matches `zood` or `food`. |
| `[xyz]` | Character class. Matches any one of the enclosed characters. For example, `[abc]` matches `a` in `plain`. Only the backslash \ retains its special meaning for escaping. Other special characters like asterisk, plus, and various brackets are treated as literals. The caret ^ indicates a negated character class if it appears first; otherwise, it's treated as a literal. The hyphen - indicates a character range if it appears in the middle; otherwise, it's treated as a literal. The right bracket ] should be escaped or appear as the first character. |
| `[^xyz]` | Negated character class. Matches any character not listed. For example, `[^abc]` matches `plin` in `plain`. |
| `[a-z]` | Character range. Matches any character in the specified range. For example, `[a-z]` matches any lowercase letter from `a` to `z`. |
| `[^a-z]` | Negated character range. Matches any character not in the specified range. For example, `[^a-z]` matches any character not between `a` and `z`. |
| `\b` | Matches a word boundary (the position between a word and a space). For example, `er\b` matches `er` in `never` but not in `verb`. |
| `\B` | Matches a non-word boundary. `er\B` matches `er` in `verb` but not in `never`. |
| `\d` | Matches a digit character. Equivalent to `[0-9]`. |
| `\D` | Matches a non-digit character. Equivalent to `[^0-9]`. |
| `\f` | Matches a form feed. Equivalent to `\x0c`. |
| `\n` | Matches a newline. Equivalent to `\x0a`. |
| `\r` | Matches a carriage return. Equivalent to `\x0d`. |
| `\s` | Matches any whitespace character (space, tab, form feed, etc.). Equivalent to `[\f\n\r\t\v]`. |
| `\S` | Matches any non-whitespace character. Equivalent to `[^\f\n\r\t\v]`. |
| `\t` | Matches a tab. Equivalent to `\x09`. |
| `\v` | Matches `\n\v\f\r\x85`. |
| `\w` | Matches any word character (including underscore). Equivalent to `[A-Za-z0-9_]`. |
| `\W` | Matches any non-word character. Equivalent to `[^A-Za-z0-9_]`. |
| `\xnm` | Hexadecimal escape sequence. Matches the character represented by the two hexadecimal digits nm. For example, `\x41` matches `A`. ASCII codes can be used in regex. |
| `\num` | Back-reference to a substring that matches the num-th parenthesized capture group in the regex. num is a positive decimal integer starting from 1, with a maximum of 63 capture groups in Regex. For example, `(.)\1` matches two consecutive identical characters. |
| `(?:pattern)` | Matches pattern but does not capture the substring (shy groups). This is useful for combining parts of a pattern with the OR operator `(\|)`. |
| `(?=pattern)` | Positive lookahead assertion. Matches the search string at any position where pattern starts. This is a non-capturing match. For example, `Windows(?=95\|98\|NT\|2000)` matches `Windows` in `Windows2000` but not in `Windows3.1`. Lookaheads do not consume characters. |
| `(?!pattern)` | Negative lookahead assertion. Matches the search string at any position where pattern does not start. This is a non-capturing match. For example, `Windows(?!95\|98\|NT\|2000)` matches `Windows` in `Windows3.1` but not in `Windows2000`. Lookaheads do not consume characters. |
| `(?<=pattern)` | Positive lookbehind assertion. Similar to positive lookahead but in reverse. For example, `(?<=95\|98\|NT\|2000)Windows` matches `Windows` in `2000Windows` but not in `3.1Windows`. |
| `(?<!pattern)` | Negative lookbehind assertion. Similar to negative lookahead but in reverse. For example, `(?<!95\|98\|NT\|2000)Windows` matches `Windows` in `3.1Windows` but not in `2000Windows`. |
| `(?i)` | Specifies case-insensitive matching for part of the rule. Currently, Regex only supports global case-insensitive matching. When this option is specified, it is treated as global case-insensitive. |
| `(?-i)` | Specifies case-sensitive matching for part of the rule. Currently, Regex defaults to case-sensitive matching. This option is only for compilation compatibility and has no effect on sensitivity. |
| `+` | A standalone plus sign, not the escaped `\+`. |
| `*` | A standalone asterisk, not the escaped `\*`. |
| `-` | A standalone hyphen, not the escaped `\-`. |
| `]` | A standalone right bracket, not the escaped `\]`. |
| `}` | A standalone right brace, not the escaped `\}`. |
| `[[:alpha:]]` | Matches any alphabetic character (uppercase or lowercase). |
| `[[:^alpha:]]` | Matches any character except alphabetic characters. |
| `[[:lower:]]` | Matches any lowercase letter. |
| `[[:^lower:]]` | Matches any character except lowercase letters. |
| `[[:upper:]]` | Matches any uppercase letter. |
| `[[:^upper:]]` | Matches any character except uppercase letters. |
| `[[:digit:]]` | Matches any single digit from 0 to 9. |
| `[[:^digit:]]` | Matches any character except digits from 0 to 9. |
| `[[:xdigit:]]` | Matches hexadecimal digits (letters and numbers). |
| `[[:^xdigit:]]` | Matches any character except hexadecimal digits. |
| `[[:alnum:]]` | Matches any alphanumeric character (letters or digits). |
| `[[:^alnum:]]` | Matches any character except alphanumeric characters. |
| `[[:space:]]` | Matches any whitespace character (space, tab, etc.). |
| `[[:^space:]]` | Matches any character except whitespace. |
| `[[:punct:]]` | Matches any punctuation character. |
| `[[:^punct:]]` | Matches any character except punctuation. |

In Cangjie, there are some special rules:

1. When the character preceding `?`, `+`, or `*` cannot be quantified, these symbols are ignored. Exception: When `(*`, `|*`, or `*` appears at the start, `*` is treated as a literal character.

2. `*?` will fail to match the string composed of all characters preceding `*?`.

3. The maximum number of capture groups in a regex is 63, and the maximum compiled rule length is 65535.

4. Currently unsupported scenario: `((pattern1){m1,n1}pattern2){m2,n2}`, where:
   - Group definition 1 is modified by `{m1,n1}`;
   - Group definition 1 is wrapped by group definition 2;
   - Group definition 2 is modified by `{m2,n2}`.

5. The input string must not contain `\0`, otherwise unexpected results may occur, including infinite loops.

> **Warning:**
>
> The current implementation does not limit the minimum or maximum repetition counts for rules like `{n}`, `{n,}`, or `{n,m}`. Excessive repetition counts may cause the regex matcher to consume excessive CPU and memory resources, potentially triggering stack overflow exceptions or leading to prolonged execution times or ReDoS attacks.

## API List

### Classes

| Class Name | Function |
| ---------- | -------- |
| [Matcher <sup>(deprecated)</sup>](./regex_package_api/regex_package_classes.md#class-matcher-deprecated) | Regex matcher for scanning and matching input sequences. |
| [Regex](./regex_package_api/regex_package_classes.md#class-regex) | Specifies compilation types and input sequences. |
| [RegexOption <sup>(deprecated)</sup>](./regex_package_api/regex_package_classes.md#class-regexoption-deprecated) | Specifies regex matching modes. |

### Enums

| Enum Name | Function |
| --------- | -------- |
| [RegexFlag](./regex_package_api/regex_package_enums.md#enum-regexflag) | Specifies regex matching modes. |

### Structs

| Struct Name | Function |
| ----------- | -------- |
| [MatchData](./regex_package_api/regex_package_structs.md#struct-matchdata) | Stores regex matching results and provides query functions. |
| [Position](./regex_package_api/regex_package_structs.md#struct-position) | Stores position information as a half-open interval. |

### Exception Classes

| Exception Class Name | Function |
| -------------------- | -------- |
| [RegexException](./regex_package_api/regex_package_exceptions.md#class-regexexception) | Provides regex-related exception handling. |