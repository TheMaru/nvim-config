return {
  'olimorris/codecompanion.nvim',
  opts = {},
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    {
      '<leader>a',
      function()
        require('codecompanion').chat()
      end,
      desc = 'Open Copilot Chat',
    },
  },
}
