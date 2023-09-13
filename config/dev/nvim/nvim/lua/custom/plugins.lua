local plugins = {
    {
        "folke/noice.nvim",
        lazy = false,
        config = function() require("noice").setup({}) end,
        dependencies = {"MunifTanjim/nui.nvim", "rcarriga/nvim-notify"}
    },
    {"christoomey/vim-tmux-navigator", lazy = false},
    {"dag/vim-fish"},
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "html-lsp",
                "prettier",
                "stylua",
                "bash-language-server",
                "shellcheck"
            }
        }
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.lspconfig"
        end
    },
    {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function() require("trouble").setup {} end,
        lazy = false
    },
    {"ThePrimeagen/vim-be-good"},
    {'ThePrimeagen/harpoon', lazy = false},
    {
        'Wansmer/treesj',
        keys = {'<space>m', '<space>j', '<space>s'},
        dependencies = {'nvim-treesitter/nvim-treesitter'},
        config = function()
            require('treesj').setup({ --[[ your config ]] })
        end,
        lazy = false
    },
    {
        "nvim-telescope/telescope.nvim",
        opts = {
            extensions_list = {'media_files'},
            extensions = {
                media_files = {
                    -- filetypes whitelist
                    -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
                    filetypes = {"png", "webp", "jpg", "jpeg"},
                    -- find command (defaults to `fd`)
                    find_cmd = "rg"
                }
            }
        }
    },
    {
        'nvim-telescope/telescope-media-files.nvim',
        dependencies = {'nvim-telescope/telescope.nvim'},
        pin = true,
        commit = "513e4ee385edd72bf0b35a217b7e39f84b6fe93c"
    }
}

return plugins
