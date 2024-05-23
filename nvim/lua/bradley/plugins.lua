-- Ensure that packer is installed when nvim is started if not present
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
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

return require('packer').startup({
	function(use)
		-- Packer can manage itself
		use 'wbthomason/packer.nvim'

		-- Fuzzy Finder
		use {
			'nvim-telescope/telescope.nvim', branch = '0.1.x',
			requires = { { 'nvim-lua/plenary.nvim' } },
			config = function()
				require('telescope').setup({
					defaults = {
						borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
					}
				})
			end
		}

		-- NeoTree - Sidebar tree file explorer
		vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
		use {
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v2.x",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
			},
			config = function()
				require('neo-tree').setup {
					window = {
						position = "float",
						width = 30,
						mappings = {
							["P"] = { "toggle_preview", config = { use_float = true } },
						}
					},
					filesystem = {
						filtered_items = {
							always_show = {
								".gitignore",
								".github",
								".golangci.yaml",
								".goreleaser.yaml"
							}
						},
						follow_current_file = {
							enabled = true,
							leave_dirs_open = true
						}
					},
				}
			end,
		}
		use {
			's1n7ax/nvim-window-picker',
			tag = 'v1.*',
			config = function()
				require 'window-picker'.setup()
			end,
		}

		-- Theme/Colorscheme
		use({
			'rose-pine/neovim',
			as = 'rose-pine',
			config = function()
				require('rose-pine').setup({
					dark_variant = 'moon',
					disable_background = false,
					disable_italics = true
				})
			end
		})
		use {
			"bradleyjones/monokai-pro.nvim",
			config = function()
				require("monokai-pro").setup({
					background_clear = {}
				})
				vim.cmd('colorscheme monokai-pro')
			end
		}

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
					lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
					lastplace_ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' },
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
				{ 'neovim/nvim-lspconfig' }, -- Required
				{ 'williamboman/mason.nvim' }, -- Optional
				{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

				-- Autocompletion
				{ 'hrsh7th/nvim-cmp' }, -- Required
				{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
				{ 'hrsh7th/cmp-buffer' }, -- Optional
				{ 'hrsh7th/cmp-path' }, -- Optional
				{ 'saadparwaiz1/cmp_luasnip' }, -- Optional
				{ 'hrsh7th/cmp-nvim-lua' }, -- Optional

				-- Snippets
				{ 'L3MON4D3/LuaSnip' }, -- Required
				{ 'rafamadriz/friendly-snippets' }, -- Optional
			},
			config = function() require('bradley.plugin-configs.lsp') end
		})
		-- use 'hrsh7th/cmp-nvim-lsp-signature-help' -- Show function signature while typing
		use { "ray-x/lsp_signature.nvim", config = function() require('lsp_signature').setup() end }
		use({
			-- Multiline diagnostics
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
			tag = 'v4.*',
			requires = 'nvim-tree/nvim-web-devicons',
			config = function() require('bufferline').setup {
				options = {
					separator_style = 'slant',
					offsets = {
						{
							filetype = "neo-tree",
							text = "File Explorer",
							text_align = "center",
						}
					}
				}
			} end
		}

		-- Show floating filename on window
		use {
			"b0o/incline.nvim",
			config = function() require('incline').setup() end
		}

		-- Fix list
		use {
			'folke/trouble.nvim',
			branch = 'dev',
			requires = 'nvim-tree/nvim-web-devicons',
			config = function()
				require('trouble').setup {
					auto_close = false,
					auto_open = false,
				}
			end
		}

		-- Copilot
		use {
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			event = "InsertEnter",
			config = function()
				require("copilot").setup({
					suggestion = {
						enabled = true,
						auto_trigger = true,
						keymap = {
							accept = "<C-o>",
							accept_word = false,
							accept_line = "<C-]>",
							next = "<C-n>",
							prev = "<C-p>",
							dismiss = "<C-q>",
						},
					},
					panel = { enabled = false },
				})
			end,
		}

		-- Neotest - test runner
		use {
			'nvim-neotest/neotest',
			requires = {
				'nvim-lua/plenary.nvim',
				'nvim-treesitter/nvim-treesitter',
				'antoinemadec/FixCursorHold.nvim',
				'nvim-neotest/neotest-go',
				'nvim-neotest/neotest-python',
				'nvim-neotest/nvim-nio',
			},
			config = function() require('bradley.plugin-configs.neotest') end
		}

		-- Statusline
		use {
			'nvim-lualine/lualine.nvim',
			requires = { 'kyazdani42/nvim-web-devicons', opt = true },
			config = function() require('lualine').setup({}) end
		}

		-- Tmux line sync with vim Theme
		use 'edkolev/tmuxline.vim'

		-- Auto comments
		use {
			'numToStr/Comment.nvim',
			config = function()
				require('Comment').setup()
			end
		}

		-- Which key
		use {
			"folke/which-key.nvim",
			config = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 30
				require("which-key").setup {}
			end
		}

		-- Golang
		use {
			'ray-x/go.nvim',
			requires = {
				-- Debugger support
				'mfussenegger/nvim-dap',
				'rcarriga/nvim-dap-ui',
				'theHamsta/nvim-dap-virtual-text',
			},
			config = function()
				require("go").setup()
				require("nvim-dap-virtual-text").setup {
					enabled = false,
					commented = true,
					virt_text_pos = 'eol'
				}
			end,
		}
		use 'ray-x/guihua.lua' -- recommended if need floating window support

		-- Github
		use {
			'pwntester/octo.nvim',
			requires = {
				'nvim-lua/plenary.nvim',
				'nvim-telescope/telescope.nvim',
				'kyazdani42/nvim-web-devicons',
			},
			config = function()
				require "octo".setup({
				  suppress_missing_scope = {
					projects_v2 = true,
				  }
				})
			end
		}

		-- Highlight word under cursor
		use {
			'RRethy/vim-illuminate',
			config = function()
				vim.g.Illuminate_delay = 1000
			end
		}

		-- No-Neck-Pain - center buffer on screen
		use {
			"shortcuts/no-neck-pain.nvim",
			config = function()
				require("no-neck-pain").setup({
					width = 160,
					autocmds = {
						enableOnVimEnter = false,
						enableOnTabEnter = false,
					},
					buffers = {
						scratchPad = {
							enabled = true, -- set to `false` to disable auto-saving
							fileName = "scratchpad.md",
							location = "~/Documents/",
						},
						bo = {
							filetype = "md",
						},
						colors = {
							blend = -0.4,
						},
					},
					mappings = {
						enabled = true,
					}
				})
			end,
		}

		-- AI
		use({
			"jackMort/ChatGPT.nvim",
			config = function()
				require("chatgpt").setup()
			end,
			requires = {
				"MunifTanjim/nui.nvim",
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim"
			}
		})

		-- Tagbar
		use "preservim/tagbar"

		-- Minimap
		use "wfxr/minimap.vim"

		-- Just for Fun :)
		use 'eandrju/cellular-automaton.nvim' -- make it rain!

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
	}
})
