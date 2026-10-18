return {
   {
      "rachartier/tiny-inline-diagnostic.nvim",
      event = "VeryLazy",
      opts = {
         preset = "minimal",
         signs = {
            diag = "●",
         },
         blend = {
            factor = 0.22,
         },
         options = {
            show_source = {
               enabled = true,
            },
            enable_on_insert = true,
            enable_on_select = true,
         },
      },
      init = function() vim.diagnostic.config({ virtual_text = false }) end,
   },
}
