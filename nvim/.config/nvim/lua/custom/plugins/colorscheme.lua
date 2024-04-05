local tokyonight = {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme 'tokyonight-night'
    end
  }
}
local papercolor = {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is
    {
      "pappasam/papercolor-theme-slim",
      priority = 1000,
      lazy = false,
      config = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme 'PaperColorSlim'
        vim.cmd("hi IncSearch guibg=#15F5BA guifg=#000000")
        vim.cmd("hi Visual guibg=#15F5BA guifg=#000000")
        vim.cmd("hi CurSearch guibg=#FDBF60 guifg=#000000")
        vim.cmd("hi CursorLine gui=bold")
      end
    },
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
  },
}

local nordic = {
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require 'nordic' .load()
      -- vim.cmd("hi Normal guifg=#c0c8d8 guibg=#000000")
    end
  }
}

local kanagawa = {
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd.colorscheme 'kanagawa-dragon'
      vim.cmd("hi Normal guifg=#c0c8d8 guibg=#000000")
    end
  }
}

local catppuccin = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 ,
    config = function()
      vim.cmd.colorscheme 'catppuccin'
    end
  }
}

local onedark = {
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("onedark").setup {
        style = "warmer",
      }
      vim.cmd.colorscheme "onedark"
      vim.cmd("hi Normal guibg=#1c1c1c")
    end
  }
}
-- NOTE: Enable colorscheme here
-- return papercolor
-- return kanagawa
-- return tokyonight
-- return catppuccin
-- return nordic
return onedark
-- vim: ts=2 sts=2 sw=2 et
