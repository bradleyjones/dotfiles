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

function Startup()
	-- skip if is a git commit message
	if vim.bo.filetype == "gitcommit" then
		return
	end
	vim.cmd("set nornu nonu")
	vim.cmd("TagbarToggle")
	vim.cmd("wincmd w") -- Select tagbar
	vim.cmd("set winhighlight=Normal:TroubleNormal")
	vim.cmd("wincmd h") -- Refocus main window
	vim.cmd("Neotree show")
	vim.cmd("Trouble workspace_diagnostics")
end

-- Show neotree & neotest on startup
vim.api.nvim_create_autocmd("VimEnter", {
	callback = Startup,
})
vim.api.nvim_create_autocmd("BufEnter", {
    command = "set rnu nu",
})

