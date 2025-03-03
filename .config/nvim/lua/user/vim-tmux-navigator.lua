-- Seamless navigation between tmux panes and vim splits.
local M = {
  "christoomey/vim-tmux-navigator",
  commit = "d847ea942a5bb4d4fab6efebc9f30d787fd96e65",
  -- commit = "38b1d0402c4600543281dc85b3f51884205674b6",
}

function M.config()
  local wk = require "which-key"
  wk.add({
    {"<C-k>", ":TmuxNavigateUp<cr>", desc="Navigate Up" },
    {"<C-j>", ":TmuxNavigateDown<cr>", desc="Navigate Down" },
    {"<C-h>", ":TmuxNavigateLeft<cr>", desc="Navigate Left" },
    {"<C-l>", ":TmuxNavigateRight<cr>", desc="Navigate Right" },
  }, nopts)
end

return M
