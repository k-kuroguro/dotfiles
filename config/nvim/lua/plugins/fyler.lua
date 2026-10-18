return {
   "FylerOrg/fyler.nvim",
   cmd = "Fyler",
   dependencies = {
      "nvim-tree/nvim-web-devicons",
      "lewis6991/gitsigns.nvim",
   },
   opts = function()
      local function select(instance)
         local entry = require("fyler.finder").parse_cursor_line(instance)
         if not entry then return end

         if entry.type == "directory" then
            instance:select()
            return
         end

         local winid = require("utils").pick_window()
         if winid and vim.api.nvim_win_is_valid(winid) then
            if winid == instance.win_id then instance:close() end
            local file = vim.fn.fnameescape(entry.path)
            vim.api.nvim_win_call(winid, function() vim.cmd.edit(file) end)
            vim.api.nvim_set_current_win(winid)
         end
      end

      local CR = { action = select, opts = { desc = "Expand or Open" } }

      return {
         hooks = {
            on_rename = function(src_path, dest_path) Snacks.rename.on_rename_file(src_path, dest_path) end,
         },
         extensions = {
            git = { enabled = true },
         },
         integrations = {
            icon = "nvim_web_devicons",
         },
         use_as_default_explorer = false,
         follow_root_dir = false,
         kind_presets = {
            replace = {
               mappings = {
                  n = {
                     ["<CR>"] = CR,
                  },
               },
            },
         },
         mappings = {
            n = {
               ["-"] = {
                  action = "visit",
                  args = { parent = true },
                  opts = { desc = "Move to Parent" },
               },
               ["."] = {
                  action = "visit",
                  args = { cursor = true },
                  opts = { desc = "Move to Cursor" },
               },
               ["zc"] = {
                  action = "shrink",
                  opts = { desc = "Close" },
               },
               ["zM"] = {
                  action = function(instance)
                     local root_key = require("fyler.lib.path").to_key(instance.state.pseudo_root_path)
                     for key in pairs(instance.state.meta) do
                        instance.state.meta[key] = key == root_key
                     end
                     instance:refresh()
                  end,
                  opts = { desc = "Close All" },
               },
               ["<C-R>"] = {
                  action = "refresh",
                  args = { recursive = true, force = true },
                  opts = { desc = "Refresh" },
               },
               ["<CR>"] = CR,
               ["<BS>"] = { disabled = true },
               ["<C-S>"] = { disabled = true },
               ["<C-T>"] = { disabled = true },
               ["<C-V>"] = { disabled = true },
               ["<2-LeftMouse>"] = { disabled = true },
               ["gi"] = { disabled = true },
               ["g."] = { disabled = true },
               ["q"] = { disabled = true },
               ["="] = { disabled = true },
            },
         },
         ui = {
            hidden_items = {
               switches = {},
            },
         },
      }
   end,
   init = function()
      vim.cmd("silent! autocmd! FileExplorer *")
      vim.cmd("autocmd VimEnter * ++once silent! autocmd! FileExplorer *")
      vim.api.nvim_create_autocmd("BufEnter", {
         callback = function(args)
            local path = vim.api.nvim_buf_get_name(args.buf)
            if vim.fn.isdirectory(path) == 0 then return end

            Snacks.bufdelete({
               buf = args.buf,
               force = true,
            })
            vim.schedule_wrap(require("fyler").open)({ root_path = path })
         end,
      })
   end,
}
