local M = {
  "yutkat/confirm-quit.nvim",
  event = "CmdlineEnter",
  -- opts = {},
  commit = "78a1ba1c5e307c85f102d1dba398bcc13464a820",
}

function M.config()
  local status_ok, confirm = pcall(require, "confirm-quit")
  if not status_ok then
    print 'Confirm Quit not loaded'
    return
  end

  confirm.setup({
    overwrite_q_command = true, -- Replaces :q and :qa with :ConfirmQuit and :ConfirmQuitAll
  })
end

return M
