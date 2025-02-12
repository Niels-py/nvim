return {
  'stevearc/oil.nvim',
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    {
      '<leader>n',
      function()
        require('oil').toggle_float()
      end,
      mode = 'n',
      desc = 'open oil',
    },
  },
  opts = {
    delete_to_trash = true,
    skip_confirm_for_simple_edits = false,

    keymaps = {
      ['g?'] = 'actions.show_help',
      ['<CR>'] = 'actions.select',
      ['<C-s>'] = 'actions.select_vsplit',
      ['<C-h>'] = 'actions.select_split',
      ['<C-t>'] = 'actions.select_tab',
      ['<C-p>'] = 'actions.preview',
      ['<C-c>'] = 'actions.close',
      ['<C-l>'] = 'actions.refresh',
      ['-'] = 'actions.parent',
      ['_'] = 'actions.open_cwd',
      ['`'] = 'actions.cd',
      ['~'] = 'actions.tcd',
      ['gs'] = false, -- remove keymap for leap compatibility
      ['gx'] = 'actions.open_external',
      ['g.'] = 'actions.toggle_hidden',
      ['gt'] = 'actions.toggle_trash',
      ['<ESC>'] = 'actions.close',
    },
    -- to use the keymaps keys
    use_default_keymaps = false,
    view_options = { show_hidden = true, preview_split = 'right' },
  },
}
