-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.relativenumber = true

-- map better window navigation
vim.keymap.set('n', '<leader>h', ':wincmd h<CR>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>j', ':wincmd j<CR>', { silent = true })
vim.keymap.set('n', '<leader>k', ':wincmd k<CR>', { silent = true })
vim.keymap.set('n', '<leader>l', ':wincmd l<CR>', { silent = true })

vim.cmd [[command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor]]

-- 'VimEnter' fires when startup is complete.
vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('CustomStartup', { clear = true }),
  callback = function()
    -- Use vim.cmd() to execute the defined command
    vim.cmd 'WipeReg'
  end,
  -- Use 'once = true' to ensure the command only runs the first time Neovim starts.
  once = true,
})

return {}
