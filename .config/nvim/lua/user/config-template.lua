local M = {
  "plugin/name",
  event = "Lazy",
}

function M.config()
  local status_ok, plugin = pcall(require, "PLUGIN_NAME")
  if not status_ok then
    print "PLUGIN_NAME not loaded"
    return
  end

  -- local wk = require "which-key"
  -- wk.register {
  --   [""] = { "<cmd><cr>", "" },
  -- }

  -- your config here
end

return M
