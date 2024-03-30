-- A pretty list for showing diagnostics.
local M = {
  "folke/trouble.nvim",
  cmd = "TroubleToggle",
  commit = "f1168feada93c0154ede4d1fe9183bf69bac54ea",
}

function M.config()
  local status_ok, trouble = pcall(require, 'trouble')
  if not status_ok then
    return
  end

  local icons = require "user.icons"

  local wk = require "which-key"
  wk.register {
    ["<leader>xd"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "[D]ocument" },
    ["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", "[L]oclist" },
    ["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", "[Q]uickfix" },
    ["<leader>xR"] = { "<cmd>TroubleToggle lsp_references<cr>", "[R]eferences" },
    ["<leader>xw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "[W]orkspace" },
    ["<leader>xx"] = { "<cmd>TroubleToggle<cr>", "Trouble" },
    ["<leader>xtl"] = { "<cmd>TodoLocList<cr>", "[L]ocal List" },
    ["<leader>xtq"] = { "<cmd>TodoQuickFix<cr>", "[Q]uickFix" },
    ["<leader>xtt"] = { "<cmd>TodoTelescope<cr>", "[T]elescope" },
    ["<leader>xtx"] = { "<cmd>TodoTrouble<cr>", "Trouble" },
  }

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
