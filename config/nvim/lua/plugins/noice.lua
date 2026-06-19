return {
   "folke/noice.nvim",
   event = "VeryLazy",
   dependencies = {
      "MunifTanjim/nui.nvim",
   },
   opts = {
      presets = {
         long_message_to_split = true,
      },
      cmdline = {
         format = {
            cmdline = { icon = " " },
            search_down = { icon = " " },
            search_up = { icon = " " },
            filter = { icon = "$ " },
            lua = { icon = " " },
            help = { icon = " " },
            input = { icon = " " },
         },
      },
      views = {
         cmdline_popup = {
            border = {
               style = "none",
               padding = { 1, 2 },
            },
         },
         confirm = {
            position = {
               row = "50%",
               col = "50%",
            },
            border = {
               style = "none",
               padding = { 1, 2 },
            },
            win_options = {
               winhighlight = {
                  FloatTitle = "NoiceConfirmTitle",
               },
            },
         },
      },
   },
}
