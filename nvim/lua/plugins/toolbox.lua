-- treesitter.config
-- require('nvim-treesitter.configs').setup {
--   ensure_installed = { "lua", "python", "typst" },  -- typst will be added manually
--   highlight = { enable = true },
-- }

--- copilot.config
vim.g.copilot_filetypes = {lua=true, tex=false, text=true, python=true, markdown=false}

--- harpoon.config	
require('harpoon').setup({
    menu = { width = 80, height=15 }
})

--- comment.config gc, gcc to toggle comment 
require('comment').setup()

--- zen.mode.config
require('true-zen').setup({
    modes = {
        ataraxis = {
            minimum_writing_area = { width=120}
        }
    }
})


require('notify').setup({
    render = "minimal",
    top_down = false,
    max_width = 80
})


-- require("chatgpt").setup()

-- autoclose.config (https://github.com/m4xshen/autoclose.nvim)
--		require('autoclose').setup()

-- whichkey.config
		-- require('which-key').setup()

-- nvim.surround.config
require('nvim-surround').setup({
    keymaps = {
        visual = "z"
    }
})

-- leap.config
require('leap').create_default_mappings()

-- toggleterm.config
require('toggleterm').setup({
    size = 60,
    hide_numbers = true,
    start_in_insert = false,
})

-- nvim-tree.config (netrw alternative) 
require('nvim-tree').setup({
    view = { width = 30,},
})

-- gitsigns.config 
require('gitsigns').setup({
    numhl = false,
    signcolumn = true,
})



-- Insert file creation time / custom
vim.api.nvim_create_user_command("InsertFileBirthTime", function()
    local filename = vim.fn.expand('%') -- Get current buffer's filename

    if filename == "" then
        print("No file associated with this buffer.")
        return
    end

    -- macOS/BSD command to get file birth (creation) time
    local cmd = string.format("date -r $(stat -f '%%B' %s) '+%%Y-%%m-%%d %%H:%%M:%%S'", vim.fn.shellescape(filename))
    local birth_time = vim.fn.system(cmd):gsub("\n", "") -- Run command & remove newline

    -- Insert at the current cursor position
    vim.api.nvim_put({ birth_time }, "c", true, true)
end, {})
