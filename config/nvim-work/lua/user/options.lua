-- Global variables
JAVA_DAP_ACTIVE = false

--- Global debug function. print(tprint(TABLE))
-----------------------------------------------
-- function tprint (tbl, indent)
--   if not indent then indent = 0 end
--   local toprint = string.rep(" ", indent) .. "{\r\n"
--   indent = indent + 2
--   for k, v in pairs(tbl) do
--     toprint = toprint .. string.rep(" ", indent)
--     if (type(k) == "number") then
--       toprint = toprint .. "[" .. k .. "] = "
--     elseif (type(k) == "string") then
--       toprint = toprint  .. k ..  "= "
--     end
--     if (type(v) == "number") then
--       toprint = toprint .. v .. ",\r\n"
--     elseif (type(v) == "string") then
--       toprint = toprint .. "\"" .. v .. "\",\r\n"
--     elseif (type(v) == "table") then
--       toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
--     else
--       toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
--     end
--   end
--   toprint = toprint .. string.rep(" ", indent-2) .. "}"
--   return toprint
-- end

-- Vim/NeoVim options
local options = {
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 0,                           -- Space in the neovim command line
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                         -- always show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  title = false,
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
  sidescrolloff = 8,
  guifont = "DejaVuSansM Nerd Font:h16",   -- the font used in graphical neovim applications
  laststatus = 3,                          -- use a single status line
  confirm = true,
  foldcolumn = '1',
  foldlevel = 99,
  foldlevelstart = 99,
  foldenable = true,
}

vim.opt.shortmess:append "c"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,]"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
vim.cmd [[set statusline+=%f]]
--vim.cmd [[set guicursor+=i:hor20]]
vim.cmd [[set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20]]

-- vim.g.codeium_disable_bindings = 1
-- vim.g.codeium_no_map_tab = 0

vim.g.loaded_perl_provider = 0

vim.cmd [[
  highlight WinSeparator guibg=None
  hi LspDiagnosticsDefaultHint  guifg=#00ff00 gui=nocombine
  hi LspDiagnosticsDefaultInfo  guifg=#73D7FF gui=nocombine
  hi LspDiagnosticsDefaultWarn  guifg=#ffff00 gui=nocombine
  hi LspDiagnosticsDefaultError guifg=#ff0000 gui=nocombine
]]
