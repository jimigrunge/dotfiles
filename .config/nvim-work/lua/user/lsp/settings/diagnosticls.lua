-- Diagnostics
-- This language server needs to be installed first
-- https://github.com/lithammer/nvim-diagnosticls
local dlsconfig = require 'diagnosticls-configs'
local fs = require 'diagnosticls-configs.fs'

-- Linters
local eslint_linter = require 'diagnosticls-configs.linters.eslint_d'
local standard_linter = require 'diagnosticls-configs.linters.standard'
local phpcs_linter = {
  sourceName = 'phpcs',
  command = fs.executable('phpcs', 'php'),
  debounce = 100,
  args = { '--standard=PSR12', '--report=emacs', '-s', '-' },
  offsetLine = 0,
  offsetColumn = 0,
  formatLines = 1,
  formatPattern = {
    [[^.*:(\d+):(\d+):\s+(.*)\s+-\s+(.*)(\r|\n)*$]],
    { line = 1, column = 2, security = 3, message = { '[phpcs] ', 4 } },
  },
  securities = { error = 'error', warning = 'warning' },
  rootPatterns = { '.git', 'vendor', 'composer.json' },
}

-- Formatters
local prettier_formatter = require 'diagnosticls-configs.formatters.prettier'
local prettier_standard_formatter = require 'diagnosticls-configs.formatters.prettier_standard'
local phpcbf_formatter = {
  sourceName = 'phpcbf',
  command = fs.executable('phpcbf', 'php'),
  args = { '--standard=PSR12', '%filepath' },
  rootPatterns = { 'composer.json', 'composer.lock', '.git' },
}

dlsconfig.init {
  -- Custom attach function
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
  default_config = true,
  formatting = true,
}

return {
  cmd = { "diagnostic-languageserver", "--stdio" },
  filetypes = { "php", 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'lua' },
  initializationOptions = {
    linters = {
      phpcs = phpcs_linter,
      eslint = eslint_linter,
      eslint_react = { eslint_linter, standard_linter },
      lua_lint = require 'diagnosticls-configs.linters.luacheck'
    },
    filetypes = {
      php = 'phpcs',
      javascript = 'eslint',
      javascriptreact = 'eslint_react',
      typescript = 'eslint',
      typescriptreact = 'eslint_react',
      lua = 'lua_lint'
    },
    formatters = {
      phpcbf = phpcbf_formatter,
      prettier = prettier_formatter,
      prettier_react = { prettier_formatter, prettier_standard_formatter },
      lua_format = require 'diagnosticls-configs.formatters.stylua'
    },
    formatFiletypes = {
      php = 'phpcbf',
      javascript = 'prettier',
      javascriptreact = 'prettier_react',
      typescript = 'prettier',
      typescriptreact = 'prettier_react',
      lua = 'lua_format'
    }
  },
  root_dir = vim.lsp.util.find_git_ancestor,
  single_file_support = true
}
