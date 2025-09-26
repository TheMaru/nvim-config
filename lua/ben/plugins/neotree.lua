return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = true,
  keys = {
    {
      '\\',
      function()
        vim.cmd 'Neotree reveal position=current'
      end,
      desc = 'NeoTree reveal',
      silent = true,
    },
    {
      '<leader>e',
      function()
        vim.cmd 'Neotree reveal position=current'
      end,
      desc = 'NeoTree reveal',
      silent = true,
    },
    {
      '<leader>rb',
      function()
        require('neo-tree.command').execute {
          toggle = true,
          source = 'buffers',
          position = 'left',
        }
      end,
      desc = 'Buffers (root dir)',
    },
    {
      '<leader>rf',
      function()
        require('neo-tree.command').execute {
          toggle = true,
          source = 'filesystem',
          position = 'left',
        }
      end,
      desc = 'Filetree (root dir)',
    },
    {
      '<leader>rg',
      function()
        require('neo-tree.command').execute {
          toggle = true,
          source = 'git_status',
          position = 'float',
        }
      end,
      desc = 'Git Status',
    },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
      hijack_netrw_behavior = 'open_default',
      follow_current_file = { enabled = true },
    },
    window = {
      position = 'current',
      width = 40,
      mappings = {
        ['e'] = function()
          vim.api.nvim_exec('Neotree focus filesystem left', true)
        end,
        ['b'] = function()
          vim.api.nvim_exec('Neotree focus buffers left', true)
        end,
        ['g'] = function()
          vim.api.nvim_exec('Neotree focus git_status left', true)
        end,
      },
    },
    event_handlers = {
      {
        event = 'file_open_requested',
        handler = function()
          -- auto close
          -- vim.cmd("Neotree close")
          -- OR
          require('neo-tree.command').execute { action = 'close' }
        end,
      },
      {
        event = 'neo_tree_window_after_open',
        handler = function(args)
          if args.position == 'left' or args.position == 'right' then
            vim.cmd 'wincmd ='
          end
        end,
      },
      {
        event = 'neo_tree_window_after_close',
        handler = function(args)
          if args.position == 'left' or args.position == 'right' then
            vim.cmd 'wincmd ='
          end
        end,
      },
    },
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)
  end,
}
