local M = {}

local function get_bottom_right_terminal_win()
   local target_win
   local max_row = -1
   local max_col = -1

   for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      local buf = vim.api.nvim_win_get_buf(win)

      if vim.bo[buf].buftype == "terminal" then
         local pos = vim.fn.win_screenpos(win)
         local row = pos[1]
         local col = pos[2]

         if row > max_row or (row == max_row and col > max_col) then
            max_row = row
            max_col = col
            target_win = win
         end
      end
   end

   return target_win
end

function M.get_layout()
   local win = get_bottom_right_terminal_win()

   if not win then
      local height = math.floor(vim.o.lines * 0.33)
      return { open_cmd = "botright " .. height .. "new" }
   else
      return { open_cmd = "vertical rightbelow new" }
   end
end

function M.get_term_by_bufnr(bufnr)
   local terminals = require("terminal.active_terminals"):get_sorted_terminals()
   for i, term in ipairs(terminals) do
      if term.bufnr == bufnr then return i, term end
   end
end

local previously_opened_terms = {}
--- If any terminals are currently open, remember them and close them all.
--- Otherwise, reopen the terminals last closed by this function and clear the stored state.
--- If no terminals are remembered, open all terminals.
function M.toggle_terminals()
   local terms = require("terminal.active_terminals"):get_sorted_terminals()
   if not next(terms) then return end

   local opened = {}
   for _, term in ipairs(terms) do
      if next(term:get_current_tab_windows()) then opened[#opened + 1] = term end
   end

   if next(opened) then
      previously_opened_terms = opened
      for _, term in ipairs(opened) do
         term:close()
      end
   else
      local restore_terms = next(previously_opened_terms) and previously_opened_terms or terms
      for _, term in ipairs(restore_terms) do
         local layout = M.get_layout()
         term:open(layout)
      end
      previously_opened_terms = {}
   end
end

function M.new()
   local layout = M.get_layout()
   require("terminal").run("", { layout = layout })
end

return M
