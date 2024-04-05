return {
  {
    'mnjm/bottomline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- See `:help lualine.txt`
    opts = {
      highlights = {
        BLMode = { fg="#282c34", bg="#98c379", bold=true },
      },
      -- seperators = { '',  '' },
      seperators = { '',  '' },
      git_symbols = { branch = "" },
      display_buf_no = true,
    },
  },
}
