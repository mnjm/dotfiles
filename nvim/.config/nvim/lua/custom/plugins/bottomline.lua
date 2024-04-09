return {
  {
    -- 'mnjm/bottomline.nvim',
    dir = "/home/manjunath/workspace/bottomline.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- See `:help lualine.txt`
    opts = {
      enable = true,
      enable_icons = true,
      highlights = {
        BLMode = { fg="#282c34", bg="#98c379", bold=true },
        BLLine = { link="BLMode" },
      },
      -- seperators = { '',  '' },
      seperators = { '',  '' },
      git_symbols = { branch = "" },
    },
  },
}
