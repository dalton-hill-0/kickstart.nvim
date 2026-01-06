local Plugin = { 'kdheepak/lazygit.nvim' }
Plugin.keys = {
  { '<leader>lg', ':LazyGit<CR>', desc = 'Open Lazy git' },
}
Plugin.cmd = {
  'LazyGit',
  'LazyGitConfig',
  'LazyGitCurrentFile',
  'LazyGitFilter',
  'LazyGitFilterCurrentFile',
}
Plugin.dependencies = { 'nvim-lua/plenary.nvim' }
return Plugin
