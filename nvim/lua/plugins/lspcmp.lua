-- lsp.config 
	require('mason').setup()

	-- Add cmp_nvim_lsp capabilities settings to lspconfig
	-- This should be executed before you configure any language server
	local lspconfig_defaults = require('lspconfig').util.default_config
	lspconfig_defaults.capabilities = vim.tbl_deep_extend('force',
		lspconfig_defaults.capabilities,
		require('cmp_nvim_lsp').default_capabilities()
	)
	-- local ih  = require('lsp-inlayhints')

	vim.api.nvim_create_autocmd('LspAttach', {
	  desc = 'LSP actions',
	  callback = function(event)
		local opts = {buffer = event.buf}
		vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
		vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
		vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
		vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
		vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
		vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
		-- vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
		vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
		vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
		vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
	  end,
	})

	require('lspconfig').pyright.setup({})
	require('lspconfig').julials.setup({})
	require('lspconfig').lua_ls.setup({})
	require('lspconfig').texlab.setup({})
	require('lspconfig').jsonls.setup({})
	require("lspconfig")["tinymist"].setup {
		settings = {
				formatterMode = "typstyle",
				exportPdf = "onType",
				semanticTokens = "disable"
			}
	}


-- cmp.config
	local kind_icons = {
		Class         = "󰠱",
		Color         = "󰏘",
		Constant      = "󰏿",
		Constructor   = "",
		Enum          = "",
		EnumMember    = "",
		Event         = "",
		Field         = "󰜢",
		File          = "󰈙",
		Folder        = "󰉋",
		Function      = "󰊕",
		Interface     = "",
		Keyword       = "󰌋",
		Method        = "󰆧",
		Module        = "",
		Operator      = "󰆕",
		Property      = "󰜢",
		Reference     = "",
		Snippet       = "",
		Struct        = "",
		Text          = "",
		TypeParameter = "",
		Unit          = "",
		Value         = "󰎠",
		Variable      = "",
	}

	local function formatter(entry, item)
		if entry.source.name == "omni" then
		  item.kind = "Ѵ"
		  return item
		end

		item.kind = kind_icons[item.kind] .. " "
		item.menu = ({
		  buffer = "[buf]",
		  nvim_lsp = "[lsp]",
		  nvim_lua = "[lua]",
		  ultisnips = "[snip]",
		  vimtex = "[tex]",
		  cmp_zotcite = "[zot]",
		  obsidian = "[o.cmp]",
		  obsidian_new = "[o.new]",
		  obsidian_tags = "[o.tag]",
		})[entry.source.name]
		if not item.menu then
		  item.menu = string.format("[%s]", entry.source.name)
		end

		return item
	end

	local cmp = require('cmp')
	cmp.setup({ sources = {} })
	cmp.setup.filetype("tex", {
		sources = {
			{ name = 'vimtex', max_item_count = 10},
			{ name = 'nvim_lsp', keyword_length=2 },
			{ name = 'buffer', keyword_length=2, max_item_count=5},
			{ name = 'path', max_item_count=4},
		},
	})
	cmp.setup.filetype("markdown", {
		sources = {
			{ name = 'cmp_zotcite', keyword_length=2, max_item_count=10},
			{ name = 'buffer', keyword_length=2, max_item_count=5},
			{ name = 'path', max_item_count=4},
		},
	})
	cmp.setup {
		preselect = 'item',
		completion = {
			 completeopt = 'menu,menuone,noinsert'
		},
		sources = cmp.config.sources({
			{ name = 'nvim_lsp', keyword_length=2 },
			{ name = 'buffer', keyword_length=2, max_item_count=5},
			{ name = 'path', max_item_count=4},
		}),
		formatting = { format = formatter },
		mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<CR>'] = cmp.mapping.confirm({ select = false }), -- automatically fill selected item (true, false)
		}),
		snippet = {
			expand = function (args)
				vim.snippet.expand(args.body)
			end
		}
	}


