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
-- Nvim Tree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', {})
-- 
-- Cellular Automation
vim.keymap.set('n', '<leader>fml', '<cmd>CellularAutomaton make_it_rain<CR>')
--
-- Git
vim.keymap.set('n', '<leader>gc', '<cmd>G c<CR>') -- git commit (using git c alias)
vim.keymap.set('n', '<leader>ga', '<cmd>G c --amend<CR>') -- git commit --amend (using git c alias)
--
-- LSP Lines
vim.keymap.set('n', '<leader>l', require('lsp_lines').toggle, { desc = 'Toggle lsp_lines' })
--
-- Line Numbers
vim.keymap.set('n', '<leader>L', '<cmd>set relativenumber!<CR>')
--
-- Insert Mode hjkl movements
vim.keymap.set('i', '<C-h>', '<C-o>h')
vim.keymap.set('i', '<C-j>', '<C-o>j')
vim.keymap.set('i', '<C-k>', '<C-o>k')
vim.keymap.set('i', '<C-l>', '<C-o>l')