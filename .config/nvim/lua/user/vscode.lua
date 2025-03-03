-- A port of the popular vscode theme.
local M = {
  "Mofiqul/vscode.nvim",
  lazy = false,
  priority = 1000,
  commit = "298c5ce4750a256ea208b72d7a472b8824ef2a49",
  -- commit = "39841d05ab4a5c03ea0985196b9f3dfa48d83411",
}

function M.config()
  vim.g.vscode_italic_comment = true
  vim.g.vscode_disable_nvimtree_bg = true

  local wk = require "which-key"
  wk.add ({
    { "<leader>vd", "<cmd>lua require('vscode').load('dark')<cr>",  desc = "VS Code [D]ark" },
    { "<leader>vl", "<cmd>lua require('vscode').load('light')<cr>", desc = "VS Code [L]ight" },
  }, opts)
end

return M
