-----------------------------------------
------------- Plugins -------------------
-----------------------------------------
-- Uses Nvim Packer Plugin. Install Nvim packer on fresh systems before use
-- :PackerInstall - to install new packages
-- :PackerSync - to sync packages
return require('packer').startup(function()

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Plenary: Lua module most plugins use
    use 'nvim-lua/plenary.nvim'

    -- Vim commentary
    use 'tpope/vim-commentary'

    -- Vim Surround
    use 'tpope/vim-surround'

    -- Colorschemes
    use 'RRethy/nvim-base16'

    -- Telescope / FZF
    -- use { "~/.fzf", run = ":call fzf#install()" }
    -- use { "junegunn/fzf", run = ":call fzf#install()" }
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }
    use { 'nvim-telescope/telescope-fzf-native.nvim',
            run = 'make',
            config = function()
                require('telescope').load_extension('fzf')
            end
        }

    use { 'kyazdani42/nvim-web-devicons',
            config = function()
                require('nvim-web-devicons').setup()
            end,
        }
end)
