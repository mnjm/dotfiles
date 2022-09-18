-------------------------------------------
--------------- Key Bindings --------------
-------------------------------------------

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

local find_cursor = function()
    if vim.w.mm_cursor_hl_id then
        vim.fn.matchdelete(vim.w.mm_cursor_hl_id)
        vim.w.mm_cursor_hl_id = nil
        return
    end
    local pattern = "\\k*\\%#\\k*"
    vim.w.mm_cursor_hl_id = vim.fn.matchadd("MMCursorHL", pattern, 1)
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
map('n', '<leader>p', '"+p')
-- Open Fzf
map('n', '<leader>f', '<CMD>Telescope find_files<CR>')
-- Move between tabs easily
map('n', '<C-Left>', '<CMD>tabp<CR>')
map('n', '<C-Right>', '<CMD>tabn<CR>')
-- Move between splits
map('n', '<C-h>', '<C-W><C-h>')
map('n', '<C-j>', '<C-W><C-j>')
map('n', '<C-k>', '<C-W><C-k>')
map('n', '<C-l>', '<C-W><C-l>')
-- Find and highlight cursor
-- Highlight group to highlight cursor
vim.cmd("hi MMCursorHL guibg=red guifg=blue")

-- Function to highlight cursor
map('n', '<leader>c', find_cursor)
