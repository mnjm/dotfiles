-- '##::::'##:'##::: ##:::::::'##:'##::::'##:'####::'######:::::'##::: ##:'########::'#######::'##::::'##:'####:'##::::'##:
--  ###::'###: ###:: ##::::::: ##: ###::'###: ####:'##... ##:::: ###:: ##: ##.....::'##.... ##: ##:::: ##:. ##:: ###::'###:
--  ####'####: ####: ##::::::: ##: ####'####:. ##:: ##:::..::::: ####: ##: ##::::::: ##:::: ##: ##:::: ##:: ##:: ####'####:
--  ## ### ##: ## ## ##::::::: ##: ## ### ##:'##:::. ######::::: ## ## ##: ######::: ##:::: ##: ##:::: ##:: ##:: ## ### ##:
--  ##. #: ##: ##. ####:'##::: ##: ##. #: ##:..:::::..... ##:::: ##. ####: ##...:::: ##:::: ##:. ##:: ##::: ##:: ##. #: ##:
--  ##:.:: ##: ##:. ###: ##::: ##: ##:.:: ##:::::::'##::: ##:::: ##:. ###: ##::::::: ##:::: ##::. ## ##:::: ##:: ##:.:: ##:
--  ##:::: ##: ##::. ##:. ######:: ##:::: ##:::::::. ######::::: ##::. ##: ########:. #######::::. ###::::'####: ##:::: ##:
-- ..:::::..::..::::..:::......:::..:::::..:::::::::......::::::..::::..::........:::.......::::::...:::::....::..:::::..::
-- Author - mnjm - github.com/mnjm
-- Repo - github.com/mnjm/dotfiles

-- Set leader first!!
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
--
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

-- vim: ts=2 sts=2 sw=2 et
