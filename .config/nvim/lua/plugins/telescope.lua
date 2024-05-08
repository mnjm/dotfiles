-- '##::::'##:'##::: ##:::::::'##:'##::::'##:'####::'######:::::'##::: ##:'########::'#######::'##::::'##:'####:'##::::'##:
--  ###::'###: ###:: ##::::::: ##: ###::'###: ####:'##... ##:::: ###:: ##: ##.....::'##.... ##: ##:::: ##:. ##:: ###::'###:
--  ####'####: ####: ##::::::: ##: ####'####:. ##:: ##:::..::::: ####: ##: ##::::::: ##:::: ##: ##:::: ##:: ##:: ####'####:
--  ## ### ##: ## ## ##::::::: ##: ## ### ##:'##:::. ######::::: ## ## ##: ######::: ##:::: ##: ##:::: ##:: ##:: ## ### ##:
--  ##. #: ##: ##. ####:'##::: ##: ##. #: ##:..:::::..... ##:::: ##. ####: ##...:::: ##:::: ##:. ##:: ##::: ##:: ##. #: ##:
--  ##:.:: ##: ##:. ###: ##::: ##: ##:.:: ##:::::::'##::: ##:::: ##:. ###: ##::::::: ##:::: ##::. ## ##:::: ##:: ##:.:: ##:
--  ##:::: ##: ##::. ##:. ######:: ##:::: ##:::::::. ######::::: ##::. ##: ########:. #######::::. ###::::'####: ##:::: ##:
-- ..:::::..::..::::..:::......:::..:::::..:::::::::......::::::..::::..::........:::.......::::::...:::::....::..:::::..::
-- Author - mnjm - github.com/mnjm
-- Repo - github.com/mnjm/dotfiles

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = #vim.fn.argv() > 0 and "VeryLazy" or "UIEnter",
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',

        build = 'make',

        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },

      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_fonts },
    },
    config = function()
      -- Two important keymaps to use while in telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      local telescope = require('telescope')
      telescope.setup {
        -- File ignore patterns
        defaults = {
          file_ignore_patterns = {".git/", ".cache/"},
        },

        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable telescope extensions, if they are installed
      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[F]ind [G]it Files' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind open [B]uffers' })
      vim.keymap.set('n', '<leader>fh', function() builtin.find_files({hidden = true}) end, { desc = '[F]ind [H]idden files' })

      vim.keymap.set('n', '<leader>st', builtin.builtin, { desc = '[S]earch [T]elescope commands' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- Also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch in [B]uffers' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
