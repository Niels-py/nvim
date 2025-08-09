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
      '<cmd>FzfLua files<cr>',
      mode = 'n',
      desc = 'fuzzy grep search in cwd',
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
