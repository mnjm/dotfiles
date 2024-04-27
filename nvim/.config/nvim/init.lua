--------------------------------------------------------------------------------------------------
---------------------------------------- mnjm's NeoVim Config ------------------------------------
--------------------------------------------------------------------------------------------------
-- Author - mnjm - github.com/mnjm
-- Repo - github.com/mnjm/dotfiles
-- Derived from kickstart.nvim - https://github.com/dam9000/kickstart-modular.nvim

-- Set leader first!!
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Have nerd fonts?
vim.g.have_nerd_fonts = true

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Install and Configure plugins ]]
require 'lazy-plugins'

-- [[ "After" configurations - utils, plugin configs autocmds etc ]]
require 'after'

-- vim: ts=2 sts=2 sw=2 et
