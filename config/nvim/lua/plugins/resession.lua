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

      vim.api.nvim_create_autocmd("User", {
         pattern = "ResessionLoadPost",
         callback = function()
            vim.schedule(function()
               for _, win in ipairs(vim.api.nvim_list_wins()) do
                  local buf = vim.api.nvim_win_get_buf(win)
                  local name = vim.api.nvim_buf_get_name(buf)

                  if name:match("^term://") then
                     vim.api.nvim_set_current_win(win)
                     vim.cmd("silent! edit")
                  end
               end
            end)
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
