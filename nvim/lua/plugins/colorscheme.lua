
-------------------------------- colorscheme : follow system

vim.opt.termguicolors = true
require("transparent").setup({
  -- table: default groups
  groups = {
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
    'EndOfBuffer',
  },
  -- table: additional groups that should be cleared
  extra_groups = {},
  -- table: groups you don't want to clear
  exclude_groups = {},
  -- function: code to be executed after highlight groups are cleared
  -- Also the user event "TransparentClear" will be triggered
  on_clear = function() end,
})

local function is_dark_mode()
	local handle = io.popen('defaults read -g AppleInterfaceStyle 2>/dev/null')
	local result = handle:read("*a")
	handle:close()
	return result:match("Dark") and "dark" or "light"
end

function set_color_scheme(bg)
	if is_setting_colorscheme then return end
	is_setting_colorscheme = true

	bg = bg or is_dark_mode()

	local themes = {
		dark = {
			colorscheme = "no-clown-fiesta",
			highlight = [[
				highlight MatchParen cterm=reverse ctermfg=none ctermbg=none guibg=gray
				highlight LineNr guifg=#424242
			]],
			mode_cmd = 'osascript -e \'tell application "System Events" to tell appearance preferences to set dark mode to true\'',
			alac_cmd = "sed -i '' 's/github_light/github_dark/' ~/.config/alacritty.toml"
		},
		light = {
			colorscheme = "catppuccin-latte",
			highlight = [[
				highlight MatchParen cterm=reverse ctermfg=none ctermbg=none guifg=black guibg=lightblue
				highlight LineNr guifg=#e7e7e7
				highlight Comment guifg=#e0e0e0 
			]],
			mode_cmd = 'osascript -e \'tell application "System Events" to tell appearance preferences to set dark mode to false\'',
			alac_cmd = "sed -i '' 's/github_dark/github_light/' ~/.config/alacritty.toml"
		}
	}

	local theme = themes[bg]
	if theme then
		vim.cmd("colorscheme " .. theme.colorscheme)
		vim.cmd(theme.highlight)
		io.popen(theme.mode_cmd):close()
		io.popen(theme.alac_cmd):close()
	else
		vim.notify("Invalid background option: " .. bg, vim.log.levels.WARN)
	end

	is_setting_colorscheme = false
end

-- Autocommand to sync with Neovim's background setting
vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	callback = function()
		if not is_setting_colorscheme then
			set_color_scheme(vim.o.background)
		end
	end,
})

set_color_scheme()


-- ------------------------------- writing 
-- dim text text color (I do not want bright white text when writing)
-- vim.cmd('highlight EasyReadColor_0 guifg=#6f6f6f gui=NONE')
-- vim.cmd('highlight EasyReadColor_1 guifg=#00ffff gui=NONE')
-- vim.cmd('highlight EasyReadColor_2 guifg=#00ffff gui=NONE')
require('easyread').setup{
    hlValues = {
        ['1'] = 1,
        ['2'] = 1,
        ['3'] = 2,
        ['4'] = 2,
        ['fallback'] = 0.4
    },
    hlgroupOptions = { link = 'Bold' },
    fileTypes = { 'text' },
    saccadeInterval = 0,
    saccadeReset = false,
    updateWhileInsert = true
}

-- setup twilight
require("twilight").setup {
	dimming = {
		alpha = 0.3, -- amount of dimming
	},
	context = 8, -- number of lines we will try to show around the current line
	-- treesitter = true, -- use treesitter when available for the filetype
	expand = { -- for treesitter, we can expand the 'visible' text object
		'function',
		'method',
		'table',
	},
	-- exclude = {}, -- exclude these filetypes
}

-- -------------------------------   Highlights 

--  non-italic comment, retain other highlights
local hlc = vim.api.nvim_get_hl_by_name('Comment', true)
vim.api.nvim_set_hl(0, 'Comment', {
    fg        = hlc.foreground,
    bg        = hlc.background,
    sp        = hlc.special,
    bold      = hlc.bold,
    italic    = false,         -- main line
    underline = hlc.underline,
    undercurl = hlc.undercurl,
})


-- vim.api.nvim_set_hl(0, "iCursor", { fg = "white", bg = "steelblue" })
-- vim.api.nvim_set_hl(0, "QuickFixLine", { link = "Normal" })

-- Linking highlight groups, tex / vimtex
vim.api.nvim_set_hl(0, "texCmd", 				{ fg = "#8679b5", bg = "NONE", italic = false })
vim.api.nvim_set_hl(0, "texMathEnvArgName", 	{ link = "texEnvArgName" })
vim.api.nvim_set_hl(0, "texMathZone", 			{ link = "Normal" })
vim.api.nvim_set_hl(0, "texMathZoneEnv",        { link = "texMathZone" })
vim.api.nvim_set_hl(0, "texCmdGreek",           { link = "texMathZone" })
vim.api.nvim_set_hl(0, "Conceal",               { link = "texMathZone" })
vim.api.nvim_set_hl(0, "texMathZoneEnvStarred", { link = "texMathZone" })
vim.api.nvim_set_hl(0, "texMathZoneX",          { link = "texMathZone" })
vim.api.nvim_set_hl(0, "texMathZoneXX",         { link = "texMathZone" })
vim.api.nvim_set_hl(0, "texMathZoneEnsured",    { link = "texMathZone" })

-- If fzf uses a floating window (optional)
vim.api.nvim_set_hl(0, "FzfLuaBackdrop", { bg = "none" })
vim.api.nvim_set_hl(0, "FzfLuaNormal",   { bg = "none" })
vim.api.nvim_set_hl(0, "FzfLuaBorder",   { bg = "none" })

