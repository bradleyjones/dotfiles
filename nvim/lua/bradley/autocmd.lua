-- Autocmds --

-- Format on save based on lsp
vim.api.nvim_create_autocmd(
	'BufWritePre',
	{
		pattern = '<buffer>',
		command = 'lua vim.lsp.buf.format()'
	}
)

-- Run gofmt + goimport on save
local format_sync_grp = vim.api.nvim_create_augroup("GoFmtImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require('go.format').gofmt()
	end,
	group = format_sync_grp,
})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require('go.format').goimport()
	end,
	group = format_sync_grp,
})

-- Java
vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
		vim.bo.softtabstop = 2
		vim.bo.expandtab = true
		vim.bo.smartindent = true
	end,
})

function Startup()
	-- skip if is a git commit message
	if vim.bo.filetype == "gitcommit" then
		return
	end
	vim.cmd("set nornu nonu")
	-- vim.cmd("Trouble diagnostics")
	-- vim.cmd("TagbarToggle")
	-- vim.cmd("wincmd w") -- Select tagbar
	-- vim.cmd("set winhighlight=Normal:TroubleNormal")
	-- vim.cmd("wincmd h") -- Refocus main window
	vim.cmd("wincmd k") -- Refocus main window
	vim.opt.number = true
	vim.opt.relativenumber = true
	vim.opt.signcolumn = "yes"
end

-- Show neotree & neotest on startup
vim.api.nvim_create_autocmd("VimEnter", {
	callback = Startup,
})
-- vim.api.nvim_create_autocmd("BufEnter", {
--     command = "set rnu nu",
-- })
