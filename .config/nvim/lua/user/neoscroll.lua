-- Smooth scrolling for neovim.
local M = {
  "karb94/neoscroll.nvim",
  commit = "f957373912e88579e26fdaea4735450ff2ef5c9c",
  -- commit = "be4ebf855a52f71ca4338694a5696675d807eff9",
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
