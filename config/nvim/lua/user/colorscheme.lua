local M = {
  "lunarvim/colorschemes",
  commit = "e29f32990d6e2c7c3a4763326194fbd847b49dac",
}

function M.config()
  vim.g.italic_comments = true
  vim.g.tokyonight_style = "night"
  vim.o.background = "dark"
  -- vim.cmd([[colorscheme tokyonight]])
  vim.cmd([[colorscheme vscode]])
  -- vim.cmd([[colorscheme system76]])

  vim.api.nvim_command("highlight LspDiagnosticsUnderlineError gui=undercurl")
  vim.api.nvim_command("highlight LspDiagnosticsUnderlineWarning gui=undercurl")
  vim.api.nvim_command("highlight LspDiagnosticsUnderlineInformation gui=undercurl")
  vim.api.nvim_command("highlight LspDiagnosticsUnderlineInfo gui=undercurl")
  vim.api.nvim_command("highlight LspDiagnosticsUnderlineHint gui=undercurl")

  -- VSCode Color overrides
  local c = require('vscode.colors').get_colors()
  local italic_comments = (vim.g.vscode_italic_comment == true or vim.g.vscode_italic_comment == 1)
  vim.api.nvim_set_hl(0, 'Comment', { fg = c.vscGray, bg = 'NONE', italic = italic_comments })
  vim.api.nvim_set_hl(0, 'SpecialComment', { fg = c.vscGreen, bg = 'NONE' })
  vim.api.nvim_set_hl(0, '@comment', { fg = c.vscGray, bg = 'NONE', italic = italic_comments })
end

return M
