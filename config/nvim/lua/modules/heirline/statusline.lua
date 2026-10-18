local lib = require("heirline-components.all")
local init = require("heirline-components.core.init")

local git_branch = {
   condition = function() return vim.g.is_in_git_repo and vim.g.gitsigns_head end,
   provider = function(self) return " " .. vim.g.gitsigns_head .. " " end,
   init = init.update_events({
      { "User", pattern = "GitSignsUpdate" },
      "DirChanged",
   }),
   on_click = {
      name = "heirline_branch",
      callback = function() Snacks.picker.git_branches() end,
   },
}

local cwd = {
   provider = function(self)
      local path = vim.fn.getcwd()
      local max_len = math.floor(vim.o.columns * 0.3)
      return "󰉋 " .. require("utils.path").shorten_path(path, max_len) .. "  "
   end,
   update = { "DirChanged", "WinResized" },
   on_click = {
      name = "heirline_cwd",
      callback = function() Snacks.picker.projects() end,
   },
}

local lazy = {
   provider = function() return require("lazy.status").updates() .. "  " end,
   condition = require("lazy.status").has_updates,
   update = { "User", pattern = "LazyUpdate" },
   on_click = {
      name = "heirline_lazy",
      callback = function() require("lazy").home() end,
   },
}

return {
   lib.component.mode({
      mode_text = { "center" },
      surround = {
         separator = { "", " " },
      },
   }),
   git_branch,
   lib.component.fill(),
   lazy,
   cwd,
   lib.component.lsp({
      lsp_progress = false,
      lsp_client_names = {
         icon = {
            padding = { right = 1 },
         },
      },
      surround = { separator = { "", " " } },
      on_click = {
         name = "heirline_lsp",
         callback = function() require("mason.ui").open() end,
      },
   }),
}
