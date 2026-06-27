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
      require("incline").setup(opts)

      vim.api.nvim_create_autocmd("TermRequest", {
         desc = "Refresh incline when terminal title changes",
         callback = function(ev)
            if ev.data.sequence:match("^\027%]2;") then require("incline").refresh() end
         end,
      })

      vim.api.nvim_create_autocmd("OptionSet", {
         pattern = "winbar",
         callback = function() require("incline").refresh() end,
      })

      Snacks.toggle({
         name = "Incline",
         get = function() return require("incline").is_enabled() end,
         set = function(state)
            if state then
               require("incline").enable()
            else
               require("incline").disable()
            end
         end,
      }):map("<leader>ui")
   end,
}
