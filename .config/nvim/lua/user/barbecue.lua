-- VS Code like winbar that uses nvim-navic in order to get LSP context.
local M = {
  "utilyre/barbecue.nvim",
  version = "*",
  commit = "3e31404f0b93a2c30d151abf0648650ac811c664",
  -- commit = "d38a2a023dfb1073dd0e8fee0c9be08855d3688f",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
}

function M.config()
  local status_ok, plugin = pcall(require, "barbecue")
  if not status_ok then
    print 'Barbecue not loaded'
    return
  end

  plugin.setup()
end

return M
