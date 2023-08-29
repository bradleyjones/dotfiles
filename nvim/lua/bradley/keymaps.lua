-- Key maps --
--
-- Telescope
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<C-f>f', telescope.find_files, {})
vim.keymap.set('n', '<C-f>g', telescope.git_files, {})
vim.keymap.set('n', '<C-g>', telescope.live_grep, {}) -- live grep uses ripgrep
vim.keymap.set('n', '<C-s>', telescope.resume, {})
vim.keymap.set('n', '<C-b>', telescope.buffers, {})
vim.keymap.set('n', '<leader>?', telescope.help_tags, {})
--
-- NeoTree
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', {})
--
-- Cellular Automation
vim.keymap.set('n', '<leader>fml', '<cmd>CellularAutomaton make_it_rain<CR>')
--
-- Git
vim.keymap.set('n', '<leader>gc', '<cmd>G c<CR>') -- git commit (using git c alias)
vim.keymap.set('n', '<leader>gC', '<cmd>G c -a<CR>') -- git commit -a (using git c alias)
vim.keymap.set('n', '<leader>ga', '<cmd>G c --amend<CR>') -- git commit --amend (using git c alias)
vim.keymap.set('n', '<leader>gA', '<cmd>G c -a --amend<CR>') -- git commit -a --amend (using git c alias)
--
-- LSP Lines
vim.keymap.set('n', '<leader>l', require('lsp_lines').toggle, { desc = 'Toggle lsp_lines' })
--
-- LSP Signature
vim.keymap.set({ 'n' }, '<C-k>', function() require('lsp_signature').toggle_float_win() end, { silent = true, noremap = true, desc = 'toggle signature' })
--
-- Line Numbers
vim.keymap.set('n', '<leader>L', '<cmd>set relativenumber!<CR>')
--
-- Insert Mode hjkl movements
vim.keymap.set('i', '<C-h>', '<C-o>h')
vim.keymap.set('i', '<C-j>', '<C-o>j')
vim.keymap.set('i', '<C-k>', '<C-o>k')
vim.keymap.set('i', '<C-l>', '<C-o>l')
--
-- Trouble
vim.keymap.set('n', 'gr', '<cmd>TroubleToggle lsp_references<cr>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>tt', '<cmd>TroubleToggle<cr>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>tw', '<cmd>TroubleToggle workspace_diagnostics<cr>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>td', '<cmd>TroubleToggle document_diagnostics<cr>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>tl', '<cmd>TroubleToggle loclist<cr>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>tq', '<cmd>TroubleToggle quickfix<cr>', { silent = true, noremap = true })
--
-- NeoTest
local neotest = require('neotest')
vim.keymap.set('n', '<leader>Tt', function() neotest.summary.toggle() end, { desc = 'Toggle test summary' })
vim.keymap.set('n', '<leader>Tr', function() neotest.run.run() end, { desc = 'Run nearest test' })
vim.keymap.set('n', '<leader>To', function() neotest.output.open({ enter = true }) end, { desc = 'Open test output' })
vim.keymap.set('n', '<leader>Tf', function() neotest.run.run(vim.fn.expand("%"))  end, { desc = 'Run test file' })
-- NEED TO GET WATCH WORKING IN GO
-- vim.keymap.set('n', '<leader>Tw', function() neotest.watch.toggle() end, { desc = 'Toggle test watch' })
-- vim.keymap.set('n', '<leader>TW', function() neotest.watch.watch(vim.fn.expand("%")) end, { desc = 'Start test watch' })
-- vim.keymap.set('n', '<leader>TS', function() neotest.watch.stop() end, { desc = 'Stop test watch' })
--
-- Buffer Control
vim.keymap.set('n', '<C-l>', '<cmd>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<C-h>', '<cmd>BufferLineCyclePrev<CR>')
vim.keymap.set('n', '<C-w>d', '<cmd>bd<CR>') -- Close window / delete buffer
--
-- Light/Dark Mode
vim.keymap.set('n', '<leader>cl', '<cmd>set background=light<CR>')
vim.keymap.set('n', '<leader>cd', '<cmd>set background=dark<CR>')
--
-- Toggle comments
local comment_api = require('Comment.api')
local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
vim.keymap.set('n', '<leader>ci', comment_api.toggle.linewise.current)
vim.keymap.set('x', '<leader>ci', function()
	vim.api.nvim_feedkeys(esc, 'nx', false)
	comment_api.toggle.linewise(vim.fn.visualmode())
end)
--
-- Copilot
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
--
-- Diagnostics
vim.keymap.set('n', '<leader>Dn', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', '<leader>Dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
--
-- Go Debugging
vim.keymap.set('n', '<leader>db', '<cmd>GoBreakToggle<CR>', { desc = 'Toggle breakpoint' })
vim.keymap.set('n', '<leader>ds', '<cmd>GoDebug<CR>', { desc = 'Start debugging' })
vim.keymap.set('n', '<leader>dS', '<cmd>GoDebug -s<CR>', { desc = 'Stop debugging' })
vim.keymap.set('n', '<leader>dr', function() require('dap.ext.vscode').load_launchjs() end, { desc = 'Start Remote Debugging' })
vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end, { desc = 'Continue' })
vim.keymap.set('n', '<leader>do', function() require('dap').step_over() end, { desc = 'Step over' })
vim.keymap.set('n', '<leader>di', function() require('dap').step_into() end, { desc = 'Step into' })
vim.keymap.set('n', '<leader>dO', function() require('dap').step_out() end, { desc = 'Step out' })

