require "user.launch"                   -- Launch the neovim configuration.
require "user.options"                  -- Set global options.
require "user.autocommands"             -- Set autocommands.
require "user.keymaps"                  -- Set keymaps.
require "user.abbreviations"            -- Set abbreviations.
spec "user.plenary"                     -- All the lua functions I don't want to write twice.
spec "user.alpha"                       -- A fast and fully programmable greeter for neovim.
spec "user.colorscheme"                 -- Select and configure your colorscheme.
spec "user.vscode"                      -- A port of the popular vscode theme.
spec "user.tokyonight"                  -- A clean, dark neovim theme.
spec "user.telescope"                   -- Find, Filter, Preview, Pick.
spec "user.neoscroll"                   -- Smooth scrolling for neovim.
spec "user.confirm-quit"                -- Confirm before quitting neovim.
spec "user.search-replace"              -- Search and replace with preview.
spec "user.nvim-scrollview"             -- A modern neovim scrollbar.
spec "user.vim-tmux-navigator"          -- Seamless navigation between tmux panes and vim splits.
-- spec "user.bufferline"                  -- A snazzy buffer line.
spec "user.twilight"                    -- Dims inactive portions of the code you're editing.
spec "user.brackets"                    -- Show matching brace for scope.
spec "user.barbecue"                    -- VS Code like winbar that uses nvim-navic in order to get LSP context.
spec "user.gx"                          -- Open URL under cursor in browser.
spec "user.nvim-autopairs"              -- Insert and delete brackets, parens, quotes in pair.
spec "user.nvim-ts-autotag"             -- Automatically close and rename HTML tags.
-- spec "user.nvim-keymap-amend"           -- A plugin to help you amend keymaps.
spec "user.fold-preview"                -- A neovim plugin for previewing folds.
spec "user.pretty-fold"                 -- A plugin to make folds more pretty.
spec "user.treesj"                      -- splitting/joining blocks of code like arrays, hashes, etc.
spec "user.treesitter"                  -- Treesitter configurations and abstraction layer.
spec "user.nvim-treesitter-context"     -- Treesitter context manager.
spec "user.tree-sitter-blade"           -- Treesitter support for Blade.
spec "user.nvim-treesitter-textobjects" -- nvim-treesitter-textobjects
spec "user.nvim-treesitter-playground"  -- Treesitter configurations and abstraction layer.
spec "user.nvim-treesitter-endwise"     -- Treesitter support for endwise.
spec "user.harpoon"                     -- Switch files fast
spec "user.comment"                     -- Comment stuff out.
spec "user.todo-comments"               -- Highlight, list and search TODO comments.
spec "user.surround"                    -- Surround text with pairs.
spec "user.nvim-web-devicons"           -- Icons for neovim.
spec "user.vim-devicons"                -- Devicons for vim.
spec "user.nvim-tree"                   -- A file explorer tree for neovim.
spec "user.vim-undotree"                -- View undo history
spec "user.vim-bbye"                    -- Delete buffers and close windows.
spec "user.lualine"                     -- A blazing fast and easy to configure neovim statusline.
spec "user.incline"                     -- File labels
spec "user.navic"                       -- A neovim window navigator.
spec "user.symbols-outline"             -- A tree like view for symbols in neovim using the Language Server Protocol.
spec "user.toggleterm"                  -- A neovim terminal in a floating window.
spec "user.persistence"                 -- Persist variables across sessions.
spec "user.project"                     -- A neovim project plugin.
spec "user.indentline"                  -- A vim plugin to display the indention levels with thin vertical lines.
spec "user.cmp"                         -- A completion plugin for neovim coded in Lua.
spec "user.chatgpt"                     -- A neovim plugin for GPT-3 chat.
spec "user.copilot"                     -- A neovim plugin for GitHub Copilot.
spec "user.cmp-npm"                     -- A npm completion source for cmp.
spec "user.vim-dadbod"                  -- A DB UI for VIM
spec "user.neodev"                      -- A neovim plugin for development.
spec "user.nvim-lspconfig"              -- A collection of common configurations for the Nvim LSP client.
spec "user.mason"                       -- A plugin for Mason LSP manager.
spec "user.none-ls"                     -- A fast, asynchronous, cross language LSP client.
spec "user.trouble"                     -- A pretty list for showing diagnostics.
spec "user.schemastore"                 -- A collection of JSON schemas for various languages.
spec "user.lsp-signature"               -- Show function signature when you type.
spec "user.lsp-lines"                   -- Highlight the current line and column for LSP clients.
spec "user.goto-preview"                -- Goto previews in popup windows
spec "user.nvim-lightbulb"              -- A plugin that shows a lightbulb in the sign column for actions.
spec "user.nvim-code-action-menu"       -- A plugin for showing code actions in a floating window.
spec "user.illuminate"                  -- A plugin for highlighting other uses of the word under the cursor.
spec "user.nui"                         -- A plugin for creating UIs in neovim.
spec "user.cosmic-ui"                   -- A plugin for creating UIs in neovim.
spec "user.whitespace"                  -- A plugin for managing whitespace.
spec "user.fzf"                         -- A command-line fuzzy finder.
spec "user.nvim-notify"                 -- A fancy notification manager for neovim.
spec "user.noice"                       -- A plugin for playing music in neovim.
-- spec "user.refactoring"                 -- A refactoring plugin for neovim. (This is still beta)
spec "user.gitsigns"                    -- A git diff and git status plugin.
spec "user.diffview"                    -- A git diff viewer.
spec "user.gitlinker"                   -- A plugin for opening files and line numbers on GitHub, Bitbucket, Gitlab, and Gitea from neovim.
spec "user.vim-fugitive"                -- A git wrapper for neovim.
spec "user.lazygit"                     -- LazyGit window
spec "user.colorizer"                   -- A plugin for colorizing hex codes in neovim.
spec "user.color-picker"                -- A color picker for neovim.
spec "user.fidget"                      -- A plugin for creating and managing snippets.
spec "user.cheatsheet"                  -- A plugin for creating and managing cheatsheets.
spec "user.dap"                         -- A plugin for debugging in neovim.
spec "user.glow"                        -- A markdown previewer for neovim.
spec "user.neogen"                      -- A plugin for generating LSP snippets.
spec "user.whichkey"                    -- A plugin for displaying keybindings in neovim.
spec "user.zen-mode"                    -- Distractions free editing
require "user.lazy"                     -- Lazy load plugins.
