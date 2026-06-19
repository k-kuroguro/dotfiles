return {
   "EdenEast/nightfox.nvim",
   lazy = false,
   priority = 1000,
   opts = {
      groups = {
         all = {
            SnacksPicker = { bg = "palette.bg0" },
            SnacksPickerInput = { bg = "palette.bg3" },
            SnacksPickerInputTitle = { fg = "palette.bg2", bg = "palette.blue" },
            SnacksPickerPreviewTitle = { fg = "palette.bg2", bg = "palette.red" },
            SnacksPickerInputBorder = { fg = "palette.bg3", bg = "palette.bg3" },
            SnacksPickerListBorder = { fg = "palette.bg0", bg = "palette.bg0" },
            SnacksPickerPreviewBorder = { fg = "palette.bg0", bg = "palette.bg0" },
            SnacksNotifierTrace = { bg = "palette.bg3" },
            SnacksNotifierDebug = { bg = "palette.bg3" },
            SnacksNotifierInfo = { fg = "diag.info", bg = "palette.bg3" },
            SnacksNotifierWarn = { fg = "diag.warn", bg = "palette.bg3" },
            SnacksNotifierError = { fg = "diag.error", bg = "palette.bg3" },
            SnacksNotifierIconDebug = { fg = "palette.fg1" },
            SnacksNotifierIconTrace = { fg = "palette.fg1" },
            SnacksDashboardTitle = { fg = "palette.blue.bright" },
            SnacksDashboardFooter = { fg = "palette.blue.bright" },

            NoiceCmdlinePopup = { bg = "palette.bg3" },
            NoiceCmdlinePopupTitleInput = { fg = "palette.bg2", bg = "palette.blue" },
            NoiceCmdlinePopupBorder = { fg = "palette.bg3", bg = "palette.bg3" },
            NoiceConfirm = { bg = "palette.bg3" },
            NoiceConfirmBorder = { fg = "palette.bg3", bg = "palette.bg3" },
            NoiceConfirmTitle = { fg = "palette.bg2", bg = "palette.blue" },
            NoiceFormatConfirm = { bg = "palette.bg3" },
            NoiceFormatConfirmDefault = { bg = "palette.bg3" },

            WhichKeyNormal = { bg = "palette.bg3" },

            ToggleTermFloatBorder = { fg = "palette.bg0", bg = "palette.bg0" },

            TreesitterContext = { bg = "palette.bg3" },

            --  User-defined groups for incline.nvim
            InclineWinnr = { fg = "palette.cyan", bg = "palette.bg3" },
         },
      },
   },
   config = function(_, opts)
      require("nightfox").setup(opts)
      vim.cmd("colorscheme carbonfox")
   end,
}
