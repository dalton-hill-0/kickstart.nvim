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

-- Enable concealment and treesitter for markdown files
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('MarkdownConceal', { clear = true }),
  pattern = 'markdown',
  callback = function(args)
    -- Set conceal options
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = '' -- Show concealed text when cursor is on the line

    -- Ensure treesitter highlighting is enabled for this buffer
    vim.treesitter.start(args.buf, 'markdown')
  end,
})
