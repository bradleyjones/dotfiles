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

-- Finalise LSP Setup
lsp.setup()

--
-- CMP Completion Config
--
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require('cmp')
local cmp_config = lsp.defaults.cmp_config({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered()
	},
	experimental = { ghost_text = true },
	sources = {
		{ name = 'path' },
		{ name = 'nvim_lsp', keyword_length = 1 },
		{ name = 'buffer', keyword_length = 3 },
		{ name = 'luasnip', keyword_length = 2 },
		{ name = 'nvim_lsp_signature_help' }
	}
})

cmp.setup(cmp_config)

-- Diagnostic messages
vim.diagnostic.config({
	virtual_lines = false, -- enable/disable lsp_lines (default false so enabled with toggle
	virtual_text = {
		spacing = 16
	},
	signs = true,
	update_in_insert = true,
	underline = true,
	severity_sort = false,
	float = true,
})
