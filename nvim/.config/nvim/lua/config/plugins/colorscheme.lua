-- Colorscheme - High contrast retro theme

return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
        config = function()
            require("rose-pine").setup({
                variant = "main",
                dark_variant = "main",
                disable_background = false,
                disable_float_background = false,
                disable_italics = true,  -- Clearer text without italics
                styles = {
                    transparency = false,
                },
                highlight_groups = {
                    -- Increase contrast for better readability
                    Normal = { bg = "#0a0e14", fg = "#b3b1ad" },
                    NormalFloat = { bg = "#0a0e14", fg = "#b3b1ad" },
                    Comment = { fg = "#5C6773" },
                },
            })
            vim.cmd("colorscheme rose-pine")
        end,
    },

    -- Alternative colorschemes (commented out)
    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         vim.cmd("colorscheme catppuccin-mocha")
    --     end,
    -- },

    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         vim.cmd("colorscheme tokyonight-night")
    --     end,
    -- },
}
