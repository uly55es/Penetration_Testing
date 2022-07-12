# Regular Expressions

## Table of Contents
- [Test Methods](#test-methods)
- [Charsets](#charsets)
- [Wildcards and optional characters](#wildcards-and-optional-characters)
- [Metacharacters and repetitions](#metacharacters-and-repetitions)
- [Starts with](#starts-with)
- [Ends with](#ends-with)
- [Define Groups](#define-groups)
  + [Either Or Pattern](#either-or-pattern)

Patterns of text that you define to search documents and match exactly what you're looking for.

## Test Methods

Two test methods:

```bash
egrep <pattern> <file>
```

[Regex Online Editor](https://regexr.com/)

***

## Charsets

Useful when searching for **patterns of text**

Charset is defined by enclosing in `[` square brackets `]`

> `[abc]` will match `a`, `b`, and `c` (every occurrence of each letter)

> `[abc]zz` will match `azz`, `bzz`, and `czz`

Can define ranges with `-`: 

> `[a-c]zz` is same as above

Combine ranges together: 

> `[a-cx-z]zz` will match `azz`, `bzz`, `czz`, `xzz`, `yzz`, and `zzz`

Can be used to match any alphabetical character:

> `[a-zA-Z]` will match any **single** letter (lowercase or uppercase)

Numbers can be used as well:

> `file[1-3]` will match `file1`, `file2`, and `file3`

**Exclude** characters from a charset with the `^` hat symbol:

> `[^k]ing` will match `ring`, `sing`, `$ing`, but **not** `king`

Can also exclude charsets, not just single characters:

> `[^a-c]at` will match `fat` and `hat`, but not `bat` or `cat`

***

## Wildcards and optional characters

Wildcard used to match any aingle character is the `.` dot:

> `a.c` will match `aac`, `abc`, `a0c`, `a!c`, etc.

Set a character as optional with `?`:

> `abc?` will match `ab`, and `abc`; the `c` is optional

*NOTE:* to search for a `.` literal dot, escape it with `\` reverse slash:

> `a\.c` will match `a.c`

***

## Metacharacters and repetitions

Ways to match bigger character sets

`\d` matches a digit, like `9`

`\D` matches a non-digit, like `A` or `@`

`\w` matches an alphanumeric character, like `a` or `3`

 > **will match `_` metacharacter**

`\W` matches a non-alphanumeric character, like `!` or `#`

`\s` matches a whitespace character (spaces, tabs, and line breaks)

`\S` matches everything else (alphanumeric characters and symbols)

With repetitions, can match many characters of a single type in a row.

> `z{2}` will match exactly `zz`

`{12}` - exactly 12 times

`{1,5}` - 1 to 5 times

`{2,}` - two or more times

`*` - 0 or more times

`+` - one or more times

***

## Starts with

Specify to search by a certain pattern in the beginning of a line

`^` - starts with

> To search for a line that starts with `abc`, can use `^abc`

***

## Ends with

Specify to search by a certain pattern at the end of a line

`$` - ends with

> To search for a line that ends with `xyz`, can use `xyz$`

***

## Define Groups

Define groups by enclosing a pattern in `(`parentheses`)`

### Either Or Pattern

Use `|` pipe in Regex to say "or"

> `during the(day|night)` will match both `during the day` and `during the night`

> `(no){5}` will match `nonononono`


