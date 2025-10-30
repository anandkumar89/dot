vim.g.markdown_fenced_languages = { "tex", "python", "julia" }

vim.opt.relativenumber = false-- Equivalent to 'set nornu'
vim.opt.numberwidth = 2
vim.opt.signcolumn = "yes:1" -- Equivalent to 'set scl=yes:1'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.visualbell = true
vim.opt.conceallevel = 2

vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.cursorline = true 

vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.swapfile = false

vim.opt.undofile = true                    			-- Enable persistent undo
vim.opt.undodir = vim.fn.expand("~/.config/.undo") 	-- Set undo directory
