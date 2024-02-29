return {
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
-- vim: ts=2 sts=2 sw=2 et
