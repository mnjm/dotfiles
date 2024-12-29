--                                           /$$                                                       /$$
--                                          | $/                                                      |__/
--  /$$$$$$/$$$$  /$$$$$$$  /$$ /$$$$$$/$$$$|_//$$$$$$$       /$$$$$$$   /$$$$$$   /$$$$$$  /$$    /$$ /$$ /$$$$$$/$$$$
-- | $$_  $$_  $$| $$__  $$|__/| $$_  $$_  $$ /$$_____/      | $$__  $$ /$$__  $$ /$$__  $$|  $$  /$$/| $$| $$_  $$_  $$
-- | $$ \ $$ \ $$| $$  \ $$ /$$| $$ \ $$ \ $$|  $$$$$$       | $$  \ $$| $$$$$$$$| $$  \ $$ \  $$/$$/ | $$| $$ \ $$ \ $$
-- | $$ | $$ | $$| $$  | $$| $$| $$ | $$ | $$ \____  $$      | $$  | $$| $$_____/| $$  | $$  \  $$$/  | $$| $$ | $$ | $$
-- | $$ | $$ | $$| $$  | $$| $$| $$ | $$ | $$ /$$$$$$$/      | $$  | $$|  $$$$$$$|  $$$$$$/   \  $/   | $$| $$ | $$ | $$
-- |__/ |__/ |__/|__/  |__/| $$|__/ |__/ |__/|_______/       |__/  |__/ \_______/ \______/     \_/    |__/|__/ |__/ |__/
--                    /$$  | $$
--                   |  $$$$$$/
--                    \______/
-- Author - mnjm - github.com/mnjm
-- Repo - github.com/mnjm/dotfiles
--
--
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

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

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

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 4

-- set to false if true color is not supported
vim.opt.termguicolors = true

-- highlight column in 100th column
vim.opt.colorcolumn = "101"

-- More readable [Not saved] message
vim.opt.confirm = true

-- Spell checking
vim.o.spelllang = 'en_us'

-- Better Editing experience
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1 -- If negative, shiftwidth value is used
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.wrap = false
vim.opt.showmatch = true -- Highlight matching brackets
-- Set display status line always but only 1 for all windows
vim.opt.laststatus = 3
-- disable displaying command line
vim.opt.cmdheight = 0

-- netrw changes
vim.g.netrw_banner = 0 -- hide banner
vim.g.netrw_liststyle = 3 -- show tree like listing
-- vim.g.netrw_browse_split = 4 -- open file in prev focused window
vim.g.netrw_altv = 1
-- vim.g.netrw_winsize = 15 -- default window size when netrw is opened


-- Set leader first!!
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Tab navigations
vim.keymap.set('n', '<leader>t', '<CMD>tabe .<CR>', { desc = "Open a new [t]ab"})

-- Window navigations
vim.keymap.set('n', '<leader>|', '<CMD>vs .<CR>', { desc = "Vertical split"})
vim.keymap.set('n', '<leader>-', '<CMD>sp .<CR>', { desc = "Horizontal split"})

-- Keeping cursor in center
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- Clipboard yank
vim.keymap.set({'v', 'n'}, '<leader>y', '"+y', { desc = "Clipboard [y]ank"})
-- Clipboard paste
vim.keymap.set({'v', 'n'}, '<leader>p', '"+p', { desc = "Clipboard [p]aste"})
-- Delete but dont put the deleted thing into the register
vim.keymap.set({'n', 'v'}, '<leader>d', '\"_d', { desc = "[d]elete without adding it to register"})

-- This map is so that I dont have to think about wheather to move cursor with <C-o> while working with brackets
vim.keymap.set('i', '<C-o>', '<C-\\><C-o>', { desc = 'Execute single command in insert mode, but dont move cursor' })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines down" })

-- vim: ts=2 sts=2 sw=2 et
