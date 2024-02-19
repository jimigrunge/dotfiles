local M = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  commit = "03f825956ec49e550d07875d867ea6e7c4dc8c00",
  dependencies = {
    {
      "zbirenbaum/copilot-cmp",
      commit = "72fbaa03695779f8349be3ac54fa8bd77eed3ee3",
      config = function()
        require("copilot_cmp").setup()
      end
    },
    {
      'AndreM222/copilot-lualine',
      commit = "f7f0b3b3e7b0183d65fb5416c1d3e210e8a67ba6",
    },
  },
}

function M.config()
  local status_ok, copilot = pcall(require, "copilot")
  if not status_ok then
    print("copilot not loaded")
    return
  end

  copilot.setup({
    panel = {
      enabled = false,
      auto_refresh = false,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = "<M-CR>"
      },
      layout = {
        position = "bottom", -- | top | left | right
        ratio = 0.4
      },
    },
    suggestion = {
      enabled = false,
      auto_trigger = false,
      debounce = 75,
      keymap = {
        accept = "<M-l>",
        accept_word = false,
        accept_line = false,
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
    filetypes = {
      yaml = false,
      markdown = false,
      help = false,
      gitcommit = false,
      gitrebase = false,
      hgcommit = false,
      svn = false,
      cvs = false,
      json = false,
      sh = function()
        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
          -- disable for .env files
          return false
        end
        return true
      end,
      ["."] = false,
    },
    copilot_node_command = 'node', -- Node.js version must be > 18.x
    server_opts_overrides = {},
  })

  vim.cmd("Copilot disable")
end

return M
