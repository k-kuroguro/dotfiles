local ellipsis = "…"
local ellipsis_width = vim.fn.strdisplaywidth(ellipsis)

local function truncate(line, text_width, icon_width)
   if vim.fn.strdisplaywidth(line) <= text_width then return line .. (" "):rep(icon_width) end

   local ret = line

   while ret ~= "" and vim.fn.strdisplaywidth(ret) + ellipsis_width > text_width do
      ret = vim.fn.strcharpart(ret, 0, vim.fn.strchars(ret) - 1)
   end

   return ret .. ellipsis .. (" "):rep(icon_width)
end

return {
   enabled = true,
   icons = {
      error = "  ",
      warn = "  ",
      info = "  ",
      debug = "  ",
      trace = "  ",
   },
   style = function(buf, notif, ctx)
      ctx.opts.border = "none"

      local max_width = math.floor(vim.o.columns * ctx.notifier.opts.width.max)
      local icon_width = vim.fn.strdisplaywidth(notif.icon)
      local padding = ctx.notifier.opts.padding and 2 or 0
      local text_width = max_width - icon_width - 1 - padding

      local lines = vim.split(notif.msg, "\n")
      for i, line in ipairs(lines) do
         lines[i] = truncate(line, text_width, icon_width)
      end

      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      vim.api.nvim_buf_set_extmark(buf, ctx.ns, 0, 0, {
         virt_text = { { notif.icon, ctx.hl.icon } },
         virt_text_pos = "right_align",
      })
   end,
   width = { min = 1, max = 0.5 },
   height = { min = 1, max = 0.5 },
   margin = { top = 0, right = 0, bottom = 0 },
}
