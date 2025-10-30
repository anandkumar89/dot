
-- custom-floating-todo
function open_floating_task_file(filepath)
    -- The file to open (change this to your specific file path)
    local file_path = vim.fn.expand(filepath)  -- Replace with your file

    -- Create a new buffer
    local buf = vim.api.nvim_create_buf(false, true)

    -- Define window dimensions and position
    local width = math.floor(vim.o.columns * 0.6)  -- 60% of screen width
    local height = math.floor(vim.o.lines * 0.6)  -- 60% of screen height
    local row = math.floor((vim.o.lines - height) / 2)  -- Center the window vertically
    local col = math.floor((vim.o.columns - width) / 2) -- Center the window horizontally

    -- Set window options for the floating window
    local opts = {
        style = "minimal",
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        border = "rounded"  -- Rounded border for aesthetics
    }

    -- Open the window with the buffer
    vim.api.nvim_open_win(buf, true, opts)

    -- Load the file into the buffer
    vim.cmd("edit " .. file_path)

    -- Optional: Set buffer options (e.g., make it non-modifiable)
    vim.api.nvim_buf_set_option(buf, 'modifiable', true)

    -- Set keybinding to close the floating window by pressing 'q'
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':w | :bd! | :q<CR>', { noremap = true, silent = true })

    -- Make sure the buffer gets written when dismissed
    vim.api.nvim_create_autocmd('BufWriteCmd', {
        buffer = buf,
        callback = function()
            vim.cmd('write')  -- Write the buffer when closing
        end
    })
end

vim.api.nvim_set_keymap('n', '<leader>ft', ':lua open_floating_task_file("~/Desktop/Overleaf/status.md")<CR>', { noremap = true, silent = true })

