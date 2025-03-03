-- A DB UI for VIM
return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod',                     lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_winwidth = 50
    vim.g.db_ui_win_position = "left"
    vim.g.db_ui_force_echo_notifications = 1

    require("cmp").setup.buffer {
      sources = {
        {
          name = "vim-dadbod-completion",
        },
      },
    }

    local wk = require "which-key"
    wk.add({
      {"<leader>Du", "<cmd>DBUIToggle<cr>", desc="Toggle UI" },
      {"<leader>Df", "<cmd>DBUIFindBuffer<cr>", desc="Find buffer" },
      {"<leader>Dr", "<cmd>DBUIRenameBuffer<cr>", desc="Rename buffer" },
      {"<leader>Dq", "<cmd>DBUILastQueryInfo<cr>", desc="Last query info" },
    }, opts)
  end,
}
-- local M = {
--   "tpope/vim-dadbod",
--   opt = true,
--   dependencies = {
--     "kristijanhusak/vim-dadbod-ui",
--     "kristijanhusak/vim-dadbod-completion",
--   },
--   cmd = { "DBUIToggle", "DBUI", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
-- }
--
-- local function db_completion()
--   require("cmp").setup.buffer { sources = { { name = "vim-dadbod-completion" } } }
-- end
--
-- function dadbod_setup()
--   vim.g.db_ui_save_location = vim.fn.stdpath "config" .. require("plenary.path").path.sep .. "db_ui"
--
--   vim.api.nvim_create_autocmd("FileType", {
--     pattern = {
--       "sql",
--     },
--     command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
--   })
--
--   vim.api.nvim_create_autocmd("FileType", {
--     pattern = {
--       "sql",
--       "mysql",
--       "plsql",
--     },
--     callback = function()
--       vim.schedule(db_completion)
--     end,
--   })
-- end
--
-- function M.config()
--   -- local status_ok, plugin = pcall(require, "vim-dadbod")
--   -- if not status_ok then
--   --   print "Dadbod not loaded"
--   --   return
--   -- end
--   print "In vim-dadbod.lua"
--
--   local wk = require "which-key"
--   wk.register {
--     ["<leader>Du"] = { "<cmd>DBUIToggle<cr>", "Toggle UI" },
--     ["<leader>Df"] = { "<cmd>DBUIFindBuffer<cr>", "Find buffer" },
--     ["<leader>Dr"] = { "<cmd>DBUIRenameBuffer<cr>", "Rename buffer" },
--     ["<leader>Dq"] = { "<cmd>DBUILastQueryInfo<cr>", "Last query info" },
--   }
--
--   db_completion()
--   -- dadbod_setup()
--   -- plugin.setup()
-- end
--
-- return M
