-- zotcite.config 
require('zotcite').setup({
    filetypes= {"markdown", "tex"},
    open_cmd = "/Applications/sioyek.app/Contents/MacOS/sioyek",
    hl_cite_key = true
})


-- obsidian-config
require('obsidian').setup({
	workspaces = {
		{
			name = "Notes",
			path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes"
		},
	},
	templates = { subdir = "Meta/Templates", },
	attachments = {
		img_folder = "Meta/Attachments",
		confirm_img_paste = true,
	},
	daily_notes = {
		folder = "Meta/Daily Document",
		date_format = "%Y-%m-%d",
		template = "dailyNotes.md"
	},
	picker = {
		name = "fzf-lua",
	},
	completion = {
		nvim_cmp = true,
		min_chars = 2,
	},
	note_id_func = function (title)
		return tostring(os.time())
	end,
	note_path_func = function (spec)
		local path = spec.dir / tostring(spec.title)
		return path:with_suffix(".md")
	end,
})


-- vimtex-config
vim.g.tex_flavor='latex'
vim.g.vimtex_view_method='sioyek'
vim.g.vimtex_view_sioyek_exe='/Applications/sioyek.app/Contents/MacOS/sioyek'
vim.g.vimtex_context_pdf_viewer='/Applications/sioyek.app/Contents/MacOS/sioyek'
vim.g.vimtex_callback_progpath='/Applications/nvim11/bin/nvim'
vim.g.vimtex_subfile_start_local=1
vim.g.vimtex_quickfix_mode=0
vim.g.vimtex_complete_ignore_case=1
vim.g.vimtex_complete_enabled=1
vim.g.vimtex_fold_enabled=1
vim.g.vimtex_syntax_enabled=1 		-- disable syntax conceal 
vim.g.tex_conceal = 'abdmgs'
vim.g.UltiSnipsExpandTrigger = '<tab>'
vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
vim.g.vim_markdown_math = 1
vim.g.vimtex_compiler_method = 'latexmk'	
vim.g.vimtex_compiler_latexmk = {
                options = {
                '-shell-escape',
                '-verbose',
                '-file-line-error',
                '-synctex=1',
                '-interaction=nonstopmode'
                }
            }

vim.g.mapleader = " "
vim.g.maplocalleader=","
vim.g.vimtex_log_ignore = {
	'Underfull',
	'Overfull',
	'specifier changed to',
	'Token not allowed in a PDF string',
}

