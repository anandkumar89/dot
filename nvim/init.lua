local vim = vim
local Plug = vim.fn['plug#']

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.call('plug#begin', '~/.config/nvim/plugged')
		Plug 'jeffkreeftmeijer/vim-numbertoggle'
		Plug 'junegunn/vim-easy-align'
		Plug 'mbbill/undotree'
		Plug 'tpope/vim-surround'
		Plug 'kdheepak/lazygit.nvim'
		Plug 'akinsho/toggleterm.nvim'
		Plug 'ggandor/lightspeed.nvim'
		Plug 'ThePrimeagen/harpoon'
		Plug 'folke/which-key.nvim' --wanted only for spell, runs all the time
		-- Plug 'm4xshen/autoclose.nvim'
		Plug 'nvim-tree/nvim-tree.lua'
		Plug 'L3MON4D3/LuaSnip'
		Plug 'numToStr/Comment.nvim'

		Plug 'lervag/vimtex'
		Plug 'honza/vim-snippets' -- someday look into what it does, 
		Plug 'micangl/cmp-vimtex'
		Plug 'SirVer/ultisnips'   -- currently have tex, md snippets

		Plug '~/.config/nvim/plugged/figures-manager' -- creating and inserting figures in md, tex
		Plug 'rcarriga/nvim-notify'

		Plug 'nvim-telescope/telescope.nvim'
		Plug 'nvim-telescope/telescope-bibtex.nvim' -- allows searching and inserting citationste in md, tex files, extend it to open files in sioyek
		Plug 'nvim-telescope/telescope-file-browser.nvim'

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
			Plug 'lvimuser/lsp-inlayhints.nvim'

		-- markdown, obsidian specific plugins
		Plug 'epwalsh/obsidian.nvim'
		Plug 'jalvesaq/zotcite'
			Plug 'nvim-lua/plenary.nvim'
			Plug 'jalvesaq/cmp-zotcite'
			Plug 'preservim/vim-markdown'

		Plug 'pocco81/true-zen.nvim'
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


--- harpoon.config	
		require('harpoon').setup({
			menu = { width = 80, height=15 }
		})
			vim.keymap.set('n', 'hx', require('harpoon.mark').add_file)
			vim.keymap.set('n', 'hn', require('harpoon.ui').nav_next)
			vim.keymap.set('n', 'hp', require('harpoon.ui').nav_prev)
			vim.keymap.set('n', 'hb', require('harpoon.ui').toggle_quick_menu)

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
		vim.api.nvim_set_keymap("n", "<leader>zn", ":TZNarrow<CR>", {})
		vim.api.nvim_set_keymap("v", "<leader>zn", ":'<,'>TZNarrow<CR>", {})
		vim.api.nvim_set_keymap("n", "<leader>zf", ":TZFocus<CR>", {})
		vim.api.nvim_set_keymap("n", "<leader>zm", ":TZMinimalist<CR>", {})
		vim.api.nvim_set_keymap("n", "<leader>za", ":TZAtaraxis<CR>", {})

		require('notify').setup()

		-- require("chatgpt").setup()

-- autoclose.config (https://github.com/m4xshen/autoclose.nvim)
--		require('autoclose').setup()


-- whichkey.config
		require('which-key').setup()

-- lightspeed.config
		require('lightspeed').setup({
				ignore_case=true,
		})

-- toggleterm.config
		require('toggleterm').setup({
			size = 80,
			hide_numbers = true,
			start_in_insert = true,
		})
		vim.keymap.set("n", "<leader>tf", "<Cmd>exe v:count1 . 'ToggleTerm direction=float'<CR>", {silent=true})
		vim.keymap.set("n", "<c-\\>", "<Cmd>exe v:count1 . 'ToggleTerm direction=vertical'<CR>", {silent=true})
		vim.keymap.set("t", "<c-\\>", "<Cmd>exe v:count1 . 'ToggleTerm direction=vertical'<CR>", {silent=true})


-- telescope.config
		local bibtex_actions = require('telescope-bibtex.actions')
		local action_state  = require('telescope.actions.state')
		local actions 		= require('telescope.actions')
		local job 			= require('plenary.job')
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
					global_files = {'~/Dropbox/Apps/Overleaf/bib/online.bib', '~/Dropbox/Apps/Overleaf/bib/library.bib'},
					search_keys = {'author', 'year', 'title'},
					context = true,
					mappings = {
						  i = {
								["<C-o>"] = bibtex_actions.key_append('%s'), -- format is determined by filetype if the user has not set it explictly
								["<C-e>"] = bibtex_actions.entry_append,
								["<C-c>"] = bibtex_actions.citation_append('{{author}} ({{year}}), {{title}}.'),
								["<CR>"] = function(prompt_bufnr)
												local entry = action_state.get_selected_entry().id.content
												-- local files = {} -- TODO handle multiple files, show harpoon like UI to select file
												-- local extensions = {}
												actions.close(prompt_bufnr)
												entry = table.concat(entry, "\n")
												for paths in entry:gmatch("file%s*=%s*{([^}]+)}") do
													for path in paths:gmatch("[^,]+") do
														path = vim.trim(path)
														local ext  = path:match("^.+%.(.+)$")
														-- table.insert(files, path)
														-- table.insert(extensions,ext)
														if ext == "pdf" then
																job:new({
																  command = "/Applications/sioyek.app/Contents/MacOS/sioyek",
																  args = { path },
																  detached = true,
																}):start()
																break
														end
													end
												end
										  end,
							  }
						 },
					wrap = true,
					}
					}
		})
		require('telescope').load_extension("bibtex")

		-- telescope.keymaps 
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>te', ':Telescope<CR>', {})
			vim.keymap.set('n', '<leader>to', builtin.commands, {})
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = "Browse Files in cwd"})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc = "Live Grep cwd"})
			vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = "Open Buffers"})
			vim.keymap.set("n", "<leader>fz", ":Telescope bibtex<CR>", {desc = "Browse Zotero Library"})
			vim.keymap.set("n", "<leader>ee", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
			vim.keymap.set("n", "<leader>ec", function ()
				builtin.find_files { cwd = vim.fn.stdpath 'config' }
			end, {desc = '[s]earch [N]eovim files'})

-- nvim-tree.config (netrw alternative) 
			require('nvim-tree').setup({
					view = { width = 30,},
			})
			function find_directory_and_focus()
				local actions = require("telescope.actions")
				local action_state = require("telescope.actions.state")
				local function open_nvim_tree(prompt_bufnr, _)
				  actions.select_default:replace(function()
				    local api = require("nvim-tree.api")
				    actions.close(prompt_bufnr)
				    local selection = action_state.get_selected_entry()
				    api.tree.open()
				    api.tree.find_file(selection.cwd .. "/" .. selection.value)
				  end)
				  return true
				end
				require("telescope.builtin").find_files({
					find_command = { "fd", "--type", "directory", "--hidden", "--exclude", ".git/*", "" },
				  attach_mappings = open_nvim_tree,
				})
			end
			vim.keymap.set("n", "<leader>fd", find_directory_and_focus)


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
			attachments = {
				img_folder = "Meta/Attachments",
				confirm_img_paste = true,
			},
			daily_notes = {
				folder = "Meta/Daily Document",
				date_format = "%Y-%m-%d",
				template = "dailyNotes.md"
			},
			completion = {
				nvim_cmp = true,
				min_chars = 2,
			},
			note_id_func = function (title)
				return title
			end
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
						-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
						mode 		= 'symbol_text',
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
		local ih  = require('lsp-inlayhints')

		lsp.on_attach(function(client, bufnr)
				local opts = {buffer = bufnr, remap=false}
				vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
				vim.keymap.set("n", "K",  function() vim.lsp.buf.hover() end, opts)
				vim.keymap.set("n", "<leader>vd",  function() vim.diagnostic.open_float() end, opts)
				vim.keymap.set("n", "[d",          function() vim.diagnostic.goto_prev() end, opts)
				vim.keymap.set("n", "]d",  		   function() vim.diagnostic.goto_next() end, opts)
				vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
				vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
				vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.rename() end, opts)
		end)
		require('lspconfig').texlab.setup({
				on_attach = function (client, bufnr)
						ih.on_attach(client, bufnr)
				end
		})
		require('mason').setup({})
		require('mason-lspconfig').setup({
				ensure_installed = {},
				handlers = {
						lsp.default_setup,
				},
		})



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
		vim.g.vimtex_compiler_latexmk = {
								  options = {
								    '-shell-escape',
								    '-verbose',
								    '-file-line-error',
								    '-synctex=1',
								    '-interaction=nonstopmode'
								  }
								}

-- lazygit-config
		vim.keymap.set("n", "<leader>gg",  ":LazyGit<CR>", {silent=true, noremap=true})

		vim.g.mapleader = ";"
		vim.g.maplocalleader=","

-- general keymaps 
		-- edit files 
		vim.keymap.set('n', '<leader>so', ':so ~/.config/nvim/init.lua<CR>')  -- source init
		vim.keymap.set('n', '<c-w>t', ':tabnew<CR>')

		-- vim.keymap.set('n', '<TAB>', function() 
		--		return "m`"..vim.v.count.."gt``"
		--	end, {expr = true}) 										 -- switching tabs 
		-- vim.keymap.set('n', '<S-TAB>',':tabprevious<CR>', {silent=true}) -- switching tabs 

		-- vim.keymap.set("i", "<C-f>", "<Esc><cmd>exec 'r!inkscape-figures-manager new -f -d figures -l \"'.getline('.').'\"'<CR>kkkkkkddjjjf{a")


vim.opt.termguicolors = true
vim.cmd([[
		let 		g:markdown_fenced_languages = ['tex', 'python', 'julia']
		set 		cmdheight=0	
		set 		relativenumber
		set 		signcolumn=number
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
		set 		wrap 
		set 		linebreak
		set 		tabstop=4
		set			shiftwidth=4
		set 		foldlevel=99  		" dont fold when file is opened
		set			bg=light
		
		nnoremap gx <CMD>execute '!open ' .. shellescape(expand('<cfile>'), v:true)<CR>
		inoremap jj	<esc>
		vnoremap = 		g_
		nnoremap = 		g_
		inoremap <c-e> 		<c-o>A
		inoremap <c-a> 		<c-o>B
		inoremap <c-d>  	<c-o>0
		inoremap <c-s> 		<c-o>E<c-o>a
		tnoremap 	 <Esc>		<c-\><c-n>
		nnoremap <leader>] :cn<CR>
		nnoremap <leader>[ :cp<CR>
		imap 	 <c-k> 		<Esc>:wincmd k<CR>i
		imap	 <c-j>		<Esc>:wincmd j<CR>i
		imap 	 <c-h>		<Esc>:wincmd h<CR>i
		imap 	 <c-l>		<Esc>:wincmd l<CR>i
		tmap 	 <c-k> 		<Esc>:wincmd k<CR>
		tmap	 <c-j>		<Esc>:wincmd j<CR>
		tmap 	 <c-h>		<Esc>:wincmd h<CR>
		tmap 	 <c-l>		<Esc>:wincmd l<CR>
		nmap 	 <c-k> 		:wincmd k<CR>
		nmap	 <c-j>		:wincmd j<CR>
		nmap 	 <c-h>		:wincmd h<CR>
		nmap 	 <c-l>		:wincmd l<CR>
		noremap   ;wq   :wq<CR>
		noremap   ;ww 	:w<CR>
		noremap   ;qq 	:q<CR>
		colorscheme xcode
		highlight MatchParen cterm=bold ctermfg=none ctermbg=none guifg=black guibg=lightblue
		"highlight iCursor guifg=white guibg=steelblue
		hi texCmd guifg=#51477a guibg=NONE gui=NONE ctermfg=127 ctermbg=NONE cterm=NONE
		hi! link texMathEnvArgName texEnvArgName
		hi! link texMathZone LocalIdent
		hi! link texMathZoneEnv texMathZone
		hi! link texMathZoneEnvStarred texMathZone
		hi! link texMathZoneX texMathZone
		hi! link texMathZoneXX texMathZone
		hi! link texMathZoneEnsured texMathZone
		hi! link QuickFixLine Normal
		hi! link qfLineNr Normal
		hi! link EndOfBuffer LineNr
		hi! link Conceal LocalIdent
		hi Search cterm=NONE ctermfg=black ctermbg=yellow
]])

