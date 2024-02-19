local M = {
  "linrongbin16/gitlinker.nvim",
  commit = "008d8d7f8218d38bf87ae4c3f61a42843c31a8f1",
}

function M.config()
  local status_ok, gitlinker = pcall(require, "gitlinker")
  if not status_ok then
    print 'Git Linker not loaded'
    return
  end

  local wk = require "which-key"
  wk.register {
    ["<leader>gn"] = { "<cmd>GitLink!<cr>", "GitLi[n]k! in browser" },
  }

  gitlinker.setup({
    message = false,
    console_log = false
  })
end

return M
