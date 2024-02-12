# rupilot.nvim
This is a minimal battle-used vim plugin to work with Rupilot.
Plugin is based on nui (modern UI toolkit) and lua only approach for making a nvim plugin.

## Installation

Install using lazy.nvim. Note that [nui.nvim](https://github.com/MunifTanjim/nui.nvim) is a requirement.

```lua
-- rupilot.nvim
{
  'Partysun/rupilot.nvim', dependencies = { "MunifTanjim/nui.nvim" }
}
```

## Usage

Run `:Rupilot` without any arguments to get a search prompt 

or with an argument to search for a term: `:Rupilot python torch create a tensor scalar`
