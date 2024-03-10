" ---------------
" set leader to space
" ---------------
let mapleader = " "
let maplocalleader = " "
set timeoutlen=500 " Set timeout length to 500 ms

" ---------------
" allows vim to access the system clipboard
" ---------------
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif

" ---------------
" Options
" ---------------
set backspace=2
set cmdheight=1                           " Space in the neovim command line
set colorcolumn=120                       " maximum code width indicator
set completeopt=longest,menuone,noselect  " mostly just for cmp
set conceallevel=0                        " so that `` is visible in markdown files
set confirm                             " get prompted if you want to save all the unsaved changes
set cursorline                            " highlight the current line
set encoding=utf-8                        " the encoding written to a file
set expandtab                             " convert tabs to spaces
set fileencoding=utf-8                    " the encoding written to a file
set fileencodings=ucs-bom,utf-8,default,latin1
set foldcolumn=1                          " show gutter to the left of the line numbers
set foldenable                            " enables folds
set foldlevel=99                          " sets the fold level. The foldlevel is calculated by dividing the line's indent by the 'shiftwidth' value, rounded down
set foldlevelstart=99                     " don't close folds when opening a buffer
set helplang=en
set hlsearch                              " highlight all matches on previous search pattern
set ignorecase                            " ignore case in search patterns
set incsearch
set laststatus=3                          " use a single status line
set modelines=0
set mouse=a                               " allow the mouse to be used in neovim
set nobackup                              " don't create a backup file
set noshowmode                            " we don't need to see things like ' INSERT ' anymore
set noswapfile                            " creates a swapfile
set notitle                               " disable window title
set nowrap                                " display lines as one long line
set nowritebackup                         " if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
set number                                " set numbered lines
set numberwidth=4                         " set number column width to 2 {default 4}
set pumheight=10                          " pop up menu height
" set relativenumber                        " set relative numbered lines
set scroll=27
set scrolloff=8                           " is one of my fav
set shiftwidth=2                          " the number of spaces inserted for each indentation
set showcmd
set showmatch
set showtabline=2                         " only if there are at least two tab pages
set sidescrolloff=8                       " The minimal number of screen columns to keep to the left and right of the cursor if 'nowrap' is set.
set smartcase                             " smart case
set smartindent                           " make indenting smarter again
set splitbelow                            " force all horizontal splits to go below current window
set splitright                            " force all vertical splits to go to the right of current window
set tabstop=2                             " insert 2 spaces for a tab
set termguicolors                         " set term gui colors (most terminals support this)
set timeoutlen=300                        " time to wait for a mapped sequence to complete (in milliseconds)
set ttymouse=xterm
set undofile                              " enable persistent undo
set updatetime=300                        " faster completion (4000ms default)
set wildmenu
set wildoptions=pum
set window=0

" Theming
" ---------------
syntax on
colorscheme evening
highlight ColorColumn guibg=gray23
highlight CursorLine guibg=gray23
highlight Comment guifg=gray55
highlight LineNr guifg=gray55

" ---------------
" Keymappings
" ---------------
nmap <leader><leader> <cmd>nohlsearch<cr>
" center after command
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" do not yank on delete
" nnoremap x "_x
" nnoremap d "_d
" increment/decement
nnoremap + <C-a>
nnoremap - <C-x>
" set fold
nnoremap zf zf%
" select all
noremap <C-a> gg<S-v>G

" indent/outdent and reselect
vmap < <gv
vmap > >gv
" move text up and down
vmap <A-j> :m .+1<CR>==
vmap <A-k> :m .-2<CR>==
vmap J :move '>+1<CR>gv-gv
vmap K :move '<-2<CR>gv-gv
" paste without copy
vmap p "_dP
" upper/lower case
vmap + gU
vmap - gu

" quick escape insert mode
imap jj <ESC>
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
