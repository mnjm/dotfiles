--------------------------------------------------------------------------------------------------
---------------------------------------- mnjm's NeoVim Config ------------------------------------
--------------------------------------------------------------------------------------------------
-- Author - mnjm - github.com/mnjm
-- Repo - github.com/mnjm/dotfiles

---@diagnostic disable: unused-local

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
  }
}

local catppuccin = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 ,
    config = function()
      vim.cmd.colorscheme 'catppuccin'
    end
  }
}

local monokai_pro = {
  {
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
  }
}

local onedark = {
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("onedark").setup {
        style = "cool",
      }
      vim.cmd.colorscheme "onedark"
      vim.cmd("hi Normal guibg=#1c1c1c")
      vim.cmd('hi @lsp.type.comment guifg=#808080')
      vim.cmd('hi @lua.lsp.comment guifg=#808080')
      vim.cmd('hi @comment guifg=#808080')
      vim.cmd('hi Comment guifg=#808080')
      vim.cmd('hi SpecialComment guifg=#808080')
      vim.cmd("hi IncSearch guibg=#15F5BA guifg=#000000")
      vim.cmd("hi Visual guibg=#15F5BA guifg=#000000")
      vim.cmd("hi CurSearch guibg=#FDBF60 guifg=#000000")
      vim.cmd("hi CursorLine gui=bold")
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
-- return monokai_pro

-- vim: ts=2 sts=2 sw=2 et
