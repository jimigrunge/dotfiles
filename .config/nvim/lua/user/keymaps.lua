-- -----------------------------------
-- Keymaps
-- -----------------------------------
-- Shorten function names
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
-- -----------------------------------
-- Usage:
-- keymap("n", "", "", opts)

-- -----------------------------------
--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<C-i>", "<C-i>", opts)

-- -----------------------------------
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
-- -----------------------------------

-- -----------------------------------
-- Mouse menu options               --
-- -----------------------------------
vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]
-- vim.cmd [[:amenu 10.120 mousemenu.-sep- *]]
vim.keymap.set("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>:popup mousemenu<CR>")

-- -----------------------------------
-- Normal --
-- -----------------------------------

-- -----------------------------------
-- Insert --
-- -----------------------------------

-- -----------------------------------
-- Visual --
-- -----------------------------------

-- -----------------------------------
-- Visual Block --
-- -----------------------------------

-- -----------------------------------
-- Terminal --
-- -----------------------------------
