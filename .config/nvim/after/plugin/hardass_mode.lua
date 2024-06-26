--                                           /$$                                                       /$$
--                                          | $/                                                      |__/
--  /$$$$$$/$$$$  /$$$$$$$  /$$ /$$$$$$/$$$$|_//$$$$$$$       /$$$$$$$   /$$$$$$   /$$$$$$  /$$    /$$ /$$ /$$$$$$/$$$$
-- | $$_  $$_  $$| $$__  $$|__/| $$_  $$_  $$ /$$_____/      | $$__  $$ /$$__  $$ /$$__  $$|  $$  /$$/| $$| $$_  $$_  $$
-- | $$ \ $$ \ $$| $$  \ $$ /$$| $$ \ $$ \ $$|  $$$$$$       | $$  \ $$| $$$$$$$$| $$  \ $$ \  $$/$$/ | $$| $$ \ $$ \ $$
-- | $$ | $$ | $$| $$  | $$| $$| $$ | $$ | $$ \____  $$      | $$  | $$| $$_____/| $$  | $$  \  $$$/  | $$| $$ | $$ | $$
-- | $$ | $$ | $$| $$  | $$| $$| $$ | $$ | $$ /$$$$$$$/      | $$  | $$|  $$$$$$$|  $$$$$$/   \  $/   | $$| $$ | $$ | $$
-- |__/ |__/ |__/|__/  |__/| $$|__/ |__/ |__/|_______/       |__/  |__/ \_______/ \______/     \_/    |__/|__/ |__/ |__/
--                    /$$  | $$
--                   |  $$$$$$/
--                    \______/
-- Author - mnjm - github.com/mnjm
-- Repo - github.com/mnjm/dotfiles

-- If enabled, arrow navigations will be disabled.

-- Uses vim.g.mm_hardass_mode global variable to enable/disable the mode
vim.g.mm_hardass_mode = true
local map_exists = false
if vim.g.mm_hardass_mode == nil then
  vim.g.mm_hardass_mode = false
end

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true, noremap = true })
end

local function unmap(m, k)
  vim.keymap.del(m, k)
end

local kmaps = {
  {{'n', 'v', 'i'}, {lhs = '<Up>', rhs='<Nop>'}},
  {{'n', 'v', 'i'}, {lhs = '<Down>', rhs='<Nop>'}},
  {{'n', 'v', 'i'}, {lhs = '<Left>', rhs='<Nop>'}},
  {{'n', 'v', 'i'}, {lhs = '<Right>', rhs='<Nop>'}},
}

-- Set key maps
local function set_hardass_key_maps()
  for _, km in pairs(kmaps) do
    if vim.g.mm_hardass_mode then
      map(km[1], km[2].lhs, km[2].rhs)
      map_exists = true
    else
      if map_exists then
        unmap(km[1], km[2].lhs)
      end
    end
  end
end

-- Toggle hardass mode flag
local function toggle_hardass_mode()
  vim.g.mm_hardass_mode = not vim.g.mm_hardass_mode
  -- Display it to user
  print("Hardass mode:"..tostring(vim.g.mm_hardass_mode))
  -- bind / unbind keys
  set_hardass_key_maps()
end

-- map / unmap based on initial configurations
set_hardass_key_maps()

-- User command [exposed] to toggle hardass mode
vim.api.nvim_create_user_command('HardAssModeToggle', toggle_hardass_mode, {})

-- vim: ts=2 sts=2 sw=2 et
