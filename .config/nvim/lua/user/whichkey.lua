-- A plugin for displaying keybindings in neovim.
local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  commit = "1f8d414f61e0b05958c342df9b6a4c89ce268766",
  -- commit = "4433e5ec9a507e5097571ed55c02ea9658fb268a",
  dependencies = {
    { 'echasnovski/mini.nvim', version = '*' },
  }
}

function M.config()
  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then
    print 'Whichkey not loaded'
    return
  end

  -- local mappings = {
  -- local keys = {
  local keys = {
    { "<leader>C", group = "[C]hatGPT" },
    { "<leader>D", group = "[D]atabase" },
    { "<leader>b", group = "[B]uffers" },
    { "<leader>bc", "<cmd>Bdelete!<cr>", desc = "[C]lose Buffer" },
    { "<leader>br", "<cmd>set relativenumber!<cr>", desc = "[R]elative Numbers" },
    { "<leader>c", "<cmd>Bdelete!<cr>", desc = "[C]lose Buffer" },
    { "<leader>d", group = "[D]ebug" },
    { "<leader>g", group = "[G]it" },
    { "<leader>gd", group = "[D]iffView" },
    { "<leader>gy", group = "[Y]ank Git Remote Link" },
    { "<leader>h", group = "[H]arpoon" },
    { "<leader>l", group = "[L]SP" },
    { "<leader>m", group = "[M]arkdown" },
    { "<leader>n", group = "[N]oice" },
    -- { "<leader>o", group = "[O]utline" },
    { "<leader>p", group = "[P]lugins Lazy" },
    { "<leader>q", "<cmd>ConfirmQuit!<cr>", desc = "[Q]uit" },
    { "<leader>r", group = "[R]esume" },
    { "<leader>s", group = "[S]earch" },
    { "<leader>sp", group = "[P]icker" },
    { "<leader>t", group = "[T]erminal" },
    { "<leader>v", group = "[V]S Code Colors" },
    { "<leader>w", "<cmd>w!<CR>", desc = "Save" },
    { "<leader>x", group = "Diagnostic[x]" },
    { "<leader>xt", group = "[T]odo" },
    { "<leader>z", group = "Fold" },
    { "<leader>zf", "zf%", desc = "Fold" },
  }

  -- n_mappings
  local nkeys = {
    mode = { "n" },
    { "[", group = "Next" },
    { "]", group = "Previous" },
    { "#", "#zz", desc = "prev under cursor & center" },
    { "*", "*zz", desc = "next under cursor & center" },
    { "+", "<c-a>", desc = "increment" },
    { "-", "<c-x>", desc = "decrement" },
    { "<a-j>", "<esc>:m .+1<cr>==gi", desc = "move text down" },
    { "<a-k>", "<esc>:m .-2<cr>==gi", desc = "move text up" },
    { "<c-down>", ":resize +2<cr>", desc = "resize down" },
    { "<c-left>", ":vertical resize -2<cr>", desc = "resize left" },
    { "<c-right>", ":vertical resize +2<cr>", desc = "resize right" },
    { "<c-s>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "signature" },
    { "<c-up>", ":resize -2<cr>", desc = "resize up" },
    { "<c-a>", "gg<s-v>g", desc = "select [a]ll" },
    { "<leader><leader>", "<cmd>nohlsearch<cr>", desc = "highlight off" },
    { "K", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "hover" },
    { "N", "Nzz", desc = "center prev result" },
    { "f", group = "[Find]" },
    { "g", group = "LSP" },
    { "gp", group = "Preview" },
    { "g#", "g#zz", desc = "prev under cursor & center" },
    { "g*", "g*zz", desc = "next under cursor & center" },
    { "gb", group = "comment blockwise" },
    { "gc", group = "comment linewise" },
    { "gv", group = "reselect" },
    { "n", "nzz", desc = "center next result" },
    { "x", '"_x', desc = "delete without copy" },
    { "z", group = "Fold" },
    { "zf", "zf%", desc = "fold" },
  }

  -- v_mappings
  local vkeys = {
    mode = { "v" },
    { "+", "gU", desc = "Uppercase" },
    { "-", "gu", desc = "Lowercase" },
    { "<", "<gv", desc = "Indent & Reselect" },
    { "<A-j>", ":m .+1<CR>==", desc = "Move text down" },
    { "<A-k>", ":m .-2<CR>==", desc = "Move text up" },
    { ">", ">gv", desc = "Outdent & Reselect" },
    { "p", '"_dP', desc = "Paste without copy" },
  }

  -- i_mappings
  local ikeys = {
    mode= { "i" },
    { "jj", "<ESC>", desc = "Quick Escape" }
  }

  -- x_mappings
  local xkeys = {
    mode = { "x" },
    { "<A-j>", ":move '>+1<CR>gv-gv", desc = "Move text down" },
    { "<A-k>", ":move '<-2<CR>gv-gv", desc = "Move text up" },
    { "J", ":move '>+1<CR>gv-gv", desc = "Move text down" },
    { "K", ":move '<-2<CR>gv-gv", desc = "Move text up" },
    { "p", '"_dP', desc = "Paste without copy" },
  }

  local config = {
    ---@type false | "classic" | "modern" | "helix"
    preset = "classic",
    -- Delay before showing the popup. Can be a number or a function that returns a number.
    ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
    delay = function(ctx)
      return ctx.plugin and 0 or 200
    end,
    ---@param mapping wk.Mapping
    filter = function(mapping)
      -- example to exclude mappings without a description
      -- return mapping.desc and mapping.desc ~= ""
      return true
    end,
    --- You can add any mappings here, or use `require('which-key').add()` later
    ---@type wk.Spec
    spec = {},
    -- show a warning when issues were detected with your mappings
    notify = true,
    -- Which-key automatically sets up triggers for your mappings.
    -- But you can disable this and setup the triggers manually.
    -- Check the docs for more info.
    ---@type wk.Spec
    triggers = {
      { "<auto>", mode = "nxso" },
    },
    -- Start hidden and wait for a key to be pressed before showing the popup
    -- Only used by enabled xo mapping modes.
    ---@param ctx { mode: string, operator: string }
    defer = function(ctx)
      return ctx.mode == "V" or ctx.mode == "<C-V>"
    end,
    plugins = {
      marks = true,       -- shows a list of your marks on ' and `
      registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
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
    win = {
      border = "rounded",       -- none, single, double, shadow
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      wo = {
        winblend = 0,
      }
    },
    layout = {
      height = { min = 4, max = 25 },                                             -- min and max height of the columns
      width = { min = 20, max = 50 },                                             -- min and max width of the columns
      spacing = 3,                                                                -- spacing between columns
      align = "left",                                                             -- align columns left, center or right
    },
    keys = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>",   -- binding to scroll up inside the popup
    },
    ---@type (string|wk.Sorter)[]
    --- Mappings are sorted using configured sorters and natural sort of the keys
    --- Available sorters:
    --- * local: buffer-local mappings first
    --- * order: order of the items (Used by plugins like marks / registers)
    --- * group: groups last
    --- * alphanum: alpha-numerical first
    --- * mod: special modifier keys last
    --- * manual: the order the mappings were added
    --- * case: lower-case first
    sort = { "local", "order"--[[ , "group", "alphanum" ]], "mod" },
    ---@type number|fun(node: wk.Node):boolean?
    expand = 0, -- expand groups when <= n mappings
    -- expand = function(node)
    --   return not node.desc -- expand all nodes without a description
    -- end,
    -- Functions/Lua Patterns for formatting the labels
    ---@type table<string, ({[1]:string, [2]:string}|fun(str:string):string)[]>
    replace = {
      key = {
        function(key)
          return require("which-key.view").format(key)
        end,
        -- { "<Space>", "SPC" },
      },
      desc = {
        { "<Plug>%(?(.*)%)?", "%1" },
        { "^%+", "" },
        { "<[cC]md>", "" },
        { "<[cC][rR]>", "" },
        { "<[sS]ilent>", "" },
        { "^lua%s+", "" },
        { "^call%s+", "" },
        { "^:%s*", "" },
      },
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
      ellipsis = "…",
      -- set to false to disable all mapping icons,
      -- both those explicitly added in a mapping
      -- and those from rules
      mappings = true,
      --- See `lua/which-key/icons.lua` for more details
      --- Set to `false` to disable keymap icons from rules
      ---@type wk.IconRule[]|false
      rules = {},
      -- use the highlights from mini.icons
      -- When `false`, it will use `WhichKeyIcon` instead
      colors = true,
      -- used by key format
      keys = {
        Up = " ",
        Down = " ",
        Left = " ",
        Right = " ",
        C = "󰘴 ",
        M = "󰘵 ",
        D = "󰘳 ",
        S = "󰘶 ",
        CR = "󰌑 ",
        Esc = "󱊷 ",
        ScrollWheelDown = "󱕐 ",
        ScrollWheelUp = "󱕑 ",
        NL = "󰌑 ",
        BS = "󰁮",
        Space = "󱁐 ",
        Tab = "󰌒 ",
        F1 = "󱊫",
        F2 = "󱊬",
        F3 = "󱊭",
        F4 = "󱊮",
        F5 = "󱊯",
        F6 = "󱊰",
        F7 = "󱊱",
        F8 = "󱊲",
        F9 = "󱊳",
        F10 = "󱊴",
        F11 = "󱊵",
        F12 = "󱊶",
      },
    },
    show_help = true, -- show a help message in the command line for using WhichKey
    show_keys = true, -- show the currently pressed key and its label as a message in the command line
    -- disable WhichKey for certain buf types and file types.
    disable = {
      ft = {},
      bt = {},
    },
    debug = false, -- enable wk.log in the current directory
  }

  which_key.setup(config)
  which_key.add(keys,  opts)
  which_key.add(nkeys, nopts)
  which_key.add(vkeys, vopts)
  which_key.add(ikeys, iopts)
  which_key.add(xkeys, xopts)
end

return M
