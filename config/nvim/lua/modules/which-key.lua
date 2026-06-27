local M = {}

local whichkey_extras = require("which-key.extras")
local utils = require("utils")

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
      if i > 10 then break end

      ret[#ret + 1] = {
         tostring(i - 1),
         function()
            term:open(require("modules.terminal").get_layout())
            vim.cmd("startinsert")
         end,
         desc = vim.b[term.bufnr].term_title,
         icon = { icon = " ", color = "green" },
      }
   end

   return ret
end

return M
