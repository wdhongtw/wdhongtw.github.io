---
title: Bash Variable Life Cycle
date: 2017-06-09 21:55:12
tags: [Bash, Language, Note]
---

# Variables in Shell Environment

## Environment Variables and Sell Variables

## Set and Unset Variables

Declare shell variable.

``` sh
VAR=
declare VAR=

# not VAR or declare VAR
unset VAR
```

Declare environment variable.

``` sh
export VAR=
declare -x VAR=

unset VAR
```

Export/unexport shell variable into/from environment variable.

``` sh
# declare VAR=
export VAR

export -n VAR
```

### Three States (Life Cycle) of Varaible

- `unset var`: The variable is not set yet, every variable begin at this state.
- `shell var`: The variable is set but will not be exported to subsequent
  commands. Only accessible within this shell.
- `environment var`: The variable is set and will be exported to subsquent
  commands.

```
   -----------------------------------------------------
   |                export VAR=                        |
   |                                                   v
---------    VAR=      ---------   export VAR     ---------------
| unset | -----------> | shell | ---------------> | environment |
|  var  | <----------- |  var  | <--------------- |     var     |
---------   unset VAR  ---------   export -n VAR  ---------------
   ^                                                   |
   |                 unset VAR                         |
   -----------------------------------------------------
```

## Empty Variables vs Unset Variables

### Detect Unset Variable

## Links

- http://stackoverflow.com/questions/12262696/using-unset-vs-setting-a-variable-to-empty
- http://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash

