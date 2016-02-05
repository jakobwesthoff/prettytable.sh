# PrettyTable

*PrettyTable* is a simple shell implementation to draw nice looking ascii
tables with auto sizing columns to the screen.

## Prerequisites

The `column` utillity as well as `sed` are needed for this script to work.

The implementation has been tested using *bash* as well as *zsh*.

## Usage

You may either source the `prettytable.sh` file or use it as an executable.
Both works just fine.

Multiline table data is simply piped into `prettytable` for formating, while
the number of columns needs to be specified. Columns need to be delimited using
a `\t` (Tab) character.

## Example

```bash
{
 printf 'PID\tUSER\tAPPNAME\n';
 printf '%s\t%s\t%s\n' "1" "john" "foo bar";
 printf '%s\t%s\t%s\n' "12345678" "someone_with_a_long_name" "blub blib blab bam boom";
} | prettytable 3
```

```
┌──────────┬──────────────────────────┬─────────────────────────┐
│PID       │USER                      │APPNAME                  │
├──────────┼──────────────────────────┼─────────────────────────┤
│1         │john                      │foo bar                  │
│12345678  │someone_with_a_long_name  │blub blib blab bam boom  │
└──────────┴──────────────────────────┴─────────────────────────┘
```
