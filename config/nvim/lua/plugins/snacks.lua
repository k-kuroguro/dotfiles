return {
   "folke/snacks.nvim",
   lazy = false,
   priority = 1000,
   opts = {
      dashboard = require("modules.snacks.dashboard"),
      notifier = require("modules.snacks.notifier"),
      picker = require("modules.snacks.picker"),
      toggle = {
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
   keys = {
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Files" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },

      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      {
         "<leader>sc",
         function() Snacks.picker.command_history({ layout = { preset = "default_no_preview" } }) end,
         desc = "Command History",
      },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
      { "<leader>sn", function() Snacks.picker.notifications() end, desc = "Notification History" },
   },
}
