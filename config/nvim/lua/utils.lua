local M = {}

function M.bufname(buf)
   local bufname = vim.api.nvim_buf_get_name(buf)

   if bufname == "" then return "[No Name]" end

   local buftype = vim.bo[buf].buftype
   if buftype == "terminal" then
      local index, _ = require("modules.terminal").get_term_by_bufnr(buf)
      if index then return "Term" .. index end
   end

   return vim.fn.fnamemodify(bufname, ":~:.")
end

return M
