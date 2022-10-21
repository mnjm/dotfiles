--------------------------------------------------------------------------------------------------
------------------------ Configs for LSP, Treesitter and completions -----------------------------
--------------------------------------------------------------------------------------------------

--- Treesitter
require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all"
    ensure_installed = "all", -- Only include parsers that are maintained
    -- ensure_installed = {"c", "cpp", "lua", "python", "bash", "yaml"}, -- Only include parsers that are maintained

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- List of parsers to ignore installing (for "all")
    ignore_install = {},

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "c", "rust" },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}
--- Folding -- I dont like folding at this point
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Smart commenting in embedded languages (like vim-script containint lua code)
-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring

---------------------------------------------------------------------------------------------------
----------------------------------- LSP Configurations --------------------------------------------
---------------------------------------------------------------------------------------------------
-- LSP Keybindings
local kmaps = {
    {'n', 'gd', vim.lsp.buf.definition},
    {'n', 'gD', vim.lsp.buf.declaration},
    {'n', 'gi', vim.lsp.buf.implementation},
    {'n', 'gr', vim.lsp.buf.references},
    {'n', 'gt', vim.lsp.buf.type_definition},
    {'n', 'K', vim.lsp.buf.hover},
    {'n', '<leader>k', vim.lsp.buf.signature_help},
    {'n', '<leader>ac', vim.lsp.buf.code_action},
    {'n', '<leader>rn', vim.lsp.buf.rename},
    {'n', 'gh', vim.diagnostic.open_float},
    {'n', '<leader>[', vim.diagnostic.goto_prev},
    {'n', '<leader>]', vim.diagnostic.goto_next},
}
local on_attach = function()
    for _, km in pairs(kmaps) do
        vim.keymap.set(km[1], km[2], km[3], { silent = true, noremap = true, buffer = 0 })
    end
end
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- LSP Configurations for Lua (for nvim)
-- sumneko_lua link: https://github.com/sumneko/lua-language-server
require('lspconfig').sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim', 'use'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
-- LSP Configurations for Python
require('lspconfig').pyright.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
-- LSP Configuration for c, cpp (c based languages)
-- Check here: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd
require('lspconfig').clangd.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
-- LSP Configuration for rust
require('lspconfig').rust_analyzer.setup{
    on_ttach = on_attach,
    capabilities = capabilities,
}

---------------------------------------------------------------------------------------------------
------------------------------ Completion Engine Stuff --------------------------------------------
---------------------------------------------------------------------------------------------------
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
local kind_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = ""
}
-- Set up nvim-cmp.
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'buffer' , option = {
            get_bufnrs = function() return vim.api.nvim_list_bufs() end, -- completions from all open buffers
        }},
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
    }, {
        { name = 'buffer'}
    }),
    formatting = {
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            -- Source
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                -- nvim_lua = "[Lua]",
                -- latex_symbols = "[LaTeX]",
            })[entry.source.name]
            return vim_item
        end
    },
})
