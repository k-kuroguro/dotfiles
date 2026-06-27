return {
   "s1n7ax/nvim-window-picker",
   version = "2.*",
   opts = {
      selection_chars = "asdfghjkl;",
      show_prompt = false,
      picker_config = {
         statusline_winbar_picker = {
            use_winbar = "always",
         },
      },
      filter_rules = {
         include_current_win = true,
         bo = {
            buftype = {},
         },
      },
      highlights = {
         enabled = true,
         winbar = {
            focused = {
               link = "WinpickMarkerFocused",
            },
            unfocused = {
               link = "WinpickMarker",
            },
         },
      },
   },
   keys = {
      {
         "<leader>ww",
         function()
            local winid = require("window-picker").pick_window()
            if winid and vim.api.nvim_win_is_valid(winid) then vim.api.nvim_set_current_win(winid) end
         end,
         desc = "Pick window",
      },
   },
}
