# nvstl

**nvstl** is a Neovim plugin that allows you to use NvChad's statusline outside of NvChad.

## Features

- Integrate NvChad's statusline into your custom Neovim configuration.
- Easy setup with minimal configuration required.
- Leverages the power of `base46` for themes and styling.

## Requirements

- [Neovim](https://github.com/neovim/neovim) 0.8 or later
- [base46](https://github.com/richardhbtz/base46) (a dependency of nvstl)

## Installation
### Using [lazy.nvim](https://github.com/folke/lazy.nvim)


```lua
{
    "richardhbtz/nvstl",
    config = function()
        require("nvstl").setup {}
    end,
    dependencies = {
        "richardhbtz/base46"
    }
},
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
require('packer').startup(function()
    use {
        "richardhbtz/nvstl",
        config = function()
            require("nvstl").setup {}
        end,
        requires = {
            "richardhbtz/base46"
        }
    }
end)
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
call plug#begin('~/.local/share/nvim/plugged')

Plug 'richardhbtz/base46'
Plug 'richardhbtz/nvstl'

call plug#end()

lua << EOF
require("nvstl").setup {}
EOF
```