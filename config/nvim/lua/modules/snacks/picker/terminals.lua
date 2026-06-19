return {
   win = {
      input = {
         keys = {
            ["<c-r>"] = { "rename", mode = { "i", "n" } },
         },
      },
   },
   finder = function()
      local terminals = require("toggleterm.terminal").get_all(false)
      if #terminals == 0 then return {} end
      local items = {}
      for i, term in ipairs(terminals) do
         local name = term.display_name or term.name
         table.insert(items, {
            idx = i,
            id = term.id,
            name = name,
            dir = term.dir,
            buf = term.bufnr,
            text = name .. " " .. term.dir,
         })
      end
      return items
   end,
   format = function(item)
      local a = Snacks.picker.util.align
      return {
         { a(item.name, 20, { align = "left", truncate = true }) },
         { a(item.dir, 20, { align = "right", truncate = true }) },
      }
   end,
   preview = function(ctx)
      ctx.preview:reset()
      ctx.preview:set_title(ctx.item.name)
      ctx.preview:set_lines(vim.api.nvim_buf_get_lines(ctx.item.buf, 0, -1, false))

      local last = vim.api.nvim_buf_line_count(ctx.item.buf)
      vim.api.nvim_win_set_cursor(ctx.win, { last, 0 })
   end,
   confirm = function(picker, item)
      if not item then return end
      local term = require("toggleterm.terminal").get(item.id, false)
      if not term then return end
      picker:close()
      if term:is_open() then
         term:focus()
      else
         term:open()
      end
   end,
   actions = {
      rename = function(picker, item)
         if not item then return end
         local term = require("toggleterm.terminal").get(item.id, false)
         if not term then return end
         vim.ui.input({ prompt = "Rename " .. item.name .. " to" }, function(input)
            if not input or input == "" then return end
            vim.cmd(term.id .. "ToggleTermSetName " .. input)
            picker:refresh()
         end)
      end,
   },
}
