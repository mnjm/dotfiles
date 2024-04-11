--------------------------------------------------------------------------------------------------
---------------------------------------- mnjm's NeoVim Config ------------------------------------
--------------------------------------------------------------------------------------------------
-- Author - mnjm - github.com/mnjm
-- Repo - github.com/mnjm/dotfiles
-- derived from kickstart.nvim

-- Highlight todo, notes, etc in comments
return {
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
}
-- vim: ts=2 sts=2 sw=2 et
