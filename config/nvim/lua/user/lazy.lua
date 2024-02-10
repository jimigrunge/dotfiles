local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    {
      "yutkat/confirm-quit.nvim",
      event = "CmdlineEnter",
      opts = {},
      commit = "78a1ba1c5e307c85f102d1dba398bcc13464a820",
    },
    -- Useful lua functions used by lots of plugins
    {
      "nvim-lua/plenary.nvim",
      commit = "55d9fe89e33efd26f532ef20223e5f9430c8b0c0",
    },
    -- Greeter window
    {
      "goolord/alpha-nvim",
      commit = "29074eeb869a6cbac9ce1fbbd04f5f5940311b32",
    },
    -- Smooth scrolling
    {
      "karb94/neoscroll.nvim",
      config = function()
        require('neoscroll').setup()
      end,
      commit = "be4ebf855a52f71ca4338694a5696675d807eff9",
    },
    {
      "dstein64/nvim-scrollview",
      commit = "3572a6772b3cfc79031891cd2b8bb1708dc4b458",
    },
    -- Navigation between vim and tmux
    {
      "christoomey/vim-tmux-navigator",
      commit = "38b1d0402c4600543281dc85b3f51884205674b6",
    },
    {
      "roobert/search-replace.nvim",
      config = function()
        require("search-replace").setup()
      end,
      commit = "d92290a02d97f4e9b8cd60d28b56b403432158d5",
    },
    {
      "utilyre/barbecue.nvim",
      version = "*",
      dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
      },
      config = function()
        require("barbecue").setup()
      end,
      commit = "d38a2a023dfb1073dd0e8fee0c9be08855d3688f",
    },
    {
      "chrishrb/gx.nvim",
      event = { "BufEnter" },
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("gx").setup {
          open_browser_app = "open",              -- specify your browser app; default for macOS is "open" and for Linux "xdg-open"
          open_browser_args = { "--background" }, -- specify any arguments, such as --background for macOS' "open".
          handlers = {
            plugin = true,                        -- open plugin links in lua (e.g. packer, lazy, ..)
            github = true,                        -- open github issues
            package_json = true,                  -- open dependencies from package.json
          },
        }
      end,
      commit = "38d776a0b35b9daee5020bf3336564571dc785af",
    },
    -- Autopairs, integrates with both cmp and treesitter
    {
      "windwp/nvim-autopairs",
      commit = "9fd41181693dd4106b3e414a822bb6569924de81",
    },
    {
      "windwp/nvim-ts-autotag",
      commit = "8515e48a277a2f4947d91004d9aa92c29fdc5e18",
    },
    {
      "anuvyklack/nvim-keymap-amend",
      commit = "b8bf9d820878d5497fdd11d6de55dea82872d98e",
    },
    -- Code folding
    {
      "anuvyklack/fold-preview.nvim",
      config = function()
        require('fold-preview').setup()
      end,
      commit = "b7920cb0aba2b48a6b679bff45f98c3ebc0f0b89",
    },
    {
      "anuvyklack/pretty-fold.nvim",
      config = function()
        require('pretty-fold').setup({})
      end,
      commit = "a7d8b424abe0eedf50116c460fbe6dfd5783b1d5",
    },
    {
      'Wansmer/treesj',
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
      config = function()
        require('treesj').setup()
      end,
      commit = "14808da3cddd62fc86ede53a5ea1fd1635897e75"
    },
    {
      "EmranMR/tree-sitter-blade",
      commit = "01e5550cb60ef3532ace0c6df0480f6f406113ff",
    },
    -- Easily comment stuff
    {
      "numToStr/Comment.nvim",
      commit = "0236521ea582747b58869cb72f70ccfa967d2e89",
    },
    -- Surround text
    {
      "ur4ltz/surround.nvim",
      commit = "36c253d6470910692491b13382f54c9bab2811e1",
    },
    -- File icons
    {
      "nvim-tree/nvim-web-devicons",
      commit = "584038666b0d8124d452a2e8ea9e38e6d6e56490",
    },
    {
      "ryanoasis/vim-devicons",
      commit = "71f239af28b7214eebb60d4ea5bd040291fb7e33",
    },
    -- Sidebar directory tree
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      commit = "b8c3a23e76f861d5f0ff3f6714b9b56388984d0b",
    },
    -- Tabs for buffers
    {
      "akinsho/bufferline.nvim",
      commit = "e48ce1805697e4bb97bc171c081e849a65859244",
    },
    -- Delete buffers without closing your window
    {
      "moll/vim-bbye",
      commit = "25ef93ac5a87526111f43e5110675032dbcacf56",
    },
    -- Status bar
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      commit = "566b7036f717f3d676362742630518a47f132fff",
    },
    -- Symbol view of document structure
    {
      "simrat39/symbols-outline.nvim",
      commit = "564ee65dfc9024bdde73a6621820866987cbb256",
    },
    -- Terminal windows inside of Nvim
    {
      "akinsho/toggleterm.nvim",
      commit = "e3805fed94d487b81e9c21548535cc820f62f840",
    },
    -- Project management
    {
      "folke/persistence.nvim",
      event = "BufReadPre", -- this will only start session saving when an actual file was opened
      config = function()
        require("persistence").setup()
      end,
      commit = "ad538bfd5336f1335cdb6fd4e0b0eebfa6e12f32",
    },
    {
      "ahmedkhalf/project.nvim",
      commit = "8c6bad7d22eef1b71144b401c9f74ed01526a4fb",
    },
    -- Indentation guides
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      commit = "12e92044d313c54c438bd786d11684c88f6f78cd",
    },
    -- Keymap cheatsheet
    {
      "folke/which-key.nvim",
      commit = "4433e5ec9a507e5097571ed55c02ea9658fb268a",
    },
    {
      "Mofiqul/vscode.nvim",
      lazy = false,
      priority = 1000,
      commit = "39841d05ab4a5c03ea0985196b9f3dfa48d83411",
    },
    {
      "lunarvim/colorschemes",
      commit = "e29f32990d6e2c7c3a4763326194fbd847b49dac",
    },
    -- cmp Completion plugins
    {
      "hrsh7th/nvim-cmp",
      commit = "538e37ba87284942c1d76ed38dd497e54e65b891",
    },
    {
      "hrsh7th/cmp-buffer",
      commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
    },
    {
      "hrsh7th/cmp-path",
      commit = "91ff86cd9c29299a64f968ebb45846c485725f23",
    },
    {
      "hrsh7th/cmp-cmdline",
      commit = "8ee981b4a91f536f52add291594e89fb6645e451",
    },
    {
      "saadparwaiz1/cmp_luasnip",
      commit = "05a9ab28b53f71d1aece421ef32fee2cb857a843",
    },
    {
      "hrsh7th/cmp-nvim-lsp",
      commit = "5af77f54de1b16c34b23cba810150689a3a90312",
    },
    {
      "hrsh7th/cmp-nvim-lua",
      commit = "f12408bdb54c39c23e67cab726264c10db33ada8",
    },
    -- Snippets
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
      version = "v2.2.*",
    },
    {
      "rafamadriz/friendly-snippets",
      commit = "69a2c1675b66e002799f5eef803b87a12f593049",
    },
    {
      "jackMort/ChatGPT.nvim",
      event = "VeryLazy",
      commit = "16eddf50d92fd089726f78d039982f8561bf90e6",
      dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim",
        "nvim-telescope/telescope.nvim"
      }
    },
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      commit = "b03617a6dc4bc88b65ab5deac1631da9a9c2dcaf"
    },
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
    {
      "David-Kunz/cmp-npm",
      dependencies = { 'nvim-lua/plenary.nvim' },
      ft = "json",
      commit = "2337f109f51a09297596dd6b538b70ccba92b4e4",
    },
    {
      "SergioRibera/cmp-dotenv",
      commit = "fd78929551010bc20602e7e663e42a5e14d76c96",
    },
    -- LSP
    {
      "folke/neodev.nvim",
      opts = {},
      commit = "dde00106b9094f101980b364fae02fd85d357306",
    },
    {
      "neovim/nvim-lspconfig",
      commit = "d29be376e64c23d6465ef3fb71aaf4bf4e8e0e68",
    },
    {
      "williamboman/mason.nvim",
      commit = "e110bc3be1a7309617cecd77bfe4bf86ba1b8134",
    },
    {
      "williamboman/mason-lspconfig.nvim",
      commit = "0989bdf4fdf7b5aa4c74131d7ffccc3f399ac788",
    },
    {
      "tamago324/nlsp-settings.nvim",
      commit = "2a52e793d4f293c0e1d61ee5794e3ff62bfbbb5d",
    },
    {
      "nvimtools/none-ls.nvim",
      dependencies = { "mason.nvim" },
      commit = "7e146f3a188853843bb4ca1bff24c912bb9b7177",
    },
    {
      "jayp0521/mason-null-ls.nvim",
      commit = "558de4372d23bd432cc3594666c4d812cd071bbf",
    },
    {
      "RishabhRD/popfix",
      commit = "bf3cc436df63cd535350d5ef1b951c91554d4b01",
    },
    {
      "RishabhRD/nvim-lsputils",
      commit = "ae1a4a62449863ad82c70713d5b6108f3a07917c",
    },
    {
      "ray-x/lsp_signature.nvim",
      commit = "fed2c8389c148ff1dfdcdca63c2b48d08a50dea0",
    },
    {
      "kosayoda/nvim-lightbulb",
      commit = "8f00b89dd1b1dbde16872bee5fbcee2e58c9b8e9",
    },
    {
      "weilbith/nvim-code-action-menu",
      cmd = 'CodeActionMenu',
      commit = "8c7672a4b04d3cc4edd2c484d05b660a9cb34a1b",
    },
    {
      "SmiteshP/nvim-navic",
      dependencies = "neovim/nvim-lspconfig",
      commit = "8649f694d3e76ee10c19255dece6411c29206a54",
    },
    {
      "RRethy/vim-illuminate",
      commit = "3bd2ab64b5d63b29e05691e624927e5ebbf0fb86",
    },
    {
      "MunifTanjim/nui.nvim",
      commit = "35da9ca1de0fc4dda96c2e214d93d363c145f418",
    },
    {
      "CosmicNvim/cosmic-ui",
      dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
      commit = "c0b14531999f2bfef3d927c4dcd57a1a8fed5ee9",
    },
    {
      "gennaro-tedesco/nvim-jqx",
      commit = "11b1d0368e5b23b9c356da8e5f70bb5827f27f62",
    },
    {
      "b0o/schemastore.nvim",
      commit = "d9de9914da37b54a53edec6923e1893c2262e236",
    },
    -- Diagnostics
    {
      "creativenull/diagnosticls-configs-nvim",
      commit = "2cb68fa91d99c77264f95a3d8918ee60c8095cd6",
    },
    {
      "folke/trouble.nvim",
      cmd = "TroubleToggle",
      commit = "f1168feada93c0154ede4d1fe9183bf69bac54ea",
    },
    {
      "ErichDonGubler/lsp_lines.nvim",
      config = function()
        require("lsp_lines").setup()
      end,
      commit = "3b57922d2d79762e6baedaf9d66d8ba71f822816",
    },
    -- Whitespace
    {
      "ntpeters/vim-better-whitespace",
      commit = "4d45b4a9b59faffa75a3662c448b8e500db07703",
    },
    -- Telescope
    {
      "junegunn/fzf",
      commit = "e4d0f7acd516d8f5869d3a2210fbf552743a129a",
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = 'make',
      commit = "6c921ca12321edaa773e324ef64ea301a1d0da62",
    },
    {
      "nvim-telescope/telescope.nvim",
      branch = '0.1.x',
    },
    {
      "nvim-telescope/telescope-media-files.nvim",
      commit = "0826c7a730bc4d36068f7c85cf4c5b3fd9fb570a",
    },
    {
      "folke/noice.nvim",
      -- event = "VeryLazy",
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
      commit = "bf67d70bd7265d075191e7812d8eb42b9791f737",
    },
    {
      "folke/todo-comments.nvim",
      event = "BufRead",
      config = function()
        require("todo-comments").setup()
      end,
      commit = "4a6737a8d70fe1ac55c64dfa47fcb189ca431872",
    },
    -- Treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      commit = "8cd2b230174efbf7b5d9f49fe2f90bda6b5eb16e",
    },
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      commit = "1277b4a1f451b0f18c0790e1a7f12e1e5fdebfee",
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      commit = "85b9d0cbd4ff901abcda862b50dbb34e0901848b",
    },
    {
      "nvim-treesitter/playground",
      commit = "ba48c6a62a280eefb7c85725b0915e021a1a0749",
    },
    {
      "ThePrimeagen/refactoring.nvim",
      commit = "c067e44b8171494fc1b5206ab4c267cd74c043b1",
    },
    {
      "danymat/neogen",
      commit = "70127baaff25611deaf1a29d801fc054ad9d2dc1",
    },
    {
      "nvim-treesitter/nvim-treesitter-context",
      commit = "400a99ad43ac78af1148061da3491cba2637ad29",
    },
    -- Git
    {
      "lewis6991/gitsigns.nvim",
      commit = "4aaacbf5e5e2218fd05eb75703fe9e0f85335803",
    },
    {
      "tpope/vim-fugitive",
      commit = "59659093581aad2afacedc81f009ed6a4bfad275",
    },
    {
      "sindrets/diffview.nvim",
      event = "BufRead",
      dependencies = "nvim-lua/plenary.nvim",
      commit = "3dc498c9777fe79156f3d32dddd483b8b3dbd95f",
    },
    {
      "linrongbin16/gitlinker.nvim",
      commit = "008d8d7f8218d38bf87ae4c3f61a42843c31a8f1",
    },
    -- Color preview/picker
    {
      "norcalli/nvim-colorizer.lua",
      commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6",
    },
    {
      "ziontee113/color-picker.nvim",
      config = function()
        require("color-picker")
      end,
      commit = "06cb5f853535dea529a523e9a0e8884cdf9eba4d",
    },
    {
      "stevearc/dressing.nvim",
      commit = "94b0d24483d56f3777ee0c8dc51675f21709318c",
    },
    {
      "ziontee113/icon-picker.nvim",
      config = function()
        require("icon-picker").setup({
          disable_legacy_commands = true
        })
      end,
      commit = "3ee9a0ea9feeef08ae35e40c8be6a2fa2c20f2d3",
    },
    -- Markdown preview
    {
      "ellisonleao/glow.nvim",
      branch = "main",
      commit = "238070a686c1da3bccccf1079700eb4b5e19aea4",
    },
    -- Popup notifications
    {
      "rcarriga/nvim-notify",
      commit = "1576123bff3bed67bc673a3076e591abfe5d8ca9",
    },
    -- Display processing progress
    {
      "j-hui/fidget.nvim",
      commit = "3a93300c076109d86c7ce35ec67a8034ae6ba9db",
    },
    -- Searchable cheatsheet using Telescope
    {
      "sudormrfbin/cheatsheet.nvim",
      commit = "9716f9aaa94dd1fd6ce59b5aae0e5f25e2a463ef",
    },
    -- DAP debug adapter
    {
      "mfussenegger/nvim-dap",
      commit = "9adbfdca13afbe646d09a8d7a86d5d031fb9c5a5",
      -- commit = "aad46274f09ba29933e4cef2257cdda5ec19cf7a",
    },
    {
      "rcarriga/nvim-dap-ui",
      commit = "d845ebd798ad1cf30aa4abd4c4eff795cdcfdd4f",
      -- commit = "7e5e16427aaf814dc2d58e1b219def9ef2fa2435",
    },
    {
      "mxsdev/nvim-dap-vscode-js",
      dependencies = { "mfussenegger/nvim-dap" },
      commit = "03bd29672d7fab5e515fc8469b7d07cc5994bbf6",
      -- commit = "03bd29672d7fab5e515fc8469b7d07cc5994bbf6",
    },
  }
})
