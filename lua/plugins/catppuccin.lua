return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      transparent_background = true,
      float = {
        transparent = false, -- enable transparent floating windows
        solid = false, -- use solid styling for floating windows, see |winborder|
      },
      auto_integrations = true,
      integrations = {
        blink_cmp = {
          style = 'bordered',
        },
        indent_blankline = {
          enabled = true,
          scope_color = 'surface1', -- catppuccin color (eg. `lavender`) Default: text
          colored_indent_levels = true,
        },
        mini = {
          enabled = true,
          indentscope_color = '',
        },
      },
    }
    vim.cmd.colorscheme 'catppuccin'

    -- hard-coded styles
    -- :h highlight-groups
    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=italic'

    vim.cmd.hi 'Constant gui=bold'
    vim.cmd.hi 'String gui=italic'
    vim.cmd.hi 'Character gui=bold'
    vim.cmd.hi 'Number gui=none'
    vim.cmd.hi 'Boolean gui=bold'
    vim.cmd.hi 'Number gui=none'

    vim.cmd.hi 'Statement gui=none'
    vim.cmd.hi 'Conditional gui=bold'
    vim.cmd.hi 'Repeat gui=bold'
    vim.cmd.hi 'Label gui=bold'
    vim.cmd.hi 'Function gui=bold,italic'
    vim.cmd.hi 'Error gui=underline'
  end,
}
