local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
  print 'Indentline not loaded'
  return
end
ibl.setup()

local config = require "ibl.config"
config.update_config({
  enabled = true,
  indent = {
    char = "┊",
    tab_char = nil,
    highlight = "IblIndent",
    smart_indent_cap = true,
    priority = 1,
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

