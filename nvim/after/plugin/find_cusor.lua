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

-- Highlight group to highlight cursor

local config = {
  map_to = "<leader>cf",
  keymap_desc = "[C]ursor [F]ind",
  ticks = 6,
  time_ms = 50,
  highlight_size = 20,
}


local find_cursor = function()
  -- get cursor pos
  local pos = vim.fn.getpos('.')
  local ln, col = pos[2], pos[3]
  if not ln or not col then return end
  -- highlight
  local size = math.floor(config.highlight_size / 2)
  local left = col - size
  if left < 1 then left = 1 end
  local time = config.time_ms
  local blink = config.ticks
  for _ = 1, blink, 1
    do
    ---@diagnostic disable-next-line: param-type-mismatch
    local hl_id = vim.fn.matchaddpos("CurSearch", { {ln, left, size*2} }, 1)
    vim.cmd('redraw')
    vim.loop.sleep(time)
    vim.fn.matchdelete(hl_id)
    vim.cmd('redraw')
    vim.loop.sleep(time)
  end
end

-- Find and highlight cursor
vim.keymap.set('n', config.map_to, find_cursor, { desc = config.keymap_desc })

-- vim: ts=2 sts=2 sw=2 et
