--------------------------------------------------------------------------------------------------
---------------------------------------- mnjm's NeoVim Config ------------------------------------
--------------------------------------------------------------------------------------------------
-- Author - mnjm - github.com/mnjm
-- Repo - github.com/mnjm/dotfiles
-- derived from kickstart.nvim

require('lazy').setup {

  'tpope/vim-surround', -- operates on surrounding objs like ysiw) adds () around inner world
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { 'numToStr/Comment.nvim', opts = {} }, -- commet plugin gc comments on selectd lines gcc on current line
  { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_fonts },
  require 'plugins/gitsigns',
  require 'plugins/which-key',
  require 'plugins/telescope',
  require 'plugins/lspconfig',
  require 'plugins/cmp',
  require 'plugins/todo-comments',
  require 'plugins/treesitter',
  require 'plugins/colorscheme',
  require 'plugins/bottomline',
  require 'plugins/topline',
  require 'plugins/winline',
  require 'plugins/lf',
}

-- vim: ts=2 sts=2 sw=2 et
