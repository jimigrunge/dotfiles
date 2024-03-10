-- Highlight, list and search TODO comments.
local M = {
  "folke/todo-comments.nvim",
  event = "BufRead",
  commit = "4a6737a8d70fe1ac55c64dfa47fcb189ca431872",
}

function M.config()
  local status_ok, todocomments = pcall(require, "todo-comments")
  if not status_ok then
    print 'TODO Comments not loaded'
    return
  end

  todocomments.setup()
end

return M
