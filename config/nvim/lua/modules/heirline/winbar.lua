local lib = require("heirline-components.all")

local ELLIPSIS = "…"

local function width(s) return vim.fn.strdisplaywidth(s) end

local function split_path(path)
   local parts = {}
   for part in path:gmatch("[^/]+") do
      parts[#parts + 1] = part
   end
   return parts
end

local function suffix(parts, depth) return table.concat(parts, "/", #parts - depth + 1, #parts) end

local function relative_path(path)
   local cwd = vim.uv.cwd()
   if not cwd then return path end
   return vim.fs.relpath(cwd, path) or path
end

local function get_file_windows()
   local items = {}
   for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].buftype == "" then
         local name = vim.api.nvim_buf_get_name(buf)
         if name ~= "" then
            items[#items + 1] = {
               win = win,
               path = relative_path(name),
            }
         end
      end
   end
   return items
end

local function unique_suffixes(items)
   local states = {}

   for _, item in ipairs(items) do
      if not states[item.path] then
         states[item.path] = {
            parts = split_path(item.path),
            depth = 1,
         }
      end
   end

   while true do
      local groups = {}
      for path, state in pairs(states) do
         local name = suffix(state.parts, state.depth)

         groups[name] = groups[name] or {}
         groups[name][#groups[name] + 1] = path
      end

      local changed = false
      for _, group in pairs(groups) do
         if #group > 1 then
            for _, path in ipairs(group) do
               local state = states[path]

               if state.depth < #state.parts then
                  state.depth = state.depth + 1
                  changed = true
               end
            end
         end
      end
      if not changed then break end
   end

   return states
end

local function format_suffix(state, max_width)
   local parts = state.parts
   local depth = state.depth
   local full = suffix(parts, depth)

   if width(full) <= max_width then return full end

   if depth <= 2 then return full end

   local first = #parts - depth + 1

   return table.concat({
      parts[first],
      ELLIPSIS,
      parts[#parts],
   }, "/")
end

local function filename(win)
   local buf = vim.api.nvim_win_get_buf(win)
   local buftype = vim.bo[buf].buftype
   if buftype == "terminal" then return vim.b[buf].term_title end

   win = win or vim.api.nvim_get_current_win()

   if not vim.api.nvim_win_is_valid(win) then return "" end

   local name = vim.api.nvim_buf_get_name(buf)

   if name == "" then return "" end

   local path = relative_path(name)
   local items = get_file_windows()
   local states = unique_suffixes(items)
   local state = states[path]

   if not state then return vim.fs.basename(name) end

   local max_width = math.floor(vim.api.nvim_win_get_width(win) * 0.5)

   return format_suffix(state, max_width)
end

local function get_icon_str(filename, buftype)
   if buftype == "terminal" then
      return " "
   else
      local ft_icon = require("nvim-web-devicons").get_icon_color(filename)
      if ft_icon then
         return ft_icon .. " "
      else
         return ""
      end
   end
end

local function get_icon_hl(filename, buftype)
   if buftype == "terminal" then
      return lib.hl.get_hlgroup("MiniIconsGreen")
   else
      local devicons = require("nvim-web-devicons")
      local ft_icon, ft_color = devicons.get_icon_color(filename)
      if ft_icon then
         return { fg = ft_color, bg = "none" }
      else
         return {}
      end
   end
end

local icon = {
   provider = function(self)
      local win = vim.api.nvim_get_current_win()
      local buf = vim.api.nvim_win_get_buf(win)
      local buftype = vim.bo[buf].buftype
      local name = vim.api.nvim_buf_get_name(buf)
      return get_icon_str(name, buftype)
   end,
   hl = function(self)
      local win = vim.api.nvim_get_current_win()
      local buf = vim.api.nvim_win_get_buf(win)
      local buftype = vim.bo[buf].buftype
      local name = vim.api.nvim_buf_get_name(buf)
      return get_icon_hl(name, buftype)
   end,
}

local filepath = {
   provider = function(self)
      local win = vim.api.nvim_get_current_win()
      return filename(win)
   end,
   hl = function(self)
      if lib.condition.is_active() then
         return vim.tbl_extend("force", lib.hl.get_hlgroup("WinBar"), { bold = true })
      else
         return lib.hl.get_hlgroup("WinBarNC")
      end
   end,
}

return {
   icon,
   filepath,
   lib.component.diagnostics({
      surround = { color = "winbar_bg" },
      on_click = {},
   }),
}
