return {
   {
      "mason-org/mason-lspconfig.nvim",
      event = { "BufReadPre", "BufNewFile" },
      cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonUpdate", "MasonLog" },
      dependencies = {
         {
            "mason-org/mason.nvim",
            opts = {
               ui = {
                  backdrop = 100,
                  width = 0.8,
                  height = 0.8,
               },
            },
         },
         "neovim/nvim-lspconfig",
      },
      opts = {
         ensure_installed = {},
      },
      config = function(_, opts) require("mason-lspconfig").setup(opts) end,
   },
}
