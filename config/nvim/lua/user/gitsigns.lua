local M = {
  "lewis6991/gitsigns.nvim",
  commit = "4aaacbf5e5e2218fd05eb75703fe9e0f85335803",
}

function M.config()
  local status_ok, gitsigns = pcall(require, "gitsigns")
  if not status_ok then
    print 'GitSigns not loaded'
    return
  end

  local icons = require "user.icons"

  local wk = require "which-key"
  wk.register {
    ["<leader>gB"] = { "<cmd>lua require'gitsigns'.blame_line{full=true}<cr>", "[B]lame Line" },
    ["<leader>gdd"] = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
    ["<leader>ge"] = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle Blam[e]" },
    ["<leader>gj"] = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
    ["<leader>gk"] = { "<cmd>Gitsigns prev_hunk<cr>", "Prev Hunk" },
    ["<leader>gp"] = { "<cmd>Gitsigns preview_hunk<cr>", "[P]review Hunk" },
    ["<leader>gu"] = { "<cmd>Gitsigns undo_stage_hunk<cr>", "[U]ndo Stage Hunk" },
  }

  gitsigns.setup {
    signs = {
      add = { hl = 'GitSignsAdd', text = icons.git.LineAdded, numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
      change = { hl = 'GitSignsChange', text = icons.git.LineModified, numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
      delete = { hl = 'GitSignsDelete', text = icons.ui.HorizonLineBottom, numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
      topdelete = { hl = 'GitSignsDelete', text = icons.ui.HorizonLineTop, numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
      changedelete = { hl = 'GitSignsChange', text = icons.git.LineRemoved, numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = true,      -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      interval = 1000,
      follow_files = true
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
      -- Options passed to nvim_open_win
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
    },
    yadm = {
      enable = false
    },
  }
end

return M
