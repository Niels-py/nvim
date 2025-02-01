local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { import = 'plugins' },
}, {
  lockfile = vim.fn.stdpath 'data' .. '/lazy/lock.json',
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { 'catppuccin' },
  },
  change_detection = {
    notify = false,
  },
  checker = { -- checks for updates
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip', -- allows browsing and extracting files in gz
        -- "matchit", -- extends the vim % functionality (html-tags, programming constructs)
        -- "matchparen", -- highlights matching pairs
        'netrwPlugin', -- the netrw plugin (i have oil so...)
        'tarPlugin', -- allows browsing and extracting files in tar balls
        'tohtml', -- converts the buffer with syntax highlighting and all to html
        'tutor', -- the neovim :Tutor command
        'zipPlugin', -- allows browsing and extracting files in zip files
        'bugreport',
        'vimball',
        'getscript',
        -- 'man',
      },
    },
  },
})
