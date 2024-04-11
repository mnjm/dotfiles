--------------------------------------------------------------------------------------------------
---------------------------------------- mnjm's NeoVim Config ------------------------------------
--------------------------------------------------------------------------------------------------
-- Author - mnjm - github.com/mnjm
-- Repo - github.com/mnjm/dotfiles
-- derived from kickstart.nvim

return {
  {
    -- 'mnjm/winline.nvim',
    dir = "/home/manjunath/workspace/winline.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      enable = true,
      always_show = false,
      enable_icons = true,
      close_icon = "󱎘",
      display_buf_no = true,
      -- seperators = { '',  '' },
      -- seperators = { '',  '' },
      seperators = { '',  '' },
    }
  },
}
