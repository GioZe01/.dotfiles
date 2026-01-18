-- Neovim configuration (ThePrimeagen-style)
-- Entry point that loads all configuration modules

-- Load configuration modules
require("config.lazy")      -- Plugin manager (must be first)
require("config.options")   -- Vim options
require("config.keymaps")   -- Key mappings
require("config.autocmds")  -- Autocommands
