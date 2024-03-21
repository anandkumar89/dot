local vim = vim 
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
    Plug 'preservim/vim-markdown'

    Plug 'jalvesaq/zotcite' 
    Plug 'jalvesaq/cmp-zotcite'
vim.call('plug#end')

require('cmp_zotcite').setup({
	filetypes = {"markdown"},
})





