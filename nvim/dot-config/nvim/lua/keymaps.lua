-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Disable arrow key movements in vim. encourage using hjkl movements
-- See plugin/hardass_mode.lua
vim.g.mm_hardass_mode = true

-- Map Leader Key building --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

------------------------ Some functions for keybinding --------------------------
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
map({'v', 'n'}, '<leader>p', '"+p')
-- Move between tabs easily
map('n', '<C-Left>', '<CMD>tabp<CR>')
map('n', '<C-Right>', '<CMD>tabn<CR>')
-- Move between splits
map('n', '<C-h>', '<C-W><C-h>')
map('n', '<C-j>', '<C-W><C-j>')
map('n', '<C-k>', '<C-W><C-k>')
map('n', '<C-l>', '<C-W><C-l>')
-- Delete but dont put the deleted thing into the register
map('v', '<leader>d', '\"_d')

-- vim: ts=2 sts=2 sw=2 et
