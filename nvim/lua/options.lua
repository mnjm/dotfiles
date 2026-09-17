vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 4
vim.opt.termguicolors = true
vim.opt.colorcolumn = '101'
vim.opt.confirm = true
vim.opt.spelllang = 'en_us'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.wrap = false
vim.opt.showmatch = true
vim.opt.laststatus = 3
vim.opt.cmdheight = 0

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_altv = 1

for _, group in ipairs({ 'Normal', 'NormalNC', 'EndOfBuffer', 'LineNr' }) do
  vim.api.nvim_set_hl(0, group, { bg = 'none' })
end
