-- AI-Powered Completion with Codeium
-- Free AI code completion (alternative to GitHub Copilot)
-- Supports Python, JavaScript, TypeScript, Rust, and many more languages

return {
    "Exafunction/codeium.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    event = "BufEnter",
    config = function()
        require("codeium").setup({
            -- Enable or disable codeium
            enable_chat = true,
            -- Virtual text configuration
            virtual_text = {
                enabled = true,
                manual = false,
                idle_delay = 75,
                virtual_text_priority = 65535,
                map_keys = true,
                key_bindings = {
                    -- Accept the current completion
                    accept = "<Tab>",
                    -- Accept the next word of the current completion
                    accept_word = false,
                    -- Accept the next line of the current completion
                    accept_line = false,
                    -- Clear the virtual text
                    clear = false,
                    -- Cycle to the next completion
                    next = "<M-]>",
                    -- Cycle to the previous completion
                    prev = "<M-[>",
                },
            },
        })

        -- Integration with nvim-cmp
        -- Add codeium to your completion sources in lsp.lua
        local cmp = require("cmp")
        local config = cmp.get_config()
        table.insert(config.sources, 1, {
            name = "codeium",
            priority = 1000,
        })
        cmp.setup(config)

        -- Optional: Custom keybindings for Codeium chat
        vim.keymap.set("n", "<leader>ai", function()
            vim.cmd("Codeium Chat")
        end, { desc = "Open Codeium Chat" })

        vim.keymap.set("n", "<leader>ae", function()
            vim.cmd("Codeium Toggle")
        end, { desc = "Toggle Codeium" })

        vim.keymap.set("n", "<leader>as", function()
            vim.cmd("Codeium Auth")
        end, { desc = "Authenticate Codeium" })
    end,
}
