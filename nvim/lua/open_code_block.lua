local M = {}
local api = vim.api
local fn = vim.fn
local run_cmds = {
    python = "python3",
    lua = "lua",
    sh = "bash",
    javascript = "node",
    julia = "julia",
    octave = "octave"
}
local ext = {
    python = "py",
    lua = "lua",
    sh = "sh",
    javascript = "js",
    julia = "jl",
    octave = "m"
}

local function extract_code_block()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local cursor_pos = api.nvim_win_get_cursor(0)
    local row = cursor_pos[1] - 1
    local start_idx, end_idx, lang
    for i = row, 0, -1 do
        if lines[i]:match('^```') then
            start_idx = i
            lang = lines[i]:match("^```%s*(%S+)%s*") or ""
			print(lines[i])
            break
        end
    end
    for i = row + 1, #lines do
        if lines[i]:match('^```') then
            end_idx = i
            break
        end
    end
    if not start_idx or not end_idx then return nil end
	print("start_idx: " .. start_idx .. " end_idx: " .. end_idx .. " lang: " .. lang .. "/")
    local code = vim.api.nvim_buf_get_lines(0, start_idx, end_idx-1, false)
    return start_idx, end_idx, code, lang
end


-- Opens a scratch buffer with the extracted code
function M.open_scratch()
    local start_idx, end_idx, code, lang = extract_code_block()
    if not code then
        print("No code block found")
        return
    end

    -- Create a new scratch buffer
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, code)
    vim.api.nvim_buf_set_option(buf, 'filetype', lang)
    vim.cmd("vsplit")
    vim.api.nvim_win_set_buf(0, buf)

    -- Set autocmd to sync changes back when buffer is closed or mode changes
    vim.api.nvim_create_autocmd("BufUnload", {
        buffer = buf,
        callback = function ()
			local new_code = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
			vim.fn.setreg('+', table.concat(new_code, '\n'))
			print("Code copied to clipboard")
		end,
    })
end

-- Function to run a given buffer's content in a terminal
M.run_tmpfile = function(content, language)
	-- local language  = language:match("^%s*(.-)%s*$") -- remove leading/trailing whitespaces
    local exec_cmd = run_cmds[language] or language

    -- Write content to a temp file
	local f_ext = ext[language]
    local tmp_file = fn.tempname() .. "_tmp." .. f_ext
    local tmp_handle = io.open(tmp_file, "w")
    if tmp_handle then
        tmp_handle:write(content)
        tmp_handle:close()
    else
        print("Error: Could not create temp file")
        return
    end

    -- Open terminal and run the script
    api.nvim_command(string.format(":tabnew | terminal %s %s", exec_cmd, tmp_file))

    -- Cleanup temp file after execution
    vim.defer_fn(function()
        os.remove(tmp_file)
    end, 5000)
end

vim.keymap.set("n", "<leader>r", function()
    local bufnr = api.nvim_get_current_buf()
    local ft = vim.bo[bufnr].filetype

    if vim.bo[bufnr].buftype == "nofile" then
		print("inside scratch buffer")
        local code = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
        local command = string.format('echo "%s" | %s', code, run_cmds[ft])
        M.run_tmpfile(code, ft) -- runs in a terminal, suitable to monitor print
        vim.cmd(string.format("w !%s", command))

    elseif ft == "markdown" or ft == "tex" then
		print("inside markdown or tex")
        local si, ei, code, language = extract_code_block()
        if code and language then
            M.run_tmpfile(code, language) -- runs in a terminal, suitable to monitor print
        else
            print("No valid code block found")
        end

    elseif ft == "julia" or ft == "python" or ft == "octave" or ft == "javascript" or ft == "sh" then
        local exec_cmd = run_cmds[ft] or ft
        api.nvim_command(string.format(":tabnew | terminal %s %s", exec_cmd, fn.expand("%:p")))
    end
end, { noremap = true, silent = true })

vim.api.nvim_create_user_command("ScratchCode", M.open_scratch, {})
vim.api.nvim_set_keymap("n", "<leader>sc", "open_scratch()<CR>", { noremap = true, silent = true })


