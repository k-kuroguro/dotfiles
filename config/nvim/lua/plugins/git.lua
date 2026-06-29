return {
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
   {
      "lewis6991/gitsigns.nvim",
      event = "LazyFile",
      opts = {},
   },
}
