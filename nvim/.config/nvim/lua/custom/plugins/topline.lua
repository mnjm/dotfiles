return {
  {
    'mnjm/topline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      seperator = { pre = '', post = '' },
      -- seperator = { pre = '', post = '' },
      close_icon = " 󰅘 ",
      highlights = {
        TopLineClose = { fg = "#d70000", bg = "#000000" },
      },
    },
  },
}
