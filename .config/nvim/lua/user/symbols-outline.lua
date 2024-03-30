-- A tree like view for symbols in neovim using the Language Server Protocol.
local M = {
  "simrat39/symbols-outline.nvim",
  commit = "564ee65dfc9024bdde73a6621820866987cbb256",
}

function M.config()
  local status_ok, outline = pcall(require, "symbols-outline")
  if not status_ok then
    print 'Outline not loaded'
    return
  end

  local icons = require "user.icons"

  local wk = require "which-key"
  wk.register {
    -- ["<leader>lo"] = { "<cmd>SymbolsOutline<cr>", "Toggle [O]utline" },
    ["<leader>o"] = { "<cmd>SymbolsOutline<cr>", "[T]oggle Outline" },
    -- ["<leader>oo"] = { "<cmd>SymbolsOutlineOpen<cr>", "[O]pen Outline" },
    -- ["<leader>oc"] = { "<cmd>SymbolsOutlineClose<cr>", "[C]lose Outline" }
  }

  outline.setup({
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = false,
    position = 'right',
    relative_width = true,
    width = 20,
    auto_close = false,
    show_numbers = true,
    show_relative_numbers = false,
    show_symbol_details = true,
    preview_bg_highlight = 'Pmenu',
    autofold_depth = nil,
    auto_unfold_hover = true,
    fold_markers = {
      icons.ui.ChevronShortRight,
      icons.ui.ChevronShortDown,
    },
    wrap = false,
    keymaps = { -- These keymaps can be a string or a table for multiple keys
      close = { "<Esc>", "q" },
      goto_location = "<Cr>",
      focus_location = "o",
      hover_symbol = "<C-space>",
      toggle_preview = "K",
      rename_symbol = "r",
      code_actions = "a",
      fold = "h",
      unfold = "l",
      fold_all = "W",
      unfold_all = "E",
      fold_reset = "R",
    },
    lsp_blacklist = {},
    symbol_blacklist = {},
    symbols = {
      File = { icon = icons.kind.File, hl = "TSURI" },
      Module = { icon = icons.kind.Module, hl = "TSNamespace" },
      Namespace = { icon = icons.kind.Namespace, hl = "TSNamespace" },
      Package = { icon = icons.kind.Package, hl = "TSNamespace" },
      Class = { icon = icons.kind.Class, hl = "TSType" },
      Method = { icon = icons.kind.Method, hl = "TSMethod" },
      Property = { icon = icons.kind.Property, hl = "TSMethod" },
      Field = { icon = icons.kind.Field, hl = "TSField" },
      Constructor = { icon = icons.kind.Constructor, hl = "TSConstructor" },
      Enum = { icon = icons.kind.Enum, hl = "TSType" },
      Interface = { icon = icons.kind.Interface, hl = "TSType" },
      Function = { icon = icons.kind.Function, hl = "TSFunction" },
      Variable = { icon = icons.kind.Variable, hl = "TSConstant" },
      Constant = { icon = icons.kind.Constant, hl = "TSConstant" },
      String = { icon = icons.kind.String, hl = "TSString" },
      Number = { icon = icons.kind.Number, hl = "TSNumber" },
      Boolean = { icon = icons.kind.Boolean, hl = "TSBoolean" },
      Array = { icon = icons.kind.Array, hl = "TSConstant" },
      Object = { icon = icons.kind.Object, hl = "TSType" },
      Key = { icon = icons.kind.Key, hl = "TSType" },
      Null = { icon = icons.kind.Null, hl = "TSType" },
      EnumMember = { icon = icons.kind.EnumMember, hl = "TSField" },
      Struct = { icon = icons.kind.Struct, hl = "TSType" },
      Event = { icon = icons.kind.Event, hl = "TSType" },
      Operator = { icon = icons.kind.Operator, hl = "TSOperator" },
      TypeParameter = { icon = icons.kind.TypeParameter, hl = "TSParameter" }
    }
  })
end

return M
