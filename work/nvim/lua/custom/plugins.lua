local plugins = {
  { "christoomey/vim-tmux-navigator", lazy = false },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
     ensure_installed = {
        -- defaults 
        "vim",
        "lua",

        -- scripting
        "bash",
        "dockerfile",
        "fish",

        -- devops
        "terraform",


        -- web dev 
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "vue",
        "hjson",
        "jsonnet",
        --"svelte",
        -- low level
        "c",
         "zig"
      }
    }
  },
  {
    "tpope/vim-abolish",
    lazy = false
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
       require "plugins.configs.lspconfig"
      require "custom.lsp"
    end
  },
 {
   "williamboman/mason.nvim",
   opts = {
      ensure_installed = {
        "lua-language-server",
        "html-lsp",
        "prettier",
        "stylua",
        "bicep-lsp"
      },
    },
  },
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    }
  },
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons"
  }
}

return plugins
