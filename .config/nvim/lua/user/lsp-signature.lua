-- Show function signature when you type.
local M = {
  "ray-x/lsp_signature.nvim",
  commit = "fed2c8389c148ff1dfdcdca63c2b48d08a50dea0",
}

function M.config()
  local status_ok, lsp_signature = pcall(require, "lsp_signature")
  if not status_ok then
    print 'Lsp Signature not loaded'
    return
  end

  local icons = require "user.icons"

  lsp_signature.setup({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded"
    },
    hint_prefix = " " .. icons.ui.BoldDoubleChevronRight .. " ",
    toggle_key = "<C-o>"
  })
end

return M
