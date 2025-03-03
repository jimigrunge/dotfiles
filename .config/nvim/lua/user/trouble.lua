-- A pretty list for showing diagnostics.
local M = {
  "folke/trouble.nvim",
  cmd = "Trouble",
  commit = "50481f414bd3c1a40122c1d759d7e424d5fafe84",
  -- commit = "f1168feada93c0154ede4d1fe9183bf69bac54ea",
}

function M.config()
  local status_ok, trouble = pcall(require, 'trouble')
  if not status_ok then
    return
  end

  local icons = require "user.icons"

  local wk = require "which-key"
  wk.add({
    {"<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc="[D]ocument" },
    {"<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc="[L]oclist" },
    {"<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc="[Q]uickfix" },
    {"<leader>xR", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc="[R]eferences" },
    {"<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", desc="[W]orkspace" },
    {"<leader>xx", "<cmd>Trouble symbols toggle focus=false<cr>", desc="Trouble Symbols" },
    -- {"<leader>xd", "<cmd>Trouble document_diagnostics<cr>", desc="[D]ocument" },
    -- {"<leader>xl", "<cmd>Trouble loclist<cr>", desc="[L]oclist" },
    -- {"<leader>xq", "<cmd>Trouble quickfix<cr>", desc="[Q]uickfix" },
    -- {"<leader>xR", "<cmd>Trouble lsp_references<cr>", desc="[R]eferences" },
    -- {"<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", desc="[W]orkspace" },
    -- {"<leader>xx", "<cmd>Trouble<cr>", desc="Trouble" },
    {"<leader>xtl", "<cmd>TodoLocList<cr>", desc="[L]ocal List" },
    {"<leader>xtq", "<cmd>TodoQuickFix<cr>", desc="[Q]uickFix" },
    {"<leader>xtt", "<cmd>TodoTelescope<cr>", desc="[T]elescope" },
    {"<leader>xtx", "<cmd>TodoTrouble<cr>", desc="Trouble" },
  }, opts)

  trouble.setup {
    auto_close = true,
    use_lsp_diagnostic_signs = false,
    signs = {
      error = icons.diagnostics.BoldError, -- "🚫",
      warning = icons.diagnostics.BoldWarning,
      hint = icons.diagnostics.BoldHint,   -- "💡",
      information = icons.diagnostics.Information,
      other = icons.ui.ThinArrowRight,
    },
  }
end

return M
