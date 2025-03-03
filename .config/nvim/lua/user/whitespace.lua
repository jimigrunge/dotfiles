-- A plugin for managing whitespace.
local M = {
  "mcauley-penney/tidy.nvim",
  -- commit = "",
}

function M.config()
  local status_ok, tidy = pcall(require, "tidy")
  if not status_ok then
    print 'Tidy not loaded'
    return
  end

  local wk = require "which-key"
  wk.add({
    {"<leader>bs", "<cmd>lua require('tidy').run<cr>", desc="[S]trip Whitespace" },
  }, opts)

  tidy.setup {
    opts = {
      enabled_on_save = false,
      filetype_exclude = {
        'terminal',
        'message',
        'diff',
        'git',
        'gitcommit',
        'unite',
        'qf',
        'help',
        'markdown ',
        'fugitive'
      }
    },
  }
end

return M
