return {
   "FylerOrg/fyler.nvim",
   cmd = "Fyler",
   dependencies = {
      "nvim-tree/nvim-web-devicons",
   },
   opts = {
      hooks = {
         on_rename = function(src_path, dest_path) Snacks.rename.on_rename_file(src_path, dest_path) end,
      },
      extensions = {
         git = { enabled = true },
      },
      integrations = {
         icon = "nvim_web_devicons",
      },
   },
   keys = {
      { "<leader>e", function() require("fyler").toggle({ kind = "split_left_most" }) end, desc = "Toggle Fyler" },
   },
   init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
         group = vim.api.nvim_create_augroup("Fyler_start_directory", { clear = true }),
         desc = "Start Fyler with directory",
         once = true,
         callback = function()
            if package.loaded["fyler"] then return end

            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
               require("lazy").load({ plugins = { "fyler.nvim" } })
               require("fyler").open()
            end
         end,
      })
   end,
}
