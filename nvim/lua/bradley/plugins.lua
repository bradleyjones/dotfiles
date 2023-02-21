-- Ensure that packer is installed when nvim is started if not present
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Auto compile Packer when this file changes
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerCompile
	augroup end
]])

return require('packer').startup({function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Fuzzy Finder
	use {
		'nvim-telescope/telescope.nvim', branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- Sidebar tree file explorer
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- for file icons
		},
		tag = 'nightly',
		config = function() require('bradley.plugin-configs.nvim-tree') end
	}

	-- Theme/Colorscheme
	use({
		'rose-pine/neovim',
		as = 'rose-pine',
		config = function()
			require('rose-pine').setup({
				disable_background = true,
				disable_italics = true
			})
			vim.cmd('colorscheme rose-pine')
		end
	})

	-- Treesitter
	use({
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function() require('bradley.plugin-configs.treesitter') end
	})

	-- Preserve last place when opening a file
	use({
		'ethanholz/nvim-lastplace',
		config = function()
			require('nvim-lastplace').setup({
				lastplace_ignore_buftype = {'quickfix', 'nofile', 'help'},
				lastplace_ignore_filetype = {'gitcommit', 'gitrebase', 'svn', 'hgcommit'},
				lastplace_open_folds = true
			})
		end
	})

	-- LSP
	use({
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{'williamboman/mason.nvim'},           -- Optional
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},         -- Required
			{'hrsh7th/cmp-nvim-lsp'},     -- Required
			{'hrsh7th/cmp-buffer'},       -- Optional
			{'hrsh7th/cmp-path'},         -- Optional
			{'saadparwaiz1/cmp_luasnip'}, -- Optional
			{'hrsh7th/cmp-nvim-lua'},     -- Optional

			-- Snippets
			{'L3MON4D3/LuaSnip'},             -- Required
			{'rafamadriz/friendly-snippets'}, -- Optional
		},
		config = function() require('bradley.plugin-configs.lsp') end
	})
	use 'hrsh7th/cmp-nvim-lsp-signature-help' -- Show function signature while typing
	use({ -- Multiline diagnostics
		'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
		config = function()
			require('lsp_lines').setup()
		end,
	})

	-- Git setup
	use {
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	}
	use 'tpope/vim-fugitive'

	-- Surround - quotes,tags,brackets,etc.
	use({
		'kylechui/nvim-surround',
		config = function()
			require('nvim-surround').setup()
		end
	})

	-- Auto pair brackets, quotes, etc.
	use {
		'windwp/nvim-autopairs',
		config = function() require('nvim-autopairs').setup {} end
	}

	-- Buffer line
	use {
		'akinsho/bufferline.nvim',
		tag = 'v3.*',
		requires = 'nvim-tree/nvim-web-devicons',
		config = function() require('bufferline').setup {} end
	}

	-- Fix list
	use {
		'folke/trouble.nvim',
		requires = 'nvim-tree/nvim-web-devicons',
		config = function() require('trouble').setup {
			auto_close = true,
			auto_open = false,
		} end
	}

	-- Copilot
	use 'github/copilot.vim'

	-- Neotest - test runner
	use {
		'nvim-neotest/neotest',
		requires = {
			'nvim-lua/plenary.nvim',
			'nvim-treesitter/nvim-treesitter',
			'antoinemadec/FixCursorHold.nvim',
			'nvim-neotest/neotest-go',
			'nvim-neotest/neotest-python',
		},
		config = function() require('bradley.plugin-configs.neotest') end
	}

	-- Just for Fun :)
	use 'eandrju/cellular-automaton.nvim'  -- make it rain!

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end,
config = {
	display = {
		open_fn = require('packer.util').float,
	}
}})
