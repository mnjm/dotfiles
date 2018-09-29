" ############################################
" ########### VIM CONFIGURATION ##############
" ############################################

" For no reason
set nocompatible

" ColorScheme
colorscheme koehler

" Syntax Highlight
syntax on

" Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Line Numbers
set relativenumber

" More readable [Not Saved] Message
set confirm

" Highlight Current Line
set cursorline
highlight CursorLine ctermbg=darkblue ctermfg=white

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

" Load Commentary
call plug#begin("~/.vim/plugins")
Plug 'tpope/vim-commentary'
call plug#end()
