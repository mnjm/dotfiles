------------------------------------------
-------- Neo-Vim Configurations ----------
-- Neo-Vim wevbsite: https://neovim.io/ --
------------------------------------------

local g   = vim.g
local o   = vim.o
local A   = vim.api

-- Enabling 24-bit color in Terminal UI
o.termguicolors = true

-- Wait 'timeoutlen'ms to receive next keystroke after pressing a binding key(ex. ctrl-f)
o.timeoutlen = 500

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 8

-- Better editor UI --
o.number = true
o.numberwidth = 2
o.relativenumber = true
o.cursorline = true
o.colorcolumn = "100"

-- More readable [Not saved] message
o.confirm = true

-- Better Editing experience
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = -1 -- If negative, shiftwidth value is used
o.expandtab = true
o.smartindent = true
o.autoindent = true
o.wrap = true -- This wraps txt to next line
o.showmatch = true -- Highlight matching brackets
-- Sane way of spitting buffers
o.splitright = true
o.splitbelow = true

-- Sane way of searching
o.incsearch = true
o.hlsearch = true

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = 'unnamedplus'

-- Map Leader Key building --
g.mapleader = ","
g.maplocalleader = ","

local _au = A.nvim_create_augroup('mm', { clear = true })

-- Highlight the region on yank
A.nvim_create_autocmd('TextYankPost', {
    group = _au,
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 240 })
    end,
})
-- Auto remove trailing space c and python codes while saving.
A.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.c", "*.py", "*.cc", "*.cpp" }, -- <== Add file types here to remove trailing spaces when saving buffers
  command = [[%s/\s\+$//e]],
  group = _au
})

-------------------------------------------
--------------- Key Bindings --------------
-------------------------------------------
local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true, noremap = true })
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
map('x', '<leader>p', '"+p')
-- Open Fzf
map('n', '<leader>f', '<CMD>FZF<CR>')
-- Move between tabs easily
map('n', '<leader>h', '<CMD>tabp<CR>')
map('n', '<leader>l', '<CMD>tabn<CR>')
-- Move between splits
map('n', '<C-h>', '<C-W><C-h>')
map('n', '<C-j>', '<C-W><C-j>')
map('n', '<C-k>', '<C-W><C-k>')
map('n', '<C-l>', '<C-W><C-l>')

-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tomorrow-night')
local ok, _ = pcall(vim.cmd, 'colorscheme base16-monokai')

-----------------------------------------
------------- Plugins -------------------
-----------------------------------------
return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- Vim commentary
    use 'tpope/vim-commentary'
    -- Vim Surround
    use 'tpope/vim-surround'
    -- Colorschemes
    use 'RRethy/nvim-base16'
    -- FZF
    -- use { "~/.fzf", run = ":call fzf#install()" }
    use { "junegunn/fzf", run = ":call fzf#install()" }
end)
