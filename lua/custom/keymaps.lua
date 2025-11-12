-- Custom keymaps
-- These are loaded early in init.lua before plugins

-- Better window navigation
vim.keymap.set('n', '<leader>h', ':wincmd h<CR>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>j', ':wincmd j<CR>', { silent = true })
vim.keymap.set('n', '<leader>k', ':wincmd k<CR>', { silent = true })
vim.keymap.set('n', '<leader>l', ':wincmd l<CR>', { silent = true })
