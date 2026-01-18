-- Fugitive: Git integration

return {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gwrite", "Gread" },
    keys = {
        { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
        { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
        { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
        { "<leader>gl", "<cmd>Git log<cr>", desc = "Git log" },
        { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff" },
        { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
    },
}
