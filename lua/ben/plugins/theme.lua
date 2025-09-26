return {
  'folke/tokyonight.nvim',
  priority = 1000,
  lazy = false,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup {
      on_colors = function(colors)
        colors.comment = '#7f87a9'
      end,
      on_highlights = function(hl, c)
        hl.LineNr = {
          fg = '#bfc7dc',
        }
        hl.LineNrAbove = {
          fg = '#bfc7dc',
        }
        hl.LineNrBelow = {
          fg = '#bfc7dc',
        }
        hl.DiagnosticUnnecessary = {
          fg = '#7f87a9',
        }
      end,
    }

    vim.cmd.colorscheme 'tokyonight-storm'
  end,
}
