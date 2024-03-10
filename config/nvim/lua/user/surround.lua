-- Surround text with pairs.
local M = {
  "ur4ltz/surround.nvim",
  commit = "36c253d6470910692491b13382f54c9bab2811e1",
}

function M.config()
  local status_ok, surround = pcall(require, 'surround')
  if not status_ok then
    print 'Surround not loaded'
    return
  end

  surround.setup {
    mappings_style = "surround"
  }
end

return M
