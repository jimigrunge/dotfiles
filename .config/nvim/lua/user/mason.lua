-- A plugin for Mason LSP manager.
local M = {
  "williamboman/mason-lspconfig.nvim",
  commit = "e942edf5c85b6a2ab74059ea566cac5b3e1514a4",
  -- commit = "a4caa0d083aab56f6cd5acf2d42331b74614a585",
  dependencies = {
    {
      "williamboman/mason.nvim",
      commit = "e2f7f9044ec30067bc11800a9e266664b88cda22",
      -- commit = "3b5068f0fc565f337d67a2d315d935f574848ee7",
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
  wk.add({
    {"<leader>lI", "<cmd>Mason<cr>", desc="Mason [I]nstaller" },
    {"<leader>lM", "<cmd>Mason<cr>", desc="[M]ason Installer" },
  }, opts)

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
