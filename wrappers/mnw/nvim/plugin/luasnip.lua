local ls = require("luasnip")

ls.setup({
  enable_autosnippets = true,
  snip_env = { in_ts_group = Custom.in_ts_group },
})

local function snippet_dir()
  local cwd = vim.fn.getcwd();
  local snippet_relative_path = "/wrappers/mnw/nvim/snippets" -- change if folder path changed
  (function()
    if cwd:match("([^/]+)$") == "dandelions" then
      return cwd .. snippet_relative_path
    elseif cwd:match("([^/]+)$") == "snippets" then
      return cwd
    else
      print(cwd)
      return "/data/dandelions/wrappers/mnw/nvim/snippets"
    end
  end)()
end

require("luasnip.loaders.from_lua").lazy_load({
  lazy_loading = snippet_dir()
})
