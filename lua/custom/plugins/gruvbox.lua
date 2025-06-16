return {
  'sainnhe/gruvbox-material',
  priority = 0,
  config = function()
    vim.o.background = 'dark'
    vim.cmd [[ let g:gruvbox_material_background = 'hard' ]]
    vim.cmd.colorscheme 'gruvbox-material'
  end,
}
