local session = require("auto-session")
local Lib = require("auto-session.lib")

local at_repo_root = vim.g.repo_root == vim.uv.cwd()

-- local first_arg = vim.fn.argv(1)
local arg_count = vim.fn.argc()
local first_arg = vim.fn.argv()
local passed_nothing_or_dir = arg_count == 0 or (arg_count == 1 and vim.fn.isdirectory(first_arg[1]) == 1)

session.setup({
  auto_create = at_repo_root,

  restore_error_handler = function(error_msg)
    if error_msg and error_msg:find("E661") then
      return true
    end

    Lib.logger.error("Error restoring session, disabling auto save. Error message: \n" .. error_msg)
    return false
  end,

  no_restore_cmds = {
    function()
      if vim.g.repo_root ~= nil and not at_repo_root and passed_nothing_or_dir then
        -- Neovim cd, not shell cd. Means when we exit Neovim,
        vim.api.nvim_cmd({
          cmd = "cd",
          args = { vim.g.repo_root },
        }, {})

        vim.api.nvim_command("AutoSession restore " .. vim.g.repo_root)
      end
    end,
  },
})

vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal"
