-- Highlight the current line and column for LSP clients.
local M = {
  "ErichDonGubler/lsp_lines.nvim",
  commit = "3b57922d2d79762e6baedaf9d66d8ba71f822816",
}

function M.config()
  local status_ok, lsp_lines = pcall(require, "lsp_lines")
  if not status_ok then
    print 'lsp_lines not loaded'
    return
  end

  local wk = require "which-key"
  wk.add({
    {"<leader>lE", "<cmd>lua require('lsp_lines').toggle()<cr>", desc="Line diagnostic [E]rror" },
  }, opts)

  lsp_lines.setup()
end

return M
