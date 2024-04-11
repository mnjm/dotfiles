--------------------------------------------------------------------------------------------------
---------------------------------------- mnjm's NeoVim Config ------------------------------------
--------------------------------------------------------------------------------------------------
-- Author - mnjm - github.com/mnjm
-- Repo - github.com/mnjm/dotfiles

return {
  {
    -- 'mnjm/topline.nvim',
    dir = "/home/manjunath/workspace/topline.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      enable = true,
      -- seperator = { pre = '', post = '' },
      -- seperator = { pre = '', post = '' },
      seperator = { pre = '',  post = '' },
      close_icon = " 󰅘 ",
      highlights = {
        TopLineClose = { fg = "#d70000", bg = "#000000" },
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
