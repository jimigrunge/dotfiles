local status_ok, trouble = pcall(require, 'trouble')
if not status_ok then
  return
end

local icons = require "user.icons"

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
