-- Treesitter: Syntax highlighting and code understanding

return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = "v0.9.2", -- Pin to version compatible with Neovim 0.9.5
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup({
                -- Install parsers manually to avoid auto-install issues
                ensure_installed = {
                    "lua",
                    "python",
                    "bash",
                    "json",
                    "vim",
                    "vimdoc",
                },

                -- Install parsers synchronously
                sync_install = false,

                -- Don't auto-install (can cause issues)
                auto_install = false,

                -- Highlighting
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },

                -- Indentation
                indent = {
                    enable = true,
                },

                -- Incremental selection
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm",
                    },
                },
            })
        end,
    },

    -- Treesitter text objects (optional, can enable later)
    -- {
    --     "nvim-treesitter/nvim-treesitter-textobjects",
    --     event = "VeryLazy",
    --     dependencies = { "nvim-treesitter/nvim-treesitter" },
    -- },
}
