-- Data Science, Machine Learning, and Bioinformatics Plugins

return {
    -- Jupyter Notebook Integration - molten.nvim (Interactive code execution)
    -- NOTE: Requires system dependencies - see installation section below
    -- If build fails, install dependencies first:
    -- sudo apt install libreadline-dev python3-dev
    -- pip install pynvim jupyter_client cairosvg pnglatex plotly kaleido
    {
        "benlubas/molten-nvim",
        version = "^1.0.0",
        enabled = false, -- Set to true after installing dependencies
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            -- Molten settings
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20
            vim.g.molten_auto_open_output = false
            vim.g.molten_wrap_output = true
            vim.g.molten_virt_text_output = true
            vim.g.molten_virt_lines_off_by_1 = true
        end,
        keys = {
            { "<leader>mi", ":MoltenInit<CR>", desc = "Initialize Molten" },
            { "<leader>me", ":MoltenEvaluateOperator<CR>", desc = "Evaluate operator" },
            { "<leader>ml", ":MoltenEvaluateLine<CR>", desc = "Evaluate line" },
            { "<leader>mr", ":MoltenReevaluateCell<CR>", desc = "Re-evaluate cell" },
            { "<leader>md", ":MoltenDelete<CR>", desc = "Delete cell" },
            { "<leader>mo", ":MoltenShowOutput<CR>", desc = "Show output" },
            { "<leader>mh", ":MoltenHideOutput<CR>", desc = "Hide output" },
            { "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>gv", mode = "v", desc = "Evaluate visual" },
        },
    },

    -- Jupytext - Edit .ipynb files as .py
    {
        "GCBallesteros/jupytext.nvim",
        config = function()
            require("jupytext").setup({
                style = "hydrogen", -- "hydrogen" | "markdown" | "light" | "percent"
                output_extension = "auto", -- Default extension. Don't change unless you know what you are doing
                force_ft = nil, -- Default filetype. Don't change unless you know what you are doing
            })
        end,
        lazy = false,
    },

    -- Image viewing in terminal (requires kitty terminal or ueberzug++)
    -- NOTE: Requires Kitty terminal emulator or ueberzug++
    -- Install: sudo apt install kitty
    -- OR: pip install ueberzug
    {
        "3rd/image.nvim",
        enabled = false, -- Set to true after installing kitty or ueberzug
        opts = {
            backend = "kitty", -- "kitty" | "ueberzug"
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "markdown", "vimwiki" },
                },
                neorg = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "norg" },
                },
            },
            max_width = nil,
            max_height = nil,
            max_width_window_percentage = nil,
            max_height_window_percentage = 50,
            window_overlap_clear_enabled = false,
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
            editor_only_render_when_focused = false,
            tmux_show_only_in_active_window = false,
            hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
        },
    },

    -- PyTorch tensor visualization (requires kitty terminal)
    -- NOTE: This is an external plugin - install manually from:
    -- https://github.com/calebmcirvin/dispy.nvim
    -- Uncomment when installed:
    -- {
    --     "calebmcirvin/dispy.nvim",
    --     config = function()
    --         require("dispy").setup({
    --             -- Configuration for tensor visualization
    --         })
    --     end,
    --     ft = "python",
    -- },

    -- bioSyntax - Syntax highlighting for bioinformatics files
    -- NOTE: bioSyntax needs to be installed system-wide
    -- Installation instructions at: https://biosyntax.org/
    -- Supports: .fasta, .fastq, .sam, .vcf, .gtf, .bed, .pdb, .cwl
    -- After installation, it automatically recognizes these file extensions

    -- Enhanced Python support for data science
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
        opts = {
            name = { "venv", ".venv", "env", ".env" },
        },
        keys = {
            { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python venv" },
            { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select cached venv" },
        },
    },

    -- CSV/TSV file viewer
    {
        "chrisbra/csv.vim",
        ft = { "csv", "tsv" },
        config = function()
            vim.g.csv_arrange_align = "l*"
            vim.g.csv_delim = ","
            vim.g.csv_no_conceal = 1
        end,
    },

    -- Markdown preview (useful for Jupyter markdown cells)
    -- NOTE: Requires npm - install with: sudo apt install nodejs npm
    {
        "iamcco/markdown-preview.nvim",
        enabled = false, -- Set to true after installing npm
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
        keys = {
            { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Markdown preview" },
            { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", desc = "Markdown preview stop" },
        },
    },

    -- Database client (for data science workflows)
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
        end,
        keys = {
            { "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle Database UI" },
        },
    },
}
