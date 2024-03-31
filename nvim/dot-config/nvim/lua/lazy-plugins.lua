require('lazy').setup {

  'tpope/vim-surround', -- ops on surrounding objs like ysiw) adds () around inner world
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Icons
  { 'nvim-tree/nvim-web-devicons' },

  -- modular approach: using `require 'path/name'` will
  -- include a plugin definition from file lua/path/name.lua

  require 'kickstart/plugins/gitsigns',

  require 'kickstart/plugins/which-key',

  require 'kickstart/plugins/telescope',

  require 'kickstart/plugins/lspconfig',

  require 'kickstart/plugins/cmp',

  require 'kickstart/plugins/todo-comments',

  require 'kickstart/plugins/treesitter',

  require 'custom/plugins/colorscheme',

  -- require 'custom/plugins/lualine',
  require 'custom/plugins/bottomline',

  require 'custom/plugins/topline',

  require 'custom/plugins/lf',

}

-- vim: ts=2 sts=2 sw=2 et
