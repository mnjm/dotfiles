--------------------------------------------------------------------------------------------------
---------------------------------------- mnjm's NeoVim Config ------------------------------------
--------------------------------------------------------------------------------------------------
-- Author - mnjm - github.com/mnjm
-- Repo - github.com/mnjm/dotfiles

local A = vim.api

local _au = A.nvim_create_augroup('mnjm', { clear = true })

-- Highlight the yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({higroup="CurSearch", timeout=250})
  end,
})

-- Auto remove trailing spaces and lines in c and python codes while saving.
-- NOTE: use ":noa w" to save without trimming
A.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = {"*.c", "*.cc", "*.cpp", "*.h", "*.hpp", "*.py", "*.lua"}, -- Here goes file tyoes
  desc = "Clean up trailing whitespaces and newlines while saving",
  callback = function()
    -- Patterns to remove trailing whitespaces and newlines
    local patterns = {[[%s/\s\+$//e]], [[%s/\($\n\s*\)\+\%$//]]}
    local save = vim.fn.winsaveview()
    for _, v in pairs(patterns) do
      A.nvim_exec2(string.format("keepjumps keeppatterns silent! %s", v), {output = false})
    end
    vim.fn.winrestview(save)
  end,
  group = _au
})

-- Enable spell checking in certail filetypes by default
A.nvim_create_autocmd('FileType', {
  pattern = {"gitcommit", "markdown"}, -- Filetypes (Vim specific) here
  desc = "Enable spelling on commit ad markdown files",
  command = 'setlocal spell',
  group = _au
})

-- if incase cmdheight is set to 0, show statusline in somecases
local cmdheight = A.nvim_get_option_value('cmdheight', {})
if cmdheight == 0 then
  A.nvim_create_autocmd({'RecordingEnter',}, {
    command = "set cmdheight=1", desc = "Show cmd height when recording" })
  A.nvim_create_autocmd({'RecordingLeave',}, {
    command = "set cmdheight=0", desc = "Show cmd height when recording" })
end

-- vim: ts=2 sts=2 sw=2 et
