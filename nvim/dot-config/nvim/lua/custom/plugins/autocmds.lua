---------------------------------------------------------------------------------------------------
----------------------------------- Autocmds ------------------------------------------------------
---------------------------------------------------------------------------------------------------
local A = vim.api

local _au = A.nvim_create_augroup('mm', { clear = true })

-- Highlight the region on yank
A.nvim_create_autocmd('TextYankPost', {
    group = _au,
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 250 })
    end,
})

-- Auto remove trailing spaces and lines in c and python codes while saving.
-- use ":noa w" to save without trimming
A.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = {"*.c", "*.cc", "*.cpp", "*.h", "*.hpp", "*.py", "*.lua"}, -- Here goes file tyoes
    callback = function()
        -- Patterns to remove trailing whitespaces and newlines
        local patterns = {[[%s/\s\+$//e]], [[%s/\($\n\s*\)\+\%$//]]}
        local save = vim.fn.winsaveview()
        for _, v in pairs(patterns) do
            A.nvim_exec(string.format("keepjumps keeppatterns silent! %s", v), false)
        end
        vim.fn.winrestview(save)
    end,
    group = _au
})

-- Enable spell checking in certail filetypes by default
A.nvim_create_autocmd('FileType', {
    pattern = {"gitcommit", "markdown"}, -- Filetypes (Vim specific) here
    command = 'setlocal spell',
    group = _au
})
