-- Useful link
--
-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
-- https://elianiva.my.id/post/neovim-lua-statusline

-- Set display status line always
vim.o.laststatus = 2
-- Turn off shows default insert/replace modes
vim.o.showmode = true

-- [Mode] filename [+] on ~> git-branch
-- C:columnnumber L:linenumber (%percentage of doc) B:buffernumber

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
    {'SLGitInfo', {fg = "#ffffff", bg="#585858", gui=nil}},
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
local function gitinfo()
    -- use fallback because it doesn't set this variable on the initial `BufEnter`
    local head, added, changed, removed = "", 0, 0, 0
    local signs = vim.b.gitsigns_status_dict
    if signs then
        head = signs.head
        added = signs.added or 0
        changed = signs.changed or 0
        removed = signs.removed or 0
    end
    if "" == head then
        return ""
    else
        return string.format(" +%s -%s ~%s  %s ", added, removed, changed, head)
    end
end

-- Get filepath with flags(modified, readonly, helpfile, preview)
local function filepath()
    return " %<%f%m%r%h%w "
end

-- Get filetype
local function filetype()
    local file_name, file_ext = vim.fn.expand("%:t"), vim.fn.expand("%:e")
    local icon = require'nvim-web-devicons'.get_icon(file_name, file_ext, { default = true })
    local ftype = vim.bo.filetype
    if ftype == '' then return '' end
    return string.format(' %s %s ', icon, ftype):lower()
end

-- Get column, linenumber and percent of document
local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " Ln:%l(%p%%) "
end

-- Display current buffer number
local function buffernumber()
    return " B:%n "
end

Statusline = {}
Statusline.active = function()
    local mode, mode_color = get_mode()
    mode_color = "%#"..mode_color.."#"
    return table.concat {
        mode_color, mode,
        "%#SLGitInfo#", gitinfo(),
        "%#SLDefault#", "%=",
        "%#SLFileInfo#", filepath(),
        "%#SLDefault#", "%=",
        "%#SLTrail#", filetype(),
        "%#SLTrail#", lineinfo(),
        mode_color, buffernumber()
    }
end
Statusline.inactive = function()
    return table.concat {
        "%#SLDefault#", "%=",
        "%#SLTrail#", filepath(),
        "%#SLDefault#", "%=",
        "%#SLTrail#", buffernumber()
    }
end

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
