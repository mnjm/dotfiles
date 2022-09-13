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
-- Auto remove trailing space c and python codes while saving.
-- TODO: Add removing trailing lines and :w resets the cursor location. Fix that
A.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.c", "*.py", "*.cc", "*.cpp" }, -- <== Add file types here to remove trailing spaces when saving buffers
  command = [[%s/\s\+$//e]],
  group = _au
})

