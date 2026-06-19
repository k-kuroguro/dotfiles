local M = {}

local utils = require("utils")

function M.expand_winnr()
   local ret = {}
   local current = vim.api.nvim_get_current_win()

   for _, win in ipairs(vim.api.nvim_list_wins()) do
      local is_float = vim.api.nvim_win_get_config(win).relative ~= ""

      if win ~= current and not is_float then
         local buf = vim.api.nvim_win_get_buf(win)
         local name = utils.bufname(buf)
         local winnr = vim.api.nvim_win_get_number(win)

         if winnr <= 10 then
            ret[#ret + 1] = {
               tostring(winnr - 1),
               function() vim.api.nvim_set_current_win(win) end,
               desc = name,
               icon = { cat = "file", name = name },
            }
         end
      end
   end

   table.sort(ret, function(a, b) return tonumber(a[1]) < tonumber(b[1]) end)

   return ret
end

return M
