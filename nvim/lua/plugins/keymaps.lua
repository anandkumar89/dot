local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


map('n', '<c-w>t', ':tabnew<CR>', opts)

-- vim.keymap.set("i", "<C-f>", "<Esc><cmd>exec 'r!inkscape-figures-manager new -f -d figures -l \"'.getline('.').'\"'<CR>")	

-- vim.api.nvim_set_keymap("n", "<leader>r", ":lua require('run_code_block').run_code_block()<CR>", { noremap = true, silent = true })

map("n", "<space><space>", ":", opts)

-- Quickfix navigation
map("n", "<leader>cn", ":cnext<CR>", opts)
map("n", "<leader>cr", ":cprev<CR>", opts)
map("n", "<leader>]", ":cn<CR>", opts)
map("n", "<leader>[", ":cp<CR>", opts)

-- Open links with gx
map("n", "gx", "<CMD>execute '!open ' .. shellescape(expand('<cfile>'), v:true)<CR>", opts)

-- Escape with jj in insert mode
map("i", "jj", "<ESC>", opts)

-- panes navigation including terminal-mode
	-- Normal mode pane navigation
		vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
		vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
		vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
		vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })

	-- Terminal mode pane navigation
		vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]], { noremap = true })
		vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]], { noremap = true })
		vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]], { noremap = true })
		-- vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]], { noremap = true }) -- conflicts with <c-l> : clear screen in terminal
	
	-- Teminal mode Escape 
		vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })

	-- vim-tmux-navigator.configs
		-- vim.keymap.set('n', '<c-w>h', '<cmd>TmuxNavigateLeft<cr>',     { silent = true })
		-- vim.keymap.set('n', '<c-w>j', '<cmd>TmuxNavigateDown<cr>',     { silent = true })
		-- vim.keymap.set('n', '<c-w>k', '<cmd>TmuxNavigateUp<cr>',       { silent = true })
		-- vim.keymap.set('n', '<c-w>l', '<cmd>TmuxNavigateRight<cr>',    { silent = true })
		-- vim.keymap.set('n', '<c-w>p', '<cmd>TmuxNavigatePrevious<cr>', { silent = true })

-- Movement and text manipulation
map("v", "=", "g_", opts)
map("n", "=", "g_", opts)
map("i", "<C-e>", "<C-o>A", opts)
map("i", "<C-a>", "<C-o>B", opts)
map("i", "<C-d>", "<C-o>0", opts)
map("i", "<C-s>", "<C-o>E<C-o>a", opts)

-- Common commands shortcuts
map("n", "<leader>wq", ":wq<CR>", opts)
map("n", "<leader>ww", ":w<CR>", opts)
map("n", "<leader>qq", ":q<CR>", opts)

-- EasyAlign
map("n", "ga", "<plug>(EasyAlign)", {})
map("x", "ga", "<plug>(EasyAlign)", {})

-- Folding
map("x", "<leader>f", ":<C-u>set foldmethod=manual<CR>:'<,'>fold<CR>", opts)
-- map('n', '<leader>so', ':source ~/.config/nvim/init.lua<CR>', {desc = "source neovim configuration"})  -- source init, do it manually.

---------------------- toolbox.lua 
-- copilot
vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-word)')
vim.keymap.set('i', '<C-O>', '<Plug>(copilot-next)')
vim.keymap.set('i', '<C-J>', '<Plug>(copilot-accept-line)')
vim.keymap.set('i', '<C-K>', '<Plug>(copilot-dismiss)')
vim.keymap.set('i', '<C-]>', '<Plug>(copilot-suggest)')

-- harpoon
vim.keymap.set('n', 'hx', require('harpoon.mark').add_file)
vim.keymap.set('n', 'hn', require('harpoon.ui').nav_next)
vim.keymap.set('n', 'hp', require('harpoon.ui').nav_prev)
vim.keymap.set('n', 'hb', require('harpoon.ui').toggle_quick_menu)

-- toggleterm
vim.keymap.set("n", "<localleader>tf", "<Cmd>exe v:count1 . 'ToggleTerm direction=float'<CR>", {silent=true})
vim.keymap.set("n", "<c-\\>", "<Cmd>exe v:count1 . 'ToggleTerm direction=vertical '<CR>", {silent=true})
vim.keymap.set("t", "<c-\\>", "<Cmd>exe v:count1 . 'ToggleTerm direction=vertical '<CR>", {silent=true})
vim.keymap.set("n", "<leader>tsl", ":ToggleTermSendCurrentLine<CR>", {silent=true})
vim.keymap.set("v", "<leader>tsl", ":'<,'>ToggleTermSendVisualLines<CR>", {silent=true})
vim.keymap.set({"t", "n"}, "<C-w>\\", ":ToggleTermToggleAll<CR>", {silent=true})

-- true-zen
vim.api.nvim_set_keymap("n", "<leader>zn", ":TZNarrow<CR>", {})
-- vim.api.nvim_set_keymap("v", "<leader>zn", ":'<,'>TZNarrow<CR>", {})
-- vim.api.nvim_set_keymap("n", "<leader>zf", ":TZFocus<CR>", {})
-- vim.api.nvim_set_keymap("n", "<leader>zm", ":TZMinimalist<CR>", {})
-- vim.api.nvim_set_keymap("n", "<leader>za", ":TZAtaraxis<CR>", {})


-- nvim-tree
vim.keymap.set("n", "<leader>nv", ":NvimTreeToggle<CR>")

-- gitsigns
vim.keymap.set('n', ']o', ':lua require"gitsigns".preview_hunk()<CR>')
vim.keymap.set('n', '[o', ':lua require"gitsigns".preview_hunk()<CR>')
vim.keymap.set('n', '<leader>hi', ':lua require"gitsigns".preview_hunk_inline()<CR>')
vim.keymap.set('n', 'g]', ':lua require"gitsigns".next_hunk()<CR>')
vim.keymap.set('n', 'g[', ':lua require"gitsigns".prev_hunk()<CR>')
vim.keymap.set('n', '<leader>hr', ':lua require"gitsigns".reset_hunk()<CR>')

--------------------------------------- mdtex.lua

-- obsidian
vim.keymap.set('n', '<leader>oo', ':ObsidianSearch<CR>')
vim.keymap.set('n', '<leader>os', ':ObsidianQuickSwitch<CR>')
vim.keymap.set('n', '<leader>or', ':ObsidianBacklinks<CR>')
vim.keymap.set('n', '<leader>ot', ':ObsidianNewFromTemplate<CR>')

-- zotcite (using telescope)
vim.keymap.set('n', '<leader>tz', ':Zseek<CR>', 			{desc = "Browse Zotero Library"})

-- vimtex
vim.keymap.set("n", "<localleader>v", ":VimtexView<CR>", {silent=true}, {desc = "Vimtex View PDF"})

-- undotree, lazygit*
vim.keymap.set('n', '<leader>uu', ':UndotreeToggle', {desc = "open/close Undo Tree"})
vim.keymap.set("n", "<leader>gg",  ":LazyGit<CR>", {silent=true, noremap=true}, {desc = "LazyGit"})

--------------------------------------- pickers.lua
-- fzf
vim.keymap.set('n', '<leader>tt', ':Fzf<CR>', 				{desc = "Fzf"})
vim.keymap.set('n', '<leader>te', ':FzfLua files cwd=%:p:h<CR>', 	{desc = "Browse Buffer Parent"})
vim.keymap.set('n', '<c-t>', ':FzfLua commands<CR>', 	{desc = "Commands"})
vim.keymap.set('n', '<leader>tg', ':FzfLua grep<CR>', 		{desc = "Live Grep cwd"})
vim.keymap.set('n', '<leader>tb', ':FzfLua buffers<CR>', 	{desc = "Open Buffers"})
vim.keymap.set('n', '<leader>to', ':FzfLua oldfiles formatter=path.filename_first<CR>', 	{desc ="Browse Old files"})
vim.keymap.set('n', '<leader>tf', ':FzfLua files<CR>',  	{desc = "Browse Files in cwd"})
vim.keymap.set('n', '<leader>ec', ':FzfLua files cwd=~/.config/nvim <CR>', {desc = '[s]earch [N]eovim files'})
vim.keymap.set('n', '<leader>eg', ':FzfLua live_grep ~/.config/nvim <CR>', {desc = '[g]rep [N]eovim files'})
vim.keymap.set('i', '<c-t>',      '<c-o>:Fzf commands<CR>', {desc = "Vim commands in insert mode"}) -- to insert filedatetime

-- telescope : reduce dependency in favor of fzf
