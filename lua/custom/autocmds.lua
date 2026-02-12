-- Custom autocommands
-- These are loaded early in init.lua before plugins

-- Command to wipe all registers
vim.cmd [[command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor]]

-- Run WipeReg on startup
-- vim.api.nvim_create_autocmd('VimEnter', {
--   group = vim.api.nvim_create_augroup('CustomStartup', { clear = true }),
--   callback = function()
--     vim.cmd 'WipeReg'
--   end,
--   once = true,
-- })

-- Enable treesitter highlighting for specific filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('TreesitterHighlight', { clear = true }),
  pattern = { 'go', 'gomod', 'gosum', 'gowork', 'markdown' },
  callback = function(args)
    vim.treesitter.start(args.buf)
  end,
})
