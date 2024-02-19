local M = {
  "mbbill/undotree",
}

function M.config()
  vim.g.undotree_WindowLayout = 2
  vim.g.undotree_SplitWidth = 45
  vim.g.undotree_DiffpanelHeight = 20

  local wk = require "which-key"
  wk.register {
    ["<leader>u"] = { "<cmd>UndotreeToggle<cr>", "[U]ndo Tree" },
  }

end

return M
