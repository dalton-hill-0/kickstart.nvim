return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    opts = {
      model = 'claude-haiku-4.5',
      mappings = {
        complete = {
          insert = '<C-Space>',
        },
      },
    },
  },
}
