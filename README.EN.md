# rupilot.nvim
This is a minimal battle-used vim plugin to work with Rupilot.
Plugin is based on nui (modern UI toolkit) and lua only approach for making a nvim plugin.

## Installation

You need to setup RUPILOT_KEY as your env variable. 
You can add `export RUPILOT_KEY=` to your .bashrc or .zshrc. And don't forget apply changes - `source ~/.zshrc`
For you OS it's all up to you how to do it.
If you don't have RUPILOT_KEY, you should visit https://rupilot.ru and create a new one.

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

---

To open input field for Rupilot command - `<leader>aa`

You can select any block of code and run - `<leader>ae`
After you should add a command to rupilot, what should you do with selected code.
