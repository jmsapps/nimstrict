# Nimstrict

Nimstrict is a tool to enforce case sensitivity in Nim projects by identifying mismatches between identifier declarations and their usage. The intention is to promote conventions locally to aid in such tools as `grep` for faster and more reliable debugging, while still encouraging Nim's global case insensitivity. The philosophy of Nimstrict is that every Nim codebase should be free to adhere to its own conventions, but that those conventions should be strict, enforceable, and internally consistent. This approach becomes crucial as Nim expands in usage, reaching larger production databases with growing teams.

## Features

- Detects case sensitivity inconsistencies in Nim projects.
- Provides warnings for identifier mismatches.
- Works with `.nim` files.

## Getting Started

### Prerequisites

Make sure you have [Nim](https://nim-lang.org/install.html) installed. This README is currently geared towards Unix-like operating systems.

### Installation (without nimble)

Clone the repository:

```bash
git clone git@github.com:jmsapps/nimstrict.git
```

`cd` into the root directory:

```bash
cd nimstrict
```

Build the nimstrict binary using nimble:

```bash
nimble c -r src/nimstrict
```

Copy the build file to the bin directory in your $PATH:

```bash
cp src/nimstrict /usr/local/bin/
```

Now run the binary using the command `nimstrict` from the root directory of any nim project:

```bash
nimstrict
```

### Usage

Take this code block:

```bash
let myVar = "someValue"

echo my_var
```

In the below example you can see that a warning is logged to console giving you the file path, the line number in parentheses, and the mismatch between the declared identifier `myVar` and its redeclaration:

```bash
src/main.nim(3) Warning: mismatch between 'myVar' and redeclaration 'my_var' [IncorrectCase]
```

The line number given here (3) is in reference to the offending redeclaration, as nimstrict will always enforce that you match the original declaration. As such, you may just as easily enforce the opposite convention:

```bash
let my_var = "some_value"

echo myVar
```

Which will in turn give you the following output in console:

```bash
src/main.nim(3) Warning: mismatch between 'my_var' and redeclaration 'myVar' [IncorrectCase]
```

### Supported Identifier Declarations

Nimstrict currently supports parsing of the following identifier declarations:

- var
- let
- const
- proc
- func
- import
- macro
- template

More will likely be added in future versions.

## License

This project is licensed under the GNU General Public License v2.0 - see the LICENSE file for details.

## Acknowledgments

[Nim](https://nim-lang.org/install.html)
