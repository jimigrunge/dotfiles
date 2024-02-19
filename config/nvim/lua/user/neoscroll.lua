local M = {
  "karb94/neoscroll.nvim",
  commit = "be4ebf855a52f71ca4338694a5696675d807eff9",
}

function M.config()
  local status_ok, neoscroll = pcall(require, "neoscroll")
  if not status_ok then
    print 'Neoscroll not loaded'
    return
  end

  neoscroll.setup()
end

return M
