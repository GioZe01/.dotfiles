-- Zen Mode: Distraction-free coding

return {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
        { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
    },
    opts = {
        window = {
            width = 120,
            options = {
                signcolumn = "no",
                number = false,
                relativenumber = false,
                cursorline = false,
                cursorcolumn = false,
                foldcolumn = "0",
            },
        },
        plugins = {
            options = {
                enabled = true,
                ruler = false,
                showcmd = false,
            },
            tmux = { enabled = true },
        },
    },
}
