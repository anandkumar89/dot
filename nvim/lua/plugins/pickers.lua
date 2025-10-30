-- config.fzf 
	
local fzf_lua = require("fzf-lua")
fzf_lua.setup({
	'telescope',
	fzf_colors ={ true},
	winopts = {
		border = 'rounded',
		backdrop = 100,
	},
	-- hls	= {
	-- 	normal   = "FzfLuaNormal",
	-- 	border   = "FzfLuaBorder",
	-- 	backdrop = "FzfLuaBackdrop",
	-- },
})
 
-- -- telescope.config, used by zotcite probably!!
-- local telescope     = require('telescope')
-- local action_state  = require('telescope.actions.state')
-- local action_layout = require('telescope.actions.layout')
-- local actions 		= require('telescope.actions')
-- local job 			= require('plenary.job')
-- 
-- telescope.setup({
--     defaults = {
--         file_ignore_patterns = {".aux", ".fdb_latexmk", ".fls", ".log", ".git/.*", ".lock", ".gz", ".out", ".blg", ".bbl", ".bst", ".pdf"},
--         mappings = {
--             i = { ["<C-l>"] = action_layout.cycle_layout_next, },
--             n = { ["<l>"] = action_layout.cycle_layout_next,  },
--         },
--         layout_strategy = 'horizontal',
--         layout_config   = {height = 0.95 },
--     }
-- })

