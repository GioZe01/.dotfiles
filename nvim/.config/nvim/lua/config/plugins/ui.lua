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
            win = {
                border = "rounded",
                padding = { 2, 2, 2, 2 },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)

            -- Define all keybinding groups with descriptions
            wk.add({
                -- Main groups
                { "<leader>p", group = " Find (Telescope)" },
                { "<leader>g", group = " Git" },
                { "<leader>d", group = " Diagnostics" },
                { "<leader>b", group = " Buffer" },
                { "<leader>c", group = " Claude AI" },
                { "<leader>t", group = " Test/Terminal" },
                { "<leader>m", group = " Jupyter/Molten" },
                { "<leader>v", group = " Virtual Env" },
                { "<leader>a", group = " Harpoon" },
                { "<leader>h", group = " Harpoon Menu" },
                { "<leader>1", desc = " Harpoon File 1" },
                { "<leader>2", desc = " Harpoon File 2" },
                { "<leader>3", desc = " Harpoon File 3" },
                { "<leader>4", desc = " Harpoon File 4" },

                -- Telescope group (detailed)
                { "<leader>p", group = " Find (Telescope)" },
                { "<leader>pf", desc = " Find Files" },
                { "<leader>ps", desc = " Search (Live Grep)" },
                { "<leader>pg", desc = " Git Files" },
                { "<leader>pb", desc = " Buffers" },
                { "<leader>ph", desc = " Help Tags" },
                { "<leader>pr", desc = " Recent Files" },
                { "<leader>pc", desc = " Grep Word Under Cursor" },
                { "<leader>pe", desc = " File Browser" },
                { "<leader>pp", desc = " File Browser (Current Dir)" },
                { "<leader>pv", desc = " File Explorer (Oil)" },

                -- Git group
                { "<leader>g", group = " Git" },
                { "<leader>gs", desc = " Git Status" },
                { "<leader>gc", desc = " Git Commit" },
                { "<leader>gp", desc = " Git Push" },
                { "<leader>gl", desc = " Git Log" },
                { "<leader>gd", desc = " Git Diff" },
                { "<leader>gb", desc = " Git Blame" },

                -- Buffer group
                { "<leader>b", group = " Buffer" },
                { "<leader>bd", desc = " Delete Buffer" },
                { "<leader>bn", desc = " Next Buffer" },
                { "<leader>bp", desc = " Previous Buffer" },

                -- Diagnostics group
                { "<leader>d", group = " Diagnostics" },
                { "<leader>dl", desc = " Diagnostic List" },

                -- Claude AI group
                { "<leader>c", group = " Claude AI" },
                { "<leader>cc", desc = " Open Claude with File" },
                { "<leader>cs", desc = " Send Selection to Claude" },
                { "<leader>ct", desc = " Claude in Terminal" },
                { "<leader>ca", desc = " Ask Claude" },

                -- AI Completion (Codeium) group
                { "<leader>a", group = " AI / Harpoon" },
                { "<leader>ai", desc = " Codeium Chat" },
                { "<leader>ae", desc = "ﮧ Toggle Codeium" },
                { "<leader>as", desc = " Authenticate Codeium" },

                -- Terminal/Testing group
                { "<leader>t", group = " Test/Terminal" },
                { "<leader>tt", desc = " Toggle Terminal (Horizontal)" },
                { "<leader>tf", desc = " Toggle Terminal (Float)" },
                { "<leader>tv", desc = " Toggle Terminal (Vertical)" },
                { "<leader>t1", desc = " Terminal 1 (General)" },
                { "<leader>t2", desc = " Terminal 2 (Testing)" },
                { "<leader>tn", desc = " Run Nearest Test" },
                { "<leader>tF", desc = " Run Test File" },
                { "<leader>ta", desc = " Run All Tests" },
                { "<leader>ts", desc = " Toggle Test Summary" },
                { "<leader>to", desc = " Show Test Output" },
                { "<leader>tw", desc = " Watch Test File" },
                { "<leader>tS", desc = " Stop Tests" },
                { "<leader>tp", desc = " Run pytest in Terminal" },

                -- Jupyter/Molten group
                { "<leader>m", group = " Jupyter/Molten" },
                { "<leader>mi", desc = " Initialize Molten" },
                { "<leader>ml", desc = " Evaluate Line" },
                { "<leader>mv", desc = " Evaluate Visual Selection" },
                { "<leader>mr", desc = " Re-evaluate Cell" },
                { "<leader>mo", desc = " Show Output" },
                { "<leader>mh", desc = " Hide Output" },
                { "<leader>md", desc = " Delete Cell" },

                -- Virtual Environment group
                { "<leader>v", group = " Virtual Env" },
                { "<leader>vs", desc = " Select Venv" },
                { "<leader>vc", desc = " Select Cached Venv" },

                -- Other important keybindings
                { "<leader>u", desc = " Undotree" },
                { "<leader>w", desc = " Save File" },
                { "<leader>q", desc = " Quit" },
                { "<leader>f", desc = " Format Document" },
                { "<leader>s", desc = " Replace Word Under Cursor" },
                { "<leader>x", desc = " Make File Executable" },
                { "<leader>y", desc = " Yank to System Clipboard" },
                { "<leader>Y", desc = " Yank Line to System Clipboard" },
                { "<leader>e", desc = " Show Diagnostic Float" },
                { "<leader>rn", desc = " Rename Symbol" },
                { "<leader>-", desc = " Oil Floating Window" },

                -- Zen mode
                { "<leader>z", group = " Zen Mode" },
                { "<leader>zz", desc = " Toggle Zen Mode" },
                { "<leader>zZ", desc = " Toggle Zen Mode (Full)" },

                -- LSP (shown when hovering over code)
                mode = { "n", "v" },
            })

            -- Non-leader key groups (for reference)
            wk.add({
                -- LSP keybindings (no leader)
                { "gd", desc = " Go to Definition" },
                { "gD", desc = " Go to Declaration" },
                { "gi", desc = " Go to Implementation" },
                { "gr", desc = " Find References" },
                { "K", desc = " Hover Documentation" },
                { "[d", desc = " Previous Diagnostic" },
                { "]d", desc = " Next Diagnostic" },

                -- Visual mode
                { "J", desc = " Move Selection Down", mode = "v" },
                { "K", desc = " Move Selection Up", mode = "v" },

                -- Oil.nvim
                { "-", desc = " Open Parent Directory" },

                mode = { "n", "v" },
            })
        end,
    },
}
