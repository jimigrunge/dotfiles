-- Treesitter configurations and abstraction layer.
local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  commit = "581e87ba4e509a50689fcdd538e5f9388845eb78",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter",
      commit = "dd0b2036c3a27cb6e6486f8bd24188c6ca43af0b"
    },
    {
      "nvim-treesitter/playground",
      commit = "ba48c6a62a280eefb7c85725b0915e021a1a0749"
    }
  }
}

function M.config()
  local status_ok, configs = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    print "Treesitter not loaded"
    return
  end

  local wk = require "which-key"
  wk.register {
    ["<leader>lm"] = { "<cmd>lua require'nvim-treesitter.textobjects.swap'.swap_previous('@parameter.inner')<cr>", "Swap next param" },
    ["<leader>ln"] = { "<cmd>lua require'nvim-treesitter.textobjects.swap'.swap_next('@parameter.inner')<cr>", "Swap prev param" },
    ["<leader>lt"] = { "<cmd>lua require'nvim-treesitter.textobjects.lsp_interop'.peek_definition_code('@function.outer')<cr>", "Peek DefCode Func" },
    ["<leader>lT"] = { "<cmd>lua require'nvim-treesitter.textobjects.lsp_interop'.peek_definition_code('@class.outer')<cr>", "Peek DefCode Class" },
  }

  local bladeGrp
  vim.api.nvim_create_augroup("BladeFiltypeRelated", { clear = true })
  vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.blade.php",
    group = bladeGrp,
    callback = function()
      vim.opt.filetype = "blade"
    end,
  })

  ---@class ParserInfo
  local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
  parser_config.blade = {
    install_info = {
      url = "https://github.com/EmranMR/tree-sitter-blade",
      files = { "src/parser.c" },
      branch = "main",
    },
    filetype = "blade"
  }
  vim.filetype.add({
    pattern = {
      [".*%.blade%.php"] = "blade",
    },
  })

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
        border = "none",
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
    playground = {
      enable = true,
      disable = {},
      updatetime = 25,       -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
    endwise = {
      enable = true,
    }
  }
end

return M
