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


-- On save show	diagnostics
vim.api.nvim_create_autocmd(
	'BufWritePre',
	{
		pattern = '<buffer>',
		command = 'TroubleToggle workspace_diagnostics'
	}
)
vim.api.nvim_create_autocmd(
	'BufWritePre',
	{
		pattern = '<buffer>',
		command = 'lua vim.diagnostic.config({ virtual_lines = true })'
	}
)
