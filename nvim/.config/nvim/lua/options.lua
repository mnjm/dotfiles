-- [[ Setting options ]]
-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, for help with jumping.
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
-- vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- More readable [Not saved] message
vim.opt.confirm = true

-- Spell checking
vim.o.spelllang = 'en_us'
vim.o.complete = string.format("%s,kspell", vim.o.complete)

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Better Editing experience
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1 -- If negative, shiftwidth value is used
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.wrap = false
vim.opt.showmatch = true -- Highlight matching brackets

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sane way of searching
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Sets how neovim will display certain whitespace in the editor.
--  See :help 'list'
--  and :help 'listchars'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true
-- Make the cursorline build
vim.opt.colorcolumn = "100"

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 4

-- NOTE: You should make sure your terminal supports this
vim.opt.termguicolors = true

-- Set display status line always but only 1 for all windows
vim.opt.laststatus = 3
-- -- Turn off shows default insert/replace modes
vim.opt.showmode = true
-- -- disable displaying command line
vim.opt.cmdheight = 0

-- vim: ts=2 sts=2 sw=2 et
