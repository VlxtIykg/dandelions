---@type vim.lsp.Config
return {
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = nil
  end,
  cmd = {
    "clangd",
    "--function-arg-placeholders=0",
  },
}
