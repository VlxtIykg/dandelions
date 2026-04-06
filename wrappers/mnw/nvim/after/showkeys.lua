local function toggle_showkeys()
  if vim.fn.exists(":ShowkeysToggle") > 0 then
    vim.cmd("ShowkeysToggle")
  end
end

-- Listen for SessionLoads after vim enter
vim.api.nvim_create_autocmd("User", {
  pattern = "SessionLoadPost",
  callback = function()
    vim.schedule(toggle_showkeys)
  end,
})

-- Handle immediate startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if not vim.g.SessionLoad then
      vim.schedule(toggle_showkeys)
    end
  end,
})
