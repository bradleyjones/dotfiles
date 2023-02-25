-- Autocmds --

-- Format on save based on lsp
vim.api.nvim_create_autocmd(
	'BufWritePre',
	{
		pattern = '<buffer>',
		command = 'lua vim.lsp.buf.format()'
	}
)

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
