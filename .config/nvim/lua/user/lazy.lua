-- Lazy load plugins.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  spec = LAZY_PLUGIN_SPEC,
  install = {
    colorscheme = { "vscode", "default" },
  },
  ui = {
    border = "rounded",
  },
  change_detection = {
    enable = true,
    notify = false,
  },
}

local wk = require "which-key"
wk.add({
  { "<leader>ph", "<cmd>Lazy home<cr>", desc = "[H]ome" },
  { "<leader>pi", "<cmd>Lazy install<cr>", desc = "[I]nstall" },
  { "<leader>ps", "<cmd>Lazy sync<cr>", desc = "[S]ync" },
  { "<leader>pu", "<cmd>Lazy update<cr>", desc = "[U]pdate" },
}, opts)
