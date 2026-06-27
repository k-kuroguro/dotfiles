local M = {}

local function get_icon(filename, buftype)
   if buftype == "terminal" then
      return { " ", group = "MiniIconsGreen" }
   else
      local devicons = require("nvim-web-devicons")
      local ft_icon, ft_color = devicons.get_icon_color(filename)
      if ft_icon then
         return { ft_icon .. " ", guifg = ft_color, guibg = "none" }
      else
         return {}
      end
   end
end

function M.render(props)
   if vim.api.nvim_win_call(props.win, function() return vim.wo.winbar ~= "" end) then return nil end

   local name = require("utils").bufname(props.buf)
   local buftype = vim.bo[props.buf].buftype
   local icon = get_icon(name, buftype)

   return {
      " ",
      icon,
      { name .. (vim.bo[props.buf].modified and "* " or " ") },
   }
end

return M
