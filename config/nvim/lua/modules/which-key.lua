local M = {}

local whichkey_extras = require("which-key.extras")
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

local function bufs()
   local current = vim.api.nvim_get_current_buf()
   return vim.tbl_filter(
      function(buf) return buf ~= current and vim.bo[buf].buflisted and vim.bo[buf].buftype == "" end,
      vim.api.nvim_list_bufs()
   )
end

function M.expand_buf()
   local ret = {}

   for _, buf in ipairs(bufs()) do
      local name = utils.bufname(buf)
      ret[#ret + 1] = {
         "",
         function() vim.api.nvim_set_current_buf(buf) end,
         desc = name,
         icon = { cat = "file", name = name },
      }
   end

   return whichkey_extras.add_keys(ret)
end

function M.expand_term()
   local ret = {}

   for i, term in ipairs(require("terminal.active_terminals"):get_sorted_terminals()) do
      if i > 9 then break end

      local name = "Term" .. i
      ret[#ret + 1] = {
         tostring(i),
         function()
            term:open(require("modules.terminal").get_layout())
            vim.cmd("startinsert")
         end,
         desc = name,
      }
   end

   return ret
end

return M
