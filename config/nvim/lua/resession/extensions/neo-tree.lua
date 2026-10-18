--TODO: Save other state of neo-tree, like position, width, etc.

local M = {}

---@param opts resession.Extension.OnSaveOpts
---@return string?
function M.on_save(opts)
   for _, winid in ipairs(vim.api.nvim_list_wins()) do
      local bufnr = vim.api.nvim_win_get_buf(winid)

      if vim.bo[bufnr].filetype == "neo-tree" then
         local ok, source = pcall(vim.api.nvim_buf_get_var, bufnr, "neo_tree_source")
         if ok then return source end
      end
   end
end

---@param source string?
function M.on_post_load(source)
   if source then vim.cmd("Neotree " .. source .. " show") end
end

return M
