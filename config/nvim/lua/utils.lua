local M = {}

function M.bufname(buf)
   local bufname = vim.api.nvim_buf_get_name(buf)

   if bufname == "" then return "[No Name]" end

   local buftype = vim.bo[buf].buftype
   if buftype == "terminal" then return vim.b[buf].term_title end

   return vim.fn.fnamemodify(bufname, ":~:.")
end

return M
