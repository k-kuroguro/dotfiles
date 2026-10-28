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
   sources = {
      projects = {
         -- Default projects source with `fd --no-ignore`.
         finder = function(opts, ctx)
            local projects = require("snacks.picker.source.recent").projects
            local proc = require("snacks.picker.source.proc")
            local original = proc.proc

            proc.proc = function(cmd_opts, cmd_ctx)
               table.insert(cmd_opts.args, 1, "--no-ignore")
               return original(cmd_opts, cmd_ctx)
            end
            local ok, finder = pcall(projects, opts, ctx)
            proc.proc = original
            if not ok then error(finder, 0) end
            return finder
         end,
         dev = { "~/ghq" },
         max_depth = 4,
      },
   },
   actions = {
      load_session = function(picker, item)
         picker:close()
         if not item then return end

         local dir = item.file
         vim.fn.chdir(dir)

         local has_session = require("modules.resession").has_session(dir)
         if has_session then
            require("resession").load(dir, { dir = require("modules.resession").dirsession })
         else
            Snacks.dashboard.pick()
         end
      end,
      show_help = require("utils").show_local_keymaps,
      cmd_fallback_input = function(picker, item)
         picker:close()
         if item and item.cmd then
            vim.schedule(function()
               vim.api.nvim_input(":")
               vim.schedule(function() vim.fn.setcmdline(item.cmd) end)
            end)
            return
         end

         local input = picker.input:get()
         if input then
            vim.schedule(function()
               vim.api.nvim_input(":")
               vim.schedule(function() vim.fn.setcmdline(input) end)
            end)
         end
      end,
   },
   icons = {
      diagnostics = {
         Error = require("configs.icons").diagnostics.error,
         Warn = require("configs.icons").diagnostics.warn,
         Info = require("configs.icons").diagnostics.info,
         Hint = require("configs.icons").diagnostics.hint,
      },
   },
   win = {
      input = {
         keys = {
            ["?"] = "show_help",
         },
      },
      list = {
         keys = {
            ["?"] = "show_help",
            ["<2-LeftMouse>"] = false,
         },
      },
   },
}
