local Plugin = { 'sindrets/diffview.nvim' }

Plugin.keys = {
  { '<leader>do', ':DiffviewOpen<CR>', desc = 'DiffviewOpen' },
  { '<leader>dc', ':DiffviewClose<CR>', desc = 'DiffviewClose' },
  { '<leader>dfh', ':DiffviewFileHistory<CR>', desc = 'DiffviewFileHistory' },
  { '<leader>dff', ':DiffviewFocusFiles<CR>', desc = 'DiffviewFocusFiles' },
}
Plugin.config = true

return Plugin
