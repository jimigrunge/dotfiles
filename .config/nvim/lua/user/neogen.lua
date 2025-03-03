-- A plugin for generating LSP snippets.
local M = {
  "danymat/neogen",
  commit = "dd0301bfba1f83a3bc009b5430fce7aa3cee6941",
  -- commit = "70127baaff25611deaf1a29d801fc054ad9d2dc1",
}

function M.config()
  local status_ok, neogen = pcall(require, "neogen")
  if not status_ok then
    print 'Neogen not loaded'
    return
  end

  local wk = require "which-key"
  wk.add({
    {"<leader>lc", "<cmd>lua require('neogen').generate()<cr>", desc="[C]reate DocBlock" },
    {"<leader>lD", "<cmd>lua require('neogen').generate()<cr>", desc="[D]ocBloc Annotations" },
  }, opts)

  -- your config here
  neogen.setup {
    enabled = true,             --if you want to disable Neogen
    input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
  }
end

return M
