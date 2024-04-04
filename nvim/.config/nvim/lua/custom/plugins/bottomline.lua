return {
  {
    'mnjm/bottomline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- See `:help lualine.txt`
    opts = {
      seperators = { '',  '' },
      -- seperators = { '',  '' },
      git_symbols = { branch = "" },
      display_buf_no = true,
    },
  },
}
