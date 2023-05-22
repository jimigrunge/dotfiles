local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  max_jobs = 10,
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Have packer manage itself
  use { "wbthomason/packer.nvim" }

  -- An implementation of the Popup API from vim in Neovim
  use { "nvim-lua/popup.nvim"
    ,commit = "b7404d35d5d3548a82149238289fa71f7f6de4ac"
  }

  -- Useful lua functions used by lots of plugins
  use { "nvim-lua/plenary.nvim"
    ,commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7"
  }

  -- Greeter window
  use { "goolord/alpha-nvim"
    ,commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31"
  }

  -- Smooth scrolling
  use {
    "karb94/neoscroll.nvim",
    commit = "54c5c419f6ee2b35557b3a6a7d631724234ba97a",
    config = function()
      require('neoscroll').setup()
    end
  }
  use { "dstein64/nvim-scrollview"
    ,commit = "c0699da2f00976943d39c7b32c015c768f68e74b"
  }

  -- Navigation between vim and tmux
  use {
    "christoomey/vim-tmux-navigator"
    ,commit = "cdd66d6a37d991bba7997d593586fc51a5b37aa8"
  }

  use {
    "chrishrb/gx.nvim",
    commit = "e5b76942ea67affe791d0fb5a65e2139b5544ae3",
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
  }

  -- Autopairs, integrates with both cmp and treesitter
  use { "windwp/nvim-autopairs"
    ,commit = "7470af886ffb3df32800e5ef9c072a6cd825770d"
  }
  use { "windwp/nvim-ts-autotag"
    ,commit = "b525525b6aba20763e19011a73454845170850d7"
  }

  -- Amend keymap method calls
  use { "anuvyklack/nvim-keymap-amend"
    ,commit = "b8bf9d820878d5497fdd11d6de55dea82872d98e"
  }

  -- Code folding
  use { "anuvyklack/fold-preview.nvim"
    ,commit = "b7920cb0aba2b48a6b679bff45f98c3ebc0f0b89"
  }
  use { "anuvyklack/pretty-fold.nvim"
    ,commit = "a7d8b424abe0eedf50116c460fbe6dfd5783b1d5"
  }
  use {
    'AckslD/nvim-trevJ.lua',
    commit = "7f401543b5cd5496b6120dddcab394c29983a55c",
    config = 'require("trevj").setup()',
    init = function()
      vim.keymap.set('n', '<leader>j', function()
        require('trevj').format_at_cursor()
      end, { noremap = true, silent = true })
    end,
  }

  -- Easily comment stuff
  use { "numToStr/Comment.nvim"
    ,commit = "ab62084fa992ed7ee3c19bbb5227ce2c4234612b"
  }

  -- Surround text
  use { "ur4ltz/surround.nvim"
    ,commit = "36c253d6470910692491b13382f54c9bab2811e1"
  }

  -- File icons
  use { "kyazdani42/nvim-web-devicons"
    ,commit = "4ec26d67d419c12a4abaea02f1b6c57b40c08d7e"
  }
  use { "ryanoasis/vim-devicons"
    ,commit = "71f239af28b7214eebb60d4ea5bd040291fb7e33"
  }

  -- Sidebar directory tree
  use {
    "kyazdani42/nvim-tree.lua",
    commit = "48d53a5934fbd51b655d03db7dad35551838f2c9",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    --[[ tag = "nightly", ]]
  }

  -- Tabs for buffers
  use {
    "akinsho/bufferline.nvim",
    commit = "5aa803aaa9d8bbbca77d0c8df8ddc0b62c19ff6a",
    tag = "v2.*"
  }

  -- Delete buffers without closing your window
  use { "moll/vim-bbye"
    ,commit = "25ef93ac5a87526111f43e5110675032dbcacf56"
  }

  -- Status bar
  use {
    "nvim-lualine/lualine.nvim",
    commit = "84ffb80e452d95e2c46fa29a98ea11a240f7843e",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  }

  -- Symbol view of document structure
  use { "simrat39/symbols-outline.nvim"
    ,commit = "512791925d57a61c545bc303356e8a8f7869763c"
  }

  -- Terminal windows inside of Nvim
  use { "akinsho/toggleterm.nvim"
    --[[ ,commit = "2e477f7ee8ee8229ff3158e3018a067797b9cd38" ]]
    , tag = '*'
  }

  -- Project management
  use {
    "folke/persistence.nvim",
    commit = "c814fae5c37aa0aba9cd9da05df6e52b88d612c3",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    config = function()
      require("persistence").setup()
    end,
  }

  -- Speed up loading Lua modules improving startup time
  use { "lewis6991/impatient.nvim"
    ,commit = "c90e273f7b8c50a02f956c24ce4804a47f18162e"
  }

  -- Indentation guides
  use { "lukas-reineke/indent-blankline.nvim"
    ,commit = "018bd04d80c9a73d399c1061fa0c3b14a7614399"
  }

  -- This is needed to fix lsp doc highlight
  use { "antoinemadec/FixCursorHold.nvim"
    ,commit = "1900f89dc17c603eec29960f57c00bd9ae696495"
  }

  -- Keymap cheatsheet
  use { "folke/which-key.nvim"
    ,commit = "4b73390eec680b4c061ea175eb32c0ff3412271d"
  }

  -- Colorschemes
  use { "arcticicestudio/nord-vim"
    ,commit = "f725ac643afce04021c9abcbb57711fcb9fa71e9"
  }
  use { "dracula/vim"
    ,commit = "eb577d47b0cfc9191bf04c414b4042d5f1a980f8"
  }
  use { "shaunsingh/moonlight.nvim"
    ,commit = "e24e4218ec680b6396532808abf57ca0ada82e66"
  }
  use { "lunarvim/darkplus.nvim"
    ,commit = "1a35b1f1a3606cdd914847db962dd0bc362fa706"
  }
  use { "folke/tokyonight.nvim"
    ,commit = "1b0c88094548a62641ece1e668fa9a234e1c539e"
  }
  use {
    "Mofiqul/vscode.nvim",
    commit = "34d1ec135319cd260940ce380f1fb73c047920ea",
    --[[ config = function() ]]
    --[[   require('vscode').change_style("dark") ]]
    --[[ end ]]
  }
  use { "lunarvim/colorschemes"
    ,commit = "e29f32990d6e2c7c3a4763326194fbd847b49dac"
  }

  -- cmp Completion plugins
  use { "hrsh7th/nvim-cmp",
    commit = "777450fd0ae289463a14481673e26246b5e38bf2"
  }
  use { "hrsh7th/cmp-buffer",
    commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa"
  }
  use { "hrsh7th/cmp-path",
    commit = "91ff86cd9c29299a64f968ebb45846c485725f23"
  }
  use { "hrsh7th/cmp-cmdline",
    commit = "8fcc934a52af96120fe26358985c10c035984b53"
  }
  use { "saadparwaiz1/cmp_luasnip",
    commit = "18095520391186d634a0045dacaa346291096566"
  }
  use { "hrsh7th/cmp-nvim-lsp",
    commit = "0e6b2ed705ddcff9738ec4ea838141654f12eeef"
  }
  use { "hrsh7th/cmp-nvim-lua",
    commit = "f3491638d123cfd2c8048aefaf66d246ff250ca6"
  }

  -- Snippets
  use { "L3MON4D3/LuaSnip",
    commit = "dc2e307287e9a9eabc18f0e3984c7e8cb164bb38"
  }
  use { "rafamadriz/friendly-snippets",
    commit = "8d91ba2dc2421a54981115f61b914974f938fa77"
  }
  use { "Pocco81/AbbrevMan.nvim",
    commit = "97b40b51b373d0d1c22f71dd8fce7f61f6bf46a5"
  }

  -- LSP
  use { "neovim/nvim-lspconfig",
    commit = "a83319233284baf32cf7f2bbec4fcb5ca693f82f"
  }
  use { "williamboman/mason.nvim",
    commit = "3fb2be48864b7850a26c54c04cedb54e95dcdf3f"
  }
  use { "williamboman/mason-lspconfig.nvim",
    commit = "a8d5db8f227b9b236d1c54a9c6234bc033825ce7"
  }
  use { "tamago324/nlsp-settings.nvim",
    commit = "fd5ca6e4c2b01f97309e6b515b9957e7454587e1"
  }
  use { "jose-elias-alvarez/null-ls.nvim",
    commit = "f8ffcd7cb8fb3325c711d459152ef132b5b65aed"
  }
  use { "jayp0521/mason-null-ls.nvim"
    , commit = "04fc5094269c4354f0409d515d1d9539a0d076e3"
  }
  use { "RishabhRD/popfix",
    commit = "bf3cc436df63cd535350d5ef1b951c91554d4b01"
  }
  use { "RishabhRD/nvim-lsputils",
    commit = "ae1a4a62449863ad82c70713d5b6108f3a07917c"
  }
  use { "ray-x/lsp_signature.nvim",
    commit = "775c0cdf5be5adcc08f27c9058edb00b5b517520"
  }
  use { "kosayoda/nvim-lightbulb",
    commit = "56b9ce31ec9d09d560fe8787c0920f76bc208297"
  }
  use {
    "weilbith/nvim-code-action-menu",
    commit = "e4399dbaf6eabff998d3d5f1cbcd8d9933710027",
    cmd = 'CodeActionMenu',
  }
  use {
    "SmiteshP/nvim-navic",
    commit = "27124a773d362628b114cd12016e743dab4ccf3e",
    requires = "neovim/nvim-lspconfig"
  }
  use { "RRethy/vim-illuminate",
    commit = "a2907275a6899c570d16e95b9db5fd921c167502"
  }
  use { "MunifTanjim/nui.nvim",
    commit = "ecd9def93891b9260b15b5fcef542eaabf4145c9"
  }
  use {
    "CosmicNvim/cosmic-ui",
    commit = "c0b14531999f2bfef3d927c4dcd57a1a8fed5ee9",
    requires = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  }

  -- Diagnostics
  use { "creativenull/diagnosticls-configs-nvim",
    commit = "c1c243cf8b98d0dd2d57f55f35c84adfc7509005"
  }
  use {
    "folke/trouble.nvim",
    commit = "2ae7237c2917d661f458443c9a88680f8ca2d7b2",
    cmd = "TroubleToggle",
  }
  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    commit = "d9c8a71b8b6e6bfa2b5cf015f59450472dbf06fe",
    config = function()
      require("lsp_lines").setup()
    end,
  })

  -- Whitespace
  use { "ntpeters/vim-better-whitespace",
    commit = "1b22dc57a2751c7afbc6025a7da39b7c22db635d"
  }

  -- Telescope
  use { "junegunn/fzf",
    commit = "f1a96296525975ea7d4c45aebc4fed5117cecb72"
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim'
    ,run = 'make'
    ,commit = "580b6c48651cabb63455e97d7e131ed557b8c7e2"
  }
  use { "nvim-telescope/telescope.nvim",
    commit = "9de317bdea2bc393074651179c4fc7f93e9b2d56",
    branch = '0.1.x',
  }
  use { "nvim-telescope/telescope-media-files.nvim",
    commit = "0826c7a730bc4d36068f7c85cf4c5b3fd9fb570a"
  }
  use {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
    commit = "8febc60a76feefd8203077ef78b6a262ea1a41f9"
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    commit = "ac4020c70722337c326bf65b645b162ee6e1796b",
    run = ":TSUpdate",
  }
  use { "JoosepAlviste/nvim-ts-context-commentstring",
    commit = "729d83ecb990dc2b30272833c213cc6d49ed5214"
  }
  use { "nvim-treesitter/nvim-treesitter-textobjects",
    commit = "8673926519ea61069f9c1366d1ad1949316d250e"
  }
  use { "nvim-treesitter/playground",
    commit = "934cb4c4adc2e7f4f351846a63c9532018c996ed"
  }
  use { "ThePrimeagen/refactoring.nvim",
    commit = "e7c40818b2995016ede93c5620055206b1aba44f"
  }
  use { "danymat/neogen",
    commit = "9c17225aac94bdbf93baf16e1b2d2c6dcffb0901"
  }
  use { "nvim-treesitter/nvim-treesitter-context",
    commit = "38203f5e6c62617b3c07662dc71ce3047ecd90d3"
  }

  -- Git
  use { "lewis6991/gitsigns.nvim",
    commit = "372d5cb485f2062ac74abc5b33054abac21d8b58"
  }
  use { "tpope/vim-fugitive",
    commit = "ef99f1d90cdb33a52931aed5868785b51fb9411d"
  }
  use {
    "sindrets/diffview.nvim",
    commit = "63720aa5a70ce4aa386be407d0e612cd9e63861a",
    event = "BufRead",
    requires = "nvim-lua/plenary.nvim"
  }

  -- Color preview/picker
  use { "norcalli/nvim-colorizer.lua",
    commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6"
  }
  use {
    "ziontee113/color-picker.nvim",
    commit = "e23de39cff3babdc97c39ae79bb68fedf1a1fe00",
    config = function()
      require("color-picker")
    end,
  }
  use {
    "stevearc/dressing.nvim",
    commit = "91b9ba8a9474d2c4156dc2f3e858e07ae8faecf0",
  }
  use({
    "ziontee113/icon-picker.nvim",
    commit = "66d37ceae84099ca76235de44466829eb37118c2",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true
      })
    end,
  })

  -- Markdown preview
  use {
    "ellisonleao/glow.nvim",
    commit = "a3f24fdaa71d2c25a2b88026032b34f5b6a6e215",
    branch = "main",
  }
  -- Popup notifications
  use { "rcarriga/nvim-notify"
    ,commit = "50d037041ada0895aeba4c0215cde6d11b7729c4"
  }

  -- Display processing progress
  use { "j-hui/fidget.nvim",
    commit = "0ba1e16d07627532b6cae915cc992ecac249fb97"
  }

  -- Searchable cheatsheet using Telescope
  use { "sudormrfbin/cheatsheet.nvim",
    commit = "9716f9aaa94dd1fd6ce59b5aae0e5f25e2a463ef"
  }

  -- DAP debug adapter
  use { "mfussenegger/nvim-dap",
    commit = "debd7c2f80eaf20c5f5df25db8d8c1b9b18f4421"
  }
  use { "rcarriga/nvim-dap-ui",
    commit = "286f682f366fbc652b38dff893569374e9433dd3"
  }
  use { "mxsdev/nvim-dap-vscode-js", requires = {"mfussenegger/nvim-dap"} }
  -- Removed in favor of Mason
  --[[ use { "ravenxrz/DAPInstall.nvim", ]]
  --[[   commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" ]]
  --[[ } ]]
  --[[ use { "theHamsta/nvim-dap-virtual-text" } ]]
  --[[ use { "nvim-telescope/telescope-dap.nvim" } ]]

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
