return {
   "folke/which-key.nvim",
   event = "VeryLazy",
   priority = 1000,
   dependencies = {
      "nvim-tree/nvim-web-devicons",
   },
   opts = {
      delay = function(ctx)
         local leader = vim.fn.keytrans(vim.g.mapleader or " ")
         if ctx.mode == "n" and ctx.keys == leader .. "b" then return 0 end
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
               "<leader>g",
               group = "git",
            },
            {
               "<leader>b",
               group = "buffers",
               expand = function() return require("modules.which-key").expand_buf() end,
            },
         },
      },
      icons = {
         mappings = false,
         keys = {
            BS = "󰁮 ",
         },
      },
   },
   keys = {
      {
         "<leader>?",
         require("utils").show_local_keymaps,
         desc = "Local Keymaps",
      },
   },
}
