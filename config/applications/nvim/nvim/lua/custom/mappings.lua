local M = {}

M.general = {
    n = {
        ["<C-h>"] = {"<cmd> TmuxNavigateLeft<CR>", "window left"},
        ["<C-l>"] = {"<cmd> TmuxNavigateRight<CR>", "window right"},
        ["<C-j>"] = {"<cmd> TmuxNavigateDown<CR>", "window down"},
        ["<C-k>"] = {"<cmd> TmuxNavigateUp<CR>", "window up"}
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
        ["<A-d>"] = {"<cmd> lua require('harpoon.ui').nav_next()<CR>", ""},
        ["<A-u>"] = {"<cmd> lua require('harpoon.ui').nav_prev()<CR>", ""}
    }
}

M.trouble = {
    n = {
        ["<leader>tt"] = {"<cmd> TroubleToggle<CR>", "toggle Trouble"},
        ["<leader>tr"] = {"<cmd> TroubleRefresh<CR>", "refresh Trouble"}
    }
}

return M
