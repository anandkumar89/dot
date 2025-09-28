local vim = vim
local Plug = vim.fn['plug#']

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.call('plug#begin', '~/.config/nvim/plugged')
-- toolbox.lua
	Plug 'jeffkreeftmeijer/vim-numbertoggle'
	Plug 'junegunn/vim-easy-align'
	Plug 'mbbill/undotree'
	Plug 'akinsho/toggleterm.nvim'
	Plug 'kylechui/nvim-surround'
	Plug 'ggandor/leap.nvim'
	Plug 'ThePrimeagen/harpoon'
	-- Plug 'folke/which-key.nvim' --wanted only for spell, runs all the time
	Plug 'nvim-tree/nvim-tree.lua'
	-- Plug 'L3MON4D3/LuaSnip' 
	Plug 'numToStr/Comment.nvim'
	Plug 'github/copilot.vim'
	Plug 'tpope/vim-fugitive'
	Plug 'lewis6991/gitsigns.nvim'
	-- Plug 'nvim-treesitter/nvim-treesitter' --installed when using typst, not using now.
	Plug 'christoomey/vim-tmux-navigator'

-- picker.lua
	Plug '/usr/local/opt/fzf'
	Plug 'ibhagwan/fzf-lua'
	-- Plug 'nvim-telescope/telescope.nvim' -- used only by zotcite : not using now. moved to Fzf-lua

	Plug 'lervag/vimtex'
	Plug 'SirVer/ultisnips'   -- currently have tex, md snippets
	Plug 'honza/vim-snippets' -- someday look into what it does, 
	Plug 'micangl/cmp-vimtex' -- cmp.source
	Plug 'hrsh7th/cmp-cmdline' -- cmp.source


	Plug '~/.config/nvim/plugged/figures-manager' -- creating and inserting figures in md, tex
	Plug 'rcarriga/nvim-notify'

-- LSP & Completion
	Plug 'neovim/nvim-lspconfig'
	Plug 'williamboman/mason-lspconfig.nvim'
	Plug 'williamboman/mason.nvim'
	Plug 'VonHeikemen/lsp-zero.nvim'

	Plug 'onsails/lspkind.nvim'				-- adds icons in cmp
	Plug 'lvimuser/lsp-inlayhints.nvim'		-- adds inlayhints for lsp
	Plug 'hrsh7th/nvim-cmp'					-- the cmp provider	
	Plug 'hrsh7th/cmp-buffer'				-- cmp.source : buffer completion
	Plug 'hrsh7th/cmp-path'					-- cmp.source : path completion
	Plug 'hrsh7th/cmp-nvim-lsp'				-- cmp.source : lsp completion


-- markdown, obsidian specific plugins
	Plug 'nvim-lua/plenary.nvim'
	Plug 'epwalsh/obsidian.nvim'
	Plug '~/.config/nvim/plugged/zotcite'
	Plug '~/.config/nvim/plugged/cmp-zotcite'
	Plug 'iamcco/markdown-preview.nvim'


	Plug 'pocco81/true-zen.nvim'
	Plug 'catppuccin/nvim'
	Plug 'aktersnurra/no-clown-fiesta.nvim'
	Plug 'lunacookies/vim-colors-xcode'
	Plug 'projekt0n/github-nvim-theme'
	Plug 'preservim/vim-colors-pencil'
	Plug 'aktersnurra/no-clown-fiesta.nvim'
	Plug "xiyaowong/transparent.nvim"

	Plug "goolord/alpha-nvim" -- dashboard

	-- better writing
	Plug "preservim/vim-pencil"
	Plug "reedes/vim-pencil"
	Plug "JellyApple102/easyread.nvim"
	Plug 'folke/twilight.nvim'
	Plug 'folke/zen-mode.nvim'

	-- julia development
	Plug 'JuliaEditorSupport/julia-vim'
	-- Plug 'kdheepak/JuliaFormatter.vim' -- languageserver.jl already supports this! maynot want to use. Check with coc-julia
vim.call('plug#end')

require("plugins.options")		-- ~/.config/nvim/lua/plugins/options.lua
require("plugins.toolbox")		-- ~/.config/nvim/lua/plugins/toolbox.lua
require("plugins.pickers")		-- ~/.config/nvim/lua/plugins/pickers.lua
require("plugins.mdtex")		-- ~/.config/nvim/lua/plugins/mdtex.lua
require("plugins.lspcmp")		-- ~/.config/nvim/lua/plugins/lspcmp.lua
require("plugins.floatingtodo")	-- ~/.config/nvim/lua/plugins/floatingtodo.lua
require("plugins.colorscheme")	-- ~/.config/nvim/lua/plugins/colorscheme.lua
require("plugins.keymaps")		-- ~/.config/nvim/lua/plugins/keymaps.lua

-- require("brightness").setup()	-- ~/.config/nvim/lua/brightness.lua (provides )
require("open_code_block")		-- ~/.config/nvim/lua/open_code_block.lua
require("search")				-- ~/.config/nvim/lua/search.lua
require("commands")				-- ~/.config/nvim/lua/commands.lua
-- ftplugin : ~/.config/nvim/after/ftplugin
-- lua scr	: ~/.config/nvim/lua


vim.api.nvim_create_user_command("GitLogLoclist", function()
  local file = vim.fn.expand("%")
  local cmd = "git log --pretty=format:'%h %ad %s' --date=short " .. file
  vim.fn.setloclist(0, vim.fn.systemlist(cmd))
  vim.cmd("lopen")
end, {})

vim.api.nvim_create_user_command('CitedSearch', 'lua require("cited_search").search()', {})


require('refactor') -- probably not needed : '<,'>!gemini -p "prompt" does the same job
