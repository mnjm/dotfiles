return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'material',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
