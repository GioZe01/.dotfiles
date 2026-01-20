local function setup_claude_commands()
    local claude_bin = vim.fn.expand("~/.local/bin/claude")

    -- Open Claude with current file
    vim.api.nvim_create_user_command("Claude", function()
        local current_file = vim.fn.expand("%:p")
        if current_file ~= "" then
            vim.fn.system(string.format('%s "%s" &', claude_bin, current_file))
        else
            vim.fn.system(claude_bin .. " &")
        end
    end, { desc = "Open Claude Code with current file" })

    -- Send visual selection to Claude
    vim.api.nvim_create_user_command("ClaudeSelection", function()
        local start_pos = vim.fn.getpos("'<")
        local end_pos = vim.fn.getpos("'>")
        local lines = vim.fn.getline(start_pos[2], end_pos[2])

        local temp_file = "/tmp/claude_selection.txt"
        vim.fn.writefile(lines, temp_file)
        vim.fn.system(string.format('%s "%s" &', claude_bin, temp_file))
    end, { range = true, desc = "Send selection to Claude Code" })

    -- Ask Claude about current file
    vim.api.nvim_create_user_command("ClaudeAsk", function(opts)
        local current_file = vim.fn.expand("%:p")
        local question = opts.args

        if current_file ~= "" then
            local temp_file = "/tmp/claude_question.txt"
            vim.fn.writefile({question, "", "File: " .. current_file}, temp_file)
            vim.fn.system(string.format('%s "%s" &', claude_bin, temp_file))
        end
    end, { nargs = "+", desc = "Ask Claude about current file" })

    -- Open Claude in terminal
    vim.api.nvim_create_user_command("ClaudeTerminal", function()
        vim.cmd("3ToggleTerm")
        vim.defer_fn(function()
            if vim.b.terminal_job_id then
                vim.api.nvim_chan_send(vim.b.terminal_job_id, "claude\r")
            end
        end, 100)
    end, { desc = "Open Claude in terminal" })
end

return {
    name = "claude-integration",
    dir = vim.fn.stdpath("config"),
    config = setup_claude_commands,
}
