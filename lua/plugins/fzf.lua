return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  cmd = { 'FzfLua' },
  keys = {
    {
      '<leader>f',
      '<cmd>FzfLua files<cr>',
      mode = 'n',
      desc = 'fuzzy find files in cwd',
    },
    {
      '<leader>g',
      '<cmd>FzfLua live_grep<cr>',
      mode = 'n',
      desc = 'fuzzy grep search in cwd',
    },
    {
      '<leader>H',
      '<cmd>FzfLua helptags<cr>',
      mode = 'n',
      desc = 'search helptags',
    },
    {
      '<leader>z',
      '<cmd>FzfLua zoxide<cr>',
      mode = 'n',
      desc = 'search commonly used folders',
    },
  },
  config = function()
    require('fzf-lua').setup {
      winopts = {
        height = 0.8,
        width = 0.9,
      },
      files = {
        previewer = true,
      },
    }
  end,
}
