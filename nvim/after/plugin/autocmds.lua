local group = vim.api.nvim_create_augroup('mnjm', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = group,
  desc = 'Highlight yanked text',
  callback = function()
    vim.highlight.on_yank({ higroup = 'CurSearch', timeout = 250 })
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = group,
  pattern = '*',
  desc = 'Remove trailing whitespace and blank lines',
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd [[keepjumps keeppatterns silent! %s/\s\+$//e]]
    vim.cmd [[keepjumps keeppatterns silent! %s/\($\n\s*\)\+\%$//e]]
    vim.fn.winrestview(view)
  end,
})

if vim.o.cmdheight == 0 then
  vim.api.nvim_create_autocmd('RecordingEnter', {
    group = group,
    command = 'set cmdheight=1',
    desc = 'Show the command line while recording',
  })
  vim.api.nvim_create_autocmd('RecordingLeave', {
    group = group,
    command = 'set cmdheight=0',
    desc = 'Hide the command line after recording',
  })
end
