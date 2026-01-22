-- Neovim configuration (ThePrimeagen-style)
-- Entry point that loads all configuration modules

-- Load configuration modules in correct order
require("config.options")   -- Vim options (MUST be first to disable netrw before plugins)
require("config.lazy")      -- Plugin manager and plugins
require("config.keymaps")   -- Key mappings
require("config.autocmds")  -- Autocommands
