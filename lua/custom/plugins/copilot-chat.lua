return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    opts = {
      mappings = {
        complete = {
          insert = '<C-Space>',
        },
      },
    },
  },
}
