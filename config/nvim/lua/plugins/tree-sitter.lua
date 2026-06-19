local treesitter_path = vim.fs.joinpath(vim.fn.stdpath("data"), "/treesitter")
vim.uv.fs_mkdir(treesitter_path, tonumber("755", 8))

return {
   {
      "https://github.com/nvim-treesitter/nvim-treesitter",
      branch = "main",
      lazy = false,
      dependencies = { "neovim-treesitter/treesitter-parser-registry" },
      opts = {
         install_dir = treesitter_path,
      },
      config = function(_, opts)
         require("nvim-treesitter").setup(opts)

         vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
            callback = function() pcall(vim.treesitter.start) end,
         })
      end,
   },
   {
      "nvim-treesitter/nvim-treesitter-context",
      lazy = false,
   },
}
