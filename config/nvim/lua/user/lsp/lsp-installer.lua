local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

-- -----------------------------------
-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)

  local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if server.name == 'bashls' then
    local bashls_opts = require("user.lsp.settings.bashls")
    opts = vim.tbl_deep_extend("force", bashls_opts, opts)
  end

  if server.name == 'cssls' then
    local css_opts = require("user.lsp.settings.cssls")
    opts = vim.tbl_deep_extend("force", css_opts, opts)
  end

  if server.name == 'clangd' then
    local clangd_opts = require("user.lsp.settings.clangd")
    opts = vim.tbl_deep_extend("force", clangd_opts, opts)
  end

  if server.name == 'eslint' then
    local eslint_opts = require("user.lsp.settings.eslint")
    opts = vim.tbl_deep_extend("force", eslint_opts, opts)
  end

  if server.name == 'html' then
    local html_opts = require("user.lsp.settings.html")
    opts = vim.tbl_deep_extend("force", html_opts, opts)
  end

  if server.name == 'intelephense' then
    local php_opts = require("user.lsp.settings.intelephense")
    opts = vim.tbl_deep_extend("force", php_opts, opts)
  end

  if server.name == "jsonls" then
    local jsonls_opts = require("user.lsp.settings.jsonls")
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server.name == 'lemminx' then
    local lemminx_opts = require("user.lsp.settings.lemminx")
    opts = vim.tbl_deep_extend("force", lemminx_opts, opts)
  end

  if server.name == 'pyright' then
    local pyright_opts = require("user.lsp.settings.pyright")
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server.name == 'solang' then
    local solang_opts = require("user.lsp.settings.solang")
    opts = vim.tbl_deep_extend("force", solang_opts, opts)
  end

  --[[ if server.name == "sumneko_lua" then ]]
  --[[   local sumneko_opts = require("user.lsp.settings.sumneko_lua") ]]
  --[[   opts = vim.tbl_deep_extend("force", sumneko_opts, opts) ]]
  --[[ end ]]
  if server.name == "lua_ls" then
    local lua_ls_opts = require("user.lsp.settings.lua_ls")
    opts = vim.tbl_deep_extend("force", lua_ls_opts, opts)
  end

  if server.name == 'tsserver' then
    local tsserver_opts = require("user.lsp.settings.tsserver")
    opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
  end

  if server.name == 'vimls' then
    local vimls_opts = require("user.lsp.settings.vimls")
    opts = vim.tbl_deep_extend("force", vimls_opts, opts)
  end

  if server.name == 'yamlls' then
    local yamlls_opts = require("user.lsp.settings.yamlls")
    opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
  end

  if server == "jdtls" then goto continue end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
  ::continue::
end)
