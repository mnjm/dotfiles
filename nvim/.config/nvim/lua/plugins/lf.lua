--------------------------------------------------------------------------------------------------
---------------------------------------- mnjm's NeoVim Config ------------------------------------
--------------------------------------------------------------------------------------------------
-- Author - mnjm - github.com/mnjm
-- Repo - github.com/mnjm/dotfiles

return {
  {
    "lmburns/lf.nvim",
    dependencies = {
      'akinsho/toggleterm.nvim'
    },
    config = function()
      local size = 0.9
      local fn = vim.fn
      local o = vim.o
      require("lf").setup({
        default_action = "drop", -- default action when `Lf` opens a file
        dir = "", -- directory where `lf` starts ('gwd' is git-working-directory, ""/nil is CWD)
        direction = "float", -- window type: float horizontal vertical
        border = "shadow", -- border kind: single double shadow curved
        height = fn.float2nr(fn.round(size * o.lines)), -- height of the *floating* window
        width = fn.float2nr(fn.round(size * o.columns)), -- width of the *floating* window
        escape_quit = true, -- map escape to the quit command (so it doesn't go into a meta normal mode)
        focus_on_open = true, -- focus the current file when opening Lf (experimental)
        mappings = false, -- whether terminal buffer mapping is enabled
        highlights = { -- highlights passed to toggleterm
          Normal = {link = "Normal"},
          NormalFloat = {link = 'Normal'},
        },
      })
      vim.keymap.set(
        "n",
        "<leader>bf",
        function()
          require("lf").start()
        end,
        {noremap = true, desc = "[B]rowse [F]iles"}
      )
      vim.keymap.set(
        "n",
        "<leader>bg",
        function()
          require("lf").start("gwd")
        end,
        {noremap = true, desc = "[B]rowse [G]it Files"}
      )
    end
  },
}
