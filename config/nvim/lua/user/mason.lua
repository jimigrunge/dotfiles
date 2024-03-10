-- A plugin for Mason LSP manager.
local M = {
  "williamboman/mason-lspconfig.nvim",
  commit = "fe4cce44dec93c69be17dad79b21de867dde118a",
  dependencies = {
    {
      "williamboman/mason.nvim",
      commit = "c43eeb5614a09dc17c03a7fb49de2e05de203924",
    },
  }
}

function M.config()
  local mason_status, mason = pcall(require, "mason")
  if not mason_status then
    print 'Mason not loaded'
    return
  end
  local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not mason_lspconfig_status then
    print 'Mason Lspconfig not loaded'
    return
  end

  local wk = require "which-key"
  wk.register {
    ["<leader>lI"] = { "<cmd>Mason<cr>", "Mason [I]nstaller" },
    ["<leader>lM"] = { "<cmd>Mason<cr>", "[M]ason Installer" },
  }

  -- -----------------------------------
  -- LSP servers
  local servers = LSP_SERVERS

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
end

return M
