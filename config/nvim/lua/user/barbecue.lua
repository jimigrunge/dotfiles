local M = {
  "utilyre/barbecue.nvim",
  version = "*",
  commit = "d38a2a023dfb1073dd0e8fee0c9be08855d3688f",
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
