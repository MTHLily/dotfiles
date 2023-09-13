---@diagnostic disable: different-requires
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local utils = require "core.utils"

local lspconfig = require("lspconfig")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

--- Default servers
local servers = {
    "html",
    "cssls",
    "clangd",
    "intelephense",
    "tailwindcss",
    "emmet_ls",
    "gopls",
    "bashls"
}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {on_attach = on_attach, capabilities = capabilities}
end

-- ESM Langserver
-- General langserver, I use it for autoformat
lspconfig.efm.setup {
    on_attach = function(client, bufnr)
        utils.load_mappings("lspconfig", {buffer = bufnr})

        if client.server_capabilities.signatureHelpProvider then
            require("nvchad_ui.signature").setup(client)
        end

        if not utils.load_config().ui.lsp_semantic_tokens then
            client.server_capabilities.semanticTokensProvider = nil
        end

        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function() vim.lsp.buf.format() end
            })
        end
    end,
    capabilities = capabilities,
    init_options = {documentFormatting = true},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {
                {
                    formatCommand = "lua-format -i --config=$HOME/.config/luaformatter/config.yaml -v",
                    formatStdin = true
                }
            },
            vue = {
                {
                    formatCommand = "env (test -e ./node_modules/.bin/prettier && echo './node_modules/.bin/prettier' || echo 'prettier') --parser vue",
                    formatStdin = true
                }
            },
            php = {
                {
                    formatCommand = "env (test -e ./node_modules/.bin/prettier && echo './node_modules/.bin/prettier' || echo 'prettier') --parser php",
                    formatStdin = true
                }
            }
        }
    },
    filetypes = {'vue', 'php', 'ts', 'lua'}
}

--- VueJS/Typescript Setup
lspconfig.volar.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {
        'typescript',
        'javascript',
        'javascriptreact',
        'typescriptreact',
        'vue',
        'json'
    }
}
