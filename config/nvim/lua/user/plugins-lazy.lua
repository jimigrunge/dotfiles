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
    -- An implementation of the Popup API from vim in Neovim
    { "nvim-lua/popup.nvim"
      ,commit = "b7404d35d5d3548a82149238289fa71f7f6de4ac"
    },
    -- Useful lua functions used by lots of plugins
    { "nvim-lua/plenary.nvim"
      ,commit = "50012918b2fc8357b87cff2a7f7f0446e47da174"
    },
    -- Greeter window
    { "goolord/alpha-nvim"
      ,commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31"
    },
    -- Smooth scrolling
    {
      "karb94/neoscroll.nvim",
      commit = "4bc0212e9f2a7bc7fe7a6bceb15b33e39f0f41fb",
      config = function()
        require('neoscroll').setup()
      end
    },
    { "dstein64/nvim-scrollview"
      ,commit = "e8befc94ea66194700495d2f71419ba112634b0b"
    },
    -- Navigation between vim and tmux
    {
      "christoomey/vim-tmux-navigator"
      ,commit = "7db70e08ea03b3e4d91f63713d76134512e28d7e"
    },
    {
      "roobert/search-replace.nvim",
      config = function()
        require("search-replace").setup()
      end,
    },
    {
      "utilyre/barbecue.nvim",
      commit = "d38a2a023dfb1073dd0e8fee0c9be08855d3688f",
      version = "*",
      dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
      },
      config = function()
        require("barbecue").setup()
      end,
    },
    {
      "chrishrb/gx.nvim",
      commit = "38d776a0b35b9daee5020bf3336564571dc785af",
      event = { "BufEnter" },
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("gx").setup {
          open_browser_app = "open", -- specify your browser app; default for macOS is "open" and for Linux "xdg-open"
          open_browser_args = { "--background" }, -- specify any arguments, such as --background for macOS' "open".
          handlers = {
            plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
            github = true, -- open github issues
            package_json = true, -- open dependencies from package.json
          },
        }
      end
    },
    -- Autopairs, integrates with both cmp and treesitter
    { "windwp/nvim-autopairs"
      ,commit = "0f04d78619cce9a5af4f355968040f7d675854a1"
    },
    { "windwp/nvim-ts-autotag"
      ,commit = "6be1192965df35f94b8ea6d323354f7dc7a557e4"
    },
    { "anuvyklack/nvim-keymap-amend"
      ,commit = "b8bf9d820878d5497fdd11d6de55dea82872d98e"
    },
    -- Code folding
    { "anuvyklack/fold-preview.nvim"
      ,commit = "b7920cb0aba2b48a6b679bff45f98c3ebc0f0b89"
    },
    { "anuvyklack/pretty-fold.nvim"
      ,commit = "a7d8b424abe0eedf50116c460fbe6dfd5783b1d5"
    },
    {
      'AckslD/nvim-trevJ.lua',
      commit = "7f401543b5cd5496b6120dddcab394c29983a55c",
      config = 'require("trevj").setup()',
      init = function()
        vim.keymap.set('n', '<leader>j', function()
          require('trevj').format_at_cursor()
        end, { noremap = true, silent = true })
      end,
    },
    -- Easily comment stuff
    { "numToStr/Comment.nvim"
      ,commit = "0236521ea582747b58869cb72f70ccfa967d2e89"
    },
    -- Surround text
    { "ur4ltz/surround.nvim"
      ,commit = "36c253d6470910692491b13382f54c9bab2811e1"
    },
    -- File icons
    { "nvim-tree/nvim-web-devicons"
      ,commit = "5de460ca7595806044eced31e3c36c159a493857"
    },
    { "ryanoasis/vim-devicons"
      ,commit = "71f239af28b7214eebb60d4ea5bd040291fb7e33"
    },
    -- Sidebar directory tree
    {
      "nvim-tree/nvim-tree.lua",
      commit = "78a9ca5ed6557f29cd0ce203df44213e54bfabb9",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
    },
    -- Tabs for buffers
    {
      "akinsho/bufferline.nvim",
      commit = "357cc8f8eeb64702e6fcf2995e3b9becee99a5d3",
    },
    -- Delete buffers without closing your window
    { "moll/vim-bbye"
      ,commit = "25ef93ac5a87526111f43e5110675032dbcacf56"
    },
    -- Status bar
    {
      "nvim-lualine/lualine.nvim",
      commit = "2248ef254d0a1488a72041cfb45ca9caada6d994",
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    -- Symbol view of document structure
    { "simrat39/symbols-outline.nvim"
      ,commit = "512791925d57a61c545bc303356e8a8f7869763c"
    },
    -- Terminal windows inside of Nvim
    { "akinsho/toggleterm.nvim",
      version = '*'
    },
    -- Project management
    {
      "folke/persistence.nvim",
      commit = "ad538bfd5336f1335cdb6fd4e0b0eebfa6e12f32",
      event = "BufReadPre", -- this will only start session saving when an actual file was opened
      config = function()
        require("persistence").setup()
      end,
    },
    -- Indentation guides
    { "lukas-reineke/indent-blankline.nvim"
      ,commit = "046e2cf04e08ece927bacbfb87c5b35c0b636546"
      ,main = "ibl"
    },
    -- Keymap cheatsheet
    { "folke/which-key.nvim"
      ,commit = "4433e5ec9a507e5097571ed55c02ea9658fb268a"
    },
    -- { "nordtheme/vim"
    --   ,commit = "f13f5dfbb784deddbc1d8195f34dfd9ec73e2295"
    -- },
    -- { "dracula/vim"
    --   ,commit = "b2cc39273abbb6b38a3d173d2a5d8c2d1c79fc19"
    -- },
    { "shaunsingh/moonlight.nvim"
      ,commit = "e24e4218ec680b6396532808abf57ca0ada82e66"
    },
    { "lunarvim/darkplus.nvim"
      ,commit = "7c236649f0617809db05cd30fb10fed7fb01b83b"
    },
    { "folke/tokyonight.nvim"
      ,commit = "f247ee700b569ed43f39320413a13ba9b0aef0db" --v2
    },
    {
      "Mofiqul/vscode.nvim",
      commit = "563e3f671543ba14f23ccb57020a428add640d02",
      lazy = false
    },
    { "lunarvim/colorschemes"
      ,commit = "e29f32990d6e2c7c3a4763326194fbd847b49dac"
    },
    -- cmp Completion plugins
    { "hrsh7th/nvim-cmp",
      commit = "51260c02a8ffded8e16162dcf41a23ec90cfba62"
    },
    { "hrsh7th/cmp-buffer",
      commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa"
    },
    { "hrsh7th/cmp-path",
      commit = "91ff86cd9c29299a64f968ebb45846c485725f23"
    },
    { "hrsh7th/cmp-cmdline",
      commit = "8ee981b4a91f536f52add291594e89fb6645e451"
    },
    { "saadparwaiz1/cmp_luasnip",
      commit = "05a9ab28b53f71d1aece421ef32fee2cb857a843"
    },
    { "hrsh7th/cmp-nvim-lsp",
      commit = "44b16d11215dce86f253ce0c30949813c0a90765"
    },
    { "hrsh7th/cmp-nvim-lua",
      commit = "f12408bdb54c39c23e67cab726264c10db33ada8"
    },
    -- Snippets
    { "L3MON4D3/LuaSnip",
      commit = "80a8528f084a97b624ae443a6f50ff8074ba486b"
    },
    { "rafamadriz/friendly-snippets",
      commit = "43727c2ff84240e55d4069ec3e6158d74cb534b6"
    },
    {
      "Exafunction/codeium.nvim",
      commit = "822e762567a0bf50b1a4e733c8c93691934d7606",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
      },
      config = function()
        require("codeium").setup({
        })
      end
    },
    -- LSP
    { "neovim/nvim-lspconfig",
      commit = "6428fcab6f3c09e934bc016c329806314384a41e"
    },
    { "williamboman/mason.nvim",
      commit = "cd7835b15f5a4204fc37e0aa739347472121a54c"
    },
    { "williamboman/mason-lspconfig.nvim",
      commit = "a8d5db8f227b9b236d1c54a9c6234bc033825ce7"
    },
    { "tamago324/nlsp-settings.nvim",
      commit = "2a52e793d4f293c0e1d61ee5794e3ff62bfbbb5d"
    },
    --[[ { "jose-elias-alvarez/null-ls.nvim", ]]
    --[[   commit = "0010ea927ab7c09ef0ce9bf28c2b573fc302f5a7" ]]
    --[[ }, ]]
    { "nvimtools/none-ls.nvim",
      commit = "b8fd44ee1616e6a9c995ed5f94ad9f1721d303ef"
    },
    { "jayp0521/mason-null-ls.nvim"
      , commit = "ae0c5fa57468ac65617f1bf821ba0c3a1e251f0c"
    },
    { "RishabhRD/popfix",
      commit = "bf3cc436df63cd535350d5ef1b951c91554d4b01"
    },
    { "RishabhRD/nvim-lsputils",
      commit = "ae1a4a62449863ad82c70713d5b6108f3a07917c"
    },
    { "ray-x/lsp_signature.nvim",
      commit = "33250c84c7a552daf28ac607d9d9e82f88cd0907"
    },
    { "kosayoda/nvim-lightbulb",
      commit = "8f00b89dd1b1dbde16872bee5fbcee2e58c9b8e9"
    },
    {
      "weilbith/nvim-code-action-menu",
      commit = "e4399dbaf6eabff998d3d5f1cbcd8d9933710027",
      cmd = 'CodeActionMenu',
    },
    {
      "SmiteshP/nvim-navic",
      commit = "0ffa7ffe6588f3417e680439872f5049e38a24db",
      dependencies = "neovim/nvim-lspconfig"
    },
    { "RRethy/vim-illuminate",
      commit = "3bd2ab64b5d63b29e05691e624927e5ebbf0fb86"
    },
    { "MunifTanjim/nui.nvim",
      commit = "c0c8e347ceac53030f5c1ece1c5a5b6a17a25b32"
    },
    {
      "CosmicNvim/cosmic-ui",
      commit = "c0b14531999f2bfef3d927c4dcd57a1a8fed5ee9",
      dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    },
    {
      "gennaro-tedesco/nvim-jqx",
      commit = "11b1d0368e5b23b9c356da8e5f70bb5827f27f62"
    },
    -- Diagnostics
    { "creativenull/diagnosticls-configs-nvim",
      commit = "2cb68fa91d99c77264f95a3d8918ee60c8095cd6"
    },
    {
      "folke/trouble.nvim",
      commit = "f1168feada93c0154ede4d1fe9183bf69bac54ea",
      cmd = "TroubleToggle",
    },
    {
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      commit = "9e3f99fbbd28aaec80dc0158c43be8cca8dd5017",
      config = function()
        require("lsp_lines").setup()
      end,
    },
    -- Whitespace
    { "ntpeters/vim-better-whitespace",
      commit = "1b22dc57a2751c7afbc6025a7da39b7c22db635d"
    },
    -- Telescope
    { "junegunn/fzf",
      commit = "d02b9442a56ec03dbb905d432762cf545603ef07"
    },
    { 'nvim-telescope/telescope-fzf-native.nvim'
      ,build = 'make'
      ,commit = "6c921ca12321edaa773e324ef64ea301a1d0da62"
    },
    { "nvim-telescope/telescope.nvim",
      branch = '0.1.x',
    },
    { "nvim-telescope/telescope-media-files.nvim",
      commit = "0826c7a730bc4d36068f7c85cf4c5b3fd9fb570a"
    },
    {
      "folke/todo-comments.nvim",
      event = "BufRead",
      config = function()
        require("todo-comments").setup()
      end,
      commit = "3094ead8edfa9040de2421deddec55d3762f64d1"
    },
    -- Treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      commit = "107e61afb7129d637ea6c3c68b97a22194b0bf16",
      build = ":TSUpdate",
    },
    { "JoosepAlviste/nvim-ts-context-commentstring",
      commit = "92e688f013c69f90c9bbd596019ec10235bc51de"
    },
    { "nvim-treesitter/nvim-treesitter-textobjects",
      commit = "eb208bfdfcf76efea0424747e23e44641e13aaa6"
    },
    { "nvim-treesitter/playground",
      commit = "ba48c6a62a280eefb7c85725b0915e021a1a0749"
    },
    { "ThePrimeagen/refactoring.nvim",
      commit = "5831194debd23920a32abd9fefd5dddba44e34fc"
    },
    { "danymat/neogen",
      commit = "70127baaff25611deaf1a29d801fc054ad9d2dc1"
    },
    { "nvim-treesitter/nvim-treesitter-context",
      commit = "8aa32aa6b84dda357849dbc0f775e69f2e04c041"
    },
    -- Git
    { "lewis6991/gitsigns.nvim",
      commit = "5a9a6ac29a7805c4783cda21b80a1e361964b3f2"
    },
    { "tpope/vim-fugitive",
      commit = "cbe9dfa162c178946afa689dd3f42d4ea8bf89c1"
    },
    {
      "sindrets/diffview.nvim",
      commit = "d38c1b5266850f77f75e006bcc26213684e1e141",
      event = "BufRead",
      dependencies = "nvim-lua/plenary.nvim"
    },
    {
      'ruifm/gitlinker.nvim'
    },
    -- Color preview/picker
    { "norcalli/nvim-colorizer.lua",
      commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6"
    },
    {
      "ziontee113/color-picker.nvim",
      commit = "06cb5f853535dea529a523e9a0e8884cdf9eba4d",
      config = function()
        require("color-picker")
      end,
    },
    {
      "stevearc/dressing.nvim",
      commit = "1f2d1206a03bd3add8aedf6251e4534611de577f",
    },
    {
      "ziontee113/icon-picker.nvim",
      commit = "8e89c06411584e02a928b3baaee056eab24466b3",
      config = function()
        require("icon-picker").setup({
          disable_legacy_commands = true
        })
      end,
    },
    -- Markdown preview
    {
      "ellisonleao/glow.nvim",
      commit = "5b38fb7b6e806cac62707a4aba8c10c5f14d5bb5",
      branch = "main",
    },
    -- Popup notifications
    { "rcarriga/nvim-notify"
      ,commit = "e4a2022f4fec2d5ebc79afa612f96d8b11c627b3"
    },
    -- Display processing progress
    { "j-hui/fidget.nvim",
      commit = "90c22e47be057562ee9566bad313ad42d622c1d3" -- Pin to legacy tag
    },
    -- Searchable cheatsheet using Telescope
    { "sudormrfbin/cheatsheet.nvim",
      commit = "9716f9aaa94dd1fd6ce59b5aae0e5f25e2a463ef"
    },
    -- DAP debug adapter
    { "mfussenegger/nvim-dap",
      commit = "3eb26a63a3674e3722182a92f21d04c4e5ce0f43"
    },
    { "rcarriga/nvim-dap-ui",
      commit = "34160a7ce6072ef332f350ae1d4a6a501daf0159"
    },
    { "mxsdev/nvim-dap-vscode-js",
      commit = "03bd29672d7fab5e515fc8469b7d07cc5994bbf6",
      dependencies = {"mfussenegger/nvim-dap"}
    },
  }
})
