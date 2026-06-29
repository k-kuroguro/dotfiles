vim.keymap.set({ "n", "t" }, "<C-h>", "<Cmd>wincmd h<CR>", { noremap = true, silent = true })
vim.keymap.set({ "n", "t" }, "<C-j>", "<Cmd>wincmd j<CR>", { noremap = true, silent = true })
vim.keymap.set({ "n", "t" }, "<C-k>", "<Cmd>wincmd k<CR>", { noremap = true, silent = true })
vim.keymap.set({ "n", "t" }, "<C-l>", "<Cmd>wincmd l<CR>", { noremap = true, silent = true })

vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], { noremap = true, silent = true })

vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<Cmd>w<CR><ESC>", { desc = "Save File" })

vim.keymap.set("i", "jj", "<ESC>", { noremap = true, silent = true })

vim.keymap.set("n", "sp", "<Cmd>split<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "sv", "<Cmd>vsplit<CR>", { noremap = true, silent = true })
