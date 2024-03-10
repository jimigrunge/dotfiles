-- Search and replace with preview.
local M = {
  "roobert/search-replace.nvim",
  commit = "d92290a02d97f4e9b8cd60d28b56b403432158d5",
}

function M.config()
  local status_ok, plugin = pcall(require, "search-replace")
  if not status_ok then
    print 'search-replace not loaded'
    return
  end

  local wk = require "which-key"
  wk.register {
    ["<leader>ss"] = { "<cmd>SearchReplaceSingleBufferSelections<cr>", "[S]earch Replace" },
    ["<leader>sS"] = { "<cmd>SearchReplaceMultiBufferSelections<cr>", "[S]earch Replace Buffers" },
  }

  plugin.setup()
end

return M
