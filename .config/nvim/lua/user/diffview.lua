-- A git diff viewer.
local M = {
  "sindrets/diffview.nvim",
  event = "BufRead",
  dependencies = "nvim-lua/plenary.nvim",
  commit = "4516612fe98ff56ae0415a259ff6361a89419b0a",
  -- commit = "3dc498c9777fe79156f3d32dddd483b8b3dbd95f",
}

function M.config()
  local wk = require "which-key"
  wk.add({
    {"<leader>gdc", "<cmd>DiffviewClose<cr>", desc="Diff View [C]lose" },
    {"<leader>gdf", "<cmd>DiffviewFileHistory<cr>", desc="[F]ile History" },
    {"<leader>gdo", "<cmd>DiffviewOpen<cr>", desc="Diff View [O]pen" },
  }, opts)
end

return M
