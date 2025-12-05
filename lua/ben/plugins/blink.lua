return { -- Autocompletion
  'saghen/blink.cmp',
  event = 'VimEnter',
  build = 'cargo build --release',
  dependencies = {
    -- Snippet Engine
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      opts = {},
    },
    'folke/lazydev.nvim',
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <c-y> to accept ([y]es) the completion.
      --    This will auto-import if your LSP supports it.
      --    This will expand snippets if the LSP sent a snippet.
      -- 'super-tab' for tab to accept
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- For an understanding of why the 'default' preset is recommended,
      -- you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      preset = 'default',
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },

    snippets = { preset = 'luasnip' },

    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See :h blink-cmp-config-fuzzy for more information
    fuzzy = { implementation = 'prefer_rust_with_warning' },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  },
  config = function(_, _)
    -- safe requires
    local ok_blink, blink = pcall(require, 'blink.cmp')
    local ok_luasnip, luasnip = pcall(require, 'luasnip')
    if not ok_blink then
      return
    end
    if not ok_luasnip then
      luasnip = nil
    end

    local cmp_api = blink.api or blink -- blink.cmp exposes api functions on blink.api or top-level

    local function has_words_before()
      local col = vim.fn.col '.' - 1
      return col > 0 and vim.fn.getline('.'):sub(col, col):match '%s' == nil
    end

    local opts = { noremap = true, silent = true }

    vim.keymap.set({ 'i', 's' }, '<Tab>', function()
      -- completion menu visible?
      if cmp_api.visible and cmp_api.visible() then
        return cmp_api.select_next_item() or ''
      end

      -- LuaSnip expand or jump?
      if ok_luasnip and luasnip.expand_or_jumpable and luasnip.expand_or_jumpable() then
        return luasnip.expand_or_jump()
      end

      -- If there's text before cursor, trigger blink completion (optional)
      if has_words_before() and cmp_api.open then
        return cmp_api.open()
      end

      -- fallback: insert a real tab (respects expandtab setting)
      return vim.api.nvim_replace_termcodes('<Tab>', true, false, true)
    end, vim.tbl_extend('force', opts, { expr = true }))

    vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
      if cmp_api.visible and cmp_api.visible() then
        return cmp_api.select_prev_item() or ''
      end

      if ok_luasnip and luasnip.jumpable and luasnip.jumpable(-1) then
        return luasnip.jump(-1)
      end

      return vim.api.nvim_replace_termcodes('<S-Tab>', true, false, true)
    end, vim.tbl_extend('force', opts, { expr = true }))
  end,
}
