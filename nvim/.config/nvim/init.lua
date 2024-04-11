--------------------------------------------------------------------------------------------------
---------------------------------------- mnjm's NeoVim Config ------------------------------------
--------------------------------------------------------------------------------------------------
-- derived from kickstart.nvim
-- Set leader first!!
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Have nerd fonts?
vim.g.have_nerd_fonts = true

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'

-- [[ "After" configurations - utils, plugin configs autocmds etc ]]
require 'custom'

-- vim: ts=2 sts=2 sw=2 et
