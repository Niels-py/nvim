return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  cmd = { 'Telescope' },
  keys = {
    {
      '<leader>/',
      function()
        require('telescope.builtin').live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end,
      mode = 'n',
      desc = '[S]earch [/] in Open Files',
    },
    {
      '<leader>f',
      require('telescope.builtin').find_files,
      mode = 'n',
      desc = 'fuzzy find files in cwd',
    },
    {
      '<leader><leader>',
      require('telescope.builtin').buffers,
      mode = 'n',
      desc = 'find open buffers',
    },
    -- {
    --   '<leader>t',
    --   require('telescope.builtin').treesitter,
    --   mode = 'n',
    --   desc = 'find function or variable or something like that',
    -- },
    {
      '<leader>p',
      require('telescope.builtin').oldfiles,
      mode = 'n',
      desc = 'find recently opend files',
    },
    {
      '<leader>g',
      require('telescope.builtin').live_grep,
      mode = 'n',
      desc = 'ripgrep in current buffer',
    },
    {
      '<leader>H',
      function()
        require('telescope.builtin').help_tags()
      end,
      mode = 'n',
      desc = 'find help pages',
    },
    {
      '<leader>m',
      function()
        require('telescope.builtin').marks()
      end,
      mode = 'n',
      desc = 'find set marks',
    },
  },
  opts = {
    defaults = {
      prompt_prefix = '❯ ',
      selection_caret = '➜ ',
      file_ignore_patterns = {
        '.git/',
        '.cache',
        '%.o',
        '%.a',
        '%.out',
        '%.class',
        '%.zip',
      },
      mappings = {
        i = {
          ['<C-k>'] = require('telescope.actions').move_selection_previous,
          ['<C-j>'] = require('telescope.actions').move_selection_next,
          ['<C-p>'] = require('telescope.actions').move_selection_previous,
          ['<C-n>'] = require('telescope.actions').move_selection_next,
          ['<Esc>'] = require('telescope.actions').close,
        },
      },
    },
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
      'fzf',
      media_files = {
        filetypes = { 'png', 'webp', 'jpg', 'jpeg', 'mp4', 'mkv' },
      },
      'zoxide',
    },
    pickers = {
      find_files = {
        find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
      },
    },
  },
}
