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
      desc = 'Open CodeCompanion Chat',
    },
    {
      '<C-a>',
      '<cmd>CodeCompanionActions<cr>',
      desc = 'CodeCompanion Actions',
    },
  },
  config = function()
    require('codecompanion').setup {
      opts = {
        log_level = 'DEBUG',
      },
      interactions = {
        chat = {
          adapter = 'claude_code',
          model = 'opus',
        },
      },
      adapters = {
        acp = {
          claude_code = function()
            return require('codecompanion.adapters').extend('claude_code', {
              env = {
                api_key = 'CLAUDE_CODE_OAUTH_TOKEN',
              },
              defaults = {
                ---@param self CodeCompanion.ACPAdapter
                ---@return string
                model = function(self)
                  return 'opus'
                end,
              },
            })
          end,
        },
      },
    }
  end,
}
