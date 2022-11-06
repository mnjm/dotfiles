-----------------------------------------
------------- Plugins -------------------
-----------------------------------------
-- Uses Nvim Packer Plugin. Install Nvim packer on fresh systems before use
-- :PackerInstall - to install new packages
-- :PackerSync - to sync packages
return require('packer').startup(function()
    -----------------------------------------------------------------------------------------------
    ------------------------------------- Plugins -------------------------------------------------
    -----------------------------------------------------------------------------------------------
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- Plenary: Lua module most plugins use
    use 'nvim-lua/plenary.nvim'
    -- dev icons that most nvim plugins use
    use { 'kyazdani42/nvim-web-devicons',
            config = function()
                require('nvim-web-devicons').setup()
            end,
        }

    -- Vim commentary
    use 'tpope/vim-commentary'

    -- Vim Surround
    use 'tpope/vim-surround'

    -- Colorschemes
    use 'NLKNguyen/papercolor-theme'

    -- Telescope / FZF
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }
    use { 'nvim-telescope/telescope-fzf-native.nvim',
            run = 'make',
            config = function()
                require('telescope').load_extension('fzf')
            end
        }
    use {"nvim-telescope/telescope-file-browser.nvim",
            config = function()
                require('telescope').load_extension('file_browser')
            end
        }

    -- Git Plugin
    use {
        'lewis6991/gitsigns.nvim',
        tag = 'release'
    }

    -- TreeSitter - For better syntax highlighting
    use 'nvim-treesitter/nvim-treesitter'

    -- LSP - Config'
    use 'neovim/nvim-lspconfig'

    -- LSP - Autocomplete
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'

    -- Snip tools
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- Symbols navigation
    use 'simrat39/symbols-outline.nvim'
end)
