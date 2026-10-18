local last_source = "filesystem"

return {
   {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      lazy = false,
      dependencies = {
         "nvim-lua/plenary.nvim",
         "MunifTanjim/nui.nvim",
         "nvim-tree/nvim-web-devicons",
      },
      opts = function()
         local function on_move(data) Snacks.rename.on_rename_file(data.source, data.destination) end
         local function hide_cursor()
            vim.cmd("highlight! Cursor blend=100")
            vim.opt.guicursor:append("a:Cursor/lCursor")
         end
         local function show_cursor()
            vim.cmd("highlight! Cursor blend=0")
            vim.opt.guicursor:remove("a:Cursor/lCursor")
         end

         return {
            hide_root_node = true,
            use_default_mappings = false,
            popup_border_style = "single",
            event_handlers = {
               { event = "file_moved", handler = on_move },
               { event = "file_renamed", handler = on_move },
               { event = "neo_tree_buffer_enter", handler = hide_cursor },
               { event = "neo_tree_buffer_leave", handler = show_cursor },
               { event = "neo_tree_popup_buffer_enter", handler = show_cursor },
            },
            source_selector = {
               winbar = true,
               content_layout = "center",
               separator = "",
               sources = {
                  { source = "filesystem", display_name = "Files" },
                  { source = "buffers", display_name = "Buffers" },
                  { source = "git_status", display_name = "Git" },
               },
            },
            window = {
               mappings = {
                  ["<CR>"] = "open",
                  ["w"] = "open_with_window_picker",
                  ["s"] = "split_with_window_picker",
                  ["v"] = "vsplit_with_window_picker",
                  ["<C-R>"] = "refresh",
                  ["?"] = {
                     require("utils").show_local_keymaps,
                     desc = "show_help",
                  },
                  ["f"] = {
                     function() vim.api.nvim_exec("Neotree focus filesystem left", true) end,
                     desc = "focus_filesystem",
                  },
                  ["b"] = {
                     function() vim.api.nvim_exec("Neotree focus buffers left", true) end,
                     desc = "focus_buffers",
                  },
                  ["g"] = {
                     function() vim.api.nvim_exec("Neotree focus git_status left", true) end,
                     desc = "focus_git_status",
                  },
               },
            },
            default_component_configs = {
               icon = {
                  folder_closed = "󰉋",
                  folder_open = "󰝰",
                  folder_empty = "󰝰",
                  folder_empty_open = "󰝰",
               },
            },
            filesystem = {
               hijack_netrw_behavior = "disabled",
               filtered_items = {
                  hide_dotfiles = false,
                  hide_gitignored = false,
                  hide_ignored = false,
                  hide_hidden = false,
               },
               follow_current_file = {
                  enabled = true,
               },
               window = {
                  mappings = {
                     ["f"] = "noop",
                  },
               },
            },
            buffers = {
               window = {
                  mappings = {
                     ["b"] = "noop",
                  },
               },
            },
            git_status = {
               window = {
                  mappings = {
                     ["g"] = "noop",
                  },
               },
            },
            commands = {},
         }
      end,
      config = function(_, opts)
         local ok = pcall(require, "window-picker")
         if not ok then
            package.preload["window-picker"] = function()
               return {
                  pick_window = function()
                     local wins = vim.tbl_filter(
                        function(win) return require("utils").pick_window_filter(win, vim.api.nvim_win_get_buf(win)) end,
                        vim.api.nvim_tabpage_list_wins(0)
                     )
                     return require("utils").pick_window({ main = wins[1] })
                  end,
               }
            end
         end

         require("neo-tree").setup(opts)
      end,
      keys = {
         {
            "<leader>e",
            function()
               if vim.bo.filetype == "neo-tree" then
                  vim.cmd("wincmd p")
               else
                  vim.cmd("Neotree focus filesystem left")
               end
            end,
            desc = "Toggle NeoTree Focus",
         },
         {
            "<leader>E",
            "<Cmd>Neotree toggle last left<CR>",
            desc = "Toggle NeoTree",
         },
      },
   },
}
