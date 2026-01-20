-- Neovim options (ThePrimeagen settings)

local opt = vim.opt

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Search
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Visual
opt.termguicolors = true
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.cursorline = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Wrapping
opt.wrap = false

-- Backup and undo
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- Update time (for CursorHold events, used by LSP)
opt.updatetime = 50

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Clipboard (use system clipboard)
opt.clipboard = "unnamedplus"

-- Mouse
opt.mouse = "a"

-- Command line
opt.cmdheight = 1
opt.showmode = false

-- Folding (disabled to avoid startup issues)
opt.foldenable = false

-- Font settings (for GUI clients like Neovide)
opt.guifont = "DejaVu Sans Mono:h13"

-- Improve rendering
opt.lazyredraw = false

-- Create undodir if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end

-- Disable unused providers to avoid health check warnings
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
-- Node.js provider will be enabled when npm is installed
