vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], { noremap = true, silent = true })

vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<Cmd>w<CR><ESC>", { desc = "Save File" })

vim.keymap.set("i", "jj", "<ESC>", { noremap = true, silent = true })
