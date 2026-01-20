-- Lazy.nvim plugin manager bootstrap and setup

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Auto-install lazy.nvim if not present
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    -- Plugin specifications from lua/config/plugins/
    spec = {
        { import = "config.plugins" },
    },

    -- Plugin defaults
    defaults = {
        lazy = false,
        version = false, -- Use latest git commit
    },

    -- Installation settings
    install = {
        colorscheme = { "habamax" },
    },

    -- UI settings
    ui = {
        border = "rounded",
    },

    -- Performance
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },

    -- Change detection
    change_detection = {
        enabled = true,
        notify = false,
    },

    -- Luarocks/hererocks configuration
    -- Disable hererocks as it's only needed for molten-nvim which is disabled by default
    rocks = {
        enabled = false,  -- Disable to avoid warnings
        hererocks = false,  -- Don't use hererocks
    },
})

-- Keybinding to open lazy.nvim UI
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy UI" })
