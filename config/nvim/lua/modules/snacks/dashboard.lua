---@param opts? {limit?:number, pick?:boolean}
local function projects(opts)
   opts = vim.tbl_extend("force", { pick = true, session = true }, opts or {})
   local limit = opts.limit or 5

   local dirs = {}
   for file in Snacks.dashboard.oldfiles() do
      local dir = Snacks.git.get_root(file)
      if dir and not vim.tbl_contains(dirs, dir) then
         table.insert(dirs, dir)
         if #dirs >= limit then break end
      end
   end

   local ret = {} ---@type snacks.dashboard.Item[]
   for _, dir in ipairs(dirs) do
      ret[#ret + 1] = {
         file = dir,
         icon = "directory",
         action = function(self)
            vim.fn.chdir(dir)

            local has_session = require("modules.resession").has_session(dir)
            if has_session then
               require("resession").load(dir, { dir = require("modules.resession").dirsession })
            elseif opts.pick then
               Snacks.dashboard.pick()
            end
         end,
         autokey = true,
      }
   end

   return ret
end

return {
   enabled = true,
   width = 60,
   autokeys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
   sections = {
      {
         align = "center",
         text = {
            { "│ ", hl = "Special" },
            { "╲ ││\n", hl = "String" },
            { "││", hl = "Special" },
            { "╲╲││\n", hl = "String" },
            { "││ ", hl = "Special" },
            { "╲ │\n\n", hl = "String" },
            { "NVIM " .. vim.version().build .. "\n", hl = "String" },
         },
      },
      { icon = "󰈔", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      {
         icon = "󰝰 ",
         title = "Projects",
         projects,
         indent = 2,
         padding = 1,
      },
      { section = "startup" },
   },
}
