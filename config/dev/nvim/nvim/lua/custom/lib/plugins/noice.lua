local M = {}

M.plugin = {
    "folke/noice.nvim",
    lazy = false,
    opts = {lsp = {signature = {enabled = false}, hover = {enabled = false}}},
    dependencies = {"MunifTanjim/nui.nvim", "rcarriga/nvim-notify"}
}

return M
