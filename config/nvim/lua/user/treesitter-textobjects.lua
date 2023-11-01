local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  print 'Treesitter Configs textobjects not loaded'
	return
end

treesitter_configs.setup {
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ["<leader>lm"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>ln"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = {
        ["<leader>lt"] = "@function.outer",
        ["<leader>lT"] = "@class.outer",
      },
    },
    select = {
      enable = true,  -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      include_surrounding_whitespace = false,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm:
        -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/blob/master/queries/c/textobjects.scm
        ["af"] = {query = "@function.outer"},
        ["if"] = {query = "@function.inner"},
        ["ac"] = {query = "@class.outer"},
        ["ic"] = {query = "@class.inner"},
        ["ab"] = {query = "@block.outer"},
        ["ib"] = {query = "@block.inner"},
        ["as"] = {query = "@statement.outer"},
        ["is"] = {query = "@statement.inner"},
      },
    },
  },
}

