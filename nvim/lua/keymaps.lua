vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<leader>t', '<cmd>tabe .<CR>', { desc = 'Open a new [t]ab' })
vim.keymap.set('n', '<leader>\\', '<cmd>vs .<CR>', { desc = 'Vertical split' })
vim.keymap.set('n', '<leader>-', '<cmd>sp .<CR>', { desc = 'Horizontal split' })

vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Clipboard [y]ank' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Clipboard [p]aste' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d', { desc = '[D]elete without adding it to register' })
vim.keymap.set('i', '<C-o>', '<C-\\><C-o>', { desc = 'Execute one command in insert mode' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })

vim.keymap.set('n', '<leader>dg', '<cmd>.diffget<CR>', { desc = '[D]iff [G]et current line' })
vim.keymap.set('n', '<leader>dp', '<cmd>.diffput<CR>', { desc = '[D]iff [P]ut current line' })
