# nnname
Naming features for Torch nn modules

## Installation

```sh
luarock install nnname
```

## Usage

**nnname** adds `find()` `findAll()` `setName()` methods to `nn.Module`, so please require `nn` and `dpnn` (optional) before `nnname` as follows.
Also, it rewrites the `__string()` function to show module name.
The name of a module is store at `.name` variable.

```lua
require 'nn'
require 'dpnn' -- optional
require 'nnname'
```
## API

### [nn.Module] setName(name)
It sets the name of the module to `name` and return the module.

### [nn.Module] find(name, last)
It returns the first nn.Module whose name is `name` in the nn.Container by default. It returns the last module with that specific name when `last` is `true`.

### [table] findAll(name)
It returns a table of modules in the nn.Container whose name is `name`.


## Example
```lua
model = nn.Sequential():setName('net')
    :add(nn.Linear(10, 4):setName('linear'))
    :add(nn.ReLU(true):setName('relu_1'))
    :add(nn.Linear(4, 1):setName('linear'))
    :add(nn.Sigmoid(true):setName('Sigmoid'))

relu = model:find('relu_1') -- get the module with name 'relu_1'

linears = model:findAll('linear') -- get a table of modules with name 'linear'
```
