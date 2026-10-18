local M = {}

local ELLIPSIS = "…"

local function width(s) return vim.fn.strdisplaywidth(s) end

local function apply_tilde(path) return vim.fn.fnamemodify(path, ":~") end

local function split_components(path)
   local prefix, rest = "", path
   if path:sub(1, 1) == "/" then
      prefix, rest = "/", path:sub(2)
   elseif path:sub(1, 2) == "~/" then
      prefix, rest = "~", path:sub(3)
   elseif path == "~" then
      return "~", {}
   end
   local parts = {}
   for part in rest:gmatch("[^/]+") do
      parts[#parts + 1] = part
   end
   return prefix, parts
end

local function join(prefix, comps)
   local body = table.concat(comps, "/")
   if prefix == "/" then
      return "/" .. body
   elseif prefix == "~" then
      return body == "" and "~" or ("~/" .. body)
   end
   return body
end

--- Shorten a path to fit within max_len.
--- The last component (file name or terminal directory name) is never
--- truncated or dropped. If it still doesn't fit, the result may exceed
--- max_len; check the second return value to detect that case.
---@param str string path string to shorten
---@param max_len integer target display width
---@return string shortened the shortened string
---@return boolean fit true if the result fits within max_len
function M.shorten_path(str, max_len)
   local path = apply_tilde(str)
   if width(path) <= max_len then return path, true end

   local prefix, parts = split_components(path)
   local n = #parts
   if n <= 1 then return path, false end

   local function build(li, ri)
      local comps = {}
      for i = 1, li do
         comps[#comps + 1] = parts[i]
      end
      if li + ri < n - 1 then comps[#comps + 1] = ELLIPSIS end
      for i = n - ri, n - 1 do
         comps[#comps + 1] = parts[i]
      end
      comps[#comps + 1] = parts[n]
      return join(prefix, comps)
   end

   local li, ri = 0, 0
   local best = build(0, 0)

   while li + ri < n - 1 do
      local can_left = li + 1 <= n - 1 - ri
      local can_right = ri + 1 <= n - 1 - li
      local left_w = can_left and width(parts[li + 1]) or math.huge
      local right_w = can_right and width(parts[n - 1 - ri]) or math.huge

      local nli, nri = li, ri
      if left_w <= right_w then
         nli = li + 1
      else
         nri = ri + 1
      end

      local candidate = build(nli, nri)
      if width(candidate) <= max_len then
         li, ri = nli, nri
         best = candidate
      else
         break
      end
   end

   return best, width(best) <= max_len
end

return M
