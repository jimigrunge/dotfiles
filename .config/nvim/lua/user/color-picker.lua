-- A color picker for neovim.
local M = {
  "ziontee113/color-picker.nvim",
  commit = "06cb5f853535dea529a523e9a0e8884cdf9eba4d",
}

function M.config()
  local status_ok, colorpicker = pcall(require, "color-picker")
  if not status_ok then
    print 'color-picker not loaded'
    return
  end

  local wk = require "which-key"
  wk.add({
    {"<leader>spc", "<cmd>PickColor<cr>", desc="[C]olor Picker" },
  }, opts)
  wk.add({
    {"<C-c><C-p>", "<cmd>PickColor<cr>", desc="Pick Color" },
  }, nopts)

  colorpicker.setup({})
end

return M
