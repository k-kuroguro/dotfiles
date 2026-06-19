vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], { noremap = true, silent = true })
vim.keymap.set("t", "<C-h>", "<Cmd>wincmd h<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-j>", "<Cmd>wincmd j<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-k>", "<Cmd>wincmd k<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-l>", "<Cmd>wincmd l<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-h>", "<Cmd>wincmd h<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<Cmd>wincmd j<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<Cmd>wincmd k<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<Cmd>wincmd l<CR>", { noremap = true, silent = true })

vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
