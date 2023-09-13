local M = {}

M.general = {
  n = {
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
  }
}

M.trouble = {
  n = {
    ["<leader>tt"] = { "<cmd>TroubleToggle<CR>", "toggle Trouble"}
  }
}

M.harpoon = {
    n = {
        ["<leader>fd"] = {
            "<cmd> lua require('harpoon.mark').add_file()<CR>",
            "add file to harpoon"
        },
        ["<leader>fg"] = {
            "<cmd> lua require('harpoon.ui').toggle_quick_menu()<CR>",
            ""
        },
        ["<leader>fs"] = {
            "<cmd> Telescope harpoon marks<CR>",
            ""
        },
        ["<A-d>"] = {"<cmd> lua require('harpoon.ui').nav_next()<CR>", ""},
        ["<A-u>"] = {"<cmd> lua require('harpoon.ui').nav_prev()<CR>", ""}
    }
}

M.telescope = {
  n = {
    ["<leader>fwa"] = { function()
      require('telescope.builtin').live_grep({
        vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
          "--hidden",
        }
      })
    end, "live grep (all)" },
    ["<leader>fww"] = { "<cmd> Telescope live_grep <CR>", "live grep" },
  }
}

M.logs = {
  n = {
    ["<leader>lm"] = {"<cmd> Noice<CR>", "Message logs"},
    ["<leader>ll"] = {"<cmd> LspLog<CR>", "LSP logs"}
  }
}

return M
