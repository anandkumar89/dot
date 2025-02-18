local vim = vim
local Plug = vim.fn['plug#']

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
-- vim.treesitter.language.disable['tex'] = true


vim.call('plug#begin', '~/.config/nvim/plugged')
		-- Plug '~/.config/nvim/plugged/zotero'
		Plug 'jeffkreeftmeijer/vim-numbertoggle'
		Plug 'junegunn/vim-easy-align'
		Plug 'mbbill/undotree'
		Plug 'akinsho/toggleterm.nvim'
		Plug 'kylechui/nvim-surround'
		Plug 'ggandor/leap.nvim'
		Plug 'ThePrimeagen/harpoon'
		Plug 'folke/which-key.nvim' --wanted only for spell, runs all the time
		-- Plug 'm4xshen/autoclose.nvim'
		Plug 'nvim-tree/nvim-tree.lua'
		Plug 'L3MON4D3/LuaSnip'
		Plug 'numToStr/Comment.nvim'
		Plug 'github/copilot.vim'

		Plug 'lervag/vimtex'
		Plug 'honza/vim-snippets' -- someday look into what it does, 
		Plug 'micangl/cmp-vimtex'
		Plug 'SirVer/ultisnips'   -- currently have tex, md snippets

		Plug '~/.config/nvim/plugged/figures-manager' -- creating and inserting figures in md, tex
		Plug 'rcarriga/nvim-notify'

		Plug 'nvim-telescope/telescope.nvim'
			-- Plug 'nvim-telescope/telescope-bibtex.nvim' -- allows searching and inserting citations in md, tex files, extend it to open files in sioyek | removed in favor of zotcite's Zseek (yet to configure opening in sioyek)
			Plug 'nvim-telescope/telescope-file-browser.nvim'
			Plug "isak102/telescope-git-file-history.nvim"
			Plug 'tpope/vim-fugitive'
			Plug 'lewis6991/gitsigns.nvim'

		Plug 'tpope/vim-obsession'

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
		Plug 'projekt0n/github-nvim-theme'
		-- Plug 'f-person/auto-dark-mode.nvim' --works by creating a background job, just toggle manually

		Plug 'JuliaEditorSupport/julia-vim'
		Plug 'kdheepak/JuliaFormatter.vim' -- languageserver.jl already supports this! maynot want to use. Check with coc-julia
		Plug 'jpalardy/vim-slime'
vim.call('plug#end')

--- copilot.config
		vim.g.copilot_filetypes = {lua=true, tex=false, text=true, python=true, markdown=false}
		vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-word)')
		vim.keymap.set('i', '<C-O>', '<Plug>(copilot-next)')
		vim.keymap.set('i', '<C-J>', '<Plug>(copilot-accept-line)')
		vim.keymap.set('i', '<C-K>', '<Plug>(copilot-dismiss)')
		vim.keymap.set('i', '<C-]>', '<Plug>(copilot-suggest)')

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
		-- vim.api.nvim_set_keymap("v", "<leader>zn", ":'<,'>TZNarrow<CR>", {})
		-- vim.api.nvim_set_keymap("n", "<leader>zf", ":TZFocus<CR>", {})
		-- vim.api.nvim_set_keymap("n", "<leader>zm", ":TZMinimalist<CR>", {})
		-- vim.api.nvim_set_keymap("n", "<leader>za", ":TZAtaraxis<CR>", {})

		require('notify').setup({
			render = "minimal",
			top_down = false,
			max_width = 80
		})

		-- require("chatgpt").setup()

-- autoclose.config (https://github.com/m4xshen/autoclose.nvim)
--		require('autoclose').setup()

-- zotcite.config 
	require('zotcite').setup({
		filetypes= {"markdown", "tex"},
		open_cmd = "/Applications/sioyek.app/Contents/MacOS/sioyek"
	})
	require('cmp_zotcite').setup({
		filetypes= {"markdown"}
	})

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
		vim.keymap.set("n", "<localleader>tf", "<Cmd>exe v:count1 . 'ToggleTerm direction=float'<CR>", {silent=true})
		vim.keymap.set("n", "<c-\\>", "<Cmd>exe v:count1 . 'ToggleTerm direction=vertical '<CR>", {silent=true})
		vim.keymap.set("t", "<c-\\>", "<Cmd>exe v:count1 . 'ToggleTerm direction=vertical '<CR>", {silent=true})


-- telescope.config
		-- local bibtex_actions = require('telescope-bibtex.actions')
		local action_state  = require('telescope.actions.state')
		local action_layout = require('telescope.actions.layout')
		local actions 		= require('telescope.actions')
		local job 			= require('plenary.job')
		require('telescope').setup({
			defaults = {
				file_ignore_patterns = {
					".aux", ".fdb_latexmk", ".fls", ".log", ".git/.*", ".lock", ".gz", ".out", ".blg", ".bbl", ".bst", ".pdf"
				},
				mappings = {
					i = {
							["<C-l>"] = action_layout.cycle_layout_next,
					},
					n = {
							["<C-l>"] = action_layout.cycle_layout_next,
					}
				},
				layout_strategy = 'horizontal',
				layout_config   = {height = 0.95 },
			}
			-- extensions = {
			-- 	bibtex = {
			-- 		depth=2,
			-- 		format='plain',
			-- 		global_files = {'~/Dropbox/Apps/Overleaf/bib/library.bib'},
			-- 		search_keys = {'author', 'year', 'title'},
			-- 		context = true,
			-- 		mappings = {
			-- 			  i = {
			-- 					["<C-o>"] = bibtex_actions.key_append('%s'), -- format is determined by filetype if the user has not set it explictly
			-- 					["<C-e>"] = bibtex_actions.entry_append,
			-- 					["<C-c>"] = bibtex_actions.citation_append('{{author}} ({{year}}), {{title}}.'),
			-- 					["<CR>"] = function(prompt_bufnr)
			-- 									local entry = action_state.get_selected_entry().id.content
			-- 									-- local files = {} -- TODO handle multiple files, show harpoon like UI to select file
			-- 									-- local extensions = {}
			-- 									actions.close(prompt_bufnr)
			-- 									entry = table.concat(entry, "\n")
			--
			-- 									-- -- Iterate over each substring separated by ';'
			-- 									-- for filename in fileString:gmatch("[^;]+") do
			-- 									--     -- Check if the file extension is '.pdf'
			-- 									--     if filename:match("%.pdf$") then
			-- 									--         -- Store the first PDF file and break the loop
			-- 									--         firstPDF = filename
			-- 									--         break
			-- 									--     end
			-- 									-- end
			-- 									for paths in entry:gmatch("file%s*=%s*{([^}]+)}") do
			-- 										for path in paths:gmatch("[^,]+") do
			-- 											path = vim.trim(path)
			-- 											local ext  = path:match("^.+%.(.+)$")
			-- 											-- table.insert(files, path)
			-- 											-- table.insert(extensions,ext)
			-- 											if ext == "pdf" then
			-- 													job:new({
			-- 													  command = "/Applications/sioyek.app/Contents/MacOS/sioyek",
			-- 													  args = { path },
			-- 													  detached = true,
			-- 													}):start()
			-- 													break
			-- 											end
			-- 										end
			-- 									end
			-- 							  end,
			-- 				  }
			-- 			 },
			-- 		wrap = false,
			-- 		}
			-- }
		})
		-- require('telescope').load_extension("bibtex")
		require("telescope").load_extension("git_file_history")
		-- require("telescope").load_extension("zotero") -- TODO someday handling zotero database better than zotcite?

		-- telescope.keymaps 
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>tt', ':Telescope<CR>', {})
			vim.keymap.set('n', '<leader>tc', builtin.commands, {})
			vim.keymap.set('n', '<leader>tg', builtin.live_grep, {desc = "Live Grep cwd"})
			vim.keymap.set('n', '<leader>tb', builtin.buffers, {desc = "Open Buffers"})
			vim.keymap.set("n", "<leader>tz", ":Zseek<CR>", {desc = "Browse Zotero Library"})
			vim.keymap.set('n', '<leader>to', builtin.oldfiles, {desc ="Browse Old files"})
			vim.keymap.set('n', '<leader>tf', builtin.find_files, {desc = "Browse Files in cwd"})
			vim.keymap.set("n", "<leader>te", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
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
		vim.keymap.set("n", "<leader>td", find_directory_and_focus)
		vim.keymap.set("n", "<leader>nv", ":NvimTreeToggle<CR>")


-- obsidian-config
		require('obsidian').setup({
			workspaces = {
				{
					name = "Notes",
					path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes"
				},
			},
			templates = {
				subdir = "Meta/Templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
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
		-- vim.keymap.set('n', '<leader>ot', ':ObsidianToday<CR>')
		vim.keymap.set('n', '<leader>or', ':ObsidianBacklinks<CR>')
		vim.keymap.set('n', '<leader>ot', ':ObsidianNewFromTemplate<CR>')

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


-- gitsigns.config 
	require('gitsigns').setup({
		numhl = true,
		signcolumn = false,
	})
	vim.keymap.set('n', '<leader>go', ':lua require"gitsigns".preview_hunk()<CR>')
	vim.keymap.set('n', '<leader>gn', ':lua require"gitsigns".next_hunk()<CR>')
	vim.keymap.set('n', '<leader>gp', ':lua require"gitsigns".prev_hunk()<CR>')
	vim.keymap.set('n', '<leader>gr', ':lua require"gitsigns".reset_hunk()<CR>')

-- cmp-config
		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		local luasnip = require('luasnip')
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
				{ name = 'buffer', keyword_length=2, max_item_count=5},
				{ name = 'nvim_lsp', keyword_length=2 }
				-- { name = 'nvim_lsp',
				-- 	option = {
				-- 		markdown_oxide = {
				-- 	  		keyword_pattern = [[\(\k\| \|\/\|#\)\+]]
				-- 		}
				-- 	}
				-- },
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
						mode 		= 'symbol',
						preset 		= 'default',
						show_labelDetails = true,
						maxwidth	= 50,
						ellipsis_char= '..',
				})
			},
			snippet = {
				expand = function (args)
					luasnip.lsp_expand(args.body)
				end
			}
		}
		cmp.setup.filetype("tex", {
		  sources = {
				{ name = 'vimtex', max_item_count = 10},
				{ name = 'buffer', keyword_length=2, max_item_count=5},
				{ name = 'nvim_lsp'},
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
		-- require('lspconfig').texlab.setup({
		-- 		on_attach = function (client, bufnr)
		-- 				ih.on_attach(client, bufnr)
		-- 		end
		-- })
		require('mason').setup({})
		require('mason-lspconfig').setup({})
		-- require("lspconfig").markdown_oxide.setup({
		-- 	-- capabilities = capabilities, -- ensure that capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
		-- 	root_dir = lspconfig.util.root_pattern('.git', vim.fn.getcwd()), -- this is a temp fix for an error in the lspconfig for this LS
		-- })


-- illustrate-config
		local illustrate = require('illustrate')
		local illustrate_finder = require('illustrate.finder')
		vim.keymap.set('n', '<leader>fc', function() illustrate.create_and_open_svg() end, {})
		vim.keymap.set('n', '<leader>fo', function() illustrate.open_under_cursor() end, {})
		vim.keymap.set('n', '<leader>fs', function() illustrate_finder.search_create_copy_and_open() end, {})

-- vimtex-config
		vim.keymap.set('n', '<leader>uu', ':UndotreeToggle')
		vim.keymap.set("n", "<leader>gg",  ":LazyGit<CR>", {silent=true, noremap=true})
		vim.keymap.set("n", "<localleader>v", ":VimtexView<CR>", {silent=true})
		vim.g.tex_flavor='latex'
		vim.g.vimtex_view_method='sioyek'
		vim.g.vimtex_view_sioyek_exe='/Applications/sioyek.app/Contents/MacOS/sioyek'
		vim.g.vimtex_context_pdf_viewer='/Applications/sioyek.app/Contents/MacOS/sioyek'
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

		vim.g.mapleader = ";"
		vim.g.maplocalleader=","

-- colorscheme : follow system

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
					colorscheme = "github_dark_tritanopia",
					highlight = [[
						highlight MatchParen cterm=reverse ctermfg=none ctermbg=none guifg=crimson guibg=none
						highlight LineNr guifg=#424242
					]],
					mode_cmd = 'osascript -e \'tell application "System Events" to tell appearance preferences to set dark mode to true\'',
					alac_cmd = "sed -i '' 's/github_light/github_dark/' ~/.config/alacritty.toml"
				},
				light = {
					colorscheme = "github_light_tritanopia",
					highlight = [[
						highlight MatchParen cterm=reverse ctermfg=none ctermbg=none guifg=black guibg=lightblue
						highlight LineNr guifg=#e7e7e7
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

-- general keymaps 
		-- edit files 
		vim.keymap.set('n', '<leader>so', ':so ~/.config/nvim/init.lua<CR>')  -- source init
		vim.keymap.set('n', '<c-w>t', ':tabnew<CR>')

		-- vim.keymap.set('n', '<TAB>', function() 
		--		return "m`"..vim.v.count.."gt``"
		--	end, {expr = true}) 										 -- switching tabs 
		-- vim.keymap.set('n', '<S-TAB>',':tabprevious<CR>', {silent=true}) -- switching tabs 

		-- vim.keymap.set("i", "<C-f>", "<Esc><cmd>exec 'r!inkscape-figures-manager new -f -d figures -l \"'.getline('.').'\"'<CR>")


vim.opt.termguicolors = true
vim.cmd([[
		let 		g:markdown_fenced_languages = ['tex', 'python', 'julia']
		set 		relativenumber
		set 		ruler 
		set			scl=number
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
		set			foldlevel=1

		nnoremap	<silent> 	<leader>cn		:cnext<CR>
		nnoremap	<silent> 	<leader>cr		:cprev<CR>
		nnoremap 	gx 			<CMD>execute '!open ' .. shellescape(expand('<cfile>'), v:true)<CR>
		inoremap 	jj			<esc>
		vnoremap 	= 			g_
		nnoremap 	= 			g_
		inoremap 	<c-e> 		<c-o>A
		inoremap 	<c-a> 		<c-o>B
		inoremap 	<c-d>  		<c-o>0
		inoremap 	<c-s> 		<c-o>E<c-o>a
		nnoremap 	<leader>] 	:cn<CR>
		nnoremap 	<leader>[ 	:cp<CR>
		noremap   	;wq   		:wq<CR>
		noremap   	;ww 		:w<CR>
		noremap   	;qq 		:q<CR>
		nmap 		ga 			<plug>(EasyAlign)
		xnoremap 	<leader>f	:<C-u>set foldmethod=manual<CR>:'<,'>fold<CR>
		xmap 		ga 			<plug>(EasyAlign)

		" highlight iCursor guifg=white guibg=steelblue
		" hi texCmd guifg=#51477a guibg=NONE gui=NONE ctermfg=127 ctermbg=NONE cterm=NONE
		hi texCmd guifg=#8679b5 guibg=NONE gui=NONE ctermfg=127 ctermbg=NONE cterm=NONE
		" highlight CursorLineNr guifg=#ff0000
		" highlight SignColumn guibg=NONE
		set cul
		hi! link texMathEnvArgName texEnvArgName
		hi! link texMathZone LocalIdent
		hi! link texMathZoneEnv texMathZone
		hi! link texMathZoneEnvStarred texMathZone
		hi! link texMathZoneX texMathZone
		hi! link texMathZoneXX texMathZone
		hi! link texMathZoneEnsured texMathZone
		hi! link QuickFixLine Normal

		" hi! link qfLineNr Normal
		" hi! link EndOfBuffer LineNr
		" hi! link Conceal LocalIdent
		" hi Search cterm=NONE ctermfg=black ctermbg=yellow
]])

-- Non-Italics Comments 
-- Get current `Comment` highlight settings
local comment_hl = vim.api.nvim_get_hl_by_name('Comment', true)

-- Apply `italic = false` but keep the current color and other settings
vim.api.nvim_set_hl(0, 'Comment', {
    fg = comment_hl.foreground,
    bg = comment_hl.background,
    sp = comment_hl.special,
    bold = comment_hl.bold,
    italic = false,  -- Remove italics
    underline = comment_hl.underline,
    undercurl = comment_hl.undercurl,
})

