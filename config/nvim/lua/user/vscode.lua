-- A port of the popular vscode theme.
local M = {
  "Mofiqul/vscode.nvim",
  lazy = false,
  priority = 1000,
  commit = "39841d05ab4a5c03ea0985196b9f3dfa48d83411",
}

function M.config()
  vim.g.vscode_italic_comment = true
  vim.g.vscode_disable_nvimtree_bg = true

  local wk = require "which-key"
  wk.register {
      ["<leader>vd"] = { "<cmd>lua require('vscode').change_style('dark')<cr>", "VS Code [D]ark" },
      ["<leader>vl"] = { "<cmd>lua require('vscode').change_style('light')<cr>", "VS Code [L]ight" },
  }
end

return M
