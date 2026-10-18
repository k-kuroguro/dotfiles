return {
   {
      "folke/snacks.nvim",
      lazy = false,
      priority = 1000,
      opts = {
         dashboard = require("modules.snacks.dashboard"),
         notifier = require("modules.snacks.notifier"),
         picker = require("modules.snacks.picker"),
         toggle = {
            notify = false,
            icon = {
               enabled = "󱨥 ",
               disabled = "󱨦 ",
            },
         },
         styles = {
            notification = {
               border = "single",
            },
         },
      },
      config = function(_, opts) require("snacks").setup(opts) end,
      keys = function()
         local function not_in_git_repo_warn()
            if not vim.g.is_in_git_repo then
               vim.notify("Not in a git repository", vim.log.levels.WARN)
               return true
            end
            return false
         end

         return {
            { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
            { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },

            { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
            { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
            {
               "<leader>sc",
               function()
                  Snacks.picker.command_history({
                     layout = { preset = "default_no_preview" },
                     confirm = "cmd_fallback_input",
                  })
               end,
               desc = "Command History",
            },
            {
               "<leader>sC",
               function() Snacks.picker.commands({ confirm = "cmd_fallback_input" }) end,
               desc = "Commands",
            },
            { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
            { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
            { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
            { "<leader>sn", function() Snacks.picker.notifications() end, desc = "Notification History" },
            { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
            { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
            { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },

            { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
            { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
            { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
            { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
            { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },

            {
               "<leader>gi",
               function()
                  if not_in_git_repo_warn() then return end
                  Snacks.picker.gh_issue()
               end,
               desc = "GitHub Issues (open)",
            },
            {
               "<leader>gI",
               function()
                  if not_in_git_repo_warn() then return end
                  Snacks.picker.gh_issue({ state = "all" })
               end,
               desc = "GitHub Issues (all)",
            },
            {
               "<leader>gp",
               function()
                  if not_in_git_repo_warn() then return end
                  Snacks.picker.gh_pr()
               end,
               desc = "GitHub Pull Requests (open)",
            },
            {
               "<leader>gP",
               function()
                  if not_in_git_repo_warn() then return end
                  Snacks.picker.gh_pr({ state = "all" })
               end,
               desc = "GitHub Pull Requests (all)",
            },

            {
               "<leader>ww",
               function()
                  local winid = require("snacks").picker.util.pick_win({ main = vim.api.nvim_get_current_win() })
                  if winid and vim.api.nvim_win_is_valid(winid) then vim.api.nvim_set_current_win(winid) end
               end,
               desc = "Pick window",
            },

            {
               "<C-r>",
               function()
                  if vim.fn.getcmdtype() == ":" then
                     local pattern = vim.fn.getcmdline()
                     return "<C-c><Cmd>lua Snacks.picker.command_history({ pattern = "
                        .. string.format("%q", pattern)
                        .. ', layout = { preset = "default_no_preview" }, confirm = "cmd_fallback_input" })<CR>'
                  end
                  return "<C-r>"
               end,
               mode = "c",
               expr = true,
               desc = "Command history",
            },
         }
      end,
      init = function()
         vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
               _G.dd = function(...) Snacks.debug.inspect(...) end
               _G.bt = function() Snacks.debug.backtrace() end
               vim._print = function(_, ...) dd(...) end
            end,
         })
      end,
   },
   {
      "dmtrKovalenko/fff.nvim",
      lazy = false,
      build = function() require("fff.download").download_or_build_binary() end,
   },
   {
      "madmaxieee/fff-snacks.nvim",
      lazy = false,
      opts = {
         live_grep = { grep_mode = { "fuzzy", "regex", "plain" } },
      },
      keys = {
         { "<leader>ff", function() require("fff-snacks").find_files({ title = "Files" }) end, desc = "Files" },
         { "<leader>sg", function() require("fff-snacks").live_grep({ title = "Grep" }) end, desc = "Grep" },
         {
            "<leader>sw",
            function() require("fff-snacks").grep_word({ title = "Grep Word" }) end,
            desc = "Visual selection or word",
            mode = { "n", "x" },
         },
      },
   },
}
