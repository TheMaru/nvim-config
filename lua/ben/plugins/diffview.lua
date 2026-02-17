return {
  'sindrets/diffview.nvim',
  event = 'VeryLazy', -- Loads the plugin after startup to not affect start time
  -- You can also lazy load on the commands it provides:
  -- cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  config = function()
    require('diffview').setup {
      -- You can add custom configuration here if needed.
      -- The defaults are usually sufficient for most users.
    }
  end,
}
