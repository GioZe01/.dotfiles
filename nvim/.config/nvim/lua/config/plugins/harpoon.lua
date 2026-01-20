-- Harpoon: Quick file marks and navigation (ThePrimeagen's workflow)
-- Harpoon allows you to mark up to 4-5 files for instant navigation
-- Perfect for switching between frequently edited files in a project

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    keys = {
        { "<leader>a", desc = "Harpoon: Add file" },
        { "<leader>h", desc = "Harpoon: Toggle menu" },
        { "<leader>1", desc = "Harpoon: File 1" },
        { "<leader>2", desc = "Harpoon: File 2" },
        { "<leader>3", desc = "Harpoon: File 3" },
        { "<leader>4", desc = "Harpoon: File 4" },
    },
    config = function()
        local harpoon = require("harpoon")

        -- Initialize harpoon with default settings
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
                key = function()
                    return vim.loop.cwd()
                end,
            },
        })

        -- Keybindings
        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "Harpoon: Add file to list" })

        vim.keymap.set("n", "<leader>h", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon: Toggle quick menu" })

        -- Navigate to files 1-4 (using leader + number for no conflicts)
        vim.keymap.set("n", "<leader>1", function()
            harpoon:list():select(1)
        end, { desc = "Harpoon: Go to file 1" })

        vim.keymap.set("n", "<leader>2", function()
            harpoon:list():select(2)
        end, { desc = "Harpoon: Go to file 2" })

        vim.keymap.set("n", "<leader>3", function()
            harpoon:list():select(3)
        end, { desc = "Harpoon: Go to file 3" })

        vim.keymap.set("n", "<leader>4", function()
            harpoon:list():select(4)
        end, { desc = "Harpoon: Go to file 4" })

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-S-P>", function()
            harpoon:list():prev()
        end, { desc = "Harpoon: Previous file" })

        vim.keymap.set("n", "<C-S-N>", function()
            harpoon:list():next()
        end, { desc = "Harpoon: Next file" })

        -- Telescope integration (optional)
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        vim.keymap.set("n", "<leader>ph", function()
            toggle_telescope(harpoon:list())
        end, { desc = "Open harpoon window (Telescope)" })
    end,
}
