-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- Fuzzy Finder
		{
			'nvim-telescope/telescope.nvim', branch = '0.1.x',
			dependencies = { 'nvim-lua/plenary.nvim' },
		},

		-- Neo Tree Sidebar
		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			dependencies = {
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
		},
		{
			's1n7ax/nvim-window-picker',
			name = 'window-picker',
			event = 'VeryLazy',
			version = '2.*',
			config = function()
				require'window-picker'.setup()
			end,
		},

		-- Theme/Colorscheme
		{
			'rose-pine/neovim',
			name = 'rose-pine',
			config = function()
				require('rose-pine').setup({
					dark_variant = 'moon',
					disable_background = false,
					disable_italics = true
				})
			end
		},
		{
			"bradleyjones/monokai-pro.nvim",
			config = function()
				require("monokai-pro").setup({
					background_clear = {}
				})
				vim.cmd('colorscheme monokai-pro')
			end
		},

		-- Treesitter
		{
			'nvim-treesitter/nvim-treesitter',
			build = ':TSUpdate',
			config = function() require('bradley.plugin-configs.treesitter') end
		},

		-- Preserve last place when opening a file
		{
			'ethanholz/nvim-lastplace',
			config = function()
				require('nvim-lastplace').setup({
					lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
					lastplace_ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' },
					lastplace_open_folds = true
				})
			end
		},

		-- LSP
		{
			'VonHeikemen/lsp-zero.nvim',
			branch = 'v4.x',
			dependencies = {
				-- LSP Support
				'neovim/nvim-lspconfig', -- Required
				'williamboman/mason.nvim', -- Optional
				'williamboman/mason-lspconfig.nvim', -- Optional

				-- Autocompletion
				'hrsh7th/nvim-cmp', -- Required
				'hrsh7th/cmp-nvim-lsp', -- Required
				'hrsh7th/cmp-buffer', -- Optional
				'hrsh7th/cmp-path', -- Optional
				'saadparwaiz1/cmp_luasnip', -- Optional
				'hrsh7th/cmp-nvim-lua', -- Optional

				-- Snippets
				'L3MON4D3/LuaSnip', -- Required
				'rafamadriz/friendly-snippets', -- Optional
			},
			config = function() require('bradley.plugin-configs.lsp') end
		},
		-- use 'hrsh7th/cmp-nvim-lsp-signature-help' -- Show function signature while typing
		{
			"ray-x/lsp_signature.nvim",
			config = function() require('lsp_signature').setup() end },
		{
			-- Multiline diagnostics
			'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
			config = function()
				require('lsp_lines').setup()
			end,
		},

		-- Git setup
		{
			'lewis6991/gitsigns.nvim',
			config = function()
				require('gitsigns').setup()
			end
		},
		'tpope/vim-fugitive',

		-- Surround - quotes,tags,brackets,etc.
		{
			'kylechui/nvim-surround',
			config = function()
				require('nvim-surround').setup()
			end
		},

		-- Auto pair brackets, quotes, etc.
		{
			'windwp/nvim-autopairs',
			config = function() require('nvim-autopairs').setup {} end
		},


		-- Buffer line
		{
			'akinsho/bufferline.nvim',
			version = '*',
			dependencies = {'nvim-tree/nvim-web-devicons'},
			config = function()
				require('bufferline').setup {
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
				}
			end
		},

		-- Show floating filename on window
		{
			"b0o/incline.nvim",
			config = function() require('incline').setup() end
		},

		-- Fix list
		{
			'folke/trouble.nvim',
			branch = 'main',
			dependencies = {'nvim-tree/nvim-web-devicons'},
			config = function()
				require('trouble').setup {
					auto_close = false,
					auto_open = false,
					open_no_results = true,
					modes = {
						diagnostics = {
							mode = "diagnostics",
							preview = {
								type = "float",
								relative = "editor",
								border = "rounded",
								title = "Preview",
								title_pos = "center",
								position = { 1, -2 },
								size = { width = 0.4, height = 0.4 },
								zindex = 200,
							},
							win = {
								type = "split",
								position = "bottom",
								size = 10,
								relative = "win",
							},
						},
						lsp = {
							mode = "lsp",
							focus = true,
							auto_refresh = false,
							preview = {
								type = "float",
								relative = "editor",
								border = "rounded",
								title = "Preview",
								title_pos = "center",
								position = { 0, -2 },
								size = { width = 0.4, height = 0.4 },
								zindex = 200,
							},
							win = {
								type = "split",
								position = "top",
								size = 10,
								relative = "win",
							},
						},
					},
				}
			end
		},

		-- Copilot
		{
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			event = "InsertEnter",
			config = function()
				require("copilot").setup({
					suggestion = {
						enabled = true,
						auto_trigger = true,
						keymap = {
							accept = "<C-i>",
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
		},

		-- Neotest - test runner
		{
			'nvim-neotest/neotest',
			dependencies = {
				'nvim-lua/plenary.nvim',
				'nvim-treesitter/nvim-treesitter',
				'antoinemadec/FixCursorHold.nvim',
				'nvim-neotest/neotest-go',
				'nvim-neotest/neotest-python',
				'nvim-neotest/nvim-nio',
			},
			config = function() require('bradley.plugin-configs.neotest') end
		},

		-- Statusline
		{
			'nvim-lualine/lualine.nvim',
			dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
			config = function() require('lualine').setup({}) end
		},

		-- Tmux line sync with vim Theme
		'edkolev/tmuxline.vim',

		-- Auto comments
		{
			'numToStr/Comment.nvim',
			config = function()
				require('Comment').setup()
			end
		},

		-- Which key
		{
			"folke/which-key.nvim",
			config = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 30
				require("which-key").setup {}
			end
		},

		-- Golang
		{
			'ray-x/go.nvim',
			dependencies = {
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
		},
		'ray-x/guihua.lua', -- recommended if need floating window support

		-- Github
		{
			'pwntester/octo.nvim',
			dependencies = {
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
		},

		-- Highlight word under cursor
		{
			'RRethy/vim-illuminate',
			config = function()
				vim.g.Illuminate_delay = 1000
			end
		},

		-- No-Neck-Pain - center buffer on screen
		{
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
		},

		-- AI
		{
			"jackMort/ChatGPT.nvim",
			config = function()
				require("chatgpt").setup()
			end,
			dependencies = {
				"MunifTanjim/nui.nvim",
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim"
			}
		},

		-- Tagbar
		"preservim/tagbar",


		-- Zen Mode
		"folke/zen-mode.nvim",
		-- Just for Fun :)
		'eandrju/cellular-automaton.nvim', -- make it rain!
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

--[=[
return require('packer').startup({
	function(use)




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
--]=]
