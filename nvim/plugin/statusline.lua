-- Useful link
-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
-- https://elianiva.my.id/post/neovim-lua-statusline

-- Set display status line always
vim.o.laststatus = 2
-- Turn off shows default insert/replace modes
vim.o.showmode = false

-- [Mode] filename [+] on ~> git-branch
-- C:columnnumber L:linenumber (%percentage of doc) B:buffernumber

-- StatusLine highlight groups -- Colorscheme=da-one-black
local highlights = {
    {'SLDefault', {fg = "#ffffff", bg="#282828"}},
    {'SLNormalMode', {fg = "#000000", bg="#98c379", gui="bold"}},
    {'SLReplaceMode', {fg = "#000000", bg="#ff9470", gui="bold"}},
    {'SLCommandMode', {fg = "#000000", bg="#ffc387", gui="bold"}},
    {'SLInsertMode', {fg = "#000000", bg="#6bb8ff", gui="bold"}},
    {'SLTerminalMode', {fg = "#000000", bg="#b3684f", gui="bold"}},
    {'SLVisualMode', {fg = "#000000", bg="#fa7883", gui="bold"}},
    {'SLTrail', {fg = "#ffffff", bg="#585858"}},
    {'SLGitInfo', {fg = "#87ff5f", bg="#585858"}}
}
for _, highlight in pairs(highlights) do
    local name = highlight[1]
    local fg = highlight[2].fg
    local bg = highlight[2].bg
    local gui = highlight[1].gui == nil and "" or string.format("gui=%s", highlight[2].gui)
    vim.cmd(string.format('hi %s guibg=%s guifg=%s %s', name, bg, fg, gui))
end

-- Show mode
local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

-- Get the current mode
local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(" %s ", modes[current_mode]):upper()
end

-- Set mode highlight groups
local function update_mode_colors()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#SLDefault#"
  if current_mode == "n" then
      mode_color = "%#SLNormalMode#"
  elseif current_mode == "i" or current_mode == "ic" then
      mode_color = "%#SLInsertMode#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
      mode_color = "%#SLInsertMode#"
  elseif current_mode == "R" then
      mode_color = "%#SLReplaceMode#"
  elseif current_mode == "c" then
      mode_color = "%#SLCommandMode#"
  elseif current_mode == "t" then
      mode_color = "%#SLTerminalMode#"
  end
  return mode_color
end

-- Get git info
local function gitinfo()
    -- use fallback because it doesn't set this variable on the initial `BufEnter`
    local signs = vim.b.gitsigns_status_dict or {head = '', added = 0, changed = 0, removed = 0}
    local is_head_empty = signs.head == ''
    if is_head_empty then
        return ""
    else
        return string.format(" on ↝ %s (+%s -%s ~%s) ", signs.head, signs.added, signs.removed, signs.changed)
    end
end

-- Get filepath with flags(modified, readonly, helpfile, preview)
local function filepath()
    return " %<%f%m%r%h%w "
end

-- Get filetype
local function filetype()
    return string.format("FT:%s ", vim.bo.filetype:gsub("^%l", string.upper))
end

-- Get column, linenumber and percent of document
local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " C:%c L:%l (%p%%) "
end

-- Display current buffer number
local function buffernumber()
    return " B:%n "
end

statusline = {}
statusline.active = function()
    local mode_color = update_mode_colors()
    return table.concat {
        mode_color, mode(),
        "%#SLDefault#", " ",
        "%#SLGitInfo#", gitinfo(),
        "%#SLDefault#", "%=",
        mode_color, filepath(),
        "%#SLDefault#", "%=",
        "%#SLTrail#", filetype(),
        "%#SLDefault#", " ",
        "%#SLTrail#", lineinfo(),
        mode_color, buffernumber()
    }
end
statusline.inactive = function()
    return "%=%F%="
end

local _au = vim.api.nvim_create_augroup('status_line', { clear = true })
vim.api.nvim_create_autocmd({'WinEnter', 'BufEnter'}, {
    pattern = "*",
    command = 'setlocal statusline=%!v:lua.statusline.active()',
    group = _au
})
vim.api.nvim_create_autocmd({'WinLeave', 'BufLeave'}, {
    pattern = "*",
    command = 'setlocal statusline=%!v:lua.statusline.inactive()',
    group = _au
})
