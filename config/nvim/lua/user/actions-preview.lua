local M = {
  "aznhe21/actions-preview.nvim",
  -- event = "Lazy",
}

function M.config()
  local status_ok, actionspreview = pcall(require, "actions-preview")
  if not status_ok then
    print 'actions-preview not loaded'
    return
  end

  local wk = require "which-key"
  wk.register {
    ["<leader>la"] = { "<cmd>lua require('actions-preview').code_actions<cr>", "Code [A]ction" },
  }

  actionspreview.setup()
end

return M
