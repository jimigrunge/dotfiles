-- A neovim window navigator.
local M = {
  "SmiteshP/nvim-navic",
  dependencies = "neovim/nvim-lspconfig",
  commit = "8649f694d3e76ee10c19255dece6411c29206a54",
}

function M.config()
  local status_ok, navic = pcall(require, "nvim-navic")
  if not status_ok then
    print 'nvim-navic not loaded'
    return
  end

  local icons = require "user.icons"

  navic.setup({
    icons = icons.kind,
    separator = " > "
  })
end

return M
