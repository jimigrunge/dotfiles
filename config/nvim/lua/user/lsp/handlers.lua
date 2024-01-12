local M = {}

local icons = require "user.icons"

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.BoldError },
    { name = "DiagnosticSignWarn",  text = icons.diagnostics.BoldWarning },
    { name = "DiagnosticSignHint",  text = icons.diagnostics.BoldInformation },
    { name = "DiagnosticSignInfo",  text = icons.diagnostics.BoldQuestion },
  }
  local border = "rounded"

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    virtual_lines = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = border,
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/codeAction"] = require 'lsputil.codeAction'.code_action_handler
  vim.lsp.handlers['textDocument/references'] = require 'lsputil.locations'.references_handler
  vim.lsp.handlers['textDocument/definition'] = require 'lsputil.locations'.definition_handler
  vim.lsp.handlers['textDocument/declaration'] = require 'lsputil.locations'.declaration_handler
  vim.lsp.handlers['textDocument/typeDefinition'] = require 'lsputil.locations'.typeDefinition_handler
  vim.lsp.handlers['textDocument/implementation'] = require 'lsputil.locations'.implementation_handler
  vim.lsp.handlers['textDocument/documentSymbol'] = require 'lsputil.symbols'.document_handler
  vim.lsp.handlers['workspace/symbol'] = require 'lsputil.symbols'.wrkspace_handlero
  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      signs = true,
      underline = true,
      update_in_insert = true,
    })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
  require("lspconfig.ui.windows").default_options.border = border
end

local function lsp_highlight_document(client)
  local illuminate_status_ok, illuminate = pcall(require, "illuminate")
  if not illuminate_status_ok then
    return
  end
  illuminate.on_attach(client)
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
  keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
  keymap(bufnr, "n", "go", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = border })<CR>', opts)
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = border })<CR>', opts)
  keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

M.on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)

  if client.name == "jdt.ls" then
    vim.lsp.codelens.refresh()
    if JAVA_DAP_ACTIVE then
      require("jdtls").setup_dap { hotcodereplace = "auto" }
      require("jdtls.dap").setup_dap_main_class_configs()
    end
    client.server_capabilities.documentFormattingProvider = false
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
  M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

return M
