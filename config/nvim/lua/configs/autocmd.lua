do
   local id
   id = vim.api.nvim_create_autocmd({
      "BufReadPost",
      "BufNewFile",
      "BufWritePost",
   }, {
      callback = function(args)
         vim.schedule(function()
            if not vim.api.nvim_buf_is_valid(args.buf) then return end

            local file = vim.api.nvim_buf_get_name(args.buf)
            if file == "" or vim.bo[args.buf].buftype == "nofile" then return end

            if vim.fn.executable("git") ~= 1 then
               vim.api.nvim_del_autocmd(id)
               return
            end

            vim.fn.system({
               "git",
               "-C",
               vim.fs.dirname(file),
               "rev-parse",
               "--is-inside-work-tree",
            })

            if vim.v.shell_error ~= 0 then return end

            vim.api.nvim_exec_autocmds("User", {
               pattern = "GitFileOnce",
               modeline = false,
            })
            vim.api.nvim_del_autocmd(id)
         end)
      end,
   })
end

do
   local id
   id = vim.api.nvim_create_autocmd({
      "VimEnter",
      "DirChanged",
   }, {
      callback = function()
         vim.schedule(function()
            if vim.fn.executable("git") ~= 1 then
               vim.api.nvim_del_autocmd(id)
               return
            end

            vim.fn.system({
               "git",
               "-C",
               vim.fn.getcwd(),
               "rev-parse",
               "--is-inside-work-tree",
            })

            if vim.v.shell_error ~= 0 then return end

            vim.api.nvim_exec_autocmds("User", {
               pattern = "GitCwdOnce",
               modeline = false,
            })
            vim.api.nvim_del_autocmd(id)
         end)
      end,
   })
end

vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
   callback = function()
      vim.fn.system({
         "git",
         "-C",
         vim.fn.getcwd(),
         "rev-parse",
         "--is-inside-work-tree",
      })

      vim.g.is_in_git_repo = vim.v.shell_error == 0
   end,
})
