-- Persist variables across sessions.
local M = {
  "folke/persistence.nvim",
  commit = "f6aad7dde7fcf54148ccfc5f622c6d5badd0cc3d",
  -- commit = "ad538bfd5336f1335cdb6fd4e0b0eebfa6e12f32",
}

function M.config()
  local status_ok, persistence = pcall(require, "persistence")
  if not status_ok then
    print 'persistence not loaded'
    return
  end

  local wk = require "which-key"
  wk.add({
    {"<leader>rs", "<cmd>lua require('persistence').load()<cr>", desc="[S]ession For Current Directory" },
    {"<leader>rS", "<cmd>lua require('persistence').start()<cr>", desc="[S]tart Persistence" },
    {"<leader>rl", "<cmd>lua require('persistence').load({ last = true })<cr>", desc="[L]ast Session" },
    {"<leader>rq", "<cmd>lua require('persistence').stop()<cr>", desc="[Q]uit Persistence " },
    {"<leader>rw", "<cmd>lua require('persistence').save()<cr>", desc="[W]rite Session For Current Directory" },
  }, opts)

  persistence.setup()
end

return M
