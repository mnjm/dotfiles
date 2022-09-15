--------------------------------------------------------
---------------- NVIM Autocmds -------------------------
--------------------------------------------------------
-- Ref: https://neovim.io/doc/user/api.html#API
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
patterns = {[[%s/\s\+$//e]], [[%s/\($\n\s*\)\+\%$//]]}
files = { "*.c", "*.py", "*.cc", "*.cpp" }, 
A.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = files, 
    callback = function()
        local save = vim.fn.winsaveview()
        for _, v in pairs(patterns) do
            A.nvim_exec(string.format("keepjumps keeppatterns silent! %s", v), false)
        end
        vim.fn.winrestview(save)
    end,
    group = _au
})

