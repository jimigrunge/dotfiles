local M = {
  "anuvyklack/fold-preview.nvim",
  commit = "b7920cb0aba2b48a6b679bff45f98c3ebc0f0b89",
}

function M.config()
  local status_ok, plugin = pcall(require, "fold-preview")
  if not status_ok then
    print 'fold-preview not loaded'
    return
  end

  plugin.setup()
end

return M
