------------------------------------------
-------- Neo-Vim Configurations ----------
-- Neo-Vim wevbsite: https://neovim.io/ --
-------------- LANG: lua -----------------
------------------------------------------

-----Pretty print lua table
function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, { ... })
    print(unpack(objects))
end

require('plugins')
require('settings')
require('keybindings')
