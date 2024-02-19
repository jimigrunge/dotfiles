local M = {
  "kosayoda/nvim-lightbulb",
  commit = "8f00b89dd1b1dbde16872bee5fbcee2e58c9b8e9",
}

function M.config()
  local status_ok, lightbulb = pcall(require, 'nvim-lightbulb')
  if not status_ok then
    print 'Lightbulb not loaded'
    return
  end

  lightbulb.setup {
    ignore = {
      clients = { "none-ls" },
    },
    autocmd = {
      enabled = true,
    }
  }
end

return M
