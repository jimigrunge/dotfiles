-- A plugin for opening files and line numbers on GitHub, Bitbucket, Gitlab, and Gitea from neovim.
local M = {
  "linrongbin16/gitlinker.nvim",
  commit = "296ad98061ca31706a7d890a0f13baed6e137c79",
  -- commit = "008d8d7f8218d38bf87ae4c3f61a42843c31a8f1",
}

function M.config()
  local status_ok, gitlinker = pcall(require, "gitlinker")
  if not status_ok then
    print 'Git Linker not loaded'
    return
  end

  local wk = require "which-key"
  wk.add({
    {"<leader>gn", "<cmd>GitLink!<cr>", desc="GitLi[n]k! in browser" },
  }, opts)

  gitlinker.setup({
    message = false,
    console_log = false
  })
end

return M
