return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.opt.timeoutlen
    delay = 300,
    icons = { mappings = true },

    -- Document existing key chains
    spec = {
      { '<leader>h', group = 'Git Hunk', mode = { 'n', 'v' } },
    },
  },
}
