-- Include these modules

require('bradley.plugins')
require('bradley.keymaps')
require('bradley.autocmd')

--
-- Vim settings
--

vim.opt.termguicolors = true

-- Line Number Column
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Indentation
vim.opt.smartindent = true

-- Swapfile/Backup
vim.opt.swapfile = false
vim.opt.backup = false

-- Scrolling
vim.opt.scrolloff = 8
vim.opt.updatetime = 50

-- Hidden Characters - use 'set list' to show
vim.opt.listchars = "tab:>-,trail:~,extends:>,precedes:<"

-- Default to US spelling
vim.opt.spelllang = "en_us"
vim.opt.spell = false

-- Status Line
vim.opt.laststatus = 3

-- Colours
vim.cmd([[
	augroup MyColors
	autocmd!
	autocmd ColorScheme * hi clear OctoEditable
	augroup END
]])

-- Minimap
vim.g.minimap_git_colors = 1

-- Custom filemapping for tcss (Textual CSS)
vim.filetype.add({
	pattern = {
		['.*.tcss'] = 'css',
	},
})

-- Conceal (for obsidian.nvim)
vim.opt.conceallevel = 2
