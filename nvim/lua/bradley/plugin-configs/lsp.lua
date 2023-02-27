-- Mason Config (lsp package manager)
-- Must be configured before LSP Zero

require('mason.settings').set({
	ui = {
		border = 'rounded'
	}
})

--
-- LSP Zero Config
--

local lsp = require('lsp-zero')

lsp.preset({
	name = 'minimal',
	set_lsp_keycaps = true,
	manage_nvim_cmp = false,
	suggest_lsp_servers = true,
})

lsp.ensure_installed({
	'lua_ls',
	'gopls',
})

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			}
		}
	}
})

-- Key mappings need to be done here to apply per buffer
lsp.on_attach(function(_, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "gR", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- Finalise LSP Setup
lsp.setup()

--
-- CMP Completion Config
--
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require('cmp')
local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }
local cmp_config = lsp.defaults.cmp_config({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered()
	},
	experimental = { ghost_text = false },
	sources = {
		{ name = 'path' },
		{ name = 'nvim_lsp', keyword_length = 1 },
		{ name = 'buffer', keyword_length = 3 },
		{ name = 'luasnip', keyword_length = 2 },
		{ name = 'nvim_lsp_signature_help' }
	},
	mapping = cmp.mapping.preset.insert({
		['<Tab>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		['<CR>'] = cmp.mapping.close(),
		['<C-e>'] = cmp.mapping.close(),
		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select_opts),
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select_opts),
	}),
})

cmp.setup(cmp_config)

-- Diagnostic messages
vim.diagnostic.config({
	virtual_lines = false, -- enable/disable lsp_lines (default false so enabled with toggle
	virtual_text = {
		prefix = '',
		spacing = 16,
	},
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = false,
	float = true,
})
