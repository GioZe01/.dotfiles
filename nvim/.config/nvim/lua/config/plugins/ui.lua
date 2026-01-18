-- UI enhancements

return {
    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { { "filename", path = 1 } },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        },
    },

    -- Buffer line
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = {
            options = {
                mode = "buffers",
                separator_style = "thin",
                always_show_bufferline = false,
                show_buffer_close_icons = false,
                show_close_icon = false,
                color_icons = true,
            },
        },
    },

    -- Indent guides
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        main = "ibl",
        opts = {
            indent = {
                char = "│",
            },
            scope = {
                enabled = false,
            },
        },
    },

    -- Better notifications (disabled - compatibility issues with Neovim 0.9.5)
    -- To re-enable later: uncomment this block when Neovim is updated
    -- {
    --     "rcarriga/nvim-notify",
    --     lazy = false,
    --     priority = 900,
    --     config = function()
    --         local notify = require("notify")
    --         notify.setup({
    --             background_colour = "#000000",
    --             timeout = 3000,
    --             max_width = 50,
    --         })
    --         vim.notify = notify
    --     end,
    -- },

    -- Icons
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },

    -- Which-key: Show keybindings
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = {
                spelling = true,
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.register({
                ["<leader>p"] = { name = "+telescope" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>d"] = { name = "+diagnostics" },
                ["<leader>b"] = { name = "+buffer" },
            })
        end,
    },
}
