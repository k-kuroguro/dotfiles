return {
   "saghen/blink.cmp",
   version = "1.*",
   event = { "InsertEnter", "CmdlineEnter" },
   build = "cargo build --release",
   opts = {},
   opts_extend = { "sources.default" },
}
