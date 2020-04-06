" ############################################
" ########### VIM CONFIGURATION ##############
" ############################################

" For no reason
set nocompatible

" Change leader key
let mapleader=','

" Colorscheme
colorscheme desert

" Shell to use
set shell=/bin/zsh

" Syntax Highlight
syntax on

" Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Line Numbers
set relativenumber number

" More readable [Not Saved] Message
set confirm

" Highlight Current Line
set cursorline
hi CursorLine term=standout cterm=bold

" Bar at 80 Column
highlight ColorColumn ctermbg=red
set colorcolumn=100

" Show Command
set showcmd

" Load file specific indent files
filetype indent on

" Autocompletion for commands
set wildmenu

" Highlight Matching Brackets
set showmatch

" Correct split setting
set splitright splitbelow

" Auto remove trailing space.
autocmd FileType cc,c,cpp,py autocmd BufWritePre * %s/\s\+$//e

" Incremental Search and Hightlight
set incsearch
set hlsearch

" Plugins
call plug#begin("~/.vim/plugins")
" Vim Commentary from tpope
Plug 'tpope/vim-commentary'
" Vim Surround from tpope
Plug 'tpope/vim-surround'
" " harmany between vim and tmux
" Plug 'christoomey/vim-tmux-navigator'
" Fzf
Plug '~/.fzf'
call plug#end()

" My Vim Bindings
nnoremap <leader>t :tabe<Space>.<CR>
nnoremap <leader>r :vs<Space>.<CR>
nnoremap <leader>b :sp<Space>.<CR>

nnoremap <leader>f :FZF<CR>

" Shift between tabs
nnoremap ,a :tabp<CR>
nnoremap ,d :tabn<CR>

" Move between splits
nnoremap <C-h> <C-W><C-h>
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>

" Clipboard copy paste
vnoremap <leader>y "+y
map <leader>p "+p

" Syntax Highlight
hi Search ctermfg=0

" Disable print in GUI
:aunmenu ToolBar.Print
