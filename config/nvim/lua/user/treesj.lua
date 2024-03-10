-- splitting/joining blocks of code like arrays, hashes, etc.
local M = {
  'Wansmer/treesj',
  commit = "14808da3cddd62fc86ede53a5ea1fd1635897e75",
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
}

function M.config()
  local status_ok, plugin = pcall(require, "treesj")
  if not status_ok then
    print 'treesj not loaded'
    return
  end

  local wk = require "which-key"
  wk.register {
    ["<leader>j"] = { "<cmd>lua require('treesj').toggle()<cr>", "Format Structures" },
  }

  plugin.setup()
end

return M
