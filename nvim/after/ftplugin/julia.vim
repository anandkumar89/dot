let g:latex_to_unicode_auto = 1
let g:latex_to_unicode_tab  = 0
let g:latex_to_unicode_cmd_mapping = ['<C-j>']

nnoremap <leader>jf	:<C-u>call JuliaFormatter#Format(0)<CR>
nnoremap <leader>jf 	:<C-u>call JuliaFormatter#Format(1)<CR>

let g:JuliaFormatter_options = { 
			\'style' : 'blue', 
			\}


let g:slime_default_config = {"sessionname":"jl", "windowname":"0"}
let g:slime_dont_ask_default = 1
let g:slime_call_demlimiter = "#%%"
nmap 	<leader>r 	<Plug>SlimeSendCell

