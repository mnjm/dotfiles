---------------------------------------------------------------------------------------------------
----------------- Plugin configurations that doesnt deserve its own file --------------------------
---------------------------------------------------------------------------------------------------

-- symbols outline setup
require("symbols-outline").setup()
-- Takes some time for LSP server to loadup and send all tags
vim.keymap.set('n','<leader>o', ':SymbolsOutline<CR>')

-- Telescope File Browser
require('telescope').load_extension('file_browser')
