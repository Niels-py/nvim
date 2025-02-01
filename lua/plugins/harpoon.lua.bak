return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      '<leader>a',
      function()
        require('harpoon'):list():add()
      end,
      mode = 'n',
      desc = 'add buffer to harpoon list',
    },
    {
      '<leader>e',
      function()
        require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
      end,
      mode = 'n',
      desc = 'Open harpoon window',
    },
    {
      '<leader>c',
      function()
        require('harpoon'):list():clear()
      end,
      mode = 'n',
      desc = 'add buffer to harpoon list',
    },
    {
      '<leader>j',
      function()
        require('harpoon'):list():next()
      end,
      mode = 'n',
      desc = 'jump to next harpoon buffer',
    },
    {
      '<leader>k',
      function()
        require('harpoon'):list():prev()
      end,
      mode = 'n',
      desc = 'jump to previous harpoon buffer',
    },
    {
      '<leader>1',
      function()
        require('harpoon'):list():select(1)
      end,
      mode = 'n',
      desc = 'jump to harpoon buffer 1',
    },
    {
      '<leader>2',
      function()
        require('harpoon'):list():select(2)
      end,
      mode = 'n',
      desc = 'jump to harpoon buffer 2',
    },
    {
      '<leader>3',
      function()
        require('harpoon'):list():select(3)
      end,
      mode = 'n',
      desc = 'jump to harpoon buffer 3',
    },
    {
      '<leader>4',
      function()
        require('harpoon'):list():select(4)
      end,
      mode = 'n',
      desc = 'jump to harpoon buffer 4',
    },
  },
}
