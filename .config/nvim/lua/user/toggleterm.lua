-- A neovim terminal in a floating window.
local M = {
  "akinsho/toggleterm.nvim",
  commit = "e3805fed94d487b81e9c21548535cc820f62f840",
}

function M.config()
  local status_ok, toggleterm = pcall(require, "toggleterm")
  if not status_ok then
    print 'Toggleterm not loaded'
    return
  end

  local term_opts = { silent = true }
  local wk = require "which-key"
  wk.register {
    ["<leader>gg"] = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazy[G]it" },
    ["<leader>tg"] = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazy[G]it" },
    ["<leader>tn"] = { "<cmd>lua _NODE_TOGGLE()<cr>", "[N]ode" },
    ["<leader>tu"] = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCD[U]" },
    ["<leader>tb"] = { "<cmd>lua _BTOP_TOGGLE()<cr>", "[B]Top" },
    ["<leader>th"] = { "<cmd>lua _HTOP_TOGGLE()<cr>", "[H]top" },
    ["<leader>tp"] = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "[P]ython" },
    ["<leader>tt"] = { "<cmd>ToggleTerm size=30<cr>", "[T]oggle Term" },
    ["<leader>tf"] = { "<cmd>ToggleTerm direction=float<cr>", "[F]loat" },
    ["<C-t>"] = { ":ToggleTerm<cr>", "Toggle Term", term_opts },
  }

  toggleterm.setup({
    size = 60,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
    winbar = {
      enabled = false,
      name_formatter = function(term) --  term: Terminal
        return term.name
      end
    },
  })

  function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', 'jj', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-Bslash>', [[<C-\><c-n><cmd>close<cr>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-Bslash>', [[<C-\><c-n><cmd>close<cr><c-w><c-p>]], opts)
  end

  vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  -- vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

  local Terminal = require("toggleterm.terminal").Terminal

  local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, size = 250, direction = "horizontal" })
  function _LAZYGIT_TOGGLE()
    lazygit:toggle()
  end

  local node = Terminal:new({ cmd = "node", hidden = true, size = 80, direction = "horizontal" })
  function _NODE_TOGGLE()
    node:toggle()
  end

  local ncdu = Terminal:new({ cmd = "ncdu", hidden = true, size = 80, direction = "horizontal" })
  function _NCDU_TOGGLE()
    ncdu:toggle()
  end

  local htop = Terminal:new({ cmd = "htop", hidden = true, size = 80, direction = "horizontal" })
  function _HTOP_TOGGLE()
    htop:toggle()
  end

  local bpytop = Terminal:new({ cmd = "bpytop", hidden = true, size = 80, direction = "horizontal" })
  function _BPYTOP_TOGGLE()
    bpytop:toggle()
  end

  local btop = Terminal:new({ cmd = "btop", hidden = true, size = 80, direction = "horizontal" })
  function _BTOP_TOGGLE()
    btop:toggle()
  end

  local python = Terminal:new({ cmd = "python", hidden = true, size = 80, direction = "horizontal" })
  function _PYTHON_TOGGLE()
    python:toggle()
  end
end

return M
