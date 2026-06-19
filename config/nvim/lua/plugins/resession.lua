return {
   "stevearc/resession.nvim",
   event = { "BufEnter" },
   opts = {
      buf_filter = require("modules.resession").buf_filter,
   },
   config = function(_, opts)
      local resession = require("resession")

      resession.setup(opts)

      local dirsession = require("modules.resession").dirsession
      vim.api.nvim_create_autocmd("VimLeavePre", {
         callback = function()
            if require("modules.resession").should_save_session() then
               local cwd = vim.fn.getcwd()
               resession.save(cwd, { dir = dirsession, notify = false })
               require("modules.resession").save_last_session(cwd)
            end
         end,
      })
   end,
   keys = {
      {
         "<leader>qs",
         function() require("resession").load(nil, { dir = require("modules.resession").dirsession }) end,
         desc = "Select session",
      },
      { "<leader>ql", function() require("modules.resession").load_last_session() end, desc = "Load last session" },
   },
}
