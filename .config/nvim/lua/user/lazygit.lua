-- Open lazygit in a floating window
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
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open Lazy[G]it" }
  }
}

function M.config()
  local status_ok, lazygit = pcall(require, "lazygit")
  if not status_ok then
    print 'Lazygit not loaded'
    return
  end

  -- lazygit.setup{}
end

return M
