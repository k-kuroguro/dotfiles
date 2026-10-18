local winbar = {
   enabled = {
      filetype = {
         "help",
      },
   },
   disabled = {
      filetype = {
         "snacks_dashboard",
      },
      buftype = {
         "prompt",
         "nofile",
         "quickfix",
      },
      bufname = {},
   },
}

local statuscolumn = {
   enabled = {},
   disabled = {
      filetype = {
         "snacks_dashboard",
      },
      buftype = {
         "prompt",
         "nofile",
         "quickfix",
         "terminal",
      },
   },
}

local function buffer_matches(patterns, bufnr)
   local values = {
      filetype = vim.bo[bufnr].filetype,
      buftype = vim.bo[bufnr].buftype,
      bufname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t"),
   }

   for kind, pattern_list in pairs(patterns) do
      if type(pattern_list) == "string" then pattern_list = { pattern_list } end

      for _, pattern in ipairs(pattern_list) do
         if values[kind]:find(pattern) then return true end
      end
   end

   return false
end

local function disable_winbar_cb(args)
   local bufnr = args.buf

   if winbar.enabled and vim.api.nvim_buf_is_valid(bufnr) and buffer_matches(winbar.enabled, bufnr) then
      return false
   end

   return not vim.api.nvim_buf_is_valid(bufnr)
      or not vim.bo[bufnr].buflisted
      or (winbar.disabled and buffer_matches(winbar.disabled, bufnr))
      or false
end

local function disable_statuscolumn_cb(args)
   local bufnr = args.buf

   if statuscolumn.enabled and vim.api.nvim_buf_is_valid(bufnr) and buffer_matches(statuscolumn.enabled, bufnr) then
      return false
   end

   return not vim.api.nvim_buf_is_valid(bufnr)
      or not vim.bo[bufnr].buflisted
      or (statuscolumn.disabled and buffer_matches(statuscolumn.disabled, bufnr))
      or false
end

return {
   disable_winbar_cb = disable_winbar_cb,
   disable_statuscolumn_cb = disable_statuscolumn_cb,
}
