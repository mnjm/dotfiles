local config = {
  map_to = '<leader>cf',
  keymap_desc = '[C]ursor [F]ind',
  ticks = 6,
  time_ms = 50,
  highlight_size = 20,
}

local function find_cursor()
  local line, column = unpack(vim.api.nvim_win_get_cursor(0))
  local size = math.floor(config.highlight_size / 2)
  local left = math.max(column - size + 1, 1)

  for _ = 1, config.ticks do
    local highlight_id = vim.fn.matchaddpos('CurSearch', { { line, left, size * 2 } }, 1)
    vim.cmd.redraw()
    vim.uv.sleep(config.time_ms)
    vim.fn.matchdelete(highlight_id)
    vim.cmd.redraw()
    vim.uv.sleep(config.time_ms)
  end
end

vim.keymap.set('n', config.map_to, find_cursor, { desc = config.keymap_desc })
