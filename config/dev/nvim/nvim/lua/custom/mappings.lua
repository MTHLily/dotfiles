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

M.external = {
    n = {
        ["<leader>eg"] = {
            function()
                local buf_name = vim.api.nvim_buf_get_name(0):match("(.*/)")
                local dir = (buf_name ~= "") and buf_name or vim.loop.cwd()
                vim.cmd('!tmux neww -c "' .. dir .. '" bash -c lazygit')
            end
        }
    }
}

M.telescope = {
    n = {
        ["<leader>fwa"] = {
            function()
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
                        "--hidden"
                    }
                })
            end,
            "live grep (all)"
        },
        ["<leader>fww"] = {"<cmd> Telescope live_grep <CR>", "live grep"}
    }
}

M.trouble = {
    n = {
        ["<leader>tt"] = {"<cmd> TroubleToggle<CR>", "toggle Trouble"},
        ["<leader>tr"] = {"<cmd> TroubleRefresh<CR>", "refresh Trouble"}
    }
}

return M
