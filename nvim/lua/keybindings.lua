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

-- Highlight group to highlight cursor
vim.cmd("hi MMCursorHL guibg=#6bb8ff guifg=#000000")
-- Function to highlight cursor
local find_cursor = function()
    local pattern = "\\k*\\%#\\k*"
    local time = 50
    local blink = 6
    for _ = 1, blink, 1
    do
        local hl_id = vim.fn.matchadd("MMCursorHL", pattern, 1)
        vim.cmd('redraw')
        vim.loop.sleep(time)
        vim.fn.matchdelete(hl_id)
        vim.cmd('redraw')
        vim.loop.sleep(time)
    end
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
-- Open Fzf
map('n', '<leader>f', '<CMD>Telescope find_files<CR>')
map('n', '<leader>fb', '<CMD>Telescope file_browser<CR>')
map('n', '<leader>b', '<CMD>Telescope buffers<CR>')
-- Move between tabs easily
map('n', '<C-Left>', '<CMD>tabp<CR>')
map('n', '<C-Right>', '<CMD>tabn<CR>')
-- Move between splits
map('n', '<C-h>', '<C-W><C-h>')
map('n', '<C-j>', '<C-W><C-j>')
map('n', '<C-k>', '<C-W><C-k>')
map('n', '<C-l>', '<C-W><C-l>')
-- Find and highlight cursor
map('n', '<leader>c', find_cursor)
-- Delete but dont put the deleted thing into the register
map('v', '<leader>d', '\"_d')
