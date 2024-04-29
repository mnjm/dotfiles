set nocompatible                                                " No vi pls
let mapleader=' '                                               " Change leader key used for custom keybindings
let localmapleader=' '
set termguicolors
colorscheme desert                                              " Color scheme
syntax on                                                       " Highlight syntax
set tabstop=4                                                   " Indentation
set shiftwidth=4
set softtabstop=4
set expandtab
set relativenumber number                                       " Line Numbers
set numberwidth=3
set confirm                                                     " More readable [Not Saved] Message
set cursorline                                                  " Cursor Line highlight
hi CursorLine term=standout cterm=bold
set colorcolumn=101                                             " Bar at 100th column
set showcmd                                                     " Show Command on bottom left
filetype indent on                                              " Load file specific indent files
set wildmenu                                                    " Autocomplete commands/files in command mode
set showmatch                                                   " Highlight Matching Brackets
set splitright splitbelow                                       " Sane way of splitting
" Disable print in GUI
aunmenu ToolBar.Print
autocmd FileType cc,c,cpp,py autocmd BufWritePre * %s/\s\+$//e  " Auto remove trailing space c and python codes.
set incsearch                                                   " Search setting
set hlsearch
set laststatus=2
set mouse=a
set nowrap
"
" Cursor changes
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
set ttimeout
set ttimeoutlen=1
set ttyfast

" Netrw changes
let g:netrw_banner=0
let g:netrw_listtype=3

" Transperent background
hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE

" Plugins
call plug#begin("~/.vim/plugins")
Plug 'tpope/vim-commentary'                                     " Vim Commentary from tpope
Plug 'tpope/vim-surround'                                       " Vim Surround from tpope
Plug '~/.fzf'                                                   " Fzf
call plug#end()

" Custom key bindings
" Tab
nnoremap <leader>t :tabe<Space>.<CR>
nnoremap <C-Left> :tabp<CR>
nnoremap <C-Right> :tabn<CR>
" Window
nnoremap <leader>\| :vs<Space>.<CR>
nnoremap <leader>- :sp<Space>.<CR>
nnoremap <C-h> <C-W><C-h>
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>
" Clipboard
vnoremap <leader>y "+y
map <leader>p "+p
" Fzf
nnoremap <leader>f :FZF<CR>
" Center
nnoremap n nzz
nnoremap N Nzz
inoremap <C-o> <C-\><C-o>
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
" Clear highlight
nnoremap <esc><esc> <cmd>silent! nohls<cr>
nnoremap <C-o> <C-\><C-o>
