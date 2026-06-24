vim.api.nvim_create_autocmd("TermOpen", {
   callback = function(args)
      local win = vim.fn.bufwinid(args.buf)
      if win ~= -1 then vim.wo[win].statuscolumn = " " end
   end,
})
