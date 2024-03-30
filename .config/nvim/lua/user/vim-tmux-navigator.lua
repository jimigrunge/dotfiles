-- Seamless navigation between tmux panes and vim splits.
local M = {
  "christoomey/vim-tmux-navigator",
  commit = "38b1d0402c4600543281dc85b3f51884205674b6",
}

function M.config()
  local wk = require "which-key"
  wk.register {
    ["<C-k>"] = { ":TmuxNavigateUp<cr>", "Navigate Up", nops },
    ["<C-j>"] = { ":TmuxNavigateDown<cr>", "Navigate Down", nops },
    ["<C-h>"] = { ":TmuxNavigateLeft<cr>", "Navigate Left", nops },
    ["<C-l>"] = { ":TmuxNavigateRight<cr>", "Navigate Right", nops },
  }
end

return M
