local M = {
  "norcalli/nvim-colorizer.lua",
  commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6",
}

function M.config()
  local status_ok, colorizer = pcall(require, "colorizer")
  if not status_ok then
    print 'Colorizer not loaded'
    return
  end

  colorizer.setup({
    'css',
    'javascript',
    html = {
      mode = 'background',
    }
  })
end

return M
