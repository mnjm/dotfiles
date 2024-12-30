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

local colorschemes = {

  tokyonight = {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme 'tokyonight-night'
    end
  },

  papercolor = {
    "pappasam/papercolor-theme-slim",
    priority = 1000,
    lazy = false,
    config = function()
      vim.o.background = "dark"
      vim.cmd.colorscheme 'PaperColorSlim'
      vim.cmd("hi IncSearch guibg=#15F5BA guifg=#000000")
      vim.cmd("hi CurSearch guibg=#FDBF60 guifg=#000000")
      vim.cmd("hi CursorLine gui=bold")
    end
  },

  nordic = {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require 'nordic' .load()
      -- vim.cmd("hi Normal guifg=#c0c8d8 guibg=#000000")
    end
  },

  kanagawa = {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      require('kanagawa').setup({
        compile = true,
        dimInactive = true,
        theme = "dragon",
        terminalColors = false,
        colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
      })
      vim.cmd.colorscheme 'kanagawa-dragon'
      vim.cmd("hi IncSearch guibg=#15F5BA guifg=#000000")
      vim.cmd("hi Visual guibg=#15F5BA guifg=#000000")
      vim.cmd("hi CurSearch guibg=#FDBF60 guifg=#000000")
      vim.cmd("hi CursorLine gui=bold")
    end
 },

  catppuccin = {
    "catppuccin/nvim", name = "catppuccin", priority = 1000 ,
    config = function()
      vim.cmd.colorscheme 'catppuccin'
    end
  },

  monokai_pro = {
    "loctvl842/monokai-pro.nvim", name = "monokai_pro", priority = 1000,
    config = function()
      require("monokai-pro").setup({
        terminal_colors = false,
        styles = {
          comment = { italic = false }
        },
        filter = "spectrum"
      })
      vim.cmd("colorscheme monokai-pro-spectrum")
      vim.cmd("hi IncSearch guibg=#15F5BA guifg=#000000")
      vim.cmd("hi Visual guibg=#15F5BA guifg=#000000")
      vim.cmd("hi CurSearch guibg=#FDBF60 guifg=#000000")
      vim.cmd("hi CursorLine gui=bold")
    end
  },

  onedark_pro = {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("onedarkpro").setup( {
        options = { transparency = true },
      })
      vim.cmd("colorscheme onedark")
      vim.cmd("hi IncSearch guibg=#15F5BA guifg=#000000")
      vim.cmd("hi Visual guibg=#15F5BA guifg=#000000")
      vim.cmd("hi CurSearch guibg=#FDBF60 guifg=#000000")
      vim.cmd("hi CursorLine gui=bold")
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#abb2bf" })
    end,
  },

  rose_pine = {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require('rose-pine').setup({
        disable_background = true,
        styles = {
          italic = false,
        },
      })
      vim.cmd("colorscheme rose-pine")
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalMC", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    end
  },

}

return colorschemes.papercolor

-- vim: ts=2 sts=2 sw=2 et
