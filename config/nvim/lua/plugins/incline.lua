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
   config = function(_, opts)
      vim.api.nvim_create_autocmd("TermRequest", {
         desc = "Refresh incline when terminal title changes",
         callback = function(ev)
            if ev.data.sequence:match("^\027%]2;") then
               local ok, incline = pcall(require, "incline")
               if ok then incline.refresh() end
            end
         end,
      })

      require("incline").setup(opts)
   end,
}
