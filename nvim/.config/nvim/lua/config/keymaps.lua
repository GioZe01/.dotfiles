-- Key mappings (ThePrimeagen style)
--
-- NOTE: Some keybindings are defined in their respective plugin files:
-- - Harpoon: <leader>a (add), <leader>h (menu), <leader>1-4 (files) (see harpoon.lua)
-- - Oil.nvim: <leader>pv, - for file explorer (see file-explorer.lua)
-- - Telescope: <leader>p* for fuzzy finding (see telescope.lua)
-- - LSP: gd, gr, K, <leader>ca, etc. (see lsp.lua)
-- - AI: <leader>ai, <leader>ae for Codeium (see ai-completion.lua)

local keymap = vim.keymap.set

-- Better up/down with word wrap
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move selected lines up/down
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected line down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected line up" })

-- Keep cursor centered when scrolling
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Keep search results centered
keymap("n", "n", "nzzzv", { desc = "Next search result (centered)" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Join lines without moving cursor
keymap("n", "J", "mzJ`z", { desc = "Join lines" })

-- Paste over selection without yanking
keymap("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })

-- Yank to system clipboard
keymap({"n", "v"}, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
keymap("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- Delete to void register
keymap({"n", "v"}, "<leader>d", [["_d]], { desc = "Delete to void register" })

-- Disable Q (ex mode)
keymap("n", "Q", "<nop>")

-- Quick fix navigation
keymap("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
keymap("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })
keymap("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location list item" })
keymap("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous location list item" })

-- Search and replace word under cursor
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

-- Make current file executable
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Clear highlights
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Save file
keymap("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

-- Quit
keymap("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Window resizing
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Buffer navigation
keymap("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- Terminal toggles
keymap("n", "<leader>tt", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Toggle terminal (horizontal)" })
keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle terminal (float)" })
keymap("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Toggle terminal (vertical)" })
keymap("n", "<leader>t1", "<cmd>1ToggleTerm<cr>", { desc = "Toggle terminal 1 (general)" })
keymap("n", "<leader>t2", "<cmd>2ToggleTerm<cr>", { desc = "Toggle terminal 2 (testing)" })

-- Terminal mode navigation
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Move left from terminal" })
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Move down from terminal" })
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Move up from terminal" })
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Move right from terminal" })
keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Test commands (neotest)
keymap("n", "<leader>tn", function() require("neotest").run.run() end, { desc = "Run nearest test" })
keymap("n", "<leader>tF", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Run test file" })
keymap("n", "<leader>ta", function() require("neotest").run.run(vim.fn.getcwd()) end, { desc = "Run all tests" })
keymap("n", "<leader>ts", function() require("neotest").summary.toggle() end, { desc = "Toggle test summary" })
keymap("n", "<leader>to", function() require("neotest").output.open({ enter = true }) end, { desc = "Show test output" })
keymap("n", "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, { desc = "Watch test file" })
keymap("n", "<leader>tS", function() require("neotest").run.stop() end, { desc = "Stop tests" })

-- Pytest in dedicated terminal
keymap("n", "<leader>tp", function()
    vim.cmd("2ToggleTerm")
    vim.defer_fn(function()
        if vim.b.terminal_job_id then
            vim.api.nvim_chan_send(vim.b.terminal_job_id, "pytest -v\r")
        end
    end, 100)
end, { desc = "Run pytest in terminal 2" })

-- Claude Code integration
keymap("n", "<leader>cc", "<cmd>Claude<cr>", { desc = "Open Claude with file" })
keymap("v", "<leader>cs", "<cmd>ClaudeSelection<cr>", { desc = "Send selection to Claude" })
keymap("n", "<leader>ct", "<cmd>ClaudeTerminal<cr>", { desc = "Claude in terminal" })
keymap("n", "<leader>ca", ":ClaudeAsk ", { desc = "Ask Claude about file" })
