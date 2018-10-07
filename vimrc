" ############################################
" ########### VIM CONFIGURATION ##############
" ############################################

" For no reason
set nocompatible

" Colorscheme
colorscheme industry

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

" Show Last Command
set showcmd

" Load file specific indent files
filetype indent on

" Autocompletion for commands
set wildmenu

" Highlight Matching Brackets
set showmatch

" Incremental Search and Hightlight
set incsearch
set hlsearch

" Plugins
call plug#begin("~/.vim/plugins")
" Vim Commentary from tpope
Plug 'tpope/vim-commentary'
call plug#end()
