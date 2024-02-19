local M = {
  "folke/persistence.nvim",
  commit = "ad538bfd5336f1335cdb6fd4e0b0eebfa6e12f32",
}

function M.config()
  local status_ok, persistence = pcall(require, "persistence")
  if not status_ok then
    print 'persistence not loaded'
    return
  end

  local wk = require "which-key"
  wk.register {
    ["<leader>rs"] = { "<cmd>lua require('persistence').load()<cr>", "[S]ession For Current Directory" },
    ["<leader>rl"] = { "<cmd>lua require('persistence').load({ last = true })<cr>", "[L]ast Session" },
    ["<leader>rq"] = { "<cmd>lua require('persistence').stop()<cr>", "[Q]uit Persistence " },
  }

  persistence.setup()
end

return M
