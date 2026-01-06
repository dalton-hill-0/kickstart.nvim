return {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim', branch = 'master' },
  },
  build = 'make tiktoken',
  opts = {
    model = 'gpt-4.1',
    temperature = 0.1, -- Lower = focused, higher = creative
    window = {
      layout = 'vertical',
      width = 0.5, -- 50% of screen width
    },
    auto_insert_mode = false, -- Enter insert mode when opening
  },
  keys = {
    { '<leader>cm', '<cmd>CopilotChatModels<cr>', desc = 'Copilot Models' },
    { '<leader>cc', '<cmd>CopilotChat<cr>', desc = 'Copilot Chat' },
    { '<leader>cq', '<cmd>CopilotChatClose<cr>', desc = 'Copilot Chat Close' },
    { '<leader>cr', '<cmd>CopilotChatReset<cr>', desc = 'Copilot Chat Reset' },
  },
}
