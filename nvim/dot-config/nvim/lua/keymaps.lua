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

------------------------ Some functions for keybinding --------------------------
local function map(m, k, v, desc)
    vim.keymap.set(m, k, v, { silent = true, noremap = true, desc = desc})
end

-- Fix n and N. Keeping cursor in center
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
-- Open a new tab buffer
map('n', '<leader>t', '<CMD>tabe .<CR>', "Open a new [t]ab")
-- Vertical split
map('n', '<leader>|', '<CMD>vs .<CR>', "Vertical split")
-- Horizontal split
map('n', '<leader>-', '<CMD>sp .<CR>', "Horizontal split")
-- Clipboard yank
map('v', '<leader>y', '"+y', "Clipboard [y]ank")
-- Clipboard paste
map({'v', 'n'}, '<leader>p', '"+p', "Clipboard [p]aste")
-- Move between tabs easily
map('n', '<C-Left>', '<CMD>tabp<CR>', "Go to [Left] tab")
map('n', '<C-Right>', '<CMD>tabn<CR>', "Go to [Prev] tab")
-- Move between splits
map('n', '<C-h>', '<C-W><C-h>', "Go to left split")
map('n', '<C-j>', '<C-W><C-j>', "Go to down split")
map('n', '<C-k>', '<C-W><C-k>', "Go to up split")
map('n', '<C-l>', '<C-W><C-l>', "Go to right split")
-- Delete but dont put the deleted thing into the register
map('v', '<leader>d', '\"_d', "[d]elete without adding it to register")

-- vim: ts=2 sts=2 sw=2 et
