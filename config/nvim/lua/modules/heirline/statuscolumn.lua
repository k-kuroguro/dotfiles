local lib = require("heirline-components.all")

return {
   init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
   lib.component.signcolumn(),
   lib.component.numbercolumn({
      hl = function()
         if vim.v.lnum == vim.fn.line(".") then return { bold = true } end
      end,
   }),
   lib.component.foldcolumn(),
}
