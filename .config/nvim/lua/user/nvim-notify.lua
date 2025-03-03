-- A fancy notification manager for neovim.
local M = {
  "rcarriga/nvim-notify",
  commit = "a3020c2cf4dfc4c4f390c4a21e84e35e46cf5d17",
  -- commit = "d333b6f167900f6d9d42a59005d82919830626bf",
}

function M.config()
  local status_ok, notify = pcall(require, 'notify')
  if not status_ok then
    print 'Notify not loaded'
    return
  end

  local icons = require "user.icons"

  local wk = require "which-key"
  wk.add({
    {"<leader>sm", "<cmd>Telescope notify<cr>", desc="[M]essages" },
  }, opts)

  ---@diagnostic disable-next-line: missing-fields
  notify.setup({
    level = vim.log.levels.INFO,
    -- max_width = function() return nil end,
    -- max_height = function() return nil end,
    stages = "fade_in_slide_out",
    background_colour = "#000000",
    -- background_colour = "NotifyBackground",
    -- on_open = function() return nil end,
    -- on_close = function() return nil end,
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
    render = 'wrapped-compact',
    -- render = 'minimal',
    timeout = 1000
  })

  require("telescope").load_extension("notify")
end

return M
