require("configs.options")
require("configs.keymaps")
require("configs.autocmd")

local lazypath = vim.env.LAZY or vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
   })
   if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo(
         { { "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out, "WarningMsg" }, { "\nPress any key to exit..." } },
         true,
         {}
      )
      vim.fn.getchar()
      vim.cmd.quit()
   end
end

vim.opt.rtp:prepend(lazypath)

local Event = require("lazy.core.handler.event")
Event.mappings.LazyFile = { id = "LazyFile", event = { "BufReadPost", "BufNewFile", "BufWritePre" } }
Event.mappings.GitFileOnce = { id = "GitFileOnce", event = "User", pattern = "GitFileOnce" }
Event.mappings.GitCwdOnce = { id = "GitCwdOnce", event = "User", pattern = "GitCwdOnce" }

local lazy_config = require("configs.lazy")
require("lazy").setup({
   { import = "plugins" },
}, lazy_config)
