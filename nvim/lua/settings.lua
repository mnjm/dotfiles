--------------------------------------------------------
---------------- NVIM Settings -------------------------
--------------------------------------------------------
-- Ref: https://neovim.io/doc/user/options.html

local o   = vim.o

-- Enabling 24-bit color in Terminal UI
o.termguicolors = true

-- Wait 'timeoutlen'ms to receive next keystroke after pressing a binding key(ex. ctrl-f)
o.timeoutlen = 500

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 8

-- Better editor UI --
o.number = true
o.numberwidth = 3
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

vim.cmd[[colorscheme base16-da-one-black]]
