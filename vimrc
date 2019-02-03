" ############################################
" ########### VIM CONFIGURATION ##############
" ############################################

" For no reason
set nocompatible

" Colorscheme
colorscheme koehler

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

" Bar at 100th Column
highlight ColorColumn ctermbg=gray
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

" Incremental Search and Hightlight
set incsearch
set hlsearch

" Plugins
call plug#begin("~/.vim/plugins")
" Vim Commentary from tpope
Plug 'tpope/vim-commentary'
" Vim Surround from tpope
Plug 'tpope/vim-surround'
call plug#end()

set t_Co=256

" My Vim Bindings
nnoremap <leader>t :tabe<Space>.<CR>
nnoremap <leader>r :vs<Space>.<CR>
nnoremap <leader>b :sp<Space>.<CR>

" Clipboard copy oaste
vnoremap <leader>y "+y
map <leader>p "+p
