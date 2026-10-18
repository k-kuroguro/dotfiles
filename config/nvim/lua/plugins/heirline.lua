return {
   "rebelot/heirline.nvim",
   event = "VeryLazy",
   dependencies = {
      "Zeioth/heirline-components.nvim",
      opts = function()
         local icons = require("configs.icons")
         return {
            icons = {
               DiagnosticError = icons.diagnostics.error,
               DiagnosticWarn = icons.diagnostics.warn,
               DiagnosticInfo = icons.diagnostics.info,
               DiagnosticHint = icons.diagnostics.hint,
            },
         }
      end,
   },
   opts = function()
      return {
         opts = {
            disable_winbar_cb = require("modules.heirline.disable_cb").disable_winbar_cb,
         },
         statusline = require("modules.heirline.statusline"),
         winbar = require("modules.heirline.winbar"),
         statuscolumn = require("modules.heirline.statuscolumn"),
      }
   end,
   config = function(_, opts)
      local heirline = require("heirline")
      local heirline_components = require("heirline-components.all")

      heirline_components.init.subscribe_to_events()
      heirline.load_colors(heirline_components.hl.get_colors())
      heirline.setup(opts)

      local function setup_local_statuscolumn(callback)
         local statuscolumn = "%{%v:lua.require'heirline'.eval_statuscolumn()%}"

         local function update(win, args)
            if not vim.api.nvim_win_is_valid(win) then return end

            if callback and callback(args) then
               vim.wo[win].statuscolumn = ""
               vim.wo[win].number = false
               vim.wo[win].relativenumber = false
               vim.wo[win].signcolumn = "no"
               vim.wo[win].foldcolumn = "0"
            else
               local colopt = require("configs.options").columns
               vim.wo[win].statuscolumn = statuscolumn
               vim.wo[win].number = colopt.number
               vim.wo[win].relativenumber = colopt.relativenumber
               vim.wo[win].signcolumn = colopt.signcolumn
               vim.wo[win].foldcolumn = colopt.foldcolumn
            end
         end

         local function update_all(args)
            args = args or {}
            for _, win in ipairs(vim.api.nvim_list_wins()) do
               local win_args = vim.tbl_extend("force", args, {
                  buf = vim.api.nvim_win_get_buf(win),
               })
               update(win, win_args)
            end
         end

         vim.api.nvim_create_autocmd({
            "VimEnter",
            "UIEnter",
            "BufWinEnter",
            "FileType",
            "TermOpen",
         }, {
            desc = "Heirline: set window-local statuscolumn",
            callback = function(args)
               if args.event == "VimEnter" or args.event == "UIEnter" then
                  update_all(args)
               else
                  update(vim.api.nvim_get_current_win(), args)
               end
            end,
         })

         update_all()
      end
      setup_local_statuscolumn(require("modules.heirline.disable_cb").disable_statuscolumn_cb)
   end,
   init = function()
      vim.o.statusline = " "
      vim.opt.statuscolumn = ""
      vim.opt.number = false
      vim.opt.relativenumber = false
      vim.opt.signcolumn = "no"
      vim.opt.foldcolumn = "0"
   end,
}
