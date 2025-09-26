return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup {
      options = {
        indicator = {
          style = 'underline',
        },
        separator_style = 'slope',
        numbers = 'buffer_id',
        offsets = { {
          filetype = 'neo-tree',
          text_align = 'center',
          text = 'Neo Tree',
        } },
        diagnostics = 'nvim_lsp',
      },
    }
    vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { desc = 'Cycle to next Buffer (Tab)' })
    vim.keymap.set('n', '<s-Tab>', ':BufferLineCyclePrev<CR>', { desc = 'Cycle to previous Buffer (Tab)' })
  end,
}
