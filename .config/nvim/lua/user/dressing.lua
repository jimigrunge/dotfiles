local M = {
  "stevearc/dressing.nvim",
  commit = "94b0d24483d56f3777ee0c8dc51675f21709318c",
}

function M.config()
  local status_ok, dressing = pcall(require, "dressing")
  if not status_ok then
    print 'dressing not loaded'
    return
  end

  dressing.setup()
end

return M
