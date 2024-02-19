" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" On-demand loading
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

" setup for latex
Plug 'lervag/vimtex'
	let g:tex_flavor='latex'
	let g:vimtex_view_method='skim'
	let g:vimtex_quickfix_mode=0
	let g:vimtex_complete_enabled=1
	let g:vimtex_fold_enabled=1	
	let g:vimtex_syntax_enabled=1 		" disable syntax conceal 

" Plug 'neoclide/coc.nvim' , {'do': { -> coc#util#install()}}   " autocompletion using coc
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
	let g:UltiSnipsExpandTrigger = '<tab>'
	let g:UltiSnipsJumpForwardTrigger = '<tab>'
	let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

Plug 'arzg/vim-colors-xcode'



" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

" coc-nvim triggers 
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"




inoremap <C-e> <C-o>A "


setlocal spell
set spelllang=en_us

nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

set noswapfile
set wmh=0
set hlsearch

" localleader for vimtex 
let maplocalleader = ","
nmap <localleader>v <plug>(vimtex-view)   " Open PDF file for tex

"""""""""" theming
colorscheme xcodedark
" VimTeX highlight groups
hi texCmd guifg=#ad3da4 guibg=NONE gui=NONE ctermfg=127 ctermbg=NONE cterm=NONE
hi! link texMathEnvArgName texEnvArgName
hi! link texMathZone LocalIdent
hi! link texMathZoneEnv texMathZone
hi! link texMathZoneEnvStarred texMathZone
hi! link texMathZoneX texMathZone
hi! link texMathZoneXX texMathZone
hi! link texMathZoneEnsured texMathZone
hi Search cterm=NONE ctermfg=black ctermbg=yellow
" Small tweaks
hi! link QuickFixLine Normal
hi! link qfLineNr Normal
hi! link EndOfBuffer LineNr
hi! link Conceal LocalIdent
