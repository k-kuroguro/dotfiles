return {
   "rebelot/terminal.nvim",
   event = { "TermOpen" },
   cmd = { "TermRun", "TermOpen", "TermClose", "TermToggle", "TermKill", "TermSend", "TermSetTarget", "TermMove" },
   opts = {
      autoclose = true,
      startinsert = true,
   },
   config = function(_, opts) require("terminal").setup(opts) end,
   keys = {
      {
         "<leader>tt",
         function() require("modules.terminal").toggle_terminals() end,
         desc = "Toggle terminals",
      },
      {
         "<leader>tn",
         function() require("modules.terminal").new() end,
         desc = "New terminal",
      },
   },
}
