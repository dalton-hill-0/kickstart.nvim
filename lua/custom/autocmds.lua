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

-- Enable treesitter highlighting for all supported filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('TreesitterHighlight', { clear = true }),
  pattern = {
    -- Go
    'go',
    'gomod',
    'gosum',
    'gowork',
    -- JavaScript/TypeScript
    'javascript',
    'typescript',
    'javascriptreact',
    'typescriptreact',
    -- Python
    'python',
    -- Config/Data
    'json',
    'yaml',
    'toml',
    -- Shell
    'sh',
    'bash',
    'zsh',
    -- Web
    'html',
    'css',
    'scss',
    -- Documentation
    'markdown',
    -- Other
    'vim',
    'lua',
  },
  callback = function(args)
    vim.treesitter.start(args.buf)
  end,
})

-- Enable treesitter-based folding for supported languages
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('TreesitterFolding', { clear = true }),
  pattern = {
    'go',
    'javascript',
    'typescript',
    'javascriptreact',
    'typescriptreact',
    'python',
    'json',
    'yaml',
    'lua',
    'html',
    'css',
  },
  callback = function()
    vim.wo[0][0].foldmethod = 'expr'
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldenable = false -- Start with folds open
  end,
})
