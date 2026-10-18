return {
   "EdenEast/nightfox.nvim",
   lazy = false,
   priority = 1000,
   opts = {
      groups = {
         all = {
            SnacksPicker = { bg = "palette.bg0" },
            SnacksPickerInput = { bg = "palette.bg3" },
            SnacksPickerInputTitle = { fg = "palette.bg0", bg = "palette.blue" },
            SnacksPickerPreviewTitle = { fg = "palette.bg0", bg = "palette.red" },
            SnacksPickerInputBorder = { fg = "palette.bg3", bg = "palette.bg3" },
            SnacksPickerListBorder = { fg = "palette.bg0", bg = "palette.bg0" },
            SnacksPickerPreviewBorder = { fg = "palette.bg0", bg = "palette.bg0" },
            SnacksGhTitle = { fg = "palette.bg0", bg = "palette.red" },
            SnacksGhBorder = { fg = "palette.bg0", bg = "palette.bg0" },
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
            NoiceCmdlinePopupTitleInput = { fg = "palette.bg0", bg = "palette.blue" },
            NoiceCmdlinePopupBorder = { fg = "palette.bg3", bg = "palette.bg3" },
            NoiceConfirm = { bg = "palette.bg3" },
            NoiceConfirmBorder = { fg = "palette.bg3", bg = "palette.bg3" },
            NoiceConfirmTitle = { fg = "palette.bg0", bg = "palette.blue" },
            NoiceFormatConfirm = { bg = "palette.bg3" },
            NoiceFormatConfirmDefault = { bg = "palette.bg3" },

            WhichKeyNormal = { bg = "palette.bg3" },

            TreesitterContext = { bg = "palette.bg3" },

            SnacksPickerPickWin = { bg = "palette.blue", fg = "palette.bg1" },
            SnacksPickerPickWinCurrent = { bg = "palette.red", fg = "palette.bg1" },

            StatusLine = { fg = "palette.fg1", bg = "palette.bg0" },
            HeirlineNormal = { bg = "palette.blue" },
            HeirlineInsert = { bg = "palette.green" },
            HeirlineCommand = { bg = "palette.yellow" },
            HeirlineVisual = { bg = "palette.magenta" },
            HeirlineReplace = { bg = "palette.red" },
            HeirlineTerminal = { bg = "palette.orange" },
            HeirlineInactive = { bg = "palette.blue" },

            WinBar = { fg = "palette.fg1", bg = "palette.bg1", style = "" },
            WinBarNC = { fg = "palette.fg2", bg = "palette.bg1", style = "" },

            NeoTreeNormal = { bg = "palette.bg1" },
            NeoTreeTabActive = { fg = "palette.fg1", bg = "palette.bg1", style = "bold" },
            NeoTreeTabInactive = { fg = "palette.fg2", bg = "palette.bg0" },
            NeoTreeFloatBorder = { fg = "palette.bg0", bg = "palette.bg0" },
            NeoTreeFloatTitle = { fg = "palette.bg0", bg = "palette.blue" },
         },
      },
   },
   config = function(_, opts)
      require("nightfox").setup(opts)
      vim.cmd("colorscheme carbonfox")
   end,
}
