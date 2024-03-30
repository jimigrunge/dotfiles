-- --------------------------------
-- Vim/NeoVim options
-- --------------------------------
local options = {
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 0,                           -- Space in the neovim command line
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  encoding = "utf-8",                      -- the encoding written to a file
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                         -- only if there are at least two tab pages
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  splitkeep = "cursor",                    -- keep cursor in same position when closing window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  title = false,                           -- disable window title
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  cursorline = true,                       -- highlight the current line
  colorcolumn = '120',                     -- maximum code width indicator
  number = true,                           -- set numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  relativenumber = true,                   -- set relative numbered lines
  wrap = false,                            -- display lines as one long line
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,                       -- The minimal number of screen columns to keep to the left and right of the cursor if 'nowrap' is set.
  guifont = "DejaVuSansM Nerd Font:h16",   -- the font used in graphical neovim applications
  laststatus = 3,                          -- use a single status line
  confirm = true,                          -- get prompted if you want to save all the unsaved changes
  foldcolumn = '1',                        -- show gutter to the left of the line numbers
  foldlevel = 99,                          -- sets the fold level. The foldlevel is calculated by dividing the line's indent by the "shiftwidth" value, rounded down
  foldlevelstart = 99,                     -- don't close folds when opening a buffer
  foldenable = true,                       -- enables folds
  inccommand = "split",                    -- provides interactive feedback when composing a substitute command
}

-- --------------------------------
-- Load options from the array
-- --------------------------------
for k, v in pairs(options) do
  vim.opt[k] = v
end

-- --------------------------------
-- append does not work with loop loader
-- --------------------------------
vim.opt.shortmess:append("c")                     -- Don't give ins-completion-menu messages
vim.opt.path:append({ "**" })                     -- Subdirectory searching
vim.opt.wildignore:append({ "*/node_modules/*" }) -- Ignore node_modules
vim.opt.whichwrap:append("<,>,[,]")               -- When to move to the next line
vim.opt.iskeyword:append("-")                     -- Append to keyword list
vim.opt.statusline:append("%f")                   -- determines the content of the status line. %f = Path to the file in the buffer
-- Configures the cursor style for each mode
vim.opt.guicursor:append("n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20")
-- --------------------------------
-- Format Options
-- --------------------------------
-- c	Auto-wrap comments using 'textwidth', inserting the current comment leader automatically.
-- r	Automatically insert the current comment leader after hitting <Enter> in Insert mode.
-- o	Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
--    In case comment is unwanted in a specific place use CTRL-U to quickly delete it.
vim.opt.formatoptions:remove({ "co" })
vim.opt.formatoptions:append({ "r" })
-- --------------------------------

vim.g.loaded_netrw = 1         -- Disable netrw file manager
vim.g.loaded_netrwPlugin = 1   -- Disable netrw file manager
vim.g.loaded_perl_provider = 0 -- Disable Perl support:
vim.scriptencoding = "utf-8"   -- File encoding

-- --------------------------------
-- Enables the experimental Lua module loader
-- --------------------------------
-- overrides loadfile
-- adds the Lua loader using the byte-compilation cache
-- adds the libs loader
-- removes the default Nvim loader
vim.loader.enable()
-- --------------------------------

vim.cmd [[
  highlight WinSeparator guibg=None
  hi LspDiagnosticsDefaultHint  guifg=#00ff00 gui=nocombine
  hi LspDiagnosticsDefaultInfo  guifg=#73D7FF gui=nocombine
  hi LspDiagnosticsDefaultWarn  guifg=#ffff00 gui=nocombine
  hi LspDiagnosticsDefaultError guifg=#ff0000 gui=nocombine
]]
