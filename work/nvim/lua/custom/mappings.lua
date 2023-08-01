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

return M
