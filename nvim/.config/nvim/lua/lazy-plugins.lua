require('lazy').setup {

  'tpope/vim-surround', -- operates on surrounding objs like ysiw) adds () around inner world
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { 'numToStr/Comment.nvim', opts = {} }, -- commet plugin gc comments on selectd lines gcc on current line
  { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_fonts },
  require 'kickstart/plugins/gitsigns',
  require 'kickstart/plugins/which-key',
  require 'kickstart/plugins/telescope',
  require 'kickstart/plugins/lspconfig',
  require 'kickstart/plugins/cmp',
  require 'kickstart/plugins/todo-comments',
  require 'kickstart/plugins/treesitter',
  require 'custom/plugins/colorscheme',
  require 'custom/plugins/bottomline',
  require 'custom/plugins/topline',
  require 'custom/plugins/winline',
  require 'custom/plugins/lf',
}

-- vim: ts=2 sts=2 sw=2 et
