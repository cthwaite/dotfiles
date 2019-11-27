set nocompatible              " be iMproved, required

" ==== vim-plug ================================================================
call plug#begin('~/.vim/plugged')

" Airline and airline themes
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
Plug 'racer-rust/vim-racer'
" NERDTree
Plug 'scrooloose/nerdtree'
" Asynchronous Lint Engine
Plug 'w0rp/ale'
" The ultimate undo history visualizer for VIM
Plug 'mbbill/undotree', { 'on': ['UndotreeFocus', 'UndotreeShow', 'UndotreeToggle'] }
" Show git status in gutter.
Plug 'airblade/vim-gitgutter'

" --- Search
" Search with rg
Plug 'jremmen/vim-ripgrep'
" Search with fzf
Plug 'junegunn/fzf.vim'

" --- Rust
" rust.vim
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
" TOML syntax
Plug 'cespare/vim-toml', { 'for': 'toml' }
" Pest PEG grammar syntax support
Plug 'pest-parser/pest.vim'

" --- txt
" Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
Plug 'ctrlpvim/ctrlp.vim'
" Decrease reliance on single-key navigation.
Plug 'takac/vim-hardtime'
" Highlight trailing whitespace.
Plug 'bronson/vim-trailing-whitespace'
" Override awful default YAML syntax highlighting
Plug 'stephpy/vim-yaml'

call plug#end()            " required

" NeoVim Python hosts
" let g:python_host_prog=$BREW_HOME.'/bin/python2'
let g:python3_host_prog='python3'

" ==============================================================================
" ==== Setup ===================================================================
set shell=zsh\ -l               " just so we're clear, vim
"set background=dark             " against a dark background
syntax on		                " syntax highlighting
set mouse=a		                " enable mouse
set termguicolors               " true colour scheme in the terminal
colorscheme monokai
set mousehide 		            " hide mouse cursor while typing
set encoding=utf-8              " default encoding is utf-8
scriptencoding utf-8            " script encoding is utf-8
set fileformats=unix,dos,mac    " prefer Unix over Windows over OS 9 formats
set history=1000                " 1000 lines of history
set shortmess+=filmnrxoOtT      " [noeol], 00L/00C, [+], [New], [RO], [unix]
                                " write/read overwrite, truncate
set autoread                    " auto-reload modified files
set noswapfile                  " no swapfile
set nobackup                    " no backup files
set bs=indent,eol,start         " backspace over everything!
set ruler                       " display cursor position
set lazyredraw                  " faster macro invocation
set title                       " set window title
set titlestring=%t              " ibid

                                " :W sudo saves the file
command W w !sudo tee % > /dev/null


" current directory is always window-local
autocmd BufEnter * lcd %:p:h

" ==== Search ==================================================================
set incsearch                   " show matches while you type
set hlsearch                    " highlight matches
set ignorecase                  " search case insensitive
set smartcase                   " search case-sensitive when uppercase characters appear in search


" ==== Formatting ==============================================================
set wrap                        " wrap lines
set autoindent		            " keep prev indent
set smartindent                 " smart autoindenting
set smarttab                    " insert shiftwidth blanks
set shiftwidth=4	            " width of shift, spaces
set softtabstop=4               " number of tab-spaces while editing
set expandtab 		            " tabs are spaces
set tabstop=4		            " tabs are worth 4 spaces
                                " force *.md files to be opened as markdown.
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.cls set filetype=vb
                                " use xmllint to reindent XML when using 'gg=G'
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" YAML is two-spaced by default
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


" ==== UI ======================================================================
set cursorline 		            " highlight current line
set showmode 		            " show current mode
highlight clear LineNr          " highlight the current line number
highlight clear SignColumn      " highlight gutter symbols
set number                      " line numbers on
set relativenumber              " for fast vertical movement
set linespace=0                 " no extra spaces between rows
                                " mkview preserves EVERYTHING
set vop=cursor,folds,options,slash,unix
set virtualedit=onemore         " cursor after EOL
set showmatch                   " show search matches
set wildmenu                    " show list for autocomplete
set wildmode=list:longest,full  " list all matches and complete
set colorcolumn=88,161          " indicate col80, col161
set nofoldenable                " automatic code folding is the devil's work

" let macvim_skip_colorscheme=1
" let g:molokai_original=1
highlight SignColumn guibg=#272822

if has('cmdline_info')
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
    set showcmd
endif


" ==== GUI stuff ===============================================================
if has('gui_running')
    set lines=80                    " minimum 80 lines
    set guifont=PragmataProMono:h11 " set font
    " colorscheme Broadcast         " broadcast
    colorscheme flatland-monokai    " monokai
    " set noantialias               " doubleplus jaggies
    set encoding=utf-8
    set guioptions-=T               " include toolbar
else
    if &term=='xterm' || &term == 'screen'
        set t_Co=256            " 256 colour
    endif
endif


" ==== keymap ==================================================================
let mapleader = " "
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
inoremap jk <esc>
inoremap <esc> <nop>
" remap split navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
                                " magic by default
nnoremap / /\v
                                " magic by default
cnoremap %s/ %s/\v


" ==== Airline =================================================================
let g:airline_powerline_fonts=1
let g:airline_theme = 'bubblegum'


" ==== Statusline / ALE ========================================================
if has('statusline')
    set laststatus=2                " last window always has a status line
endif

set statusline+=%#warningmsg#
set statusline+=%*
let g:airline#extensions#ale#enabled = 1

" ==== NERDTree ================================================================
" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

" ==== deoplete ================================================================
" tab-completion
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

set hidden
let g:racer_cmd = "$HOME/.cargo/bin/racer"
