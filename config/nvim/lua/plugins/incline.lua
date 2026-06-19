return {
   "b0o/incline.nvim",
   event = "VeryLazy",
   opts = {
      hide = {
         only_win = false,
      },
      render = require("modules.incline").render,
      window = {
         padding = 0,
      },
      ignore = {
         buftypes = {
            "acwrite",
            "help",
            "nofile",
            "nowrite",
            "quickfix",
            "prompt",
         },
         unlisted_buffers = false,
      },
   },
}
