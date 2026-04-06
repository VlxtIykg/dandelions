require("showkeys").setup({
  timeout = 10,
  maxkeys = 15,
})
-- return {
--   "nvzone/showkeys",
--   -- 1. Use 'event' instead of 'cmd' so it loads as soon as you start typing
--   event = "VeryLazy",
--   opts = {
--     timeout = 10,
--     maxkeys = 15,
--   },
--   -- 2. This function runs immediately after the plugin is loaded
--   config = function(_, opts)
--     require("showkeys").setup(opts)
--
--     -- Force the window to appear immediately
--     vim.schedule(function()
--       vim.cmd("ShowkeysToggle")
--     end)
--   end,
-- }
