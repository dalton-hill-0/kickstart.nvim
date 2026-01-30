-- Custom vim options
-- These are loaded early in init.lua before plugins

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.relativenumber = true

-- Use the system clipboard for all operations
vim.opt.clipboard = 'unnamedplus'

vim.opt.textwidth = 80
vim.opt.wrap = true

-- Set conceal level for markdown files so they work with Obsidian
vim.cmd [[
	augroup MarkdownConceal
		autocmd!
		autocmd FileType markdown setlocal conceallevel=1
	augroup END
]]
