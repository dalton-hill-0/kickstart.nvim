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
      -- Keys for regular copilot. It didn't like configuring keys.
      { '<leader>cd', '<cmd>Copilot disable<cr>', desc = 'Copilot Disable' },
      { '<leader>ce', '<cmd>Copilot enable<cr>', desc = 'Copilot Enable' },
    },
  },
}
