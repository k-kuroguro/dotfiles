return {
   {
      "mason-org/mason-lspconfig.nvim",
      event = { "BufReadPre", "BufNewFile" },
      cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonUpdate", "MasonLog" },
      dependencies = {
         { "mason-org/mason.nvim", opts = {} },
         "neovim/nvim-lspconfig",
      },
      opts = {
         ensure_installed = { "lua_ls", "denols", "rust_analyzer", "pyright" },
      },
      config = function(_, opts)
         require("mason-lspconfig").setup(opts)
         vim.diagnostic.config({
            update_in_insert = true,
            severity_sort = true,
            underline = true,
            virtual_text = {
               format = function(diagnostic)
                  return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
               end,
            },
            signs = {
               text = {
                  [vim.diagnostic.severity.ERROR] = "",
                  [vim.diagnostic.severity.WARN] = "",
                  [vim.diagnostic.severity.INFO] = "",
                  [vim.diagnostic.severity.HINT] = "",
               },
            },
         })
      end,
   },
}
