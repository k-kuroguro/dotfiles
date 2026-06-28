return {
   {
      "vim-denops/denops.vim",
      event = { "VeryLazy" },
   },
   {
      "yuki-yano/denops-lazy.nvim",
      lazy = true,
   },
   {
      "lambdalisue/gin.vim",
      dependencies = {
         { "vim-denops/denops.vim" },
      },
      cmd = {
         "Gin",
         "GinBuffer",
         "GinBranch",
         "GinBrowse",
         "GinCd",
         "GinLcd",
         "GinTcd",
         "GinChaperon",
         "GinDiff",
         "GinEdit",
         "GinLog",
         "GinPatch",
         "GinReflog",
         "GinStash",
         "GinStatus",
         "GinTag",
      },
      config = function() require("denops-lazy").load("gin.vim") end,
   },
}
