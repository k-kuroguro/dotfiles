vim.api.nvim_create_autocmd("TermOpen", {
   callback = function() vim.opt.statuscolumn = " " end,
})
