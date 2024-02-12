if vim.g.loaded_rupilot then
  return
end
vim.g.loaded_rupilot = true
local rupilot = require "rupilot"
rupilot.setup()
