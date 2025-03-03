-- Launch the neovim configuration.
-- Global variables
JAVA_DAP_ACTIVE = false
LAZY_PLUGIN_SPEC = {}
vim.g.python3_host_prog='/usr/bin/python3'
-- vim.g.python3_host_prog='/opt/homebrew/bin/python3'

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
  "ts_ls",        -- typescript
  -- "tsserver",     -- typescript
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

opts = {
  mode = "n",     -- NORMAL with leader mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}

nopts = {
  mode = "n",     -- NORMAL mode NO leader
  prefix = "",
  preset = true,
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
}

vopts = {
  mode = "v",     -- VISUAL mode
  prefix = "",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}

xopts = {
  mode = "x",     -- VISUAL BLOCK mode
  prefix = "",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}

iopts = {
  mode = "i",     -- INSERT mode
  prefix = "",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}

topts = {
  silent = true,
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
