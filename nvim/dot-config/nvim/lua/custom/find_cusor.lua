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
-- Find and highlight cursor
vim.keymap.set('n', '<leader>fc', find_cursor, { desc = '[F]ind [C]ursor' })
