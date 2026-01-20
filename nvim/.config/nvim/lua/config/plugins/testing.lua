return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-python",
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-python")({
                        dap = { justMyCode = false },
                        runner = "pytest",
                    }),
                },
                output = {
                    enabled = true,
                    open_on_run = "short",
                },
                status = {
                    enabled = true,
                    virtual_text = true,
                    signs = true,
                },
            })
        end,
    },
}
