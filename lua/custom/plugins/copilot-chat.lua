return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    opts = {
      -- model = 'claude-haiku-4.5',
      mappings = {
        complete = {
          insert = '<C-Space>',
        },
      },
    },
    keys = {
      { '<leader>cc', '<cmd>CopilotChat<cr>', desc = 'Copilot Chat' },
      { '<leader>cm', '<cmd>CopilotChatModels<cr>', desc = 'Copilot Chat Models' },
      { '<leader>cr', '<cmd>CopilotChatReset<cr>', desc = 'Copilot Chat Reset' },
    },
  },
}
