--                                           /$$                                                       /$$
--                                          | $/                                                      |__/
--  /$$$$$$/$$$$  /$$$$$$$  /$$ /$$$$$$/$$$$|_//$$$$$$$       /$$$$$$$   /$$$$$$   /$$$$$$  /$$    /$$ /$$ /$$$$$$/$$$$
-- | $$_  $$_  $$| $$__  $$|__/| $$_  $$_  $$ /$$_____/      | $$__  $$ /$$__  $$ /$$__  $$|  $$  /$$/| $$| $$_  $$_  $$
-- | $$ \ $$ \ $$| $$  \ $$ /$$| $$ \ $$ \ $$|  $$$$$$       | $$  \ $$| $$$$$$$$| $$  \ $$ \  $$/$$/ | $$| $$ \ $$ \ $$
-- | $$ | $$ | $$| $$  | $$| $$| $$ | $$ | $$ \____  $$      | $$  | $$| $$_____/| $$  | $$  \  $$$/  | $$| $$ | $$ | $$
-- | $$ | $$ | $$| $$  | $$| $$| $$ | $$ | $$ /$$$$$$$/      | $$  | $$|  $$$$$$$|  $$$$$$/   \  $/   | $$| $$ | $$ | $$
-- |__/ |__/ |__/|__/  |__/| $$|__/ |__/ |__/|_______/       |__/  |__/ \_______/ \______/     \_/    |__/|__/ |__/ |__/
--                    /$$  | $$
--                   |  $$$$$$/
--                    \______/
-- Author - mnjm - github.com/mnjm
-- Repo - github.com/mnjm/dotfiles

local A = vim.api

local _au = A.nvim_create_augroup('mnjm', { clear = true })

-- Highlight the yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = _au,
  callback = function()
    vim.highlight.on_yank({higroup="CurSearch", timeout=250})
  end,
})

-- Auto remove trailing spaces and lines in c and python codes while saving.
-- NOTE: use ":noa w" to save without trimming
A.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
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

-- if incase cmdheight is set to 0, show statusline in somecases
local cmdheight = A.nvim_get_option_value('cmdheight', {})
if cmdheight == 0 then
  A.nvim_create_autocmd({'RecordingEnter',}, {
    command = "set cmdheight=1", desc = "Show cmd height when recording" })
  A.nvim_create_autocmd({'RecordingLeave',}, {
    command = "set cmdheight=0", desc = "Show cmd height when recording" })
end

-- Diff mode: get / put single line changes
A.nvim_create_autocmd("DiffUpdated", {
  pattern = "*",
  desc = "Add keybinds for single line get/put <leader>dg <leader>dp",
  callback = function()
    vim.keymap.set('n', '<leader>dg', '<CMD>.diffget<CR>', { desc = "[D]iff[G]et single line" })
    vim.keymap.set('n', '<leader>dp', '<CMD>.diffput<CR>', { desc = "[D]iff[P]ut single line" })
  end,
  once = true,
  group = _au
})

-- vim: ts=2 sts=2 sw=2 et
