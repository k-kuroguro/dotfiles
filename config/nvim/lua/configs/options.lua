vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.laststatus = 3

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.statuscolumn = "%=%{v:relnum?v:relnum:v:lnum}%s"
vim.opt.numberwidth = 2
