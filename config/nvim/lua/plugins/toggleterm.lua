return {
   "akinsho/toggleterm.nvim",
   cmd = { "ToggleTerm", "TermExec" },
   opts = {
      highlights = {
         Normal = { link = "Normal" },
         NormalNC = { link = "NormalNC" },
         NormalFloat = { link = "NormalFloat" },
         FloatBorder = { link = "ToggleTermFloatBorder" },
      },
      on_create = function(term) vim.cmd(term.id .. "ToggleTermSetName " .. "Term" .. term.id) end,
   },
   config = function(_, opts)
      require("toggleterm").setup(opts)

      vim.api.nvim_create_autocmd("TermOpen", {
         callback = function() vim.opt.statuscolumn = " " end,
      })
   end,
   keys = {
      { "<leader>ts", function() Snacks.picker.terminals() end, desc = "Find terminals" },
      { "<leader>ta", "<cmd>ToggleTermToggleAll<CR>", desc = "Toggle all terminals" },
      {
         "<leader>tf",
         function() require("modules.toggleterm").float_toggle() end,
         desc = "Toggle floating terminal",
      },
      unpack(require("modules.toggleterm").preset_terms()),
   },
}
