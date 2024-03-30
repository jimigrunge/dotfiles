-- A git diff viewer.
local M = {
  "sindrets/diffview.nvim",
  event = "BufRead",
  dependencies = "nvim-lua/plenary.nvim",
  commit = "3dc498c9777fe79156f3d32dddd483b8b3dbd95f",
}

function M.config()
  local wk = require "which-key"
  wk.register {
    ["<leader>gdc"] = { "<cmd>DiffviewClose<cr>", "Diff View [C]lose" },
    ["<leader>gdf"] = { "<cmd>DiffviewFileHistory<cr>", "[F]ile History" },
    ["<leader>gdo"] = { "<cmd>DiffviewOpen<cr>", "Diff View [O]pen" },
  }
end

return M
