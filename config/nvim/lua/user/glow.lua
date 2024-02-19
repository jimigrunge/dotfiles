local M = {
  "ellisonleao/glow.nvim",
  branch = "main",
  commit = "238070a686c1da3bccccf1079700eb4b5e19aea4",
}

function M.config()
  local status_ok, glow = pcall(require, 'glow')
  if not status_ok then
    print 'Glow not loaded'
    return
  end

  local wk = require "which-key"
  wk.register {
    ["<leader>mp"] = { "<cmd>Glow<cr>", "Markdown [P]review" }
  }

  glow.setup({
    install_path = vim.env.HOME .. "/.local/bin", -- default path for installing glow binary
    glow_path = vim.env.HOME .. "/.local/bin/glow",
    border = "rounded",
    style = 'dark',
    pager = false,
    width = 120,
    height = 180,
    width_ratio = 0.7,
    height_ratio = 0.9,
  })
end

return M
