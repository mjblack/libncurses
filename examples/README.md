# NCurses Examples

## Summary

These are very basic examples with their C to show developers how to use the Crystal library. In many cases it is going to be almost a 1 to 1 but with differences in variable/pointer initialization, and looping.

## Environment variables
If your ncurses installation is installed to a different location (if installed using Homebrew) then you will need to use environment variables to let both the C and Crystal compilers know where headers and library files located.
| Variable | Description |
| :------- | :---------- |
| CC       | C compiler to use for C examples |
| CFLAGS   | C compiler flags |
| LDFLAGS  | Linker flags for C examples |
| CRFLAGS  | Crystal compiler flags |
| CRLDFLAGS | Crystal linker flags |

## Examples

| Example | Description |
| :------ | :---------- |
| hello_world | Basic Hello World. |
| menu1 | Basic menu example with selection |
| menu2 | Very basic CUA style menubar |
