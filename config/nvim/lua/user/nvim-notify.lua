local status_ok, notify = pcall(require, 'notify')
if not status_ok then
  print 'Notify not loaded'
  return
end

local icons = require "user.icons"

notify.setup({
  level = vim.log.levels.INFO,
  -- max_width = nil,
  -- max_height = nil,
  stages = "fade_in_slide_out",
  background_colour = "NotifyBackground",
  -- on_open = nil,
  -- on_close = nil,
  minimum_width = 50,
  fps = 30,
  top_down = true,
  time_formats = {
    notification_history = "%FT%T",
    notification = "%T",
  },
  icons = {
    ERROR = icons.diagnostics.BoldError,
    WARN = icons.diagnostics.BoldWarning,
    INFO = icons.diagnostics.BoldInformation,
    DEBUG = icons.diagnostics.Debug,
    TRACE = icons.diagnostics.Trace,
  },
  render = 'minimal',
  timeout = 1500
})
