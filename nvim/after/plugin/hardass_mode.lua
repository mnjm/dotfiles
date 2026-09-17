vim.g.mm_hardass_mode = vim.g.mm_hardass_mode ~= false

local arrow_keys = { '<Up>', '<Down>', '<Left>', '<Right>' }
local modes = { 'n', 'v', 'i' }

local function set_hardass_mode(enabled)
  for _, key in ipairs(arrow_keys) do
    if enabled then
      vim.keymap.set(modes, key, '<Nop>', { silent = true })
    else
      pcall(vim.keymap.del, modes, key)
    end
  end
end

set_hardass_mode(vim.g.mm_hardass_mode)

vim.api.nvim_create_user_command('HardAssModeToggle', function()
  vim.g.mm_hardass_mode = not vim.g.mm_hardass_mode
  set_hardass_mode(vim.g.mm_hardass_mode)
  vim.notify('Hardass mode: ' .. tostring(vim.g.mm_hardass_mode))
end, {})
