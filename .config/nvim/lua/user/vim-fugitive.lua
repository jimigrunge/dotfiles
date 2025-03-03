-- A git wrapper for neovim.
local M = {
  "tpope/vim-fugitive",
  commit = "174230d6a7f2df94705a7ffd8d5413e27ec10a80",
  -- commit = "59659093581aad2afacedc81f009ed6a4bfad275",
}

function M.config()
  local wk = require "which-key"
  wk.add({
    {"<leader>ga", "<cmd>Git add -p<cr>", desc="Git [a]dd -p" },
    {"<leader>gA", "<cmd>Git add .<cr>", desc="Git add . ([A]ll)" },
    {"<leader>gc", "<cmd>Git commit<cr>", desc="Git [c]ommit" },
    {"<leader>gl", "<cmd>Git blame<cr>", desc="B[l]ame" },
    {"<leader>gt", "<cmd>Git status<cr>", desc="S[t]atus" },
  }, opts)
end

return M
