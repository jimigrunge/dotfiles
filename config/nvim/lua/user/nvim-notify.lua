-- A fancy notification manager for neovim.
local M = {
  "rcarriga/nvim-notify",
  commit = "1576123bff3bed67bc673a3076e591abfe5d8ca9",
}

function M.config()
  local status_ok, notify = pcall(require, 'notify')
  if not status_ok then
    print 'Notify not loaded'
    return
  end

  local icons = require "user.icons"

  local wk = require "which-key"
  wk.register {
    ["<leader>sm"] = { "<cmd>Telescope notify<cr>", "[M]essages" },
  }

  ---@diagnostic disable-next-line: missing-fields
  notify.setup({
    level = vim.log.levels.INFO,
    -- max_width = function() return nil end,
    -- max_height = function() return nil end,
    stages = "fade_in_slide_out",
    background_colour = "NotifyBackground",
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
