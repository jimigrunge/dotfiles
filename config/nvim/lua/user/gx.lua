local M = {
  "chrishrb/gx.nvim",
  event = { "BufEnter" },
  dependencies = { "nvim-lua/plenary.nvim" },
  commit = "38d776a0b35b9daee5020bf3336564571dc785af",
}

function M.config()
  local status_ok, plugin = pcall(require, "gx")
  if not status_ok then
    print 'GX not loaded'
    return
  end

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
