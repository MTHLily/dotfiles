local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "clangd", "eslint", "terraformls", "bashls", "lua_ls", "gopls", "pylsp", "jsonnet_ls"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.bicep.setup{
  cmd = { "bicep-lsp"},
  filetypes = {"bicep"},
  on_attach = on_attach,
  capabilities = capabilities
}
