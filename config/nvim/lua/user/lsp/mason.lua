-- -----------------------------------
-- Load plugins
local mason_status, mason = pcall(require, "mason")
if not mason_status then
  print 'mason not loaded'
  return
end
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  print 'mason_lspconfig_status not loaded'
  return
end
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
  print 'mason_null_ls not loaded'
  return
end
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  print 'lspconfig not loaded'
  return
end

-- -----------------------------------
-- LSP servers
local servers = {
  "bashls",       -- bash
  "clangd",       -- cpp
  "cssls",        -- css
  "eslint",       -- js/ts
  "html",         -- html
  "intelephense", -- PHP
  "jsonls",       -- json
  "lemminx",      -- XML/XSLT
  "lua_ls",       -- lua
  "marksman",     -- Markdown
  "prosemd_lsp",  -- Markdown
  "pyright",      -- python
  "solang",       -- solona
  "sqlls",        -- SQL
  "stimulus_ls",  -- blade
  -- "sumneko_lua",   -- Lua
  "taplo",        -- TOML
  "tsserver",     -- typescript
  "vimls",        -- vim
  -- "vtsls",        -- typescript
  "yamlls",       -- yaml
}

-- -----------------------------------
-- List of formatters & linters for mason to install
local linter_formatters = {
  "black",              -- python formatter
  "clang-format",       -- cpp formatter
  "cpplint",            -- cpp linting
  "eslint_d",           -- ts/js linting
  "google_java_format", -- java formatting
  "luacheck",           -- lua linting
  "markdownlint",       -- markdown linting
  "markdownlint_cli2",  -- markdown linting
  "phpcbf",             -- php formatting
  "phpcs",              -- php linting
  "prettier",           -- ts/js formatter
  "shellcheck",         -- bash linting
  "shellharden",        -- bash formatting
  "stylelint",          -- css linting
  "stylua",             -- lua formatter
  "textlint",           -- maekdown linting
}

local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

-- -----------------------------------
-- Setup installer
mason.setup(settings)

-- -----------------------------------
-- Language plugin server installation
mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

-- -----------------------------------
-- null-ls format/lint installation configuration
mason_null_ls.setup({
  ensure_installed = linter_formatters,
  automatic_installation = true,
})

-- -----------------------------------
-- Configure LSP
local opts = {}

for _, server in ipairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  -- Install custom LSP settings
  local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  else
    print('no custom settings for: ' .. server)
  end

  if server == "lua_ls" then
    require("neodev").setup({})
  end

  lspconfig[server].setup(opts)
end
