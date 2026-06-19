local M = {}

local float
function M.float_toggle()
   if not float then
      float = require("toggleterm.terminal").Terminal:new({
         count = 100,
         direction = "float",
         hidden = true,
         on_create = function() end,
      })
   end

   float:toggle()
end

M.MAX_PRESET_TERMS = 3
function M.preset_terms()
   local terms = {}
   for i = 1, M.MAX_PRESET_TERMS do
      terms[#terms + 1] = {
         "<leader>t" .. i,
         "<cmd>" .. i .. "ToggleTerm size=10 direction=horizontal<CR>",
         desc = "Term" .. i,
      }
   end
   return terms
end

return M
