-- Useful link
--
-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
-- https://elianiva.my.id/post/neovim-lua-statusline

-- Set display status line always but only 1 for all windows
vim.o.laststatus = 3
-- Turn off shows default insert/replace modes
vim.o.showmode = true
-- disable displaying command line
vim.o.cmdheight = 0

-- StatusLine highlight groups -- Colorscheme=PaperColor-dark
local highlights = {
    {'SLDefault', {fg = "#ffffff", bg="#282828", gui=nil}},
    {'SLNormalMode', {fg = "#000000", bg="#5faf00", gui="bold"}},
    {'SLReplaceMode', {fg = "#000000", bg="#d7875f", gui="bold"}},
    {'SLCommandMode', {fg = "#000000", bg="#ffaf00", gui="bold"}},
    {'SLInsertMode', {fg = "#000000", bg="#5fafd7", gui="bold"}},
    {'SLVisualMode', {fg = "#000000", bg="#ff5faf", gui="bold"}},
    {'SLUnknownMode', {fg = "#000000", bg="#b3684f", gui="bold"}},
    {'SLTrail', {fg = "#ffffff", bg="#585858", gui=nil}},
    {'SLOtherInfo', {fg = "#000000", bg="#5f8787", gui=nil}},
    {'SLFileInfo', {fg = "#000000", bg="#00afaf", gui="bold"}},
}
for _, highlight in pairs(highlights) do
    local name = highlight[1]
    local fg = highlight[2].fg
    local bg = highlight[2].bg
    local gui = highlight[2].gui == nil and "" or string.format("gui=%s", highlight[2].gui)
    vim.cmd(string.format('hi %s guibg=%s guifg=%s %s', name, bg, fg, gui))
end

-- Show mode
local modes = {
    ["n"] = {"NORMAL", 'SLNormalMode'},
    ["no"] = {"NORMAL", 'SLNormalMode'},
    ["v"] = {"VISUAL", 'SLVisualMode'},
    ["V"] = {"V-LINE", 'SLVisualMode'},
    [""] = {"V-BLOCK", 'SLVisualMode'},
    ["s"] = {"SELECT"},
    ["S"] = {"S-LINE"},
    [""] = {"S-BLOCK"},
    ["i"] = {"INSERT", "SLInsertMode"},
    ["ic"] = {"INSERT", "SLInsertMode"},
    ["R"] = {"REPLACE", "SLReplaceMode"},
    ["Rv"] = {"V-REPLACE", "SLReplaceMode"},
    ["c"] = {"COMMAND", "SLCommandMode"},
    ["cv"] = {"VIM EX"},
    ["ce"] = {"EX"},
    ["r"] = {"PROMPT"},
    ["rm"] = {"MOAR"},
    ["r?"] = {"CONFIRM"},
    ["!"] = {"SHELL"},
    ["t"] = {"TERMINAL"},
}

-- Get the current mode
local function get_mode()
    local current_mode = vim.api.nvim_get_mode().mode
    current_mode = modes[current_mode]
    if current_mode == nil then
        current_mode = {"  ?  ", "SLUnknownMode"}
    end
    if current_mode[2] == nil then
        current_mode[2] = "SLUnknownMode"
    end
    return string.format(" %s ", current_mode[1]), current_mode[2]
end

-- Get git info
local function get_gitinfo()
    -- use fallback because it doesn't set this variable on the initial `BufEnter`
    local head, added, changed, removed = "", 0, 0, 0
    local signs = vim.b.gitsigns_status_dict
    local gitinfo = ""
    if signs then
        head = signs.head or ""
        added = signs.added or 0
        changed = signs.changed or 0
        removed = signs.removed or 0
    end
    if head ~= "" then
        local fmt = { {added, '+'}, {removed, '-'}, {changed, '~'} }
        for _, v in ipairs(fmt) do
            if v[1] ~= 0 then
                gitinfo = string.format("%s %s%s", gitinfo, v[2], v[1])
            end
        end
        gitinfo = string.format("%s  %s ", gitinfo, head)
    end
    return gitinfo
    -- return string.format(" +%s -%s ~%s  %s ", added, removed, changed, head)
end

-- Get lsp info
local function get_lspinfo()
    local ret = ""
    local map = {
        {vim.diagnostic.severity.ERROR, 'Err'},
        {vim.diagnostic.severity.WARN, 'Wrn'},
        -- {vim.diagnostic.severity.INFO, 'Info'},
        -- {vim.diagnostic.severity.HINT, 'Hint'},
    }
    for _, s in ipairs(map) do
        local count = #vim.diagnostic.get(0, {severity = s[1]})
        if count ~=0 then
            ret = string.format("%s %s:%s ", ret, s[2], count)
        end
    end
    ret = ret ~= "" and string.format("%s", ret) or ""
    return ret
end

-- Get filepath with flags(modified, readonly, helpfile, preview)
local function get_filepath()
    return " %<%f%m%r%h%w "
end

-- Get filetype
local function get_filetype()
    local file_name, file_ext = vim.fn.expand("%:t"), vim.fn.expand("%:e")
    local icon = require'nvim-web-devicons'.get_icon(file_name, file_ext, { default = true })
    local ftype = vim.bo.filetype
    if ftype == '' then return '' end
    return string.format(' %s %s ', icon, ftype):lower()
end

-- Get column, linenumber and percent of document
local function get_lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " %c:%l(%p%%) "
end

-- Display current buffer number
local function get_buffernumber()
    return " B:%n "
end

-- Winbar
local set_winbar = function()
    local wins = vim.api.nvim_tabpage_list_wins(0) -- get windows in the current tabpage
    if #wins > 1 then -- if more than 1 windows in the current tabpage
        vim.opt.winbar = table.concat {
            "%#SLFileInfo#", " %<%t%m%r ",
            "%#SLDefault#", "%=",
            "%#SLNormalMode#", get_buffernumber()
        }
        return
    end
    vim.opt.winbar = ""
end

Statusline = {}
Statusline.active = function()
    local mode, mode_color = get_mode()
    mode_color = "%#"..mode_color.."#"
    local lspinfo = get_lspinfo()
    return table.concat {
        mode_color, mode,
        "%#SLOtherInfo#", get_gitinfo(),
        "%#SLDefault#", "%=",
        "%#SLFileInfo#", get_filepath(),
        "%#SLDefault#", "%=",
        "%#SLOtherInfo#", lspinfo,
        "%#SLTrail#", get_filetype(),
        "%#SLTrail#", get_lineinfo(),
        mode_color, get_buffernumber()
    }
end
Statusline.inactive = function()
    return table.concat {
        "%#SLDefault#", "%=",
        "%#SLTrail#", get_filepath(),
        "%#SLDefault#", "%=",
        "%#SLTrail#", get_buffernumber()
    }
end

if vim.o.laststatus == 2 then
    local _au = vim.api.nvim_create_augroup('status_line', { clear = true })
    vim.api.nvim_create_autocmd({'WinEnter', 'BufEnter'}, {
        pattern = "*",
        command = 'setlocal statusline=%!v:lua.Statusline.active()',
        group = _au
    })
    vim.api.nvim_create_autocmd({'WinLeave', 'BufLeave'}, {
        pattern = "*",
        command = 'setlocal statusline=%!v:lua.Statusline.inactive()',
        group = _au
    })
else
    vim.opt.statusline='%!v:lua.Statusline.active()'
    -- Winbar
    local _au = vim.api.nvim_create_augroup('winbar', { clear = true })
    vim.api.nvim_create_autocmd({'WinEnter', 'WinLeave'}, {
        pattern = "*",
        callback = set_winbar,
        group = _au
    })
end
