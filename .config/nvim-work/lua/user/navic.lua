local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
  print 'nvim-navic not loaded'
  return
end

local icons = require "user.icons"

navic.setup({
  icons = icons.kind,
  separator = " > "
})
