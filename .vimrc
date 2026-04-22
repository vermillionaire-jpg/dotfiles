" ============================================================
" .vimrc
" Formatting follows Linux kernel coding style:
"   https://www.kernel.org/doc/html/v4.10/process/coding-style.html
" ============================================================

" -----------------------------------------------------------
" General
" -----------------------------------------------------------

set nocompatible          " Use Vim defaults, not Vi
syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype detection and indent rules

" -----------------------------------------------------------
" Indentation — Linux Kernel Style
" -----------------------------------------------------------
" Rule 1: Tabs are 8 characters wide. Hard tabs only — no spaces.
" Spaces are NEVER used for indentation per the kernel style guide.

set tabstop=8             " A <Tab> character is displayed as 8 columns
set shiftwidth=8          " >> and << indent/dedent by 8 columns
set softtabstop=0         " Disable soft tabs entirely
set noexpandtab           " Use real tab characters (never expand to spaces)
set autoindent            " Carry indent level from previous line
set smartindent           " Basic smart C-style autoindenting

" -----------------------------------------------------------
" Line Length — Linux Kernel Style
" -----------------------------------------------------------
" Rule 2: Hard limit of 80 columns. Highlight the 81st column
" as a visual warning.

set textwidth=80          " Hard-wrap at 80 columns (affects 'gq' formatting)
set colorcolumn=81        " Highlight column 81 as a line-length warning
highlight ColorColumn   ctermbg=52    guibg=#5f0000   " Dark red — visible on black bg
highlight CursorLine    cterm=NONE    ctermbg=17  guibg=#00005f   " Dark blue cursor line
highlight Search        ctermfg=0     ctermbg=214 guifg=#000000 guibg=#ffaf00  " Black text on amber
highlight Visual        ctermfg=0     ctermbg=75  guifg=#000000 guibg=#5fafff  " Black text on sky blue

" -----------------------------------------------------------
" Whitespace Hygiene
" -----------------------------------------------------------
" The kernel style explicitly forbids trailing whitespace.

set list                          " Show invisible characters
set listchars=tab:»\ ,trail:·,extends:›,precedes:‹

" Strip trailing whitespace on save (all files)
autocmd BufWritePre * :%s/\s\+$//e

" -----------------------------------------------------------
" Line Numbers & Cursor
" -----------------------------------------------------------

set number                " Show absolute line numbers
set relativenumber        " Also show relative numbers for easy navigation
set cursorline            " Highlight the current line
set ruler                 " Show line/column in the status bar

" -----------------------------------------------------------
" Mouse & Scroll Support
" -----------------------------------------------------------

set mouse=a               " Enable mouse in all modes (normal, insert, visual)
                          " Allows: click to position cursor, scroll wheel,
                          "         drag to resize splits, etc.

" Smooth-ish scrolling — keep cursor 5 lines from edges while scrolling
set scrolloff=5
set sidescrolloff=5

" -----------------------------------------------------------
" Search
" -----------------------------------------------------------

set hlsearch              " Highlight all search matches
set incsearch             " Highlight matches while typing
set ignorecase            " Case-insensitive search by default
set smartcase             " ...unless the query contains uppercase letters

" Clear search highlighting with <Esc> in normal mode
nnoremap <silent> <Esc> :nohlsearch<CR><Esc>

" -----------------------------------------------------------
" Editing Comfort
" -----------------------------------------------------------

set backspace=indent,eol,start  " Allow backspace over everything in insert mode
set showmatch                   " Briefly highlight matching bracket/paren
set matchtime=2                 " Show match for 0.2 seconds
set wildmenu                    " Enhanced tab-completion for commands
set wildmode=longest:list,full  " Complete longest common match, then list all
set laststatus=2                " Always show the status line
set showcmd                     " Show partial commands in the bottom bar

" -----------------------------------------------------------
" Splits & Buffers
" -----------------------------------------------------------

set splitright            " Vertical splits open to the right
set splitbelow            " Horizontal splits open below
set hidden                " Allow switching buffers without saving

" -----------------------------------------------------------
" Key Mappings
" -----------------------------------------------------------

" Use <Space> as leader
let mapleader = " "

" Quick save / quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Navigate splits with Ctrl+hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" -----------------------------------------------------------
" Colors
" -----------------------------------------------------------

" Use 256-color mode when available (keeps things looking right in tmux)
if &t_Co >= 256 || has("gui_running")
  set t_Co=256
endif

" Enable true color if the terminal supports it
if has("termguicolors")
  " Ensure correct escape sequences for true color inside tmux
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
