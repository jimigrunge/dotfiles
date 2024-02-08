local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- -----------------------------------
-- Shorten function name
local keymap = vim.api.nvim_set_keymap

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
-- Normal --
-- -----------------------------------
-- Better window navigation
keymap("n", "<C-k>", ":TmuxNavigateUp<cr>", opts)
keymap("n", "<C-j>", ":TmuxNavigateDown<cr>", opts)
keymap("n", "<C-h>", ":TmuxNavigateLeft<cr>", opts)
keymap("n", "<C-l>", ":TmuxNavigateRight<cr>", opts)

-- Center under cursor search
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "gt", ":BufferLinePick<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Delete character without copy
keymap("n", "x", '"_x', opts)

-- Upper/Lower case
keymap("n", "+", "viwgU", opts)
keymap("n", "-", "viwgu", opts)

-- No highlight
keymap("n", "<space><space>", "<cmd>nohlsearch<CR>", opts)

-- Create fold
keymap("n", "zf", "zf%", opts)

-- Center next search result
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Custom grepping
keymap("n", "ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

keymap("n", "<C-c><C-p>", "<cmd>PickColor<cr>", opts)

-- -----------------------------------
-- Insert --
-- -----------------------------------
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)
keymap("i", "jj", "<ESC>", opts)
keymap("i", "<C-c><C-p>", "<cmd>PickColorInsert<cr>", opts)

keymap("i", "<C-c><C-a>", "<cmd>IconPickerInsert alt_font<cr>", opts)
keymap("i", "<C-c><C-e>", "<cmd>IconPickerInsert emoji<cr>", opts)
keymap("i", "<C-c><C-E>", "<cmd>PickEverything alt_font nerd_font symbols emoji<cr>", opts)
keymap("i", "<C-c><C-f>", "<cmd>IconPickerInsert nerd_font<cr>", opts)
keymap("i", "<C-c><C-s>", "<cmd>IconPickerInsert symbols<cr>", opts)

-- -----------------------------------
-- Visual --
-- -----------------------------------
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- Paste without copy
keymap("v", "p", '"_dP', opts)

-- -----------------------------------
-- Visual Block --
-- -----------------------------------
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Paste without copy
keymap("x", "p", '"_dP', opts)

-- -----------------------------------
-- Terminal --
-- -----------------------------------
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
--[[ keymap("t", "<C-t>", ":ToggleTerm<cr>", term_opts) ]]
