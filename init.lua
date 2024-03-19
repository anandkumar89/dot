local vim = vim 
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

Plug 'lervag/vimtex'
Plug 'honza/vim-snippets' -- someday look into what it does, 
Plug 'SirVer/ultisnips' -- currently have tex, md snippets
Plug 'neoclide/coc.nvim' 

Plug '~/.config/nvim/plugged/illustrate.nvim' -- creating and inserting figures in md, tex

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-bibtex.nvim' -- allows searching and inserting citations in md, tex files, extend it to open files in sioyek

Plug 'epwalsh/obsidian.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'catppuccin/nvim'
Plug 'lunacookies/vim-colors-xcode'
vim.call('plug#end')

-- telescope setup
local bibtex_actions = require('telescope-bibtex.actions')
require('telescope').setup({
	defaults = {
		file_ignore_patterns = {
			".aux", ".fdb_latexmk", ".fls", ".log", ".git/.*", ".lock", ".gz", ".out", ".blg", ".bbl"
		},
		layout_strategy = 'vertical',
		layout_config   = {height = 0.95 },
	},
	extensions = {
		bibtex = {
			depth=2,
			format='plain',
			search_keys = {'author', 'year', 'title'},
			context = true,
			mappings = {
				  i = {
					["<CR>"] = bibtex_actions.key_append('%s'), -- format is determined by filetype if the user has not set it explictly
				    	["<C-e>"] = bibtex_actions.entry_append,
				    	["<C-c>"] = bibtex_actions.citation_append('{{author}} ({{year}}), {{title}}.'),
				      }
				 },
			wrap = true,
			}
		    }
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
})

vim.keymap.set('n', '<leader>oo', ':ObsidianSearch<CR>') 
vim.keymap.set('n', '<leader>os', ':ObsidianQuickSwitch<CR>') 
vim.keymap.set('n', '<leader>ot', ':ObsidianToday<CR>') 



local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>tt', ':Telescope<CR>', {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


local illustrate = require('illustrate')
vim.keymap.set('n', '<leader>fc', function() illustrate.create_and_open_svg() end, {})
vim.keymap.set('n', '<leader>fs', function() illustrate.search_and_open() end, {})
vim.keymap.set('n', '<leader>fo', function() illustrate.open_under_cursor() end, {})



-- let mapleader = ","
vim.g.tex_flavor='latex'
vim.g.vimtex_view_method='sioyek'
vim.g.vimtex_view_sioyek_exe='/Applications/sioyek.app/Contents/MacOS/sioyek'
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

vim.g.mapleader = ";"
vim.g.maplocalleader=","

-- coc-nvim triggers (moved to cmp-nvim, while installing zotcite, setup for vimtex also)
vim.cmd([[
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap jj	<esc>
inoremap <c-e> 	<c-o>A
inoremap <c-a> 	<c-o>B
inoremap <c-s> 	<c-o>E<c-o>a
set 		ruler 
set 		splitright
set 		splitbelow
set 		vb t_vb=
set 		conceallevel=2
setlocal 	spell
set 		spelllang=en_us
set 		noswapfile
set 		wmh=0
set 		hlsearch
set 		nowrap 
set 		linebreak
set 		relativenumber
]])


vim.keymap.set('n', '<leader>ec', ':tabnew $MYVIMRC<CR>', {silent=true}) -- edit init file
vim.keymap.set('n', '<leader>es', ':tabnew ~/.config/nvim/UltiSnips/tex.snippets<CR>', {silent=true}) 
vim.keymap.set('n', '<leader>mo', ':set mouse=<CR>')
vim.keymap.set('n', '<leader>md', ':set mouse=a<CR>')
vim.keymap.set('n', '<leader>so', ':so ~/.config/nvim/init.lua<CR>')
vim.keymap.set('n', '<leader>co', ':cd ~/Library/CloudStorage/Dropbox/Apps/Overleaf<CR>')
vim.keymap.set('n', '<leader>ee', ':Vexplore<CR>')
vim.keymap.set('n', '<leader>st', ':set syntax=tex')

vim.keymap.set('n', '<c-k>', ':wincmd k<CR>', {silent=true}) -- switching panes 
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>', {silent=true}) -- switching panes 
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>', {silent=true}) -- switching panes 
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>', {silent=true}) -- switching panes
vim.keymap.set('n', '<TAB>', function() 
		return "m`"..vim.v.count.."gt``"
	end, {expr = true}) -- switching tabs 
vim.keymap.set('n', '<S-TAB>',':tabprevious<CR>', {silent=true}) -- switching tabs 

vim.keymap.set('n', '=', '$')  -- moving to end =
vim.keymap.set('v', '=', '$')  -- moving to end =
vim.keymap.set('n', '<localleader>v', '<plug>(vimtex-view)')   -- Open PDF file for tex


-- set background=dark
-- colorscheme rosepine
vim.cmd('colorscheme xcode')
vim.cmd('hi texCmd guifg=#51477a guibg=NONE gui=NONE ctermfg=98 ctermbg=NONE cterm=NONE')
vim.cmd('hi! link texMathEnvArgName texEnvArgName')
vim.cmd('hi! link texMathZone LocalIdent')
vim.cmd('hi! link texMathZoneEnv texMathZone')
vim.cmd('hi! link texMathZoneEnvStarred texMathZone')
vim.cmd('hi! link texMathZoneX texMathZone')
vim.cmd('hi! link texMathZoneXX texMathZone')
vim.cmd('hi! link texMathZoneEnsured texMathZone')
vim.cmd('hi Search cterm=NONE ctermfg=black ctermbg=yellow')
vim.cmd('hi! link QuickFixLine Normal')
vim.cmd('hi! link qfLineNr Normal')
vim.cmd('hi! link EndOfBuffer LineNr')
vim.cmd('hi! link Conceal LocalIdent')
