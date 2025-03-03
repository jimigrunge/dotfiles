-- A vim plugin to display the indention levels with thin vertical lines.
local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  commit = "7a698a1d7ed755af9f5a88733b23ca246ce2df28",
  -- commit = "12e92044d313c54c438bd786d11684c88f6f78cd",
}

function M.config()
  local status_ok, ibl = pcall(require, "ibl")
  if not status_ok then
    print 'Indentline not loaded'
    return
  end

  ibl.setup()

  local icons = require "user.icons"
  local config = require "ibl.config"

  config.update_config({
    enabled = true,
    indent = {
      char = '', --icons.ui.LineDashedMiddle,
      tab_char = icons.ui.Tab,
      highlight = "IblIndent",
      smart_indent_cap = true,
      priority = 1,
      repeat_linebreak = true
    },
    scope = {
      char = nil,
    },
    exclude = {
      -- buftypes = { "terminal", "nofile" },
      filetypes = {
        "help",
        "startify",
        "dashboard",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "lspinfo",
        "packer",
        "checkhealth",
        "man",
        "gitcommit",
        "TelescopePrompt",
        "TelescopeResults",
        "''"
      }
    },
  })
end

return M
