local M = {}

function M.bufname(buf)
   local bufname = vim.api.nvim_buf_get_name(buf)

   if bufname == "" then return "[No Name]" end

   local filetype = vim.bo[buf].filetype
   if filetype == "toggleterm" then
      local term_id = bufname:match("term://.*toggleterm#(%d+)$")
      if term_id then
         local term = require("toggleterm.terminal").get(tonumber(term_id), false)
         if term and term.display_name then return term.display_name end
      end
   end

   return vim.fn.fnamemodify(bufname, ":~:.")
end

return M
