-- Global variables
JAVA_DAP_ACTIVE = false
LAZY_PLUGIN_SPEC = {}

-- -----------------------------------
-- LSP servers
LSP_SERVERS = {
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
LSP_LINTER_FORMATTERS = {
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

nops = {
  mode = "n", -- NORMAL mode
  prefix = "",
  preset = true,
  silent = true,   -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
}

-- Lazy plugin table builder
-- @param item string to file returning a table
function spec(item)
  table.insert(LAZY_PLUGIN_SPEC, { import = item })
end

-- Wrapper for debugging
-- @param v any
P = function(v)
  print(vim.inspect(v))
  return v
end
