local M = {}

M.columns = {
   number = true,
   relativenumber = true,
   signcolumn = "yes",
   foldcolumn = "1",
}

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

vim.opt.wrap = false

vim.opt.laststatus = 3

vim.opt.number = M.columns.number
vim.opt.relativenumber = M.columns.relativenumber
vim.opt.signcolumn = M.columns.signcolumn
vim.o.foldenable = true
vim.opt.foldcolumn = M.columns.foldcolumn
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 99

vim.diagnostic.config({
   update_in_insert = true,
   severity_sort = true,
   underline = true,
   signs = {
      text = {
         [vim.diagnostic.severity.ERROR] = require("configs.icons").diagnostics.error,
         [vim.diagnostic.severity.WARN] = require("configs.icons").diagnostics.warn,
         [vim.diagnostic.severity.INFO] = require("configs.icons").diagnostics.info,
         [vim.diagnostic.severity.HINT] = require("configs.icons").diagnostics.hint,
      },
   },
})

return M
