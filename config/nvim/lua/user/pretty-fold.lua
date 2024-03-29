-- A plugin to make folds more pretty.
local M = {
  "anuvyklack/pretty-fold.nvim",
  commit = "a7d8b424abe0eedf50116c460fbe6dfd5783b1d5",
  dependencies = {
    "anuvyklack/nvim-keymap-amend",
    commit = "b8bf9d820878d5497fdd11d6de55dea82872d98e",
  }
}

function M.config()
  local status_ok, prettyfold = pcall(require, "pretty-fold")
  if not status_ok then
    print 'Pretty Fold not loaded'
    return
  end

  local icons = require "user.icons"

  prettyfold.setup {
    keep_indentation = true,
    fill_char = icons.ui.Dot,
    sections = {
      left = {
        '+', function() return string.rep('-', vim.v.foldlevel) end,
        ' ', 'number_of_folded_lines', ':', 'content',
      }
    },
    matchup_patterns = {
      { '^%s*do$',       'end' }, -- do ... end blocks
      { '^%s*if',        'end' }, -- if ... end
      { '^%s*for',       'end' }, -- for
      { 'function%s*%(', 'end' }, -- 'function( or 'function (''
      { '{',             '}' },
      { '%(',            ')' },   -- % to escape lua pattern char
      { '%[',            ']' },   -- % to escape lua pattern char
    },
  }
end

return M
