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

-- lsp_attach is where you enable features that only work
-- if there is a language server active in the file
local lsp_attach = function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "gR", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end


lsp.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here
  -- with the ones you want to install
  ensure_installed = {'lua_ls', 'gopls', 'pylsp'},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  }
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

lsp.configure('pylsp', {
	settings = {
		pylsp = {
			plugins = {
				flake8 = {
					enabled = true,
					maxLineLength = 88,
					ignore = { 'E722', 'W503' },
				},
				pydocstyle = { enabled = false },
				pylint = { enabled = true },
				pycodestyle = {
					enabled = false,
					maxLineLength = 88,
				},
				pyflakes = { enabled = true },
			}
		}
	}
})

-- Golang LSP
local lspconfig = require 'lspconfig'
local configs = require 'lspconfig/configs'

if not configs.golangcilsp then
 	configs.golangcilsp = {
		default_config = {
			cmd = {'golangci-lint-langserver'},
			root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
			init_options = {
					command = { "golangci-lint", "run", "--out-format", "json", "--issues-exit-code=1" };
			}
		};
	}
end
lspconfig.golangci_lint_ls.setup {
	filetypes = {'go','gomod'}
}


-- Finalise LSP Setup
lsp.setup()

--
-- CMP Completion Config
--
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local cmp = require('cmp')

cmp.setup({
  sources = {
	{ name = 'path' },
	{ name = 'nvim_lsp',               keyword_length = 1 },
	{ name = 'buffer',                 keyword_length = 3 },
	{ name = 'luasnip',                keyword_length = 2 },
	{ name = 'nvim_lsp_signature_help' }
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({}),
})


-- Diagnostic messages
vim.diagnostic.config({
	virtual_lines = false, -- enable/disable lsp_lines (default false so enabled with toggle)
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
