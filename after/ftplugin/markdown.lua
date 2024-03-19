local vim = vim 
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
Plug 'preservim/vim-markdown'

Plug'jalvesaq/cmp-zotcite'-- works for markdown only
Plug'hrsh7th/cmp-buffer'
Plug'hrsh7th/nvim-cmp'
Plug'hrsh7th/cmp-path'

Plug'jalvesaq/zotcite' -- works for markdown only

vim.call('plug#end')

local cmp = require('cmp')
cmp.setup {
	-- global config goes here
	sources = cmp.config.sources({
		{ name = 'buffer' },
		{ name = 'cmp_zotcite'},
		{ name = 'path'},
	}),
	mapping = cmp.mapping.preset.insert({
	     	['<C-b>'] = cmp.mapping.scroll_docs(-4),
	     	['<C-f>'] = cmp.mapping.scroll_docs(4),
	     	['<C-Space>'] = cmp.mapping.complete(),
	     	['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
}

require('cmp_zotcite').setup({
	filetypes = {"markdown"},
})

require('obsidian').setup({
	workspaces = {
		{
			name = "Notes",
			path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes"
		},
	},
	templates = {
		subdir = "Meta/Templates"
	},
	daily_notes = {
		folder = "Meta/Daily Document",
		date_format = "%Y-%m-%d",
		template = "dailyNotes.md"
	},
	completion = {
		nvim_cmp = true,
		min_chars = 2,
	}
})



-- vim.cmd("call vimtex#init()")
-- vim.cmd("call vimtex#text_obj#init_buffer()")
-- 
-- vim.api.nvim_buf_set_keymap(0, 'o', 'id', '<plug>(vimtex-id)', {silent = true})
-- vim.api.nvim_buf_set_keymap(0, 'o', 'ad', '<plug>(vimtex-ad)', {silent = true})
-- vim.api.nvim_buf_set_keymap(0, 'x', 'id', '<plug>(vimtex-id)', {silent = true})
-- vim.api.nvim_buf_set_keymap(0, 'x', 'ad', '<plug>(vimtex-ad)', {silent = true})



