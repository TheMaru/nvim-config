return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        -- A list of parser names, or "all" (the listed parsers MUST always be installed)
        ensure_installed = {
          'bash',
          'c',
          'diff',
          'html',
          'lua',
          'luadoc',
          'vim',
          'vimdoc',
          'query',
          'markdown',
          'markdown_inline',
          'javascript',
          'typescript',
          'tsx',
          'rust',
          'yaml',
          'vue',
          'css',
          'scss',
          'python',
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
          enable = true,

          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          -- disable = { "c", "rust" },
          -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }

      -- nvim-treesitter registers set-lang-from-info-string! with all=false,
      -- but nvim 0.12.2 always passes captures as TSNode[] — override with all=true
      local non_filetype_aliases = { ex = "elixir", pl = "perl", sh = "bash", uxn = "uxntal", ts = "typescript" }
      require("vim.treesitter.query").add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
        local nodes = match[pred[2]]
        if not nodes then return end
        local node = type(nodes) == "table" and nodes[1] or nodes
        if not node then return end
        local ok, text = pcall(vim.treesitter.get_node_text, node, bufnr)
        if not ok or not text then return end
        text = text:lower()
        metadata["injection.language"] = vim.filetype.match({ filename = "a." .. text }) or non_filetype_aliases[text] or text
      end, { force = true, all = true })
    end,
  },
}
