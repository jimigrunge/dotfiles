local M = {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

function M.config()
  local status_ok, lazygit = pcall(require, "lazygit")
  if not status_ok then
    print "LazyGit not loaded"
    return
  end

  local wk = require "which-key"
  wk.register {
    ["<leader>gg"] = { "<cmd>LazyGit<cr>", "Lazy [G]it" },
  }

  -- your config here
  lazygit.setup()
end

return M
