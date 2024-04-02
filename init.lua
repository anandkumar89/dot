local vim = vim 
local Plug = vim.fn['plug#']

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- vim.opt.termguicolors = true

vim.call('plug#begin', '~/.config/nvim/plugged')
		Plug 'junegunn/vim-easy-align'
		Plug 'jeffkreeftmeijer/vim-numbertoggle'
		Plug 'mbbill/undotree'
		Plug 'kdheepak/lazygit.nvim'
		Plug 'tpope/vim-surround'
		Plug 'akinsho/toggleterm.nvim'
		Plug 'ggandor/lightspeed.nvim'
		Plug 'folke/which-key.nvim'
		Plug 'nvim-tree/nvim-tree.lua'	
--				Plug 'nvim-tree/nvim-web-devicons'

		Plug 'lervag/vimtex'
		Plug 'honza/vim-snippets' -- someday look into what it does, 
		Plug 'SirVer/ultisnips'   -- currently have tex, md snippets
		Plug 'micangl/cmp-vimtex' 

		-- Plug '~/.config/nvim/plugged/illustrate.nvim' -- creating and inserting figures in md, tex
		Plug 'rpapallas/illustrate.nvim'
		Plug 'rcarriga/nvim-notify'

		Plug 'nvim-telescope/telescope.nvim'
		Plug 'nvim-telescope/telescope-bibtex.nvim' -- allows searching and inserting citations in md, tex files, extend it to open files in sioyek
		Plug 'nvim-telescope/telescope-file-browser.nvim'
		Plug 'axkirillov/easypick.nvim'

		-- LSP thingy
		Plug 'neovim/nvim-lspconfig'
		Plug 'VonHeikemen/lsp-zero.nvim'
		Plug 'williamboman/mason-lspconfig.nvim'
		Plug 'williamboman/mason.nvim'
		Plug 'hrsh7th/nvim-cmp'
			Plug 'hrsh7th/cmp-buffer'
			Plug 'hrsh7th/cmp-path'    
			Plug 'hrsh7th/cmp-nvim-lsp'
			Plug 'onsails/lspkind.nvim'

		-- markdown, obsidian specific plugins
		Plug 'epwalsh/obsidian.nvim'
		Plug 'jalvesaq/zotcite' 
			Plug 'nvim-lua/plenary.nvim'
			Plug 'jalvesaq/cmp-zotcite'

		Plug 'catppuccin/nvim'
		Plug 'lunacookies/vim-colors-xcode'
		Plug 'mhartington/oceanic-next'
		Plug 'cocopon/iceberg.vim'
		Plug 'navarasu/onedark.nvim'
		-- Plug 'f-person/auto-dark-mode.nvim' --works by creating a background job, just toggle manually

		Plug 'JuliaEditorSupport/julia-vim'
		Plug 'kdheepak/JuliaFormatter.vim' -- languageserver.jl already supports this! maynot want to use. Check with coc-julia
		Plug 'jpalardy/vim-slime'
vim.call('plug#end')

-- nvim-tree.config (netrw alternative) 
		require('nvim-tree').setup({
				view = { width = 30,}, 
		})

-- whichkey.config
		require('which-key').setup()

-- lightspeed.config
		require('lightspeed').setup({
				ignore_case=true, 
		})

-- toggleterm.config
		require('toggleterm').setup()
		vim.keymap.set("n", "<c-t>", "<Cmd>ToggleTermToggleAll<CR>")
		vim.keymap.set("t", "<c-t>", "<Cmd>ToggleTermToggleAll<CR>")
		vim.keymap.set("n", "<leader>tf", "<Cmd>ToggleTerm direction=float name=nvim<CR>", {silent=true})

-- telescope.config
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

-- obsidian-config
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

		vim.keymap.set('n', '<leader>oo', ':ObsidianSearch<CR>') 
		vim.keymap.set('n', '<leader>os', ':ObsidianQuickSwitch<CR>') 
		vim.keymap.set('n', '<leader>ot', ':ObsidianToday<CR>') 
		vim.keymap.set('n', '<leader>ob', ':ObsidianBacklinks<CR>') 


-- cmp-config
		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		local lspkind = require('lspkind')	
		local cmp = require('cmp')
		cmp.setup {
			-- global config goes here
			preselect = 'item',
			completion = {
				 completeopt = 'menu,menuone,noinsert' 	
		    },
			sources = cmp.config.sources({
				{ name = 'path', max_item_count=4},
				{ name = 'cmp_zotcite', max_item_count=5},
				{ name = 'buffer', keyword_length=2, max_item_count=3},
				{ name = 'nvim_lsp'},
			}),
			mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			formatting = {
				format = lspkind.cmp_format({
						mode 		= 'symbol',
						preset 		= 'default',
						show_labelDetails = true,
						maxwidth	= 50,
						ellipsis_char= '..',
				})	
			},
			snippets = {
				expand = function (args) 
					vim.fn["vsnip#anonymous"](args.body)
				end
			}
		}
		cmp.setup.filetype("tex", {
		  sources = {
			{ name = 'vimtex', max_item_count = 5},
			{ name = 'buffer', max_item_count = 10},
			{ name = 'nvim_lsp', max_item_count = 5}
		  },
		})

-- lsp-config
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


-- telescope-config
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>te', ':Telescope<CR>', {})
		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
		vim.keymap.set("n", "<leader>ee", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")


-- illustrate-config
		local illustrate = require('illustrate')
		local illustrate_finder = require('illustrate.finder')
		vim.keymap.set('n', '<leader>fc', function() illustrate.create_and_open_svg() end, {})
		vim.keymap.set('n', '<leader>fo', function() illustrate.open_under_cursor() end, {})
		vim.keymap.set('n', '<leader>fs', function() illustrate_finder.search_create_copy_and_open() end, {})

-- vimtex-config
		vim.keymap.set('n', '<localleader>v', '<plug>(vimtex-view)')   -- Open PDF file for tex
		vim.keymap.set('n', '<leader>uu', ':UndotreeToggle')

		vim.g.tex_flavor='latex'
		vim.g.vimtex_view_method='sioyek'
		vim.g.vimtex_view_sioyek_exe='/Applications/sioyek.app/Contents/MacOS/sioyek'
		vim.g.vimtex_callback_progpath='/Applications/nvim-macos/bin/nvim'
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

-- lazygit-config
		vim.keymap.set("n", "<leader>gg",  ":LazyGit<CR>", {silent=true, noremap=true})

vim.g.mapleader = ";"
vim.g.maplocalleader=","

-- edit files 
vim.keymap.set('n', '<leader>ec', ':tabnew $MYVIMRC<CR>', {silent=true}) -- edit init file
vim.keymap.set('n', '<leader>so', ':so ~/.config/nvim/init.lua<CR>')  -- source init

vim.keymap.set('n', '<c-w>t', ':tabnew<CR>')
vim.keymap.set('n', '<TAB>', function() 
		return "m`"..vim.v.count.."gt``"
	end, {expr = true}) 										 -- switching tabs 
vim.keymap.set('n', '<S-TAB>',':tabprevious<CR>', {silent=true}) -- switching tabs 

vim.cmd([[
set 		cmdheight=0	
set 		relativenumber
set 		signcolumn=number
set 		ruler 
set 		splitright
set 		splitbelow
set 		vb t_vb=
set 		conceallevel=2
" setlocal 	spell
set 		spelllang=en_us
set 		noswapfile
set 		wmw=0
set 		hlsearch
set 		nowrap 
set 		linebreak
set 		tabstop=4

nnoremap gx <CMD>execute '!open ' .. shellescape(expand('<cfile>'), v:true)<CR>
inoremap jj	<esc>
vnoremap = 		g_
nnoremap = 		g_
inoremap <c-e> 		<c-o>A
inoremap <c-a> 		<c-o>B
inoremap <c-d>  	<c-o>0
inoremap <c-s> 		<c-o>E<c-o>a
nmap 	 <c-k> 		:wincmd k<CR>
nmap	 <c-j>		:wincmd j<CR>
nmap 	 <c-h>		:wincmd h<CR>
nmap 	 <c-l>		:wincmd l<CR>
noremap   ;wq   :wq<CR>
noremap   ;ww 	:w<CR>
noremap   ;qq 	:q<CR>
]])

-- set background=dark
-- colorscheme rosepine
vim.cmd('colorscheme xcode')
vim.cmd('hi texCmd guifg=#51477a guibg=NONE gui=NONE ctermfg=127 ctermbg=NONE cterm=NONE')
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

