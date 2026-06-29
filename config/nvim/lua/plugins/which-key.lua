local leader = vim.fn.keytrans(vim.g.mapleader or " ")

return {
   "folke/which-key.nvim",
   event = "VeryLazy",
   dependencies = {
      "nvim-tree/nvim-web-devicons",
   },
   opts = {
      delay = function(ctx)
         if ctx.mode == "n" and (ctx.keys == leader .. "w" or ctx.keys == leader .. "b") then return 0 end
         return 200
      end,
      spec = {
         {
            {
               "<leader>f",
               group = "find",
            },
            {
               "<leader>s",
               group = "search",
            },
            {
               "<leader>t",
               group = "terminals",
               expand = function() return require("modules.which-key").expand_term() end,
            },
            {
               "<leader>q",
               group = "sessions",
            },
            {
               "<leader>w",
               proxy = "<c-w>",
               group = "windows",
            },
            {
               "<leader>b",
               group = "buffers",
               expand = function() return require("modules.which-key").expand_buf() end,
            },
         },
      },
      icons = {
         rules = {
            { pattern = "grep", icon = " ", color = "red" },
            { pattern = "find", icon = " ", color = "cyan" },
            { pattern = "search", icon = " ", color = "cyan" },
            { pattern = "select", icon = " ", color = "cyan" },
            { pattern = "window", icon = " ", color = "cyan" },
            { pattern = "session", icon = "󰉉 ", color = "azure" },
            { pattern = "history", icon = " ", color = "cyan" },
            { pattern = "recent", icon = " ", color = "cyan" },
            { pattern = "file", icon = "󰈔 ", color = "cyan" },
            { pattern = "buffer", icon = "󰈔 ", color = "cyan" },
            { pattern = "key", icon = "󰌌 ", color = "azure" },
            { pattern = "highlight", icon = " ", color = "cyan" },
            { pattern = "term", icon = " ", color = "green" },
            { pattern = "command", icon = " ", color = "green" },
            { pattern = "project", icon = "󰝰 ", color = "cyan" },
            { pattern = "register", icon = "󰅇 ", color = "azure" },
            { plugin = "neural-open.nvim", icon = " ", color = "cyan" },
            { plugin = "fyler.nvim", icon = "󰙅 ", color = "azure" },
         },
         keys = {
            BS = " ",
         },
      },
   },
}
