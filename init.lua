local vim = vim 
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'mbbill/undotree'

Plug 'lervag/vimtex'
Plug 'honza/vim-snippets' -- someday look into what it does, 
Plug 'SirVer/ultisnips' -- currently have tex, md snippets
-- Plug 'neoclide/coc.nvim' 

Plug '~/.config/nvim/plugged/illustrate.nvim' -- creating and inserting figures in md, tex

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-bibtex.nvim' -- allows searching and inserting citations in md, tex files, extend it to open files in sioyek
Plug 'axkirillov/easypick.nvim'


-- LSP thingy
Plug 'neovim/nvim-lspconfig'
Plug 'VonHeikemen/lsp-zero.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'    
    Plug 'hrsh7th/cmp-nvim-lsp'

-- markdown, obsidian specific plugins
Plug 'epwalsh/obsidian.nvim'
Plug 'jalvesaq/zotcite' 
 	Plug 'preservim/vim-markdown'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'jalvesaq/cmp-zotcite'

Plug 'catppuccin/nvim'
Plug 'lunacookies/vim-colors-xcode'	
-- Plug 'f-person/auto-dark-mode.nvim' --works by creating a background job, just toggle manually

Plug 'JuliaEditorSupport/julia-vim'
Plug 'kdheepak/JuliaFormatter.vim' -- languageserver.jl already supports this! maynot want to use. Check with coc-julia
Plug 'jpalardy/vim-slime'
vim.call('plug#end')

-- telescope setup
local bibtex_actions = require('telescope-bibtex.actions')
require('telescope').setup({
	defaults = {
		file_ignore_patterns = {
			".aux", ".fdb_latexmk", ".fls", ".log", ".git/.*", ".lock", ".gz", ".out", ".blg", ".bbl", ".bst", ".pdf"
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
	completion = {
		nvim_cmp = true,
		min_chars = 2,
	}

})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 40
local MIN_LABEL_WIDTH = 20
local cmp = require('cmp')
cmp.setup {
	-- global config goes here
	sources = cmp.config.sources({
		{ name = 'buffer' },
		{ name = 'cmp_zotcite'},
		{ name = 'path'},
		{ name = 'nvim_lsp'},
	}),
	mapping = cmp.mapping.preset.insert({
	     	['<C-b>'] = cmp.mapping.scroll_docs(-4),
	     	['<C-f>'] = cmp.mapping.scroll_docs(4),
	     	['<C-Space>'] = cmp.mapping.complete(),
	     	['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	formatting = {
		format = function(entry, vim_item)
				local label = vim_item.abbr
				local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
				if truncated_label ~= label then
				  vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
				elseif string.len(label) < MIN_LABEL_WIDTH then
				  local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
				  vim_item.abbr = label .. padding
				end
				return vim_item
		end,
	},

}


local lsp = require('lsp-zero')

lsp.on_attach(function(client, bufnr)
		local opts = {buffer = bufnr, remap=false}
		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
		vim.keymap.set("n", "K",  function() vim.lsp.buf.hover() end, opts)
		vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
		vim.keymap.set("n", "<leader>vd",  function() vim.diagnostic.open_float() end, opts)
		vim.keymap.set("n", "[d",          function() vim.diagnostic.goto_prev() end, opts)
		vim.keymap.set("n", "]d",  		   function() vim.diagnostic.goto_next() end, opts)
		vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
		vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.rename() end, opts)
end)

require('mason').setup({})
require('mason-lspconfig').setup({
		ensure_installed = {},
		handlers = {
				lsp.default_setup,
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

-- vimtex
vim.keymap.set('n', '<localleader>v', '<plug>(vimtex-view)')   -- Open PDF file for tex

vim.g.tex_flavor='latex'
vim.g.vimtex_view_method='sioyek'
vim.g.vimtex_view_sioyek_exe='/Applications/sioyek.app/Contents/MacOS/sioyek'
vim.g.vimtex_quickfix_mode=0
vim.g.vimtex_complete_ignore_case=1	
vim.g.vimtex_complete_enabled=1
vim.g.vimtex_fold_enabled=0	
vim.g.vimtex_syntax_enabled=1 		-- disable syntax conceal 
vim.g.tex_conceal = 'abdmgs'
vim.g.UltiSnipsExpandTrigger = '<tab>'
vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
vim.g.vim_markdown_math = 1

vim.g.mapleader = ";"
vim.g.maplocalleader=","


--inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
vim.cmd([[
inoremap jj	<esc>
inoremap <c-e> 	<c-o>A
inoremap <c-a> 	<c-o>B
inoremap <c-d>  <c-o>0
inoremap <c-s> 	<c-o>E<c-o>a
noremap   ;; 	:
set 		ruler 
set 		splitright
set 		splitbelow
set 		vb t_vb=
set 		conceallevel=2
setlocal 	spell
set 		spelllang=en_us
set 		noswapfile
set 		wmw=0
set 		hlsearch
set 		nowrap 
set 		linebreak
set 		relativenumber
set 		tabstop=4
]])

-- movement in insert mode
vim.keymap.set('n', '=', '$')  -- moving to end =
vim.keymap.set('v', '=', '$')  -- moving to end =

-- edit files 
vim.keymap.set('n', '<leader>ec', ':tabnew $MYVIMRC<CR>', {silent=true}) -- edit init file
vim.keymap.set('n', '<leader>es', ':tabnew ~/.config/nvim/UltiSnips/tex.snippets<CR>', {silent=true}) 

vim.keymap.set('n', '<leader>mo', ':set mouse=<CR>')  	-- mouse mode exit
vim.keymap.set('n', '<leader>md', ':set mouse=a<CR>')	-- mouse mode enter

vim.keymap.set('n', '<leader>so', ':so ~/.config/nvim/init.lua<CR>')  -- source init
vim.keymap.set('n', '<leader>ee', ':Vexplore<CR>') 	-- explore Netrw
vim.keymap.set('n', '<leader>st', ':set syntax=tex')	-- set syntax to tex, as hack when typing in math in markdown

-- switch tabs and panes 
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>', {silent=true}) -- switching panes 
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>', {silent=true}) -- switching panes 
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>', {silent=true}) -- switching panes 
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>', {silent=true}) -- switching panes
vim.keymap.set('n', '<TAB>', function() 
		return "m`"..vim.v.count.."gt``"
	end, {expr = true}) -- switching tabs 
vim.keymap.set('n', '<S-TAB>',':tabprevious<CR>', {silent=true}) -- switching tabs 


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
