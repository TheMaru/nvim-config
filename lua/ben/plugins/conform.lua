return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = {}
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters = {
      clang_format = {
        prepend_args = { '--style=file', '--fallback-style=Google' },
      },
      stylelint = {
        command = 'stylelint',
        args = { '--fix', '--stdin-filename', '$FILENAME', '--stdin' },
        -- Conform automatically pipes buffer content to stdin
      },
      eslint_auto = function()
        local name = vim.fn.executable('eslint_d') == 1 and 'eslint_d' or 'eslint'
        return require('conform.formatters.' .. name)
      end,
      prettier_auto = function()
        local name = vim.fn.executable('prettierd') == 1 and 'prettierd' or 'prettier'
        return require('conform.formatters.' .. name)
      end,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      javascript = { 'eslint_auto', 'prettier_auto' },
      javascriptreact = { 'eslint_auto', 'prettier_auto' },
      typescript = { 'eslint_auto', 'prettier_auto' },
      typescriptreact = { 'eslint_auto', 'prettier_auto' },
      css = { 'prettier', 'stylelint' },
      scss = { 'prettier', 'stylelint' },
      rust = { 'rustfmt', lsp_format = 'fallback' },
      c = { 'clang_format' },
      cpp = { 'clang_format' },
    },
  },
}
