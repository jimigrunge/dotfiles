local M = {
  "neovim/nvim-lspconfig",
  commit = "d29be376e64c23d6465ef3fb71aaf4bf4e8e0e68",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    inlay_hints = { enabled = true }
  },
  dependencies = {
    {
      "folke/neodev.nvim",
    },
    {
      "RishabhRD/nvim-lsputils",
      commit = "ae1a4a62449863ad82c70713d5b6108f3a07917c",
    },
    {
      "RishabhRD/popfix",
      commit = "bf3cc436df63cd535350d5ef1b951c91554d4b01",
    }
  },
}

local function lsp_keymaps(bufnr)
  -- local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", {
    noremap = true,
    silent = true,
    desc = "Go to [D]eclaration",
  })
  keymap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions<CR>", {
    noremap = true,
    silent = true,
    desc = "Go to [d]efinition",
  })
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {
    noremap = true,
    silent = true,
    desc = "[K] Hover",
  })
  keymap(bufnr, "n", "gi", "<cmd>Telescope lsp_implementations<CR>", {
    noremap = true,
    silent = true,
    desc = "Go to [i]mplementation",
  })
  keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {
    noremap = true,
    silent = true,
    desc = "Signature [k]elp",
  })
  keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", {
    noremap = true,
    silent = true,
    desc = "Go to [r]eferences",
  })
  keymap(bufnr, "n", "go", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {
    noremap = true,
    silent = true,
    desc = "Go to [o]ther type definition",
  })
  keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = border })<CR>', {
    noremap = true,
    silent = true,
    desc = "Previous Diagnostic",
  })
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", {
    noremap = true,
    silent = true,
    desc = "Open [l]ine diagnostic",
  })
  keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = border })<CR>', {
    noremap = true,
    silent = true,
    desc = "Next Diagnostic",
  })
  keymap(bufnr, "n", "R", '<cmd>lua vim.lsp.buf.rename()<cr>', {
    noremap = true,
    silent = true,
    desc = "[R]ename",
  })
  keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", {
    noremap = true,
    silent = true,
    desc = "[Q]uickfix",
  })
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local function lsp_highlight_document(client)
  local illuminate_status_ok, illuminate = pcall(require, "illuminate")
  if not illuminate_status_ok then
    return
  end
  illuminate.on_attach(client)
end

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)

  if client.name == "eslint" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end

  if client.name == "jdt.ls" then
    vim.lsp.codelens.refresh()
    if JAVA_DAP_ACTIVE then
      require("jdtls").setup_dap { hotcodereplace = "auto" }
      require("jdtls.dap").setup_dap_main_class_configs()
    end
    client.server_capabilities.documentFormattingProvider = false
  end

  -- if client.supports_method "textDocument/inlayHint" then
  --   vim.lsp.inlay_hint.enable(bufnr, true)
  -- end
end

local function common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }

  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end

  return capabilities
end

-- M.toggle_inlay_hints = function()
--   local bufnr = vim.api.nvim_get_current_buf()
--   vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
-- end

function M.config()
  local wk = require "which-key"
  wk.register {
    -- ["<leader>la"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code [A]ction" },
    ["<leader>la"] = { "<cmd>CodeActionMenu<cr>", "Code [A]ction" },
    ["<leader>le"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Line diagnostic [e]rror hover" },
    ["<leader>lf"] = { "<cmd>lua vim.lsp.buf.format()<cr>", "[F]ormat" },
    -- ["<leader>lf"] = {
    --   "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
    --   "[F]ormat",
    -- },
    -- ["<leader>lh"] = { "<cmd>lua require('user.lspconfig').toggle_inlay_hints()<cr>", "[H]ints" },
    ["<leader>li"] = { "<cmd>LspInfo<cr>", "[I]nfo" },
    ["<leader>lj"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
    ["<leader>lk"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
    ["<leader>ll"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", "Code [L]ens Action" },
    ["<leader>lq"] = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "[Q]uickfix" },
    -- ["<leader>lr"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
  }

  local lspconfig = require "lspconfig"
  local icons = require "user.icons"
  local border = "rounded"

  local servers = LSP_SERVERS

  local default_diagnostic_config = {
    signs = {
      active = true,
      values = {
        { name = "DiagnosticSignError", text = icons.diagnostics.BoldError },
        { name = "DiagnosticSignWarn",  text = icons.diagnostics.BoldWarning },
        { name = "DiagnosticSignHint",  text = icons.diagnostics.BoldHint },
        { name = "DiagnosticSignInfo",  text = icons.diagnostics.BoldInformation },
      },
    },
    virtual_text = false,
    virtual_lines = false,
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

  vim.diagnostic.config(default_diagnostic_config)

  for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

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
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
  require("lspconfig.ui.windows").default_options.border = border

  for _, server in pairs(servers) do
    local opts = {
      on_attach = on_attach,
      capabilities = common_capabilities(),
    }

    server = vim.split(server, "@")[1]

    local require_ok, settings = pcall(require, "user.lspsettings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", settings, opts)
    else
      print('no custom settings for: ' .. server)
    end

    if server == "lua_ls" then
      require("neodev").setup {}
    end

    lspconfig[server].setup(opts)
  end
end

return M
