local vim = vim 
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
		Plug 'lervag/vimtex'
		Plug 'honza/vim-snippets' -- someday look into what it does, 
		Plug 'SirVer/ultisnips'   -- currently have tex, md snippets
		Plug 'micangl/cmp-vimtex' 
		Plug 'hrsh7th/nvim-cmp'
vim.call('plug#end')
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
		vim.g.mapleader = ";"
		vim.g.maplocalleader=","

vim.cmd([[
		set 		cmdheight=0	
		set 		relativenumber
		set 		signcolumn=number
		set 		vb t_vb=
		set 		conceallevel=2
		setlocal 	spell
		set 		spelllang=en_us
		set 		noswapfile
		set 		wmw=0
		set 		hlsearch
		set 		nowrap 
		set 		linebreak
		set 		tabstop=4
		set			shiftwidth=4
		set 		foldlevel=99  		" dont fold when file is opened
		inoremap jj	<esc>
		vnoremap = 		g_
		nnoremap = 		g_
		inoremap <c-e> 		<c-o>A
		inoremap <c-a> 		<c-o>B
		inoremap <c-d>  	<c-o>0
		inoremap <c-s> 		<c-o>E<c-o>a
		noremap   ;wq   :wq<CR>
		noremap   ;ww 	:w<CR>
		set laststatus=0
		hi! link StatusLine Normal
		set 		ruler 
		hi! link StatusLineNC Normal
		set statusline=%{repeat('─',winwidth('.'))}
]])



