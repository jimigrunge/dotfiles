-- A refactoring plugin for neovim. (This is still beta)
local M = {
  "ThePrimeagen/refactoring.nvim",
  commit = "c067e44b8171494fc1b5206ab4c267cd74c043b1",
}

function M.config()
  local status_ok, refactoring = pcall(require, "refactoring")
  if not status_ok then
    print 'Refatoring not loaded'
    return
  end

  refactoring.setup({
    show_success_message = true
  })
end

return M
