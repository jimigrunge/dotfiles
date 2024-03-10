-- A plugin for displaying keybindings in neovim.
local M = {
  "folke/which-key.nvim",
  commit = "4433e5ec9a507e5097571ed55c02ea9658fb268a",
}

function M.config()
  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then
    print 'Whichkey not loaded'
    return
  end

  local mappings = {
    ["b"] = {
      name = "[B]uffers",
      ["c"] = { "<cmd>Bdelete!<cr>", "[C]lose Buffer" },
      ["r"] = { "<cmd>set relativenumber!<cr>", "[R]elative Numbers" },
    },
    ["c"] = { "<cmd>Bdelete!<cr>", "[C]lose Buffer" },
    ["C"] = { name = "[C]hatGPT" },
    ["d"] = { name = "[D]ebug" },
    ["D"] = {
      name = "[D]atabase",
    },
    ["g"] = {
      name = "[G]it",
      ["d"] = { name = "[D]iffView" },
      ["y"] = { name = "[Y]ank Git Remote Link" },
    },
    ["h"] = { name = "[H]arpoon" },
    ["l"] = { name = "[L]SP" },
    ["m"] = { name = "[M]arkdown" },
    ["n"] = { name = "[N]oice" },
    ["o"] = { name = "[O]utline" },
    ["p"] = {
      name = "[P]lugins Lazy",
    },
    ["q"] = { "<cmd>ConfirmQuit!<cr>", "[Q]uit" },
    ["r"] = { name = "[R]esume" },
    ["s"] = {
      name = "[S]earch",
      ["p"] = { name = "[P]icker" }
    },
    ["t"] = { name = "[T]erminal" },
    ["v"] = { name = "[V]S Code Colors" },
    ["w"] = { "<cmd>w!<CR>", "Save" },
    ["x"] = {
      name = "Diagnostic[x]",
      ["t"] = { name = "[T]odo" },
    },
    ["zf"] = { "zf%", "Fold" },
  }

  local n_mappings = {
    ["<leader><leader>"] = { "<cmd>nohlsearch<cr>", "Highlight Off" },
    ["n"] = { "nzz", "Center Next Result" },
    ["N"] = { "Nzz", "Center Prev Result" },
    ["*"] = { "*zz", "Next Under Cursor & Center" },
    ["#"] = { "#zz", "Prev Under Cursor & Center" },
    ["g*"] = { "g*zz", "Next Under Cursor & Center" },
    ["g#"] = { "g#zz", "Prev Under Cursor & Center" },
    ["<C-Up>"] = { ":resize -2<CR>", "Resize Up" },
    ["<C-Down>"] = { ":resize +2<CR>", "Resize Down" },
    ["<C-Left>"] = { ":vertical resize -2<CR>", "Resize Left" },
    ["<C-Right>"] = { ":vertical resize +2<CR>", "Resize Right" },
    ["<A-j>"] = { "<Esc>:m .+1<CR>==gi", "Move Text Down" },
    ["<A-k>"] = { "<Esc>:m .-2<CR>==gi", "Move Text Up" },
    ["x"] = { '"_x', "Delete Without Copy" },
    ["+"] = { "<C-a>", "Increment" },
    ["-"] = { "<C-x>", "Decrement" },
    -- ["+"] = { "viwgU", "Uppercase" },
    -- ["-"] = { "viwgu", "Lowercase" },
    ["zf"] = { "zf%", "Fold" },
    ["g"] = {
      name = "LSP",
      ["b"] = { name = "+Comment blockwise" },
      ["c"] = { name = "+Comment linewise" },
      ["v"] = { name = "Reselect" }
    },
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
    ["<C-a>"] = { "gg<S-v>G", "Select [A]ll" },
    ["<C-k>"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature" }
  }

  local v_mappings = {
    ["<"] = { "<gv", "Indent & Reselect" },
    [">"] = { ">gv", "Outdent & Reselect" },
    ["<A-j>"] = { ":m .+1<CR>==", "Move text down" },
    ["<A-k>"] = { ":m .-2<CR>==", "Move text up" },
    ["p"] = { '"_dP', "Paste without copy" },
    ["+"] = { "gU", "Uppercase" },
    ["-"] = { "gu", "Lowercase" },
  }

  local i_mappings = {
    ["jj"] = { "<ESC>", "Quick Escape" },
  }

  local x_mappings = {
    ["J"] = { ":move '>+1<CR>gv-gv", "Move text down" },
    ["K"] = { ":move '<-2<CR>gv-gv", "Move text up" },
    ["<A-j>"] = { ":move '>+1<CR>gv-gv", "Move text down" },
    ["<A-k>"] = { ":move '<-2<CR>gv-gv", "Move text up" },
    ["p"] = { '"_dP', "Paste without copy" },
  }

  local opts = {
    mode = "n",     -- NORMAL with leader mode
    prefix = "<leader>",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
  }

  local nops = {
    mode = "n", -- NORMAL mode
    prefix = "",
    preset = true,
  }

  local vopts = {
    mode = "v",     -- VISUAL mode
    prefix = "",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
  }

  local xopts = {
    mode = "x",     -- VISUAL BLOCK mode
    prefix = "",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
  }

  local iopts = {
    mode = "i",     -- INSERT mode
    prefix = "",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
  }

  local config = {
    plugins = {
      marks = true,       -- shows a list of your marks on ' and `
      registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = true,     -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = false,      -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = true,       -- default bindings on <c-w>
        nav = true,           -- misc bindings to work with windows
        z = true,             -- bindings for folds, spelling and others prefixed with z
        g = true,             -- bindings for prefixed with g
      },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    operators = { gc = "Comments" },
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      -- For example:
      ["<space>"] = "SPC",
      ["<cr>"] = "RET",
      ["<tab>"] = "TAB",
      ["<leader>"] = "LDR",
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>",   -- binding to scroll up inside the popup
    },
    window = {
      border = "rounded",       -- none, single, double, shadow
      position = "bottom",      -- bottom, top
      margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 },                                             -- min and max height of the columns
      width = { min = 20, max = 50 },                                             -- min and max width of the columns
      spacing = 3,                                                                -- spacing between columns
      align = "left",                                                             -- align columns left, center or right
    },
    ignore_missing = false,                                                       -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true,                                                             -- show help message on the command line when the popup is visible
    show_keys = true,                                                             -- show the currently pressed key and its label as a message in the command line
    triggers = "auto",                                                            -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "j", "k" },
      v = { "j", "k" },
    },
    -- disable the WhichKey popup for certain buf types and file types.
    -- Disabled by deafult for Telescope
    --[[ disable = { ]]
    --[[   buftypes = {}, ]]
    --[[   filetypes = { "TelescopePrompt" }, ]]
    --[[ }, ]]
  }

  which_key.setup(config)
  which_key.register(mappings, opts)
  which_key.register(n_mappings, nops)
  which_key.register(v_mappings, vopts)
  which_key.register(i_mappings, iopts)
  which_key.register(x_mappings, xopts)
end

return M
