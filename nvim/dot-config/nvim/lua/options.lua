-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Number of screen lines to keep above and below the cursor
vim.o.scrolloff = 4

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.colorcolumn = "100"

-- More readable [Not saved] message
vim.o.confirm = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Better Editing experience
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = -1 -- If negative, shiftwidth value is used
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.wrap = true
vim.o.showmatch = true -- Highlight matching brackets
-- Sane way of spitting buffers
vim.o.splitright = true
vim.o.splitbelow = true

-- Sane way of searching
vim.o.incsearch = true
vim.o.hlsearch = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Sets how neovim will display certain whitespace in the editor.
--  See :help 'list'
--  and :help 'listchars'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Spell checking
vim.o.spelllang = 'en_us'
vim.o.complete = string.format("%s,kspell", vim.o.complete)

-- Set display status line always but only 1 for all windows
vim.o.laststatus = 3
-- Turn off shows default insert/replace modes
vim.o.showmode = true
-- disable displaying command line
vim.o.cmdheight = 0

-- vim: ts=2 sts=2 sw=2 et
