-- Open URL under cursor in browser.
local M = {
  "chrishrb/gx.nvim",
  event = { "BufEnter" },
  cmd = { "Browse" },
  init = function ()
    vim.g.netrw_nogx = 1 -- disable netrw gx
  end,
  -- keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
  dependencies = { "nvim-lua/plenary.nvim" },
  commit = "c7e6a0ace694a098a5248d92a866c290bd2da1cc",
  -- commit = "38d776a0b35b9daee5020bf3336564571dc785af",
}

function M.config()
  local status_ok, plugin = pcall(require, "gx")
  if not status_ok then
    print 'GX not loaded'
    return
  end
  local wk = require "which-key"
  wk.add({
    {"gx", "<cmd>Browse<cr>", desc="Open in browser" },
  }, nopts)

  plugin.setup {
    open_browser_app = "open",                -- specify your browser app; default for macOS is "open" and for Linux "xdg-open"
    open_browser_args = { "--background" },   -- specify any arguments, such as --background for macOS' "open".
    handlers = {
      plugin = true,                          -- open plugin links in lua (e.g. packer, lazy, ..)
      github = true,                          -- open github issues
      package_json = true,                    -- open dependencies from package.json
    },
  }
end

return M
