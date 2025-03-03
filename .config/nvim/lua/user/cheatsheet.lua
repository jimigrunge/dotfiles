-- A plugin for creating and managing cheatsheets.
local M = {
  "sudormrfbin/cheatsheet.nvim",
  commit = "9716f9aaa94dd1fd6ce59b5aae0e5f25e2a463ef",
}

function M.config()
  local status_ok, cheatsheet = pcall(require, "cheatsheet")
  if not status_ok then
    print 'cheatsheet not loaded'
    return
  end

  local wk = require "which-key"
  wk.add({
    {"<leader>?", "<cmd>Cheatsheet<cr>", desc="Cheatsheet" },
  }, opts)

  cheatsheet.setup()
end

return M
