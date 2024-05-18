--                                           /$$                                                       /$$
--                                          | $/                                                      |__/
--  /$$$$$$/$$$$  /$$$$$$$  /$$ /$$$$$$/$$$$|_//$$$$$$$       /$$$$$$$   /$$$$$$   /$$$$$$  /$$    /$$ /$$ /$$$$$$/$$$$
-- | $$_  $$_  $$| $$__  $$|__/| $$_  $$_  $$ /$$_____/      | $$__  $$ /$$__  $$ /$$__  $$|  $$  /$$/| $$| $$_  $$_  $$
-- | $$ \ $$ \ $$| $$  \ $$ /$$| $$ \ $$ \ $$|  $$$$$$       | $$  \ $$| $$$$$$$$| $$  \ $$ \  $$/$$/ | $$| $$ \ $$ \ $$
-- | $$ | $$ | $$| $$  | $$| $$| $$ | $$ | $$ \____  $$      | $$  | $$| $$_____/| $$  | $$  \  $$$/  | $$| $$ | $$ | $$
-- | $$ | $$ | $$| $$  | $$| $$| $$ | $$ | $$ /$$$$$$$/      | $$  | $$|  $$$$$$$|  $$$$$$/   \  $/   | $$| $$ | $$ | $$
-- |__/ |__/ |__/|__/  |__/| $$|__/ |__/ |__/|_______/       |__/  |__/ \_______/ \______/     \_/    |__/|__/ |__/ |__/
--                    /$$  | $$
--                   |  $$$$$$/
--                    \______/
-- Author - mnjm - github.com/mnjm
-- Repo - github.com/mnjm/dotfiles

return {
  {
    'mnjm/bottomline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_fonts },
    -- See `:help lualine.txt`
    opts = {
      enable = true,
      enable_icons = vim.g.have_nerd_fonts,
      highlights = {
        BLMode = { fg="#282c34", bg="#98c379", bold=true },
        BLLine = { link="BLMode" },
        BLFill = {},
        BLFileType = {fg = "#000000", bg = "#878787", bold = false},
      },
      -- seperators = { '',  '' },
      -- seperators = { '',  '' },
      seperators = vim.g.have_nerd_fonts and { '',  '' } or nil,
      git_symbols = { branch = "" },
      lsp_symbols = {
        error = " ",
        warn = " ",
        info = " ",
        hint = " ",
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
