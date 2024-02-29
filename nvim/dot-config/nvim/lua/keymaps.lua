-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See :help lua-guide-autocommands

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- Fix n and N. Keeping cursor in center
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
-- Open a new tab buffer
vim.keymap.set('n', '<leader>t', '<CMD>tabe .<CR>', { desc = "Open a new [t]ab"})
-- Vertical split
vim.keymap.set('n', '<leader>|', '<CMD>vs .<CR>', { desc = "Vertical split"})
-- Horizontal split
vim.keymap.set('n', '<leader>-', '<CMD>sp .<CR>', { desc = "Horizontal split"})
-- Clipboard yank
vim.keymap.set('v', '<leader>y', '"+y', { desc = "Clipboard [y]ank"})
-- Clipboard paste
vim.keymap.set({'v', 'n'}, '<leader>p', '"+p', { desc = "Clipboard [p]aste"})
-- Move between tabs easily
vim.keymap.set('n', '<C-Left>', '<CMD>tabp<CR>', { desc = "Go to [Left] tab"})
vim.keymap.set('n', '<C-Right>', '<CMD>tabn<CR>', { desc = "Go to [Prev] tab"})
-- Move between splits
vim.keymap.set('n', '<C-h>', '<C-W><C-h>', { desc = "Go to left split"})
vim.keymap.set('n', '<C-j>', '<C-W><C-j>', { desc = "Go to down split"})
vim.keymap.set('n', '<C-k>', '<C-W><C-k>', { desc = "Go to up split"})
vim.keymap.set('n', '<C-l>', '<C-W><C-l>', { desc = "Go to right split"})
-- Delete but dont put the deleted thing into the register
vim.keymap.set('v', '<leader>d', '\"_d', { desc = "[d]elete without adding it to register"})
-- Clear highlights
vim.keymap.set('n', '<ESC>', "<CMD>nohlsearch<CR>", { desc = "Clear search highlights"})

-- vim: ts=2 sts=2 sw=2 et
