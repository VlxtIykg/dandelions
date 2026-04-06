vim.lsp.inlay_hint.enable(true)

vim.diagnostic.config({
  severity_sort = true,
  signs = false,
  float = {
    border = "rounded",
  },
})

-- https://github.com/llakala/meovim/commit/e6e265c71fffa599458412a78c517c82dbe54f2e
-- Lak doesn't like replacement mode, I actually like it but I just use double
-- insert for it.
vim.keymap.del("n", "grn")
nnoremap("R", vim.lsp.buf.rename, { desc = "Rename symbol" })

vim.keymap.del({ "n", "x" }, "gra")
vim.keymap.set({ "n", "x" }, "ga", vim.lsp.buf.code_action, { desc = "Code action" })
