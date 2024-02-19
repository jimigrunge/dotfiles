local M = {
  "tpope/vim-fugitive",
  commit = "59659093581aad2afacedc81f009ed6a4bfad275",
}

function M.config()
  local wk = require "which-key"
  wk.register {
    ["<leader>ga"] = { "<cmd>Git add -p<cr>", "Git [a]dd -p" },
    ["<leader>gA"] = { "<cmd>Git add .<cr>", "Git add . ([A]ll)" },
    ["<leader>gc"] = { "<cmd>Git commit<cr>", "Git [c]ommit" },
    ["<leader>gl"] = { "<cmd>Git blame<cr>", "B[l]ame" },
    ["<leader>gt"] = { "<cmd>Git status<cr>", "S[t]atus" },
  }
end

return M
