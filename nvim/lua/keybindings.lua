-------------------------------------------
--------------- Key Bindings --------------
-------------------------------------------

-- Disable arrow key movements in vim. encourage using hjkl movements
-- See plugin/hardass_mode.lua
vim.g.mm_hardass_mode = true

-- Map Leader Key building --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true, noremap = true })
end

-- Fix n and N. Keeping cursor in center
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
-- Open a new tab buffer
map('n', '<leader>t', '<CMD>tabe .<CR>')
-- Vertical split
map('n', '<leader>|', '<CMD>vs .<CR>')
-- Horizontal split
map('n', '<leader>-', '<CMD>sp .<CR>')
-- Clipboard yank
map('v', '<leader>y', '"+y')
-- Clipboard paste
map('x', '<leader>p', '"+p')
-- Open Fzf
map('n', '<leader>f', '<CMD>Telescope find_files<CR>')
-- Move between tabs easily
map('n', '<leader>h', '<CMD>tabp<CR>')
map('n', '<leader>l', '<CMD>tabn<CR>')
-- Move between splits
map('n', '<C-h>', '<C-W><C-h>')
map('n', '<C-j>', '<C-W><C-j>')
map('n', '<C-k>', '<C-W><C-k>')
map('n', '<C-l>', '<C-W><C-l>')
