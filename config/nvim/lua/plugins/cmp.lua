return {
   {
      "saghen/blink.cmp",
      version = "1.*",
      event = { "InsertEnter", "CmdlineEnter" },
      build = "cargo build --release",
      opts = {
         keymap = {
            preset = "super-tab",
         },
         completion = {
            menu = {
               cmdline_position = function()
                  if vim.g.ui_cmdline_pos ~= nil then
                     local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
                     return { pos[1], pos[2] }
                  end
                  local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
                  return { vim.o.lines - height, 0 }
               end,
               draw = {
                  components = {
                     kind_icon = {
                        text = function(ctx)
                           local icon = ctx.kind_icon
                           if vim.tbl_contains({ "Path" }, ctx.source_name) then
                              local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                              if dev_icon then icon = dev_icon end
                           else
                              icon = require("lspkind").symbol_map[ctx.kind] or ""
                           end

                           return icon .. ctx.icon_gap
                        end,
                        highlight = function(ctx)
                           local hl = ctx.kind_hl
                           if vim.tbl_contains({ "Path" }, ctx.source_name) then
                              local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                              if dev_icon then hl = dev_hl end
                           end
                           return hl
                        end,
                     },
                  },
               },
            },
         },
      },
      opts_extend = { "sources.default" },
   },
   {
      "onsails/lspkind.nvim",
      lazy = true,
   },
}
