local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  print 'Treesitter not loaded'
  return
end

configs.setup {
  ensure_installed = "all",      -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false,          -- install languages synchronously (only applied to `ensure_installed`)
  auto_install = true,
  ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true,    -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  modules = {},
  -- Tresitter-Textobjects plugin
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
      enable = true, -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      include_surrounding_whitespace = false,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm:
        -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/blob/master/queries/c/textobjects.scm
        ["af"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
        ["if"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },
        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
        ["ab"] = { query = "@block.outer", desc = "Select outer part of a block" },
        ["ib"] = { query = "@block.inner", desc = "Select inner part of a block" },
        ["as"] = { query = "@statement.outer", desc = "Select outer part of a statement" },
        ["is"] = { query = "@statement.inner", desc = "Select inner part of a statement" },
      },
    },
  },
}
