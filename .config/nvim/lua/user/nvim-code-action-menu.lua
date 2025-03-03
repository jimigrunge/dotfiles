-- A plugin for showing code actions in a floating window.
local M = {
  "weilbith/nvim-code-action-menu",
  cmd = 'CodeActionMenu',
  commit = "8c7672a4b04d3cc4edd2c484d05b660a9cb34a1b",
}

function M.config()
  local status_ok, actionspreview = pcall(require, "nvim-code-action-menu")
  if not status_ok then
    print 'Code Action Menu not loaded'
    return
  end

  local wk = require "which-key"
  wk.add({
    {"<leader>la", "<cmd>CodeActionMenu<cr>", desc="Code [A]ction" },
  }, opts)

  actionspreview.setup()
end

return M
