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
        vim.cmd("hi CurSearch guibg=#15F5BA guifg=#000000")
        vim.cmd("hi IncSearch guibg=#FDBF60 guifg=#000000")
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

-- NOTE: Enable colorscheme here
return papercolor
-- return kanagawa
-- return tokyonight
-- return catppuccin
-- return nordic
-- vim: ts=2 sts=2 sw=2 et
