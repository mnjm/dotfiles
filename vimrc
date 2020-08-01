set nocompatible                                                " For no reason
let mapleader=','                                               " Change leader key used for custom keybindings
colorscheme desert                                              " Color scheme
syntax on                                                       " Highlight syntax
set tabstop=4                                                   " Indentation
set shiftwidth=4
set softtabstop=4
set expandtab
set relativenumber number                                       " Line Numbers
set confirm                                                     " More readable [Not Saved] Message
set cursorline                                                  " Cursor Line highlight
hi CursorLine term=standout cterm=bold
set colorcolumn=100                                             " Bar at 100th column
hi ColorColumn ctermbg=red
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
hi Search ctermfg=0
set clipboard=unnamedplus                                       " Clipboard

" Plugins
call plug#begin("~/.vim/plugins")
Plug 'tpope/vim-commentary'                                     " Vim Commentary from tpope
Plug 'tpope/vim-surround'                                       " Vim Surround from tpope
Plug '~/.fzf'                                                   " Fzf
call plug#end()

" Custom key bindings 
nnoremap <leader>t :tabe<Space>.<CR>                            " Open tab
nnoremap <leader>r :vs<Space>.<CR>                              " Vertical split
nnoremap <leader>b :sp<Space>.<CR>                              " Horizontal split
vnoremap <leader>y "+y                                          " Clipboard yanc
map <leader>p "+p                                               " Clipboard paste
nnoremap <leader>f :FZF<CR>                                     " Open FZF
nnoremap <leader>h :tabp<CR>                                    " Move between tabs easily
nnoremap <leader>l :tabn<CR>
nnoremap <C-h> <C-W><C-h>                                       " Move between splits
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>
