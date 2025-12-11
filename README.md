# Hermes

Hermes is a parser combinator library I created for three main reasons:  
1. To learn about parser combinators.  
2. To parse SMS messages from my bank and output them in a hledger-compatible text format for easy syncing and reporting.  
3. To explore the C Lua API.  

There is also an interactive playground available [here](link).

## Features

- **Hybrid Implementation**: Core parsers implemented in C for speed, with Lua providing flexible combinators and utilities.
- **Parser Combinators**: Easily combine parsers with methods like one_or_more, zero_or_more, pair, and_then, or_else, and more.
- **Recursive Parsing**: Supports lazy evaluation to define mutually recursive parsers.
- **Whitespace Handling**: Convenient helpers for parsing spaces, tabs, and other whitespace.
- **Quoted Strings and Identifiers**: Built-in support for parsing quoted strings and identifiers.
- **Debugging Utilities**: Inspect parse trees and attach debug functions to parsers.

## Parser API
### Core Parsers (Implemented in C)
| Function                     | Description                                                    |
| ---------------------------- | -------------------------------------------------------------- |
| `any_char()`                 | Parses any single character.                                   |
| `literal(s)`                 | Parses a literal string `s`.                                   |
| `lazy(parser_f)`             | Lazily evaluates a parser, useful for recursive definitions.   |
| `Parser:drop_for(taken)`     | Runs parser, discards its result, then runs `taken`.           |
| `Parser:take_after(ignored)` | Runs parser, then runs `ignored` and returns the first result. |
| `Parser:map(f)`              | Transforms the result using function `f`.                      |
| `Parser:and_then(f)`         | Chains another parser based on the result of this one.         |
| `Parser:or_else(alt)`        | Tries this parser, if it fails tries alternative `alt`.        |
| `Parser:pred(f)`             | Accepts result only if predicate `f` returns `true`.           |
| `Parser:pair(p)`             | Combines two parsers into a pair of results.                   |
| `Parser:debug(f)`            | Attaches a debug function to inspect parsing progress.         |
| `Parser:parse(input)`        | Executes the parser on the input string.                       |

### Lua Parsers and Utilities
| Function                    | Description                                                 |
| --------------------------- | ----------------------------------------------------------- |
| `whitespace_char()`         | Consumes a single whitespace character.                     |
| `space0()`                  | Consumes zero or more whitespace characters.                |
| `space1()`                  | Consumes one or more whitespace characters.                 |
| `quoted_string()`           | Parses a quoted string and returns the unquoted value.      |
| `identifier()`              | Parses identifiers starting with letters or underscores.    |
| `pure(value)`               | Lifts a literal value to a parser.                          |
| `consume_until(mark)`       | Consumes input until a given marker.                        |
| `inspect(parser, indent)`   | Returns a string representation of the parser’s parse tree. |
| `set_inspect(parser, desc)` | Sets a custom description for `inspect()`.                  |

### Utilites
| Function                     | Description                       |
| ---------------------------- | --------------------------------- |
| `utils.print(table, indent)` | Pretty prints a table.            |
| `utils.tables_equal(t1, t2)` | Compares two tables for equality. |

### Examples

#### Recursive Parsing
``` lua
local p
p = parser.lazy(function()
  return parser.literal("a"):or_else(p)
end)

print(p:parse("aaaab"))  -- → "aaaa", "b"

```

#### Debuging
``` lua
local p = parser.identifier():debug(function(result, rest)
    print("Result:", result)
    print("Remaining:", rest)
end)
p:parse("variable_name rest")  

```

## License

This project is MIT licensed. See LICENSE

for details.
