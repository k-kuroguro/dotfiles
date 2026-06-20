return {
   enabled = true,
   prompt = "  ",
   layouts = {
      default = {
         layout = {
            box = "horizontal",
            backdrop = 100,
            width = 0.8,
            min_width = 120,
            height = 0.8,
            border = "none",
            {
               box = "vertical",
               {
                  win = "input",
                  height = 1,
                  border = true,
                  title = "{title} {live} {flags}",
               },
               { win = "list", border = true },
            },
            { win = "preview", title = "{preview:Preview}", border = true, width = 0.5 },
         },
      },
      default_no_preview = {
         layout = {
            box = "horizontal",
            backdrop = 100,
            width = 0.5,
            min_width = 80,
            max_width = 100,
            height = 0.8,
            border = "none",
            {
               box = "vertical",
               {
                  win = "input",
                  height = 1,
                  border = true,
                  title = "{title} {live} {flags}",
               },
               { win = "list", border = true },
            },
         },
      },
      ivy = {
         layout = {
            box = "vertical",
            backdrop = 100,
            row = -1,
            width = 0,
            height = 0.4,
            {
               win = "input",
               height = 1,
               border = "top_bottom",
               title = "{title} {live} {flags}",
            },
            {
               box = "horizontal",
               { win = "list", border = "none" },
               { win = "preview", title = "{preview}", width = 0.6, border = "left" },
            },
         },
      },
      select = {
         layout = {
            box = "vertical",
            backdrop = 100,
            width = 0.5,
            min_width = 80,
            max_width = 100,
            height = 0.4,
            min_height = 2,
            { win = "input", height = 1, border = true, title = "{title}" },
            { win = "list", border = true },
         },
      },
   },
   sources = {},
   actions = {
      load_session = function(picker, item)
         picker:close()
         if not item then return end

         local dir = item.file
         vim.fn.chdir(dir)

         local has_session = require("modules.resession").has_session(dir)
         if has_session then
            require("resession").load(dir, { dir = require("modules.resession").dirsession })
         elseif pick then
            Snacks.dashboard.pick()
         end
      end,
   },
}
