local M = {}

function M.bufname(buf)
   local bufname = vim.api.nvim_buf_get_name(buf)
   if bufname == "" then return "[No Name]" end

   local buftype = vim.bo[buf].buftype
   if buftype == "terminal" then return vim.b[buf].term_title end

   return vim.fn.fnamemodify(bufname, ":~:.")
end

function M.show_local_keymaps()
   if package.loaded["which-key"] then require("which-key").show({ global = false }) end
end

function M.pick_window_filter(win, buf) return vim.bo[buf].filetype ~= "neo-tree" end

---@param opts? {main?: number, filter?: fun(win:number, buf:number):boolean?}
function M.pick_window(opts)
   opts = vim.tbl_extend("force", {
      main = vim.api.nvim_get_current_win(),
      filter = M.pick_window_filter,
   }, opts or {})

   local winid = require("snacks").picker.util.pick_win(opts)
   return winid
end

return M
