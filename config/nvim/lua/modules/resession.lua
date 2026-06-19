local M = {}

function M.buf_filter(bufnr)
   local bo = vim.bo[bufnr]

   if bo.buftype == "help" then return true end
   if bo.buftype ~= "" and bo.buftype ~= "acwrite" then return false end
   if vim.api.nvim_buf_get_name(bufnr) == "" then return false end

   return bo.buflisted
end

function M.should_save_session()
   for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if M.buf_filter(bufnr) then return true end
   end

   return false
end

function M.has_session(dir)
   local session_file = require("resession.util").get_session_file(dir, M.dirsession)
   return vim.uv.fs_stat(session_file) ~= nil
end

local function get_last_session_file()
   return vim.fs.joinpath(require("resession.util").get_session_dir(M.dirsession), "last_session")
end

function M.save_last_session(dir) vim.fn.writefile({ dir }, get_last_session_file()) end

function M.load_last_session()
   local function notify_no_session() vim.notify("No last session found", vim.log.levels.WARN) end

   local ok, lines = pcall(vim.fn.readfile, get_last_session_file())
   if not ok then
      notify_no_session()
      return
   end
   local session = vim.trim(lines[1] or "")
   if session ~= "" then
      require("resession").load(session, { dir = M.dirsession })
   else
      notify_no_session()
   end
end

M.dirsession = "dirsession"

return M
